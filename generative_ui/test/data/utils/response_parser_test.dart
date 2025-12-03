import 'package:flutter_test/flutter_test.dart';

import 'package:generative_ui/generative_ui.dart';
import 'package:generative_ui/src/data/utils/response_parser.dart';

void main() {
  group('ResponseParser', () {
    group('Valid JSON parsing', () {
      test('parses valid JSON object correctly', () {
        const jsonString = '{"id": "test", "model": "claude", "content": []}';
        final result = ResponseParser.parse(jsonString);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], equals('test'));
        expect(result['model'], equals('claude'));
      });
    });

    group('Markdown-wrapped JSON', () {
      test('extracts JSON from markdown code blocks', () {
        const markdownJson = '''
```json
{
  "id": "123",
  "model": "claude-3",
  "content": []
}
```
''';
        final result = ResponseParser.parse(markdownJson);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], equals('123'));
      });

      test('extracts JSON from markdown without json label', () {
        const markdown = '''
```
{"id": "456", "model": "gpt", "content": []}
```
''';
        final result = ResponseParser.parse(markdown);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], equals('456'));
      });
    });

    group('JSON with whitespace', () {
      test('parses JSON with leading/trailing whitespace', () {
        const jsonWithWhitespace = '''

        {"id": "789", "model": "test", "content": []}

        ''';
        final result = ResponseParser.parse(jsonWithWhitespace);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], equals('789'));
      });

      test('parses JSON with internal whitespace', () {
        const jsonWithInternalWhitespace = '''{
  "id"   :   "inner",
  "model"  : "whitespace",
  "content" : []
}''';
        final result = ResponseParser.parse(jsonWithInternalWhitespace);

        expect(result['id'], equals('inner'));
      });
    });

    group('JSON boundary detection', () {
      test('extracts JSON from text with boundaries', () {
        const textWithJson = 'Before text {"id": "boundary", "model": "test", "content": []} After text';
        final result = ResponseParser.parse(textWithJson);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], equals('boundary'));
      });

      test('handles nested braces correctly', () {
        const nestedJson = '''{"id": "nested", "model": "test", "input": {"key": "value", "nested": {"deep": true}}}''';
        final result = ResponseParser.parse(nestedJson);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], equals('nested'));
        expect(result['input'], isA<Map>());
      });
    });

    group('Malformed JSON error handling', () {
      test('throws ParsingException for invalid JSON', () {
        const invalidJson = '{"id": invalid_value}';
        expect(
          () => ResponseParser.parse(invalidJson),
          throwsA(isA<ParsingException>()),
        );
      });

      test('throws ParsingException for non-object JSON', () {
        const arrayJson = '[1, 2, 3]';
        expect(
          () => ResponseParser.parse(arrayJson),
          throwsA(isA<ParsingException>()),
        );
      });

      test('throws ParsingException for empty input', () {
        expect(
          () => ResponseParser.parse(''),
          throwsA(isA<ParsingException>()),
        );
      });

      test('preserves original input in ParsingException', () {
        const malformedJson = '{"bad": malformed}';
        try {
          ResponseParser.parse(malformedJson);
          fail('Should have thrown ParsingException');
        } catch (e) {
          expect(e, isA<ParsingException>());
          final exception = e as ParsingException;
          expect(exception.originalInput, contains('bad'));
        }
      });
    });

    group('Edge cases', () {
      test('handles JSON with escaped quotes', () {
        const escapedJson = '{"id": "test\\"quote", "model": "test", "content": []}';
        final result = ResponseParser.parse(escapedJson);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], contains('quote'));
      });

      test('handles empty object', () {
        const emptyObject = '{}';
        final result = ResponseParser.parse(emptyObject);

        expect(result, isA<Map<String, dynamic>>());
        expect(result.length, equals(0));
      });

      test('handles large nested structures', () {
        const largeJson = '''{
  "id": "large",
  "data": {
    "level1": {
      "level2": {
        "level3": {
          "level4": {
            "value": "deep"
          }
        }
      }
    }
  }
}''';
        final result = ResponseParser.parse(largeJson);

        expect(result['id'], equals('large'));
        expect(
          result['data']['level1']['level2']['level3']['level4']['value'],
          equals('deep'),
        );
      });
    });
  });
}
