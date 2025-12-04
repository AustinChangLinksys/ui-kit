import 'dart:convert';

import 'content_block.dart';
import 'llm_response.dart';

/// Message role in conversation.
enum ChatRole {
  /// User-provided input.
  user,

  /// AI assistant response.
  assistant,

  /// System instructions (optional, typically first message).
  system,
}

/// Content part for complex message content.
abstract class ContentPart {
  /// Convert to API format.
  Map<String, dynamic> toMap();
}

/// Text content part.
class TextContentPart extends ContentPart {
  final String text;

  TextContentPart(this.text);

  @override
  Map<String, dynamic> toMap() => {'type': 'text', 'text': text};
}

/// Tool result content part (for closed-loop interaction).
class ToolResultPart extends ContentPart {
  final String toolUseId;
  final Map<String, dynamic> result;
  final bool? isError;

  ToolResultPart({
    required this.toolUseId,
    required this.result,
    this.isError,
  });

  @override
  Map<String, dynamic> toMap() => {
        'type': 'tool_result',
        'tool_use_id': toolUseId,
        'content': jsonEncode(result),
        if (isError != null) 'is_error': isError,
      };
}

/// A message in the conversation.
///
/// Supports multiple content types:
/// - Simple text for user/system messages
/// - LLMResponse for assistant messages
/// - List<ContentPart> for tool results
class ChatMessage {
  /// Message role.
  final ChatRole role;

  /// Message content (String for simple text, List<ContentPart> for complex).
  final dynamic content;

  /// Timestamp when message was created.
  final DateTime timestamp;

  /// Associated LLMResponse (for assistant messages).
  final LLMResponse? response;

  ChatMessage._({
    required this.role,
    required this.content,
    DateTime? timestamp,
    this.response,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Create a user text message.
  factory ChatMessage.user(String text) => ChatMessage._(
        role: ChatRole.user,
        content: text,
      );

  /// Create an assistant message from LLMResponse.
  factory ChatMessage.assistant(LLMResponse response) => ChatMessage._(
        role: ChatRole.assistant,
        content: response,
        response: response,
      );

  /// Create a tool result message (user role with tool_result content).
  factory ChatMessage.toolResult({
    required String toolUseId,
    required Map<String, dynamic> result,
    bool? isError,
  }) =>
      ChatMessage._(
        role: ChatRole.user,
        content: [
          ToolResultPart(toolUseId: toolUseId, result: result, isError: isError)
        ],
      );

  /// Create a system message.
  factory ChatMessage.system(String text) => ChatMessage._(
        role: ChatRole.system,
        content: text,
      );

  /// Convert to Claude Messages API format.
  Map<String, dynamic> toClaudeFormat() {
    if (content is String) {
      return {
        'role': role == ChatRole.system ? 'user' : role.name,
        'content': content,
      };
    } else if (content is List<ContentPart>) {
      return {
        'role': 'user', // tool_result is always user role
        'content':
            (content as List<ContentPart>).map((p) => p.toMap()).toList(),
      };
    } else if (content is LLMResponse) {
      // Convert assistant response to API format
      final response = content as LLMResponse;
      final contentParts = <Map<String, dynamic>>[];

      for (final block in response.content) {
        if (block is TextBlock) {
          contentParts.add({'type': 'text', 'text': block.text});
        } else if (block is ToolUseBlock) {
          contentParts.add({
            'type': 'tool_use',
            'id': block.id,
            'name': block.name,
            'input': block.input,
          });
        }
      }

      return {
        'role': 'assistant',
        'content': contentParts,
      };
    }
    throw StateError('Unknown content type: ${content.runtimeType}');
  }

  /// Check if this message is a user message.
  bool get isUser => role == ChatRole.user;

  /// Check if this message is an assistant message.
  bool get isAssistant => role == ChatRole.assistant;

  /// Check if this message is a system message.
  bool get isSystem => role == ChatRole.system;

  /// Check if this message contains a tool result.
  bool get isToolResult => content is List<ContentPart>;

  /// Get display text for this message.
  String get displayText {
    if (content is String) {
      return content as String;
    } else if (content is LLMResponse) {
      final response = content as LLMResponse;
      final textBlocks = response.content.whereType<TextBlock>();
      return textBlocks.map((b) => b.text).join('\n');
    } else if (content is List<ContentPart>) {
      return '[Tool Result]';
    }
    return '';
  }
}
