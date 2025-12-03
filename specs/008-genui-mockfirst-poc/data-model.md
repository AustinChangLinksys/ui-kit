# Phase 1: Data Model & Entities

**Purpose**: Define all domain entities and value objects for GenUI orchestration
**Date**: 2025-12-03
**Status**: Complete

---

## 1. Domain Entities

### 1.1 GenTool (Value Object)

Represents a tool definition that the LLM can invoke.

```dart
// domain/entities/gen_tool.dart

class GenTool {
  final String name;
  final String description;
  final Map<String, dynamic> inputSchema;

  const GenTool({
    required this.name,
    required this.description,
    required this.inputSchema,
  });

  /// Converts to LLM tool_use compatible format
  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'input_schema': inputSchema,
  };

  /// Factory constructor from JSON (phase 2+)
  factory GenTool.fromJson(Map<String, dynamic> json) {
    return GenTool(
      name: json['name'] as String,
      description: json['description'] as String,
      inputSchema: json['input_schema'] as Map<String, dynamic>,
    );
  }

  @override
  String toString() => 'GenTool($name)';

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is GenTool &&
    runtimeType == other.runtimeType &&
    name == other.name &&
    description == other.description;

  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
```

**Validation Rules**:
- `name`: Non-empty, alphanumeric + underscores, max 50 chars
- `description`: Non-empty, max 200 chars
- `inputSchema`: Valid JSON Schema Draft 7 object

---

### 1.2 LLMResponse (Domain Model)

Represents a parsed LLM response in tool_use format.

```dart
// domain/entities/llm_response.dart

class LLMResponse {
  final String id; // Unique identifier for tracking
  final String model; // e.g., "claude-3-mock", "anthropic.claude-3-sonnet"
  final List<ContentBlock> content;
  final DateTime timestamp;

  const LLMResponse({
    required this.id,
    required this.model,
    required this.content,
    required this.timestamp,
  });

  /// Check if response contains tool_use blocks
  bool hasToolUse() => content.any((block) => block.isToolUse);

  /// Extract first tool_use block (most common case)
  ToolUseBlock? getFirstToolUse() {
    for (final block in content) {
      if (block is ToolUseBlock) return block;
    }
    return null;
  }

  @override
  String toString() => 'LLMResponse(id: $id, model: $model, content: ${content.length} blocks)';
}

/// Base class for content blocks
abstract class ContentBlock {
  bool get isToolUse => this is ToolUseBlock;
  bool get isText => this is TextBlock;
}

/// Text content block
class TextBlock extends ContentBlock {
  final String text;

  TextBlock({required this.text});

  factory TextBlock.fromJson(Map<String, dynamic> json) {
    return TextBlock(text: json['text'] as String);
  }

  Map<String, dynamic> toJson() => {'type': 'text', 'text': text};

  @override
  String toString() => 'TextBlock: ${text.substring(0, min(50, text.length))}...';
}

/// Tool use block (primary in Phase 1)
class ToolUseBlock extends ContentBlock {
  final String id;
  final String name; // Component name (e.g., "WifiSettingsCard")
  final Map<String, dynamic> input; // Properties passed to component

  ToolUseBlock({
    required this.id,
    required this.name,
    required this.input,
  });

  /// Validate tool properties
  /// Returns error message if validation fails, null if valid
  String? validate() {
    if (name.isEmpty) return 'Tool name cannot be empty';
    if (input is! Map) return 'Tool input must be a JSON object';
    return null;
  }

  factory ToolUseBlock.fromJson(Map<String, dynamic> json) {
    return ToolUseBlock(
      id: json['id'] as String? ?? 'unknown',
      name: json['name'] as String,
      input: json['input'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    'type': 'tool_use',
    'id': id,
    'name': name,
    'input': input,
  };

  @override
  String toString() => 'ToolUseBlock(name: $name, input: $input)';
}
```

**Validation Rules**:
- `id`: Non-empty string
- `name`: Matches component name in UI Kit registry
- `input`: Map containing component-specific properties
- `model`: Non-empty string
- `content`: Non-empty list with at least one block

---

### 1.3 GenSession (Aggregate)

Represents the conversation context (future use in Phase 2+).

