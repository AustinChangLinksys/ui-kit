# Phase 1: Quick Start Guide

**Purpose**: Get GenUI mock orchestration running in 15 minutes
**Date**: 2025-12-03
**Target Audience**: Flutter developers implementing Phase 1

---

## Setup: 5 Minutes

### 1.1 Create Module Structure

```bash
# Create package directory
mkdir -p lib/src/generative_ui/lib/src/{domain,data,presentation}
mkdir -p lib/src/generative_ui/{assets,test}

# Create file structure
cd lib/src/generative_ui

# Domain layer
mkdir -p lib/src/domain/{entities,repositories,usecases}

# Data layer
mkdir -p lib/src/data/{datasources,utils}

# Presentation layer
mkdir -p lib/src/presentation/controllers

# Assets
touch assets/ai_config.json

# Tests
mkdir -p test/{domain,data,presentation}
```

### 1.2 Create pubspec.yaml

```yaml
name: generative_ui
description: GenUI Mock-First PoC - Client-side orchestration for LLM-driven UI generation
version: 0.1.0

environment:
  sdk: ">=3.0.0 <4.0.0"
  flutter: ">=3.13.0"

dependencies:
  flutter:
    sdk: flutter
  ui_kit:
    path: ../

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  assets:
    - assets/ai_config.json
```

---

## Implementation: 10 Minutes

### 2.1 Domain Layer - Exceptions

**File: `lib/src/domain/entities/gen_exception.dart`**

```dart
abstract class GenException implements Exception {
  final String message;
  GenException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class ParsingException extends GenException {
  final String originalInput;

  ParsingException(
    String message, {
    required this.originalInput,
  }) : super(message);
}

class ContentGenerationException extends GenException {
  ContentGenerationException(String message) : super(message);
}

class ToolUseValidationException extends GenException {
  ToolUseValidationException(String message) : super(message);
}
```

### 2.2 Domain Layer - Entities

**File: `lib/src/domain/entities/content_block.dart`**

```dart
abstract class ContentBlock {
  bool get isToolUse => this is ToolUseBlock;
  bool get isText => this is TextBlock;
}

class TextBlock extends ContentBlock {
  final String text;

  TextBlock({required this.text});

  factory TextBlock.fromJson(Map<String, dynamic> json) {
    return TextBlock(text: json['text'] as String);
  }

  Map<String, dynamic> toJson() => {'type': 'text', 'text': text};
}

class ToolUseBlock extends ContentBlock {
  final String id;
  final String name;
  final Map<String, dynamic> input;

  ToolUseBlock({
    required this.id,
    required this.name,
    required this.input,
  });

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
}

class LLMResponse {
  final String id;
  final String model;
  final List<ContentBlock> content;
  final DateTime timestamp;

  const LLMResponse({
    required this.id,
    required this.model,
    required this.content,
    required this.timestamp,
  });

  ToolUseBlock? getFirstToolUse() {
    for (final block in content) {
      if (block is ToolUseBlock) return block;
    }
    return null;
  }
}
```

### 2.3 Domain Layer - Repository Interface

**File: `lib/src/domain/repositories/i_content_generator.dart`**

```dart
abstract class IContentGenerator {
  /// Generate content based on user prompt
  /// Returns raw string response (pre-parsing)
  /// Throws: ContentGenerationException
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  });
}
```

### 2.4 Data Layer - JSON Parser (Core Logic)

**File: `lib/src/data/utils/response_parser.dart`**

```dart
import 'dart:convert';
import 'package:generative_ui/src/domain/entities/gen_exception.dart';

class ResponseParser {
  /// Parse raw LLM response into structured Map
  /// DBC: Precondition - rawInput must be non-empty
  /// DBC: Postcondition - returns valid Map<String, dynamic> or throws
  static Map<String, dynamic> parse(String rawInput) {
    // 1. Precondition check
    if (rawInput.trim().isEmpty) {
      throw ParsingException(
        'Raw input cannot be empty',
        originalInput: rawInput,
      );
    }

    try {
      String cleanContent = rawInput.trim();

      // 2. Handle markdown ```json ... ``` blocks
      if (cleanContent.contains('```')) {
        final start = cleanContent.indexOf('{');
        final end = cleanContent.lastIndexOf('}');

        if (start >= 0 && end > start) {
          cleanContent = cleanContent.substring(start, end + 1);
        }
      }

      // 3. Decode JSON
      final result = jsonDecode(cleanContent);

      // 4. Postcondition check
      if (result is! Map<String, dynamic>) {
        throw ParsingException(
          'Parsed result must be JSON object, got ${result.runtimeType}',
          originalInput: rawInput,
        );
      }

      return result;
    } catch (e) {
      if (e is ParsingException) rethrow;
      throw ParsingException(
        'Failed to parse: $e',
        originalInput: rawInput,
      );
    }
  }
}
```

### 2.5 Data Layer - Mock Generator

**File: `lib/src/data/datasources/mock_content_generator.dart`**

```dart
import 'dart:convert';
import 'package:generative_ui/src/domain/repositories/i_content_generator.dart';

