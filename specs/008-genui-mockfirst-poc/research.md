# Phase 0 Research: GenUI Mock-First PoC

**Purpose**: Resolve technical unknowns and establish implementation foundations
**Date**: 2025-12-03
**Status**: Complete

---

## 1. JSON Parser Robustness Strategy

### Decision: Hybrid Regex + Try-Catch Approach

**Problem**: LLM responses can be wrapped in markdown code blocks, have extra whitespace, or be nested in other structures. We need robust extraction without requiring perfect JSON input.

**Selected Approach**:
```dart
// Step 1: Extract markdown-wrapped content
// Match: ```json ... ``` or ```dart ... ``` patterns

// Step 2: Find JSON boundaries
// Locate first '{' and last '}' to handle junk before/after

// Step 3: Use jsonDecode with fallback
// If basic parse fails, try alternative approaches

// Step 4: Validate postcondition
// Ensure result is Map<String, dynamic> with expected structure
```

**Rationale**:
- Regex extraction handles markdown wrapping (common LLM behavior)
- Boundary detection handles extra text (timestamps, notes)
- Try-catch + detailed exceptions enable debugging
- DBC postcondition validates data shape before passing to UI layer

**Alternatives Considered**:
- ❌ Regular expression only: Would fail on nested structures or missing delimiters
- ❌ jsonDecode with no preprocessing: Would throw unhelpful errors on malformed input
- ✅ Hybrid approach: Balances robustness with clarity

**Test Coverage** (5 malformed formats per SC-002):
1. JSON wrapped in ```json ... ```
2. JSON with leading/trailing whitespace
3. JSON with markdown annotations before/after
4. JSON with nested code blocks
5. Partially escaped JSON (single quote issues)

---

## 2. Design by Contract (DBC) Implementation

### Decision: Explicit Preconditions/Postconditions in ResponseParser

**Problem**: Parser must fail loudly when encountering invalid input, preventing cascading errors in UI rendering.

**Selected Approach**:

```dart
class ResponseParser {
  /// Precondition: rawInput must be non-null and non-empty
  /// Postcondition: Returns valid Map<String, dynamic> or throws ParsingException
  static Map<String, dynamic> parse(String rawInput) {
    // 1. Precondition check
    if (rawInput.trim().isEmpty) {
      throw ArgumentError("Raw input cannot be empty");
    }

    try {
      // 2. Extract & clean
      final cleaned = _extractJson(rawInput);

      // 3. Decode
      final decoded = jsonDecode(cleaned);

      // 4. Postcondition check
      if (decoded is! Map<String, dynamic>) {
        throw FormatException("Result must be JSON object, got ${decoded.runtimeType}");
      }

      return decoded;
    } catch (e) {
      // 5. Throw descriptive exception
      throw ParsingException("Failed to parse LLM response: $e", originalInput: rawInput);
    }
  }
}

class ParsingException implements Exception {
  final String message;
  final String originalInput;
  ParsingException(this.message, {required this.originalInput});

  @override
  String toString() => "ParsingException: $message\n(Input: ${originalInput.substring(0, min(100, originalInput.length))}...)";
}
```

**Rationale**:
- Clear contract prevents invalid data from reaching UI
- Custom exception enables debugging (includes original input)
- Tests can verify both valid and invalid paths
- Matches Dart convention of fail-fast with descriptive errors

**Testing Strategy**:
- Unit tests verify precondition validation (empty strings, null)
- Unit tests verify postcondition validation (wrong type, missing fields)
- Integration tests verify malformed JSON handling

---

## 3. ContentGenerator Interface Design

### Decision: Async Interface with Consistent Contract

**Problem**: Mock and AWS backends need unified interface to enable seamless swapping in Phase 3.

**Selected Approach**:

