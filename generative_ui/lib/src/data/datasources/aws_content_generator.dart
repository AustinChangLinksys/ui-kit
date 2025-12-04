import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/gen_exception.dart';
import '../../domain/entities/gen_tool.dart';
import '../../domain/entities/llm_response.dart';
import '../../domain/repositories/i_content_generator.dart';
import '../../domain/repositories/i_conversation_generator.dart';
import '../config/aws_config.dart';

/// AWS Bedrock content generator implementing both single-turn and multi-turn interfaces.
///
/// Uses AWS SigV4 signing to communicate with AWS Bedrock Runtime API
/// and supports the Claude Messages API format.
class AwsContentGenerator implements IContentGenerator, IConversationGenerator {
  final AWSConfig config;
  final http.Client _httpClient;
  final AWSSigV4Signer _signer;

  /// Default max tokens for responses.
  /// Increased to 8000 to allow for complex UI layouts with nested components.
  static const int defaultMaxTokens = 8000;

  /// Anthropic API version for Bedrock.
  static const String anthropicVersion = 'bedrock-2023-05-31';

  AwsContentGenerator({
    required this.config,
    http.Client? httpClient,
  })  : _httpClient = httpClient ?? http.Client(),
        _signer = AWSSigV4Signer(
          credentialsProvider: AWSCredentialsProvider(
            AWSCredentials(
              config.accessKeyId,
              config.secretAccessKey,
            ),
          ),
        );

  /// Build the request body for Bedrock Messages API.
  ///
  /// When [forceToolUse] is true and tools are provided, sets tool_choice to 'any'
  /// which forces the model to use at least one tool instead of just returning text.
  Map<String, dynamic> buildBedrockRequest({
    required List<Map<String, dynamic>> messages,
    List<GenTool>? tools,
    String? systemPrompt,
    int maxTokens = defaultMaxTokens,
    double? temperature,
    bool forceToolUse = false,
  }) {
    final hasTools = tools != null && tools.isNotEmpty;

    return {
      'anthropic_version': anthropicVersion,
      'max_tokens': maxTokens,
      if (systemPrompt != null) 'system': systemPrompt,
      'messages': messages,
      if (hasTools) 'tools': tools.map((t) => t.toJson()).toList(),
      // Force tool use when requested and tools are available
      if (hasTools && forceToolUse) 'tool_choice': {'type': 'any'},
      if (temperature != null) 'temperature': temperature,
    };
  }

  /// Sign the request using AWS SigV4.
  Future<AWSSignedRequest> _signRequest(String body) async {
    final request = AWSHttpRequest(
      method: AWSHttpMethod.post,
      uri: config.endpointUri,
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: utf8.encode(body),
    );

    debugPrint('=== Signing Debug ===');
    debugPrint('Service: bedrock');
    debugPrint('Region: ${config.region}');
    debugPrint('URI: ${config.endpointUri}');
    debugPrint('URI path (decoded): ${config.endpointUri.path}');
    debugPrint('URI path (raw): ${config.endpointUri.toString().split(config.endpointUri.host)[1]}');
    debugPrint('Request URI in AWSHttpRequest: ${request.uri}');
    debugPrint('Request URI path: ${request.uri.path}');
    debugPrint('=====================');

    return _signer.sign(
      request,
      credentialScope: AWSCredentialScope(
        region: config.region,
        service: AWSService.bedrockRuntime,
      ),
    );
  }

  /// Execute HTTP POST to Bedrock Runtime endpoint.
  Future<http.Response> _executeRequest(
    AWSSignedRequest signedRequest,
    List<int> bodyBytes,
  ) async {
    try {
      // Create request manually to ensure all headers are preserved
      final request = http.Request('POST', signedRequest.uri);
      request.headers.addAll(Map<String, String>.from(signedRequest.headers));
      request.bodyBytes = bodyBytes;

      debugPrint('=== HTTP Request Debug ===');
      debugPrint('URI: ${request.url}');
      debugPrint('Headers: ${request.headers}');
      debugPrint('Body length: ${request.bodyBytes.length}');
      debugPrint('==========================');

      final streamedResponse = await _httpClient
          .send(request)
          .timeout(const Duration(seconds: 60));

      return http.Response.fromStream(streamedResponse);
    } on SocketException catch (e) {
      throw NetworkException(
        'Network connection failed: ${e.message}',
        cause: e,
      );
    } on TimeoutException catch (e) {
      throw NetworkException(
        'Request timed out',
        cause: e,
      );
    } on http.ClientException catch (e) {
      throw NetworkException(
        'HTTP client error: ${e.message}',
        cause: e,
      );
    }
  }

