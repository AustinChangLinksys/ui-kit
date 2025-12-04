# Research: GenUI Phase 3 - AWS Integration

**Feature**: 012-genui-phase3-aws-client
**Date**: 2025-12-04

## 1. AWS Bedrock Runtime API

### 1.1 Claude Messages API Format

**Decision**: Use Claude Messages API via Bedrock Runtime with `anthropic_version: bedrock-2023-05-31`

**Request Format**:
```json
{
  "anthropic_version": "bedrock-2023-05-31",
  "max_tokens": 2000,
  "system": "<system prompt with tool definitions>",
  "messages": [
    {"role": "user", "content": "user message"},
    {"role": "assistant", "content": "assistant response"},
    {"role": "user", "content": [
      {"type": "tool_result", "tool_use_id": "xyz", "content": "result data"}
    ]}
  ],
  "tools": [
    {
      "name": "WifiSettingsCard",
      "description": "Display Wi-Fi configuration interface",
      "input_schema": {
        "type": "object",
        "properties": {...},
        "required": [...]
      }
    }
  ]
}
```

**Response Format** (already compatible with existing `LLMResponse`):
```json
{
  "id": "msg_xxx",
  "model": "claude-3-xxx",
  "content": [
    {"type": "text", "text": "..."},
    {"type": "tool_use", "id": "toolu_xxx", "name": "WifiSettingsCard", "input": {...}}
  ],
  "stop_reason": "end_turn" | "tool_use"
}
```

**Rationale**: The response format aligns with existing `LLMResponse.fromMap()` implementation. No changes needed to entity parsing.

**Alternatives Considered**:
- Converse API: More abstracted but less control over tool formatting
- Direct Anthropic API: Would require API key management instead of IAM

### 1.2 Endpoint URL Pattern

**Decision**: Use regional Bedrock Runtime endpoint

```
https://bedrock-runtime.{region}.amazonaws.com/model/{modelId}/invoke
```

**Model IDs for Claude**:
- `anthropic.claude-3-5-sonnet-20241022-v2:0` (Claude 3.5 Sonnet)
- `anthropic.claude-3-5-haiku-20241022-v1:0` (Claude 3.5 Haiku)
- `anthropic.claude-3-opus-20240229-v1:0` (Claude 3 Opus)
- Cross-region inference: `us.anthropic.claude-3-5-sonnet-20241022-v2:0`

**Rationale**: Direct invoke endpoint supports the full Messages API format. Converse endpoint would require different request/response mapping.

### 1.3 Tool Use (Function Calling) Flow

**Decision**: Implement Claude's native tool use pattern with tool_result messages

**Flow**:
1. User sends message → Request includes `tools` array
2. Claude responds with `tool_use` block → `stop_reason: "tool_use"`
3. UI renders component, user interacts
4. Send `tool_result` message → New request with tool output
5. Claude responds with confirmation text → `stop_reason: "end_turn"`

**Tool Result Message Format**:
```json
{
  "role": "user",
  "content": [
    {
      "type": "tool_result",
      "tool_use_id": "toolu_xxx",
      "content": "{\"ssid\": \"NewNetwork\", \"saved\": true}"
    }
  ]
}
```

**Rationale**: Native tool use provides structured data flow. The `tool_use_id` ensures correct pairing of actions with responses.

## 2. AWS Dart SDK Patterns

### 2.1 aws_common Package Usage

**Decision**: Use `AWSHttpRequest` from `aws_common ^0.7.11`

```dart
import 'package:aws_common/aws_common.dart';

final request = AWSHttpRequest(
  method: AWSHttpMethod.post,
  uri: Uri.parse('https://bedrock-runtime.$region.amazonaws.com/model/$modelId/invoke'),
  headers: {
    AWSHeaders.contentType: 'application/json',
    AWSHeaders.accept: 'application/json',
  },
  body: utf8.encode(jsonEncode(requestBody)),
);
```

**Rationale**: `aws_common` provides the foundational types needed by `aws_signature_v4`. Using the same package versions ensures compatibility.

### 2.2 aws_signature_v4 Signing

**Decision**: Use `AWSSigV4Signer` with static credentials provider

```dart
import 'package:aws_signature_v4/aws_signature_v4.dart';

final signer = AWSSigV4Signer(
  credentialsProvider: AWSCredentialsProvider(
    AWSCredentials(accessKeyId, secretAccessKey),
  ),
);

final signedRequest = await signer.sign(
  request,
  credentialScope: AWSCredentialScope(
    region: region,
    service: AWSService.bedrockRuntime, // Note: may need 'bedrock-runtime'
  ),
);
```

**Service Name**: The service name for SigV4 is `bedrock-runtime` (not `bedrock`)

**Headers Added by Signing**:
- `Authorization`: SigV4 signature
- `X-Amz-Date`: Request timestamp
- `X-Amz-Content-Sha256`: Payload hash (for POST requests)

**Rationale**: AWSSigV4Signer handles the complex signing algorithm. Using static credentials is appropriate for client apps where IAM roles aren't available.

**Alternatives Considered**:
- Amplify Flutter: Heavier dependency, designed for mobile auth flows
- Manual SigV4: Error-prone, not recommended

### 2.3 Credential Management

**Decision**: Load credentials from environment variables via flutter_dotenv

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

// In main.dart before runApp:
await dotenv.load(fileName: 'assets/.env');

