# Data Model: GenUI Phase 3

**Feature**: 012-genui-phase3-aws-client
**Date**: 2025-12-04

## Overview

This document defines the data entities for GenUI Phase 3. It extends the existing Phase 1/2 entities with conversation management and AWS integration support.

## Existing Entities (No Changes)

These entities from Phase 1/2 remain unchanged:

### LLMResponse
```dart
// Location: domain/entities/llm_response.dart
class LLMResponse {
  final String id;
  final String model;
  final List<ContentBlock> content;
  final String? stopReason;
}
```

### ContentBlock / TextBlock / ToolUseBlock
```dart
// Location: domain/entities/content_block.dart
abstract class ContentBlock { final String type; }
class TextBlock extends ContentBlock { final String text; }
class ToolUseBlock extends ContentBlock {
  final String id;
  final String name;
  final Map<String, dynamic> input;
}
```

### GenTool
```dart
// Location: domain/entities/gen_tool.dart
class GenTool {
  final String name;
  final String description;
  final Map<String, dynamic> inputSchema;
}
```

## New Entities

### ChatMessage

**Purpose**: Represents a single message in a multi-turn conversation.

**Location**: `domain/entities/chat_message.dart`

```dart
/// Message role in conversation
enum ChatRole {
  /// User-provided input
  user,
  /// AI assistant response
  assistant,
  /// System instructions (optional, typically first message)
  system,
}

/// Content part for complex message content
abstract class ContentPart {
  Map<String, dynamic> toMap();
}

/// Text content part
class TextContentPart extends ContentPart {
  final String text;
  TextContentPart(this.text);

  @override
  Map<String, dynamic> toMap() => {'type': 'text', 'text': text};
}

/// Tool result content part (for closed-loop interaction)
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

/// A message in the conversation
class ChatMessage {
  /// Message role
  final ChatRole role;

  /// Message content (String for simple text, List<ContentPart> for complex)
  final dynamic content;

  /// Timestamp when message was created
  final DateTime timestamp;

  /// Associated LLMResponse (for assistant messages)
  final LLMResponse? response;

  ChatMessage._({
    required this.role,
    required this.content,
    DateTime? timestamp,
    this.response,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Create a user text message
  factory ChatMessage.user(String text) => ChatMessage._(
    role: ChatRole.user,
    content: text,
  );

  /// Create an assistant message from LLMResponse
  factory ChatMessage.assistant(LLMResponse response) => ChatMessage._(
    role: ChatRole.assistant,
    content: response,
    response: response,
  );

  /// Create a tool result message (user role with tool_result content)
  factory ChatMessage.toolResult({
    required String toolUseId,
    required Map<String, dynamic> result,
    bool? isError,
  }) => ChatMessage._(
    role: ChatRole.user,
    content: [ToolResultPart(toolUseId: toolUseId, result: result, isError: isError)],
  );

  /// Create a system message
  factory ChatMessage.system(String text) => ChatMessage._(
    role: ChatRole.system,
    content: text,
  );

  /// Convert to Claude Messages API format
  Map<String, dynamic> toClaudeFormat() {
    if (content is String) {
      return {
        'role': role == ChatRole.system ? 'user' : role.name,
        'content': content,
      };
    } else if (content is List<ContentPart>) {
      return {
        'role': 'user', // tool_result is always user role
        'content': (content as List<ContentPart>).map((p) => p.toMap()).toList(),
      };
    } else if (content is LLMResponse) {
      // Extract text from assistant response
      final response = content as LLMResponse;
      final textBlocks = response.content.whereType<TextBlock>();
      final text = textBlocks.map((b) => b.text).join('\n');
      return {
        'role': 'assistant',
        'content': text.isNotEmpty ? text : '[tool use]',
      };
    }
    throw StateError('Unknown content type: ${content.runtimeType}');
  }
}
```