  /// Parse response body and convert to LLMResponse.
  LLMResponse _parseResponse(String responseBody) {
    try {
      final json = jsonDecode(responseBody) as Map<String, dynamic>;
      return LLMResponse.fromMap(json);
    } on FormatException catch (e) {
      throw ParsingException('Failed to parse response: ${e.message}');
    }
  }

  /// Handle HTTP error codes and convert to appropriate exceptions.
  GenUiException _handleHttpError(int statusCode, String body) {
    Map<String, dynamic>? json;
    String message = 'Unknown error';
    String? errorType;

    try {
      json = jsonDecode(body) as Map<String, dynamic>;
      message = json['message'] as String? ?? message;
      errorType = json['__type'] as String?;
    } catch (_) {
      // Body is not JSON, use status code for error message
      message = 'HTTP $statusCode: $body';
    }

    switch (statusCode) {
      case 400:
        return ValidationException(message, details: json);
      case 401:
        return AuthenticationException(
          'Invalid credentials: $message',
          statusCode: statusCode,
        );
      case 403:
        return AuthenticationException(
          'Access denied: $message',
          statusCode: statusCode,
        );
      case 429:
        return RateLimitException(message: message);
      case >= 500:
        return ServerException('Server error: $message', statusCode: statusCode);
      default:
        return GenericException('$errorType: $message');
    }
  }

  @override
  Future<String> generate(String userInput) async {
    // Delegate to generateWithHistory with a single user message
    final response = await generateWithHistory(
      [ChatMessage.user(userInput)],
    );
    return jsonEncode(response.toMap());
  }

  @override
  Future<LLMResponse> generateWithHistory(
    List<ChatMessage> messages, {
    List<GenTool>? tools,
    String? systemPrompt,
    bool forceToolUse = false,
  }) async {
    debugPrint('=== AwsContentGenerator.generateWithHistory ===');
    debugPrint('Endpoint: ${config.endpointUri}');
    debugPrint('Messages count: ${messages.length}');
    debugPrint('Tools count: ${tools?.length ?? 0}');
    debugPrint('Force tool use: $forceToolUse');

    // Convert messages to Claude API format
    final apiMessages = messages
        .where((m) => m.role != ChatRole.system)
        .map((m) => m.toClaudeFormat())
        .toList();

    debugPrint('API messages count: ${apiMessages.length}');

    // Extract system prompt from messages if not provided
    final effectiveSystemPrompt = systemPrompt ??
        messages
            .where((m) => m.role == ChatRole.system)
            .map((m) => m.content as String)
            .firstOrNull;

    debugPrint('Has system prompt: ${effectiveSystemPrompt != null}');

    // Build request body
    final requestBody = buildBedrockRequest(
      messages: apiMessages,
      tools: tools,
      systemPrompt: effectiveSystemPrompt,
      forceToolUse: forceToolUse,
    );

    final body = jsonEncode(requestBody);
    final bodyBytes = utf8.encode(body);
    debugPrint('Request body length: ${body.length}');
    debugPrint('Request body preview: ${body.substring(0, body.length.clamp(0, 500))}...');

    try {
      // Sign request
      debugPrint('Signing request...');
      final signedRequest = await _signRequest(body);
      debugPrint('Request signed successfully');
      debugPrint('Signed URI: ${signedRequest.uri}');
      debugPrint('Signed URI path: ${signedRequest.uri.path}');
      debugPrint('Signed URI toString: ${signedRequest.uri.toString()}');

      // Execute request
      debugPrint('Executing HTTP request...');
      final response = await _executeRequest(signedRequest, bodyBytes);
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body length: ${response.body.length}');

      // Handle errors
      if (response.statusCode != 200) {
        debugPrint('=== HTTP Error ===');
        debugPrint('Status: ${response.statusCode}');
        debugPrint('Body: ${response.body}');
        debugPrint('==================');
        throw _handleHttpError(response.statusCode, response.body);
      }

      // Parse response
      debugPrint('Parsing response...');
      final result = _parseResponse(response.body);
      debugPrint('Response parsed: ${result.id}');
      debugPrint('=================================================');
      return result;
    } catch (e, stackTrace) {
      debugPrint('=== AwsContentGenerator Error ===');
      debugPrint('Error: $e');
      debugPrint('Type: ${e.runtimeType}');
      debugPrint('StackTrace: $stackTrace');
      debugPrint('=================================');
      rethrow;
    }
  }

  /// Close the HTTP client when done.
  void dispose() {
    _httpClient.close();
  }
}
