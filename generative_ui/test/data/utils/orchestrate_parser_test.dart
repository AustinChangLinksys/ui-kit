import 'package:flutter_test/flutter_test.dart';

import 'package:generative_ui/generative_ui.dart';

void main() {
  group('Parser Integration Tests', () {
    group('Parser → LLMResponse entity conversion', () {
      test('parses valid Claude response and builds LLMResponse entity', () {
        const claudeJsonResponse = '''{
  "id": "msg_12345",
  "model": "claude-3-sonnet-20240229",
  "content": [
    {
      "type": "text",
      "text": "Here is a Wi-Fi configuration response"
    }
  ]
}''';

        final parsed = ResponseParser.parse(claudeJsonResponse);
        final llmResponse = LLMResponse.fromMap(parsed);

        expect(llmResponse.id, equals('msg_12345'));
        expect(llmResponse.model, contains('claude'));
        expect(llmResponse.content, isNotEmpty);
        expect(llmResponse.content.first, isA<TextBlock>());
      });

      test('parses tool_use block and creates ToolUseBlock entity', () {
        const toolUseResponse = '''{
  "id": "msg_67890",
  "model": "claude-3-sonnet-20240229",
  "content": [
    {
      "type": "tool_use",
      "id": "tool_123",
      "name": "WifiSettingsCard",
      "input": {
        "ssid": "HomeNetwork",
        "security": "WPA2",
        "isEnabled": true
      }
    }
  ]
}''';

        final parsed = ResponseParser.parse(toolUseResponse);
        final llmResponse = LLMResponse.fromMap(parsed);

        expect(llmResponse.content.first, isA<ToolUseBlock>());
        final toolBlock = llmResponse.content.first as ToolUseBlock;
        expect(toolBlock.name, equals('WifiSettingsCard'));
        expect(toolBlock.input['ssid'], equals('HomeNetwork'));
        expect(toolBlock.input['security'], equals('WPA2'));
        expect(toolBlock.input['isEnabled'], equals(true));
      });

      test('parses markdown-wrapped JSON and builds domain entity', () {
        const markdownWrappedResponse = '''
Here is the generated response in JSON format:

```json
{
  "id": "msg_markdown",
  "model": "claude-3-sonnet-20240229",
  "content": [
    {
      "type": "text",
      "text": "Info card content"
    }
  ]
}
```

End of response.
''';

        final parsed = ResponseParser.parse(markdownWrappedResponse);
        final llmResponse = LLMResponse.fromMap(parsed);

        expect(llmResponse.id, equals('msg_markdown'));
        expect(llmResponse.isValid(), equals(true));
      });

      test('handles mixed content blocks', () {
        const mixedContent = '''{
  "id": "msg_mixed",
  "model": "claude-3",
  "content": [
    {
      "type": "text",
      "text": "First, here is some explanatory text"
    },
    {
      "type": "tool_use",
      "id": "tool_info",
      "name": "InfoCard",
      "input": {"message": "This is an info card"}
    },
    {
      "type": "text",
      "text": "And some follow-up text"
    }
  ]
}''';

        final parsed = ResponseParser.parse(mixedContent);
        final llmResponse = LLMResponse.fromMap(parsed);

        expect(llmResponse.content.length, equals(3));
        expect(llmResponse.content[0], isA<TextBlock>());
        expect(llmResponse.content[1], isA<ToolUseBlock>());
        expect(llmResponse.content[2], isA<TextBlock>());
      });

      test('getFirstToolUse retrieves first tool_use block', () {
        const responseWithTools = '''{
  "id": "msg_tools",
  "model": "claude-3",
  "content": [
    {
      "type": "text",
      "text": "Here is a tool:"
    },
    {
      "type": "tool_use",
      "id": "first_tool",
      "name": "FirstTool",
      "input": {}
    },
    {
      "type": "tool_use",
      "id": "second_tool",
      "name": "SecondTool",
      "input": {}
    }
  ]
}''';

        final parsed = ResponseParser.parse(responseWithTools);
        final llmResponse = LLMResponse.fromMap(parsed);

        final firstTool = llmResponse.getFirstToolUse();
        expect(firstTool, isNotNull);
        expect(firstTool!.id, equals('first_tool'));
        expect(firstTool.name, equals('FirstTool'));
      });

      test('validates LLMResponse entity structure', () {
        const validResponse = '''{
  "id": "msg_valid",
  "model": "claude-3",
  "content": [
    {
      "type": "text",
      "text": "Valid response"
    }
  ]
}''';

        final parsed = ResponseParser.parse(validResponse);
        final llmResponse = LLMResponse.fromMap(parsed);

        expect(llmResponse.isValid(), equals(true));
      });

      test('handles response with missing optional fields', () {
        const minimalResponse = '''{
  "id": "msg_minimal",
  "model": "claude-3",
  "content": [
    {
      "type": "text",
      "text": "Text"
    }
  ]
}''';

        final parsed = ResponseParser.parse(minimalResponse);
        final llmResponse = LLMResponse.fromMap(parsed);

        expect(llmResponse.stopReason, isNull);
        expect(llmResponse.content, isNotEmpty);
      });
    });

    group('Error scenarios', () {
      test('handles parsing of error responses gracefully', () {
        const errorResponse = '''{
  "id": "msg_error",
  "model": "claude-3",
  "error": {
    "type": "invalid_request",
    "message": "Invalid input"
  }
}''';

        final parsed = ResponseParser.parse(errorResponse);
        expect(parsed, isA<Map<String, dynamic>>());
        expect(parsed.containsKey('error'), equals(true));
      });

      test('gracefully handles missing id in parsed response', () {
        const noIdResponse = '''{
  "model": "claude-3",
  "content": []
}''';

        final parsed = ResponseParser.parse(noIdResponse);
        final llmResponse = LLMResponse.fromMap(parsed);

        expect(llmResponse.id, isEmpty);
        expect(llmResponse.isValid(), equals(false));
      });
    });
  });
}