**Validation Rules**:
- `content` must not be empty for user messages
- `toolUseId` must match a previous `ToolUseBlock.id` in conversation
- `role` cannot be `system` after first message in conversation

### ConversationState

**Purpose**: Manages the complete state of a chat conversation.

**Location**: `domain/entities/conversation_state.dart`

```dart
/// View states for the chat interface
enum ChatViewState {
  /// Initial welcome screen, no conversation started
  welcome,

  /// Waiting for AI response
  loading,

  /// Displaying conversation content
  content,

  /// Error state with retry option
  error,
}

/// Complete conversation state container
class ConversationState {
  /// Current UI view state
  final ChatViewState viewState;

  /// Complete message history
  final List<ChatMessage> messages;

  /// Error message (when viewState == error)
  final String? errorMessage;

  /// Whether error is retryable
  final bool isRetryable;

  /// Currently pending tool use awaiting user action
  final ToolUseBlock? pendingToolUse;

  const ConversationState({
    this.viewState = ChatViewState.welcome,
    this.messages = const [],
    this.errorMessage,
    this.isRetryable = false,
    this.pendingToolUse,
  });

  /// Create initial state
  factory ConversationState.initial() => const ConversationState();

  /// Create loading state
  ConversationState loading() => copyWith(
    viewState: ChatViewState.loading,
    errorMessage: null,
  );

  /// Create content state with new message
  ConversationState withMessage(ChatMessage message) {
    final newMessages = [...messages, message];
    final pendingTool = message.response?.getFirstToolUse();
    return copyWith(
      viewState: ChatViewState.content,
      messages: newMessages,
      pendingToolUse: pendingTool,
      errorMessage: null,
    );
  }

  /// Create error state
  ConversationState withError(String message, {bool retryable = false}) => copyWith(
    viewState: ChatViewState.error,
    errorMessage: message,
    isRetryable: retryable,
  );

  /// Clear pending tool use after action
  ConversationState toolActionCompleted() => copyWith(
    pendingToolUse: null,
  );

  ConversationState copyWith({
    ChatViewState? viewState,
    List<ChatMessage>? messages,
    String? errorMessage,
    bool? isRetryable,
    ToolUseBlock? pendingToolUse,
  }) {
    return ConversationState(
      viewState: viewState ?? this.viewState,
      messages: messages ?? this.messages,
      errorMessage: errorMessage,
      isRetryable: isRetryable ?? this.isRetryable,
      pendingToolUse: pendingToolUse,
    );
  }

  /// Get messages in Claude API format
  List<Map<String, dynamic>> toClaudeMessages() {
    return messages
        .where((m) => m.role != ChatRole.system)
        .map((m) => m.toClaudeFormat())
        .toList();
  }

  /// Get system message if present
  String? getSystemPrompt() {
    final systemMsg = messages.whereType<ChatMessage>()
        .where((m) => m.role == ChatRole.system)
        .firstOrNull;
    return systemMsg?.content as String?;
  }
}
```

**State Transitions**:
```
welcome → loading (user sends first message)
loading → content (response received)
loading → error (request failed)
content → loading (user sends another message)
content → loading (tool action triggers new request)
error → loading (user clicks retry)
```

### ToolActionOutput

**Purpose**: Captures the result of a user action on a dynamic UI component.

**Location**: `domain/entities/tool_action_output.dart`

```dart
/// Result of user interaction with a dynamic UI component
class ToolActionOutput {
  /// ID of the tool_use block this action responds to
  final String toolUseId;

  /// Name of the component (for logging/debugging)
  final String componentName;

  /// Action type (e.g., 'save', 'cancel', 'select')
  final String actionType;

  /// Output data from the component
  final Map<String, dynamic> data;

  /// Timestamp of action
  final DateTime timestamp;

  ToolActionOutput({
    required this.toolUseId,
    required this.componentName,
    required this.actionType,
    required this.data,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Convert to tool_result content
  Map<String, dynamic> toResultContent() => {
    'action': actionType,
    ...data,
  };

  /// Create ChatMessage for this action
  ChatMessage toChatMessage() => ChatMessage.toolResult(
    toolUseId: toolUseId,
    result: toResultContent(),
  );
}
```

