import 'dart:async';

import '../../domain/repositories/i_content_generator.dart';

class MockContentGenerator implements IContentGenerator {
  static const int defaultLatencyMs = 100;

  @override
  Future<String> generate(String userInput) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: defaultLatencyMs));

    // Route to appropriate scenario based on keyword matching
    final keyword = userInput.toLowerCase().trim();

    if (keyword.contains('wifi') || keyword.contains('setup')) {
      return _getWifiSettingsResponse();
    } else if (keyword.contains('error') || keyword.contains('fail')) {
      return _getErrorResponse();
    } else {
      // Default: Info card scenario
      return _getInfoResponse(userInput);
    }
  }

  /// Wi-Fi Settings Scenario
  /// Returns a tool_use response for WifiSettingsCard component
  String _getWifiSettingsResponse() {
    return '''{
  "id": "msg_wifi_settings",
  "model": "claude-3-mock",
  "content": [
    {
      "type": "text",
      "text": "I'll help you configure your Wi-Fi settings."
    },
    {
      "type": "tool_use",
      "id": "tool_wifi_123",
      "name": "WifiSettingsCard",
      "input": {
        "ssid": "HomeNetwork",
        "security": "WPA2",
        "isEnabled": true,
        "signal": 85,
        "frequency": "2.4GHz"
      }
    }
  ]
}''';
  }

  /// Info Card Scenario (Default)
  /// Returns a text-based response for InfoCard component
  String _getInfoResponse(String originalInput) {
    final message = originalInput.isNotEmpty
        ? 'This is an informational card. You asked: $originalInput'
        : 'This is an informational card.';

    return '''{
  "id": "msg_info_card",
  "model": "claude-3-mock",
  "content": [
    {
      "type": "tool_use",
      "id": "tool_info_456",
      "name": "InfoCard",
      "input": {
        "title": "Information",
        "message": "$message",
        "type": "info",
        "icon": "info"
      }
    }
  ]
}''';
  }

  /// Error Scenario
  /// Returns intentionally malformed JSON for error handling testing
  String _getErrorResponse() {
    return '''{
  "id": "msg_error_789",
  "model": "claude-3-mock",
  "content": [
    {
      "type": "tool_use",
      "id": "tool_error",
      "name": "ErrorCard",
      "input": {
        "title": "An Error Occurred",
        "message": "The operation could not be completed.",
        "errorCode": 500,
        "recoveryAction": "Please try again later"
      }
    }
  ]
}''';
  }
}