// In AWS generator:
final accessKeyId = dotenv.env['AWS_ACCESS_KEY_ID']!;
final secretAccessKey = dotenv.env['AWS_SECRET_ACCESS_KEY']!;
final region = dotenv.env['AWS_REGION']!;
final modelId = dotenv.env['BEDROCK_MODEL_ID']!;
```

**.env.example template**:
```ini
AWS_ACCESS_KEY_ID=AKIA...
AWS_SECRET_ACCESS_KEY=...
AWS_REGION=us-east-1
BEDROCK_MODEL_ID=anthropic.claude-3-5-sonnet-20241022-v2:0
```

**Security**:
- `.env` MUST be in `.gitignore`
- `.env.example` provides template without real values
- Runtime validation throws clear error if credentials missing

**Rationale**: flutter_dotenv is lightweight and follows 12-factor app principles. Environment variables are the standard pattern for credential injection.

## 3. Interface Extension Strategy

### 3.1 IContentGenerator Extension

**Decision**: Create new `IConversationGenerator` interface that extends capability

**Current Interface**:
```dart
abstract class IContentGenerator {
  Future<String> generate(String userInput);
}
```

**New Interface**:
```dart
/// Extended interface for multi-turn conversation support
abstract class IConversationGenerator {
  /// Generate response for a conversation with history
  ///
  /// Parameters:
  /// - [messages]: Complete conversation history
  /// - [tools]: Optional tool definitions for function calling
  /// - [systemPrompt]: Optional system prompt override
  Future<String> generateWithHistory(
    List<ChatMessage> messages, {
    List<GenTool>? tools,
    String? systemPrompt,
  });
}
```

**Adapter Pattern**: `AwsContentGenerator` implements both interfaces
```dart
class AwsContentGenerator implements IContentGenerator, IConversationGenerator {
  @override
  Future<String> generate(String userInput) async {
    // Delegate to generateWithHistory with single message
    return generateWithHistory([
      ChatMessage.user(userInput),
    ]);
  }

  @override
  Future<String> generateWithHistory(
    List<ChatMessage> messages, {
    List<GenTool>? tools,
    String? systemPrompt,
  }) async {
    // Full AWS implementation
  }
}
```

**Rationale**:
- Maintains backward compatibility with existing code using `IContentGenerator`
- New chat interface uses extended `IConversationGenerator`
- Single implementation handles both use cases

**Alternatives Considered**:
- Modify existing interface: Would break `MockContentGenerator` and existing tests
- Wrapper class: Adds unnecessary indirection
- Optional parameters on existing method: Less clean API

### 3.2 ChatMessage Entity Design

**Decision**: Create ChatMessage with role enum and content variants

```dart
enum ChatRole { user, assistant, system }

class ChatMessage {
  final ChatRole role;
  final dynamic content; // String or List<ContentPart>

  ChatMessage.user(String text) : role = ChatRole.user, content = text;
  ChatMessage.assistant(String text) : role = ChatRole.assistant, content = text;
  ChatMessage.toolResult(String toolUseId, Map<String, dynamic> result);

  Map<String, dynamic> toClaudeFormat();
}
```

**Rationale**: Mirrors Claude API message structure for easy serialization. Factory constructors provide type safety.

### 3.3 DynamicWidgetBuilder Modification

**Decision**: Add optional `onAction` callback to builder methods

**Current**:
```dart
Widget buildBlock(ContentBlock block, BuildContext context)
```

**Modified**:
```dart
typedef ToolActionCallback = void Function(String toolUseId, Map<String, dynamic> output);

Widget buildBlock(
  ContentBlock block,
  BuildContext context, {
  ToolActionCallback? onAction,
})
```

**Component Integration**: Registry builders receive action callback
```dart
typedef GenUiWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props, {
  void Function(Map<String, dynamic>)? onAction, // Added
});
```

**Rationale**: Optional callback maintains backward compatibility. Components that support actions can use it; others ignore it.

## 4. Error Handling Strategy

### 4.1 Error Categories

| Error Type | HTTP Code | User Message | Retry? |
|------------|-----------|--------------|--------|
| Network failure | - | "Connection lost. Check your internet." | Yes |
| Invalid credentials | 403 | "Authentication failed. Check configuration." | No |
| Expired credentials | 401 | "Session expired. Restart the app." | No |
| Rate limiting | 429 | "Too many requests. Please wait." | Yes (with backoff) |
| Model error | 500 | "AI service unavailable. Try again." | Yes |
| Malformed response | - | "Unexpected response. Try again." | Yes |

### 4.2 Exception Hierarchy

```dart
class GenUiException implements Exception {
  final String message;
  final bool isRetryable;
  GenUiException(this.message, {this.isRetryable = false});
}

class NetworkException extends GenUiException {
  NetworkException() : super('Network connection failed', isRetryable: true);
}

class AuthenticationException extends GenUiException {
  AuthenticationException() : super('AWS authentication failed', isRetryable: false);
}

class RateLimitException extends GenUiException {
  final Duration? retryAfter;
  RateLimitException({this.retryAfter})
    : super('Rate limit exceeded', isRetryable: true);
}
```

**Rationale**: Exception hierarchy enables UI to show appropriate actions (retry button vs configuration prompt).

## Summary

| Topic | Decision | Key Package/Pattern |
|-------|----------|---------------------|
| API Format | Claude Messages API | `bedrock-2023-05-31` |
| Signing | AWSSigV4Signer | `aws_signature_v4 ^0.6.9` |
| HTTP | AWSHttpRequest + http.post | `aws_common ^0.7.11`, `http ^1.2.1` |
| Credentials | flutter_dotenv | `.env` in assets |
| Interface | New IConversationGenerator | Adapter pattern |
| Tool Flow | Native tool_result messages | tool_use_id pairing |
