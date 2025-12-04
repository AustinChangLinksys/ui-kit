import 'package:flutter/foundation.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/content_block.dart';
import '../../domain/entities/conversation_state.dart';
import '../../domain/entities/gen_exception.dart';
import '../../domain/entities/gen_tool.dart';
import '../../domain/entities/tool_action_output.dart';
import '../../domain/repositories/i_conversation_generator.dart';

/// Controller for managing chat conversation state and interactions.
///
/// Handles the complete chat flow including:
/// - Sending user messages
/// - Processing AI responses
/// - Managing tool actions
/// - Error handling with retry support
class ChatController extends ChangeNotifier {
  final IConversationGenerator _generator;
  final List<GenTool>? tools;
  final String? systemPrompt;

  ConversationState _state = ConversationState.initial();

  /// Last user message for retry functionality.
  String? _lastUserMessage;

  ChatController({
    required IConversationGenerator generator,
    this.tools,
    this.systemPrompt,
  }) : _generator = generator {
    // Add system prompt to initial state if provided
    if (systemPrompt != null) {
      _state = _state.withMessage(ChatMessage.system(systemPrompt!));
    }
  }

  /// Current conversation state.
  ConversationState get state => _state;

  /// Current view state.
  ChatViewState get viewState => _state.viewState;

  /// All messages in the conversation.
  List<ChatMessage> get messages => _state.messages;

  /// Whether the controller is currently loading.
  bool get isLoading => _state.isLoading;

  /// Whether there's an error.
  bool get hasError => _state.hasError;

  /// Error message if any.
  String? get errorMessage => _state.errorMessage;

  /// Whether the error is retryable.
  bool get isRetryable => _state.isRetryable;

  /// Send a user message and get AI response.
  ///
  /// Updates state through: user message → loading → response → content
  /// On error: user message → loading → error
  Future<void> sendMessage(String message) async {
    debugPrint('=== ChatController.sendMessage ===');
    debugPrint('Message: $message');

    if (message.trim().isEmpty) {
      debugPrint('Empty message, returning');
      return;
    }

    _lastUserMessage = message;

    // Check if last assistant message has pending tool_use that needs tool_result
    _insertPendingToolResults();

    // Add user message
    final userMessage = ChatMessage.user(message);
    _state = _state.withMessage(userMessage);
    notifyListeners();
    debugPrint('User message added, state: ${_state.viewState}');

    // Transition to loading
    _state = _state.loading();
    notifyListeners();
    debugPrint('Loading state, messages count: ${_state.messages.length}');

    try {
      debugPrint('Calling generator.generateWithHistory...');
      debugPrint('Tools: ${tools?.map((t) => t.name).toList()}');

      // Get AI response
      final response = await _generator.generateWithHistory(
        _state.messages,
        tools: tools,
        systemPrompt: systemPrompt,
      );

      debugPrint('Response received: ${response.id}');
      debugPrint('Stop reason: ${response.stopReason}');
      debugPrint('Content blocks: ${response.content.length}');

      // Add assistant response
      final assistantMessage = ChatMessage.assistant(response);
      _state = _state.withMessage(assistantMessage);
      notifyListeners();
      debugPrint('Assistant message added, state: ${_state.viewState}');
    } on GenUiException catch (e, stackTrace) {
      debugPrint('=== GenUiException ===');
      debugPrint('Error: ${e.message}');
      debugPrint('Retryable: ${e.isRetryable}');
      debugPrint('StackTrace: $stackTrace');
      debugPrint('======================');
      _state = _state.withError(e.message, retryable: e.isRetryable);
      notifyListeners();
    } catch (e, stackTrace) {
      debugPrint('=== Unexpected Error ===');
      debugPrint('Error: $e');
      debugPrint('Type: ${e.runtimeType}');
      debugPrint('StackTrace: $stackTrace');
      debugPrint('========================');
      _state = _state.withError('An unexpected error occurred: $e');
      notifyListeners();
    }
  }