### AWSConfig

**Purpose**: Configuration container for AWS Bedrock connection.

**Location**: `data/config/aws_config.dart`

```dart
/// AWS Bedrock configuration
class AWSConfig {
  final String accessKeyId;
  final String secretAccessKey;
  final String region;
  final String modelId;

  const AWSConfig({
    required this.accessKeyId,
    required this.secretAccessKey,
    required this.region,
    required this.modelId,
  });

  /// Load from environment variables
  factory AWSConfig.fromEnvironment() {
    final accessKeyId = dotenv.env['AWS_ACCESS_KEY_ID'];
    final secretAccessKey = dotenv.env['AWS_SECRET_ACCESS_KEY'];
    final region = dotenv.env['AWS_REGION'];
    final modelId = dotenv.env['BEDROCK_MODEL_ID'];

    if (accessKeyId == null || accessKeyId.isEmpty) {
      throw ConfigurationException('AWS_ACCESS_KEY_ID not set');
    }
    if (secretAccessKey == null || secretAccessKey.isEmpty) {
      throw ConfigurationException('AWS_SECRET_ACCESS_KEY not set');
    }
    if (region == null || region.isEmpty) {
      throw ConfigurationException('AWS_REGION not set');
    }
    if (modelId == null || modelId.isEmpty) {
      throw ConfigurationException('BEDROCK_MODEL_ID not set');
    }

    return AWSConfig(
      accessKeyId: accessKeyId,
      secretAccessKey: secretAccessKey,
      region: region,
      modelId: modelId,
    );
  }

  /// Get Bedrock Runtime endpoint URL
  Uri get endpointUri => Uri.parse(
    'https://bedrock-runtime.$region.amazonaws.com/model/$modelId/invoke'
  );
}

class ConfigurationException implements Exception {
  final String message;
  ConfigurationException(this.message);
  @override
  String toString() => 'ConfigurationException: $message';
}
```

## Entity Relationships

```
┌─────────────────────┐
│ ConversationState   │
│  - viewState        │
│  - messages[]  ─────┼──────┐
│  - pendingToolUse   │      │
└─────────────────────┘      │
                             ▼
                    ┌─────────────────┐
                    │   ChatMessage   │
                    │  - role         │
                    │  - content      │
                    │  - response ────┼──────┐
                    └─────────────────┘      │
                                             ▼
                                    ┌─────────────────┐
                                    │   LLMResponse   │
                                    │  - id           │
                                    │  - content[] ───┼──┐
                                    └─────────────────┘  │
                                                         ▼
                                           ┌──────────────────────┐
                                           │    ContentBlock      │
                                           │  ├─ TextBlock        │
                                           │  └─ ToolUseBlock ────┼──┐
                                           └──────────────────────┘  │
                                                                     │
┌─────────────────────┐                                              │
│  ToolActionOutput   │◄─────────────────────────────────────────────┘
│  - toolUseId        │  (references ToolUseBlock.id)
│  - actionType       │
│  - data             │
└─────────────────────┘
```

## Migration Notes

### Backward Compatibility

1. `IContentGenerator.generate(String)` remains unchanged
2. `MockContentGenerator` continues to work without modification
3. `DynamicWidgetBuilder` gains optional `onAction` parameter
4. `GenUiState` can be deprecated in favor of `ConversationState`

### New Interface

```dart
// New interface in domain/repositories/i_conversation_generator.dart
abstract class IConversationGenerator {
  Future<LLMResponse> generateWithHistory(
    List<ChatMessage> messages, {
    List<GenTool>? tools,
    String? systemPrompt,
  });
}

// AWS implementation implements both interfaces
class AwsContentGenerator implements IContentGenerator, IConversationGenerator {
  // ...
}
```