class MockContentGenerator implements IContentGenerator {
  @override
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  }) async {
    // Simulate network latency
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _getResponseForPrompt(userPrompt),
    );
  }

  String _getResponseForPrompt(String prompt) {
    final lower = prompt.toLowerCase();

    // Scenario 1: Wi-Fi configuration
    if (lower.contains('wifi') || lower.contains('wi-fi')) {
      return jsonEncode({
        'id': 'msg_001',
        'model': 'claude-3-mock',
        'content': [
          {
            'type': 'tool_use',
            'id': 'tool_wifi',
            'name': 'WifiSettingsCard',
            'input': {
              'ssid': 'Guest_Network',
              'security': 'WPA3',
              'isEnabled': true,
            }
          }
        ]
      });
    }

    // Scenario 3: Error handling (intentionally malformed)
    if (lower.contains('error') || lower.contains('test error')) {
      return '{invalid json}'; // Missing closing brace - tests parser error handling
    }

    // Scenario 2: Default info card
    return jsonEncode({
      'id': 'msg_002',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'text',
          'text': 'Response to: $prompt'
        }
      ]
    });
  }
}
```

### 2.6 Domain Layer - UseCase (Orchestration)

**File: `lib/src/domain/usecases/orchestrate_ui_flow.dart`**

```dart
import 'package:generative_ui/src/data/utils/response_parser.dart';
import 'package:generative_ui/src/domain/entities/content_block.dart';
import 'package:generative_ui/src/domain/entities/gen_exception.dart';
import 'package:generative_ui/src/domain/repositories/i_content_generator.dart';

class OrchestrateUIFlowUseCase {
  final IContentGenerator contentGenerator;

  OrchestrateUIFlowUseCase({required this.contentGenerator});