  /// Insert tool_result messages for any pending tool_use blocks.
  ///
  /// Claude API requires that every tool_use must be followed by a tool_result
  /// before any new user message. This method checks the last assistant message
  /// and inserts acknowledgment tool_results for all tool_use blocks.
  void _insertPendingToolResults() {
    if (_state.messages.isEmpty) return;

    // Find the last assistant message
    ChatMessage? lastAssistantMessage;
    for (var i = _state.messages.length - 1; i >= 0; i--) {
      final msg = _state.messages[i];
      if (msg.isAssistant) {
        lastAssistantMessage = msg;
        break;
      }
      // If we hit a tool_result before an assistant message, no pending tools
      if (msg.isToolResult) return;
    }

    if (lastAssistantMessage == null) return;

    // Check if the assistant message has tool_use blocks
    final response = lastAssistantMessage.response;
    if (response == null) return;

    final toolUseBlocks = response.content.whereType<ToolUseBlock>().toList();
    if (toolUseBlocks.isEmpty) return;

    debugPrint('Found ${toolUseBlocks.length} pending tool_use blocks, inserting tool_results');

    // Insert tool_result for each tool_use block
    for (final toolUse in toolUseBlocks) {
      final toolResult = ChatMessage.toolResult(
        toolUseId: toolUse.id,
        result: {'status': 'rendered', 'component': toolUse.name},
      );
      _state = _state.withMessage(toolResult);
      debugPrint('Inserted tool_result for ${toolUse.name} (${toolUse.id})');
    }
    notifyListeners();
  }

  /// Handle tool action from a dynamic UI component.
  ///
  /// Creates a tool_result message and triggers follow-up AI request.
  Future<void> handleToolAction(ToolActionOutput action) async {
    // Create tool result message
    final toolResultMessage = action.toChatMessage();
    _state = _state.withMessage(toolResultMessage);
    _state = _state.toolActionCompleted();
    notifyListeners();

    // Transition to loading for follow-up
    _state = _state.loading();
    notifyListeners();

    try {
      // Get AI confirmation response
      final response = await _generator.generateWithHistory(
        _state.messages,
        tools: tools,
        systemPrompt: systemPrompt,
      );

      // Add assistant response
      final assistantMessage = ChatMessage.assistant(response);
      _state = _state.withMessage(assistantMessage);
      notifyListeners();
    } on GenUiException catch (e) {
      _state = _state.withError(e.message, retryable: e.isRetryable);
      notifyListeners();
    } catch (e) {
      _state = _state.withError('An unexpected error occurred: $e');
      notifyListeners();
    }
  }

  /// Retry the last failed operation.
  Future<void> retry() async {
    if (!_state.hasError || _lastUserMessage == null) return;

    // Remove the failed user message from state
    final messagesWithoutLast = [..._state.messages];
    if (messagesWithoutLast.isNotEmpty &&
        messagesWithoutLast.last.role == ChatRole.user) {
      messagesWithoutLast.removeLast();
    }

    _state = ConversationState(
      viewState: ChatViewState.content,
      messages: messagesWithoutLast,
    );
    notifyListeners();

    // Retry the message
    await sendMessage(_lastUserMessage!);
  }

  /// Clear the conversation and reset to initial state.
  void clearConversation() {
    _state = ConversationState.initial();
    if (systemPrompt != null) {
      _state = _state.withMessage(ChatMessage.system(systemPrompt!));
    }
    _lastUserMessage = null;
    notifyListeners();
  }

  /// Create a ToolActionOutput from component action data.
  ///
  /// Helper method for creating action outputs from raw action data.
  ToolActionOutput createToolAction({
    required String toolUseId,
    required String componentName,
    required Map<String, dynamic> data,
  }) {
    final actionType = data['action'] as String? ?? 'unknown';
    final actionData = Map<String, dynamic>.from(data)..remove('action');

    return ToolActionOutput(
      toolUseId: toolUseId,
      componentName: componentName,
      actionType: actionType,
      data: actionData,
    );
  }
}