```dart
// File: domain/repositories/i_content_generator.dart

abstract class IContentGenerator {
  /// Orchestrates LLM-like content generation
  ///
  /// Input: User prompt text + context (for future use)
  /// Output: Raw string response (pre-parsing)
  /// Throws: ContentGenerationException if generation fails
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  });
}

// MockContentGenerator implementation
class MockContentGenerator implements IContentGenerator {
  @override
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  }) async {
    // Keyword matching → predefined JSON
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _getResponseForPrompt(userPrompt),
    );
  }

  String _getResponseForPrompt(String prompt) {
    // Case-insensitive keyword matching
    final lower = prompt.toLowerCase();

    if (lower.contains('wifi') || lower.contains('wi-fi')) {
      return jsonEncode({
        "type": "tool_use",
        "name": "WifiSettingsCard",
        "input": {...}
      });
    } else if (lower.contains('error') || lower.contains('test error')) {
      return '{"invalid": json}'; // Intentionally malformed
    } else {
      return jsonEncode({
        "type": "tool_use",
        "name": "InfoCard",
        "input": {"text": "Response to: $prompt"}
      });
    }
  }
}

// AwsPassThroughGenerator (Phase 3 - Placeholder)
class AwsPassThroughGenerator implements IContentGenerator {
  @override
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  }) async {
    // Phase 3: Implement AWS Bedrock call with SigV4
    throw UnimplementedError('Implement in Phase 3');
  }
}
```

**Rationale**:
- `Future<String>` matches async nature of real LLM (enables testing delays/retries later)
- Returns raw string (not parsed) - allows flexibility in parser evolution
- Custom exceptions enable error handling differentiation
- No dependency on specific backend technology

**Alternatives Considered**:
- ❌ Synchronous interface: Breaks real AWS async model, would need forced Futures
- ❌ Pre-parsed return type: Locks parser interface, breaks Phase 3 flexibility
- ✅ Async raw string: Matches real behavior, parser handles variation

---

## 4. Mock Scenarios Implementation

### Decision: Keyword-Based Routing with Predefined Response Templates

**Problem**: Need to trigger different UI states without complex setup or code changes.

**Selected Approach**:

```dart
// File: data/utils/mock_scenarios.dart

class MockScenarios {
  static const Map<String, String> responses = {
    'wifi': '''
    {
      "type": "tool_use",
      "name": "WifiSettingsCard",
      "input": {
        "ssid": "Guest_Network",
        "security": "WPA3",
        "isEnabled": true
      }
    }
    ''',

    'hello': '''
    {
      "type": "tool_use",
      "name": "InfoCard",
      "input": {
        "text": "Hello! How can I help you today?"
      }
    }
    ''',

    'error': '{invalid: json}', // Intentional malformation
  };
}
```

**Rationale**:
- Simple keyword matching enables rapid iteration
- Predefined templates match Claude's actual output format
- Adding new scenarios requires <10 lines (meets SC-007 requirement)
- Malformed JSON scenario validates parser error handling

**Scenarios Covered** (matches FR-006 & SC-001):

| Scenario | Trigger | Response | Validates |
|----------|---------|----------|-----------|
| Wi-Fi Configuration | "Setup Wi-Fi", "wifi" | WifiSettingsCard JSON | Tool use rendering |
| Plain Text Info | "Hello", "test", default | InfoCard JSON | Text rendering |
| Error Handling | "Test Error", "error" | Malformed JSON | Parser error recovery |

---

## 5. Schema Generator Approach

### Decision: Reflection-Based with Dart's Type System

**Problem**: Need to serialize Flutter widgets to JSON Schema for future AWS integration.

**Selected Approach**:

```dart
// File: data/utils/schema_generator.dart

class SchemaGenerator {
  /// Generates JSON Schema for a Flutter component
  /// Introspects properties and creates Tool Use compatible schema
  static Map<String, dynamic> generateSchema({
    required String componentName,
    required Map<String, SchemaField> fields,
  }) {
    return {
      "type": "tool_use",
      "name": componentName,
      "description": "A $componentName component",
      "input_schema": {
        "type": "object",
        "properties": fields.map(
          (name, field) => MapEntry(
            name,
            {
              "type": field.type, // "string", "boolean", "number", etc.
              "description": field.description,
              if (field.enum != null) "enum": field.enum,
            },
          ),
        ),
        "required": fields.keys.where((k) => fields[k]!.required).toList(),
      }
    };
  }
}

class SchemaField {
  final String type;
  final String description;
  final bool required;
  final List<String>? enum;

  const SchemaField({
    required this.type,
    required this.description,
    this.required = true,
    this.enum,
  });
}

// Usage example:
final wifiSchema = SchemaGenerator.generateSchema(
  componentName: 'WifiSettingsCard',
  fields: {
    'ssid': SchemaField(type: 'string', description: 'Network name'),
    'security': SchemaField(
      type: 'string',
      description: 'Security type',
      enum: ['WPA3', 'WPA2', 'OPEN'],
    ),
    'isEnabled': SchemaField(type: 'boolean', description: 'Enable network'),
  },
);
```