  /// Main orchestration: Generate → Parse → Validate
  Future<LLMResponse> execute({required String userPrompt}) async {
    try {
      // 1. Generate raw response
      final raw = await contentGenerator.generate(userPrompt: userPrompt);

      // 2. Parse to structured format
      final parsed = ResponseParser.parse(raw);

      // 3. Build domain model
      final response = _buildResponse(parsed);

      // 4. Validate
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

    if (json['content'] is List) {
      for (final block in json['content'] as List) {
        final blockMap = block as Map<String, dynamic>;
        if (blockMap['type'] == 'tool_use') {
          content.add(ToolUseBlock.fromJson(blockMap));
        } else if (blockMap['type'] == 'text') {
          content.add(TextBlock.fromJson(blockMap));
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
  }
}
```

### 2.7 Create Configuration File

**File: `assets/ai_config.json`**

```json
{
  "version": "0.1.0",
  "phase": "mock",
  "mock": {
    "enabled": true,
    "delay_ms": 100
  }
}
```

### 2.8 Library Export

**File: `lib/generative_ui.dart`**

```dart
// Domain
export 'src/domain/entities/gen_exception.dart';
export 'src/domain/entities/content_block.dart';
export 'src/domain/repositories/i_content_generator.dart';
export 'src/domain/usecases/orchestrate_ui_flow.dart';

// Data
export 'src/data/datasources/mock_content_generator.dart';
export 'src/data/utils/response_parser.dart';
```

---

## Testing: Verification

### 3.1 Unit Test - Parser Robustness

**File: `test/data/utils/response_parser_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/data/utils/response_parser.dart';
import 'package:generative_ui/src/domain/entities/gen_exception.dart';

void main() {
  group('ResponseParser', () {
    test('parses valid JSON', () {
      final json = '{"type": "tool_use", "name": "Test"}';
      final result = ResponseParser.parse(json);
      expect(result['type'], equals('tool_use'));
      expect(result['name'], equals('Test'));
    });

    test('extracts JSON from markdown code block', () {
      final wrapped = '```json\n{"type": "test"}\n```';
      final result = ResponseParser.parse(wrapped);
      expect(result['type'], equals('test'));
    });

    test('throws on empty input', () {
      expect(
        () => ResponseParser.parse(''),
        throwsA(isA<ParsingException>()),
      );
    });

    test('throws on malformed JSON', () {
      expect(
        () => ResponseParser.parse('{invalid}'),
        throwsA(isA<ParsingException>()),
      );
    });

    test('throws on non-object JSON', () {
      expect(
        () => ResponseParser.parse('["array"]'),
        throwsA(isA<ParsingException>()),
      );
    });
  });
}
```

### 3.2 Unit Test - Mock Generator

**File: `test/data/datasources/mock_content_generator_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/data/datasources/mock_content_generator.dart';

void main() {
  group('MockContentGenerator', () {
    late MockContentGenerator generator;

    setUp(() {
      generator = MockContentGenerator();
    });

    test('returns Wi-Fi scenario on "wifi" keyword', () async {
      final result = await generator.generate(userPrompt: 'Setup Wi-Fi');
      expect(result, contains('WifiSettingsCard'));
    });

    test('returns error scenario on "error" keyword', () async {
      final result = await generator.generate(userPrompt: 'Test Error');
      expect(result, contains('{invalid'));
    });

    test('returns default info card otherwise', () async {
      final result = await generator.generate(userPrompt: 'Hello');
      expect(result, contains('text'));
    });
  });
}
```

### 3.3 Integration Test - Full Orchestration

**File: `test/domain/usecases/orchestrate_ui_flow_test.dart`**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/data/datasources/mock_content_generator.dart';
import 'package:generative_ui/src/domain/usecases/orchestrate_ui_flow.dart';

void main() {
  group('OrchestrateUIFlowUseCase', () {
    late OrchestrateUIFlowUseCase useCase;

    setUp(() {
      useCase = OrchestrateUIFlowUseCase(
        contentGenerator: MockContentGenerator(),
      );
    });

    test('orchestrates Wi-Fi scenario successfully', () async {
      final response = await useCase.execute(userPrompt: 'Setup Wi-Fi');
      expect(response.model, contains('mock'));
      expect(response.getFirstToolUse()?.name, equals('WifiSettingsCard'));
    });

    test('handles error scenario gracefully', () async {
      expect(
        () => useCase.execute(userPrompt: 'Test Error'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
```

---

## Usage Example

### 4.1 In a Flutter Widget

```dart
import 'package:flutter/material.dart';
import 'package:generative_ui/generative_ui.dart';

class GenUIDemo extends StatefulWidget {
  @override
  State<GenUIDemo> createState() => _GenUIDemoState();
}

class _GenUIDemoState extends State<GenUIDemo> {
  late final OrchestrateUIFlowUseCase _useCase;
  LLMResponse? _response;
  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _useCase = OrchestrateUIFlowUseCase(
      contentGenerator: MockContentGenerator(),
    );
  }

  void _handleSubmit(String prompt) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _response = null;
    });

    try {
      final response = await _useCase.execute(userPrompt: prompt);
      setState(() {
        _response = response;
        _isLoading = false;
      });
    } on ParsingException catch (e) {
      setState(() {
        _error = 'Parsing failed: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GenUI Demo')),
      body: Column(
        children: [
          // Input field (omitted for brevity)
          // ...

          if (_isLoading) CircularProgressIndicator(),
          if (_error != null) Text('Error: $_error', style: TextStyle(color: Colors.red)),
          if (_response != null) ...[
            Text('Model: ${_response!.model}'),
            if (_response!.getFirstToolUse() != null)
              Text('Tool: ${_response!.getFirstToolUse()!.name}'),
          ]
        ],
      ),
    );
  }
}
```

---

## Verification Checklist

- [ ] All files created in correct locations
- [ ] `pubspec.yaml` configured with Flutter dependencies
- [ ] Parser handles 5 malformed formats (SC-002)
- [ ] Mock scenarios trigger correctly (SC-001)
- [ ] All unit tests pass
- [ ] Integration test passes end-to-end flow
- [ ] No dependency violations (Constitution check)
- [ ] `ai_config.json` loads without errors

---

## Next Steps (Phase 2)

1. Create `GenUiWrapper` widget for UI rendering
2. Connect to actual UI Kit components (WifiSettingsCard, etc.)
3. Add system prompt template to `ai_config.json`
4. Create golden tests with Safe Mode protocol
5. Prepare for AWS integration placeholder

---

**Status**: Quick start complete. Ready to run Phase 1 tests and demo.