```dart
// domain/entities/gen_session.dart

class GenSession {
  final String id;
  final List<GenMessage> messages;
  final List<GenTool> availableTools;
  final DateTime createdAt;
  DateTime? updatedAt;

  GenSession({
    required this.id,
    required this.messages,
    required this.availableTools,
    required this.createdAt,
    this.updatedAt,
  });

  /// Add a message to the session
  void addMessage(GenMessage message) {
    messages.add(message);
    updatedAt = DateTime.now();
  }

  /// Get last N messages (for context window)
  List<GenMessage> getRecentMessages({int limit = 10}) {
    return messages.length <= limit
      ? messages
      : messages.sublist(messages.length - limit);
  }

  @override
  String toString() => 'GenSession(id: $id, messages: ${messages.length}, tools: ${availableTools.length})';
}

class GenMessage {
  final String role; // "user" or "assistant"
  final String content;
  final DateTime timestamp;

  const GenMessage({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };

  @override
  String toString() => 'GenMessage($role: ${content.substring(0, min(50, content.length))}...)';
}
```

**Validation Rules**:
- `role`: Must be "user" or "assistant"
- `content`: Non-empty string
- `messages`: Session can be empty (new session) or contain history
- `availableTools`: Should be non-empty for practical use

---

## 2. Exceptions & Error Types

### 2.1 Custom Exceptions

```dart
// domain/entities/gen_exception.dart

/// Base exception for GenUI module
abstract class GenException implements Exception {
  final String message;
  GenException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

/// Thrown when JSON parsing fails
class ParsingException extends GenException {
  final String originalInput;
  final dynamic originalError;

  ParsingException(
    String message, {
    required this.originalInput,
    this.originalError,
  }) : super(message);

  @override
  String toString() => '''
ParsingException: $message
Original Input: ${originalInput.substring(0, min(200, originalInput.length))}...
Original Error: $originalError
''';
}

/// Thrown when tool_use block is invalid
class ToolUseValidationException extends GenException {
  final ToolUseBlock toolUse;

  ToolUseValidationException(String message, {required this.toolUse})
    : super(message);

  @override
  String toString() => 'ToolUseValidationException: $message (Tool: ${toolUse.name})';
}

/// Thrown when content generation fails
class ContentGenerationException extends GenException {
  final String? statusCode;

  ContentGenerationException(String message, {this.statusCode})
    : super(message);

  @override
  String toString() => statusCode != null
    ? 'ContentGenerationException($statusCode): $message'
    : 'ContentGenerationException: $message';
}

/// Thrown for schema validation errors
class SchemaValidationException extends GenException {
  final Map<String, dynamic> schema;

  SchemaValidationException(String message, {required this.schema})
    : super(message);
}
```

---

## 3. Repository Interface

```dart
// domain/repositories/i_content_generator.dart

abstract class IContentGenerator {
  /// Generates content (text, tool_use blocks) based on user input
  ///
  /// Parameters:
  ///   - userPrompt: The user's input text
  ///   - context: Optional context data (session history, state, etc.)
  ///
  /// Returns: Raw string response (NOT parsed)
  /// This separation allows the parser to handle various formats
  ///
  /// Throws: ContentGenerationException if generation fails
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  });
}
```

---

## 4. UseCase Layer

```dart
// domain/usecases/orchestrate_ui_flow.dart

class OrchestrateUIFlowUseCase {
  final IContentGenerator contentGenerator;
  final ResponseParser parser;

  OrchestrateUIFlowUseCase({
    required this.contentGenerator,
    required this.parser,
  });

  /// Main orchestration: Generate → Parse → Validate
  Future<LLMResponse> execute({
    required String userPrompt,
  }) async {
    try {
      // 1. Generate raw response
      final raw = await contentGenerator.generate(
        userPrompt: userPrompt,
      );

      // 2. Parse to structured format
      final parsed = parser.parse(raw);

      // 3. Build domain model
      final response = _buildResponse(parsed);

      // 4. Validate response
      _validateResponse(response);

      return response;
    } on ParsingException {
      rethrow; // Let caller handle parsing errors
    } catch (e) {
      throw ContentGenerationException('Orchestration failed: $e');
    }
  }

  LLMResponse _buildResponse(Map<String, dynamic> json) {
    final content = <ContentBlock>[];

    // Handle Claude-format responses
    if (json['content'] is List) {
      for (final block in json['content'] as List) {
        if (block['type'] == 'tool_use') {
          content.add(ToolUseBlock.fromJson(block));
        } else if (block['type'] == 'text') {
          content.add(TextBlock.fromJson(block));
        }
      }
    }

    return LLMResponse(
      id: json['id'] as String? ?? 'unknown',
      model: json['model'] as String? ?? 'unknown',
      content: content.isNotEmpty ? content : [TextBlock(text: json.toString())],
      timestamp: DateTime.now(),
    );
  }

  void _validateResponse(LLMResponse response) {
    if (response.content.isEmpty) {
      throw GenException('Response contains no content blocks');
    }

    for (final block in response.content) {
      if (block is ToolUseBlock) {
        final error = block.validate();
        if (error != null) {
          throw ToolUseValidationException(error, toolUse: block);
        }
      }
    }
  }
}
```