**Rationale**:
- Dart's type system enables compile-time safety
- Reflection-based approach scales to new components without code duplication
- Output format matches Claude's tool use schema (industry standard)
- Separates schema definition from implementation

**Testing** (SC-003):
- Unit tests verify schema structure for 2-3 components
- Schema validation tests ensure output matches JSON Schema Draft 7
- Integration test verifies schema can be passed to mock generator

---

## 6. Testing Strategy & Golden Tests

### Decision: Phased Testing with Safe Mode Protocol

**Problem**: Golden tests must be stable and follow UI Kit standards (Section 12.2).

**Selected Approach**:

**Phase 1 (Unit Tests - Immediate)**:
- Domain layer: Parser, Schema Generator, Mock Scenarios
- No Flutter dependencies needed
- Validates contracts in isolation

**Phase 2 (Integration Tests - MVP)**:
- Presentation layer integration with GenUI state
- Lightweight widget tests (no golden comparisons yet)
- Validates end-to-end flow: Mock → Parser → Renderer

**Phase 3 (Golden Tests - Polish)**:
- Follows Constitution Section 12.2 "Safe Mode Protocol":
  - ✅ Explicit constraints (SizedBox wrapping all scenarios)
  - ✅ Background visibility (ColoredBox with theme background)
  - ✅ Animation freezing (TickerMode(enabled: false))
- Test matrix: 2 themes × 2 brightness (Glass Light/Dark, Brutal Light/Dark for Phase 1)

**Rationale**:
- Domain tests run in <1s (no simulator needed)
- Integration tests validate contracts
- Golden tests deferred until Phase 2 polish (focuses Phase 1 on logic)
- Safe Mode ensures CI/CD stability

---

## 7. AI Config Structure

### Decision: JSON-Based Configuration for Future Extensibility

**Problem**: Need placeholder for Phase 2 system prompt and configuration without breaking Phase 1.

**Selected Approach**:

```json
{
  "version": "0.1.0",
  "phase": "mock",
  "mock": {
    "enabled": true,
    "delay_ms": 100
  },
  "aws": {
    "enabled": false,
    "endpoint": "bedrock-runtime.us-west-2.amazonaws.com",
    "model_id": "anthropic.claude-3-sonnet-20240229-v1:0"
  },
  "system_prompt": "You are a helpful assistant that generates UI components...",
  "tools_schema": []
}
```

**Rationale**:
- Top-level `phase` field enables easy switching (Mock ↔ AWS)
- Structure mirrors CloudFormation/Terraform patterns (familiar to team)
- Comments support future documentation
- Extensible for Phase 2 system prompt and Phase 3 AWS credentials

**Loading**:
```dart
// assets.json loaded at app startup
final config = jsonDecode(
  await rootBundle.loadString('packages/generative_ui/assets/ai_config.json')
);
final isUsingMock = config['phase'] == 'mock';
```

---

## 8. Dependency Resolution

### Decision: Minimal Dependencies for Phase 1

**Phase 1 Dependencies**:
- ✅ `flutter` (core)
- ✅ `ui_kit` (parent package reference)
- ✅ `convert` (for base64, if needed for encoding)

**Phase 3 Future Dependencies**:
- ⏳ `http` (HTTP client - deferred)
- ⏳ `aws_signature_v4` (SigV4 signing - deferred)
- ⏳ `aws_smithy` (AWS SDK patterns - deferred)

**Rationale**:
- Zero external dependencies in Phase 1 (pure Dart + Flutter)
- No dependency creep (bloc, provider, firebase forbidden by Constitution)
- Clean transition to AWS in Phase 3 (single line change to use real generator)

---

## Summary

All technical unknowns resolved:

| Area | Decision | Impact |
|------|----------|--------|
| JSON Parsing | Hybrid regex + DBC | Robust handling of 5 malformed formats |
| Parser Contracts | DBC preconditions/postconditions | Fail-fast with debugging info |
| Backend Interface | Async IContentGenerator | Clean Phase 3 transition |
| Mock Implementation | Keyword-based routing | <10 lines to add scenarios (SC-007) |
| Schema Generation | Reflection-based with type safety | Scalable to new components |
| Testing | Phased approach (unit → integration → golden) | Fast feedback loop |
| Configuration | JSON with phase switching | Future-proof architecture |
| Dependencies | Minimal (no external deps in Phase 1) | Constitution compliant |

**Ready for Phase 1 Design & Implementation**.
