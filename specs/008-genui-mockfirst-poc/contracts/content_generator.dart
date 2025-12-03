/// ContentGenerator Interface Contract
///
/// This file defines the abstract contract that all content generators
/// (Mock, AWS, etc.) must implement. It ensures a clean separation between
/// backend implementations and the orchestration logic.
///
/// Phase 1: MockContentGenerator (this file's reference implementation)
/// Phase 3: AwsPassThroughGenerator (future AWS Bedrock integration)
library;

abstract class IContentGenerator {
  /// Generates content response based on user input
  ///
  /// This method represents the "generation" step in the LLM orchestration pipeline.
  /// It abstracts away the specific implementation (mock, real LLM, etc.) and provides
  /// a unified interface for the client to request content.
  ///
  /// Parameters:
  ///   - userPrompt: The primary user input string. This can be a user's text message,
  ///     command, or request (e.g., "Setup Wi-Fi", "Show me the dashboard").
  ///
  ///   - context (optional): Optional metadata dictionary containing:
  ///     * Session history: Previous messages in the conversation
  ///     * User state: Information about the current user/device state
  ///     * Environment: Target device capabilities, theme preference, etc.
  ///     * For Phase 1 (Mock), this is ignored; for Phase 3 (AWS), it enhances the prompt.
  ///
  /// Returns:
  ///   A Future resolving to a raw string response. The response format should follow
  ///   Claude's response structure (including tool_use blocks). However, the string
  ///   may be wrapped in markdown, contain extra whitespace, or have other formatting
  ///   quirks. This is intentional: the downstream ResponseParser is responsible for
  ///   extracting and cleaning the JSON.
  ///
  ///   Example return value:
  ///   ```
  ///   {
  ///     "id": "msg_001",
  ///     "model": "claude-3-mock",
  ///     "content": [
  ///       {
  ///         "type": "tool_use",
  ///         "name": "WifiSettingsCard",
  ///         "input": { "ssid": "Guest", "security": "WPA3" }
  ///       }
  ///     ]
  ///   }
  ///   ```
  ///
  /// Throws:
  ///   - ContentGenerationException: If generation fails for any reason
  ///     (network error, invalid input, timeout, etc.). The exception should
  ///     include a descriptive message for debugging.
  ///
  /// Async Behavior:
  ///   - Implementations SHOULD be asynchronous to match the real LLM behavior
  ///   - MockContentGenerator simulates latency with Future.delayed()
  ///   - AwsPassThroughGenerator (Phase 3) will use HTTP requests
  ///
  /// Contract Guarantee:
  ///   - If the Future completes successfully, the return value is GUARANTEED to be
  ///     a non-empty string containing valid JSON (though possibly wrapped/malformed).
  ///   - If generation fails, the implementation MUST throw ContentGenerationException,
  ///     never return an error JSON or null.
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  });

  /// Optional: Get the current backend identifier
  ///
  /// Useful for logging/debugging to identify which implementation is active.
  /// Phase 1: Returns "mock"
  /// Phase 3: Returns "aws-bedrock"
  String get backendId => 'unknown';

  /// Optional: Check if backend is available
  ///
  /// Phase 1: Always returns true (local)
  /// Phase 3: Could return false if network unavailable
  Future<bool> isAvailable() async => true;
}

// Reference Mock Implementation (Phase 1)
class MockContentGenerator implements IContentGenerator {
  @override
  String get backendId => 'mock';

  @override
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  }) async {
    // Simulate network latency (100ms typical for local response)
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _getResponseForPrompt(userPrompt),
    );
  }

  String _getResponseForPrompt(String prompt) {
    final lower = prompt.toLowerCase();

    if (lower.contains('wifi')) {
      return '''{
        "id": "msg_wifi",
        "model": "claude-3-mock",
        "content": [{
          "type": "tool_use",
          "id": "tool_wifi",
          "name": "WifiSettingsCard",
          "input": {
            "ssid": "Guest_Network",
            "security": "WPA3",
            "isEnabled": true
          }
        }]
      }''';
    }

    if (lower.contains('error')) {
      return '{invalid: json}'; // Intentionally malformed for testing
    }

    return '''{
      "id": "msg_default",
      "model": "claude-3-mock",
      "content": [{
        "type": "text",
        "text": "Response to: $prompt"
      }]
    }''';
  }

  @override
  Future<bool> isAvailable() {
    throw UnimplementedError();
  }
}

// Placeholder for Phase 3 AWS Integration
class AwsPassThroughGenerator implements IContentGenerator {
  @override
  String get backendId => 'aws-bedrock';

  @override
  Future<String> generate({
    required String userPrompt,
    Map<String, dynamic>? context,
  }) async {
    throw UnimplementedError(
      'AWS integration deferred to Phase 3. '
      'This will use aws_signature_v4 and http to call Bedrock API.',
    );
  }

  @override
  Future<bool> isAvailable() {
    throw UnimplementedError();
  }
}
