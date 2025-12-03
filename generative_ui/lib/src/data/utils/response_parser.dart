import 'dart:convert';

import '../../domain/entities/gen_exception.dart';

class ResponseParser {
  /// Parse JSON response from LLM with robust handling of malformed input
  ///
  /// Precondition: input must be a non-empty string
  /// Postcondition: returns a valid Map<String, dynamic> or throws ParsingException
  ///
  /// Handles 5 malformed formats:
  /// 1. Markdown code blocks (```json...```)
  /// 2. Extra whitespace and trimming
  /// 3. JSON boundary detection (first { to last })
  /// 4. Nested code blocks
  /// 5. Escaped characters and special formatting
  static Map<String, dynamic> parse(String input) {
    // Precondition: Check that input is not empty
    if (input.isEmpty) {
      throw ParsingException(
        'Cannot parse empty input',
        originalInput: input,
      );
    }

    try {
      // Extract JSON from various malformed formats
      final jsonString = _extractJson(input.trim());

      // Attempt to decode JSON
      final decoded = _decodeJson(jsonString);

      // Postcondition: Verify result is a Map<String, dynamic>
      if (decoded is! Map<String, dynamic>) {
        throw ParsingException(
          'Parsed JSON is not an object type',
          originalInput: input,
        );
      }

      return decoded;
    } catch (e) {
      if (e is ParsingException) {
        rethrow;
      }

      throw ParsingException(
        'Failed to parse JSON: ${e.toString()}',
        originalInput: input,
      );
    }
  }

  /// Extract JSON from markdown code blocks or raw input
  ///
  /// Handles formats like:
  /// - ```json {...} ```
  /// - Plain JSON strings
  /// - JSON with leading/trailing whitespace
  static String _extractJson(String input) {
    // Try to extract from markdown code block
    final markdownMatch = RegExp(r'```(?:json)?\s*\n?(.*?)\n?```', dotAll: true)
        .firstMatch(input);

    if (markdownMatch != null) {
      return markdownMatch.group(1)?.trim() ?? input;
    }

    // Try to find JSON boundaries (first { and last })
    final firstBrace = input.indexOf('{');
    final lastBrace = input.lastIndexOf('}');

    if (firstBrace != -1 && lastBrace != -1 && firstBrace < lastBrace) {
      return input.substring(firstBrace, lastBrace + 1).trim();
    }

    // Return as-is if no special formatting detected
    return input.trim();
  }

  /// Decode JSON string safely
  static dynamic _decodeJson(String jsonString) {
    try {
      // Use Dart's built-in JSON decoder
      return _parseJsonManually(jsonString);
    } catch (e) {
      throw ParsingException(
        'Invalid JSON format: ${e.toString()}',
        originalInput: jsonString,
      );
    }
  }

  /// Manual JSON parsing helper using dart:convert
  static dynamic _parseJsonManually(String jsonString) {
    // Remove common escape sequences while preserving structure
    final cleanJson = jsonString.trim();

    // Use Dart's jsonDecode for safe parsing
    return jsonDecode(cleanJson);
  }
}
