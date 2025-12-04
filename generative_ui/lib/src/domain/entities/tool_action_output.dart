import 'chat_message.dart';

/// Result of user interaction with a dynamic UI component.
///
/// Captures the action performed by the user on a rendered tool use component
/// and provides methods to convert it to the appropriate message format.
class ToolActionOutput {
  /// ID of the tool_use block this action responds to.
  final String toolUseId;

  /// Name of the component (for logging/debugging).
  final String componentName;

  /// Action type (e.g., 'save', 'cancel', 'select').
  final String actionType;

  /// Output data from the component.
  final Map<String, dynamic> data;

  /// Timestamp of action.
  final DateTime timestamp;

  ToolActionOutput({
    required this.toolUseId,
    required this.componentName,
    required this.actionType,
    required this.data,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Convert to tool_result content format.
  ///
  /// Combines action type with the data for the AI to understand
  /// what action the user took.
  Map<String, dynamic> toResultContent() => {
        'action': actionType,
        ...data,
      };

  /// Create ChatMessage for this action.
  ///
  /// Creates a tool result message that can be added to the conversation
  /// and sent to the AI for processing.
  ChatMessage toChatMessage() => ChatMessage.toolResult(
        toolUseId: toolUseId,
        result: toResultContent(),
      );

  @override
  String toString() =>
      'ToolActionOutput(toolUseId: $toolUseId, component: $componentName, action: $actionType)';
}