---

## 5. Data Flow Diagram

```
User Input (String)
         ↓
IContentGenerator.generate()  [Async]
         ↓
Raw Response String
         ↓
ResponseParser.parse()        [DBC: Precondition/Postcondition]
         ↓
Parsed Map<String, dynamic>
         ↓
OrchestrateUIFlowUseCase._buildResponse()
         ↓
LLMResponse Domain Model
         ↓
Validation (_validateResponse)
         ↓
UI Layer (GenUiWrapper renders tool_use blocks)
```

---

## 6. Type Mapping Reference

### JSON Input → Domain Model

```dart
// From LLM (Claude tool_use format)
{
  "id": "msg_123",
  "model": "claude-3-sonnet",
  "content": [
    {
      "type": "tool_use",
      "id": "tool_001",
      "name": "WifiSettingsCard",
      "input": {
        "ssid": "Guest_Network",
        "security": "WPA3",
        "isEnabled": true
      }
    }
  ]
}

// Maps to Domain Model
LLMResponse(
  id: "msg_123",
  model: "claude-3-sonnet",
  content: [
    ToolUseBlock(
      id: "tool_001",
      name: "WifiSettingsCard",
      input: {
        "ssid": "Guest_Network",
        "security": "WPA3",
        "isEnabled": true
      }
    )
  ],
  timestamp: DateTime.now()
)
```

---

## 7. Validation & Constraints

| Entity | Constraint | Error |
|--------|-----------|-------|
| GenTool | name non-empty, <50 chars | ParsingException |
| GenTool | name alphanumeric + underscore | ParsingException |
| ToolUseBlock | name matches registered component | ToolUseValidationException |
| ToolUseBlock | input is Map<String, dynamic> | ToolUseValidationException |
| LLMResponse | content non-empty | GenException |
| LLMResponse | at least one valid block | GenException |
| GenMessage | role is "user" or "assistant" | GenException |

---

## 8. Testing Strategies

### Domain Layer Tests
- Entity creation and equality tests
- Validation rule enforcement tests
- Exception message clarity tests

### UseCase Tests
- Mock generator + parser integration
- Validation chain completeness
- Error propagation and transformation

### Repository Tests
- Both MockContentGenerator and (placeholder) AwsPassThroughGenerator behavior
- Contract compliance verification
- Exception mapping

---

## Appendix: Class Diagram

```
┌─────────────────────────────────┐
│       IContentGenerator         │
│  (Repository Interface)         │
├─────────────────────────────────┤
│ + generate(prompt, context)     │
└─────────────────────────────────┘
          △         △
          │         │
    ┌─────┴─────┐   └──────────────────────┐
    │           │                          │
    │           │                    ┌─────────────────┐
    │    ┌──────────────────────┐   │  Phase 3: AWS   │
    │    │ Mock Generator       │   │  (Placeholder)  │
    │    │ (Phase 1 Focus)      │   └─────────────────┘
    │    └──────────────────────┘
    │
    └──→ String (raw response)
         ↓
    ┌──────────────────────────────┐
    │  ResponseParser (DBC)        │
    │  + parse(String) → Map       │
    └──────────────────────────────┘
         ↓
    Map<String, dynamic>
         ↓
    ┌──────────────────────────────┐
    │  OrchestrateUIFlowUseCase    │
    │  + execute(prompt)           │
    └──────────────────────────────┘
         ↓
    ┌──────────────────────────────┐
    │    LLMResponse               │
    │    + id, model, content[]    │
    ├──────────────────────────────┤
    │  ContentBlock (abstract)     │
    │  ├── TextBlock               │
    │  └── ToolUseBlock            │
    └──────────────────────────────┘
```

---

**Status**: Data model complete. Ready for Phase 1 implementation.
