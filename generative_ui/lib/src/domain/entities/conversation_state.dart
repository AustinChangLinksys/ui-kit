import 'chat_message.dart';
import 'content_block.dart';

/// View states for the chat interface.
enum ChatViewState {
  /// Initial welcome screen, no conversation started.
  welcome,

  /// Waiting for AI response.
  loading,

  /// Displaying conversation content.
  content,

  /// Error state with retry option.
  error,
}

/// Complete conversation state container.
///
/// Manages the full state of a chat conversation including:
/// - Current UI view state
/// - Complete message history
/// - Error information
/// - Pending tool interactions
class ConversationState {
  /// Current UI view state.
  final ChatViewState viewState;

  /// Complete message history.
  final List<ChatMessage> messages;

  /// Error message (when viewState == error).
  final String? errorMessage;

  /// Whether error is retryable.
  final bool isRetryable;

  /// Currently pending tool use awaiting user action.
  final ToolUseBlock? pendingToolUse;

  const ConversationState({
    this.viewState = ChatViewState.welcome,
    this.messages = const [],
    this.errorMessage,
    this.isRetryable = false,
    this.pendingToolUse,
  });

  /// Create initial state.
  factory ConversationState.initial() => const ConversationState();

  /// Transition to loading state.
  ConversationState loading() => copyWith(
        viewState: ChatViewState.loading,
        errorMessage: null,
      );

  /// Add a message and transition to content state.
  ConversationState withMessage(ChatMessage message) {
    final newMessages = [...messages, message];
    final pendingTool = message.response?.getFirstToolUse();
    return copyWith(
      viewState: ChatViewState.content,
      messages: newMessages,
      pendingToolUse: pendingTool,
      errorMessage: null,
    );
  }

  /// Transition to error state.
  ConversationState withError(String message, {bool retryable = false}) =>
      copyWith(
        viewState: ChatViewState.error,
        errorMessage: message,
        isRetryable: retryable,
      );

  /// Clear pending tool use after action completed.
  ConversationState toolActionCompleted() => copyWith(
        pendingToolUse: null,
      );

  /// Create a copy with modified fields.
  ConversationState copyWith({
    ChatViewState? viewState,
    List<ChatMessage>? messages,
    String? errorMessage,
    bool? isRetryable,
    ToolUseBlock? pendingToolUse,
    bool clearPendingToolUse = false,
  }) {
    return ConversationState(
      viewState: viewState ?? this.viewState,
      messages: messages ?? this.messages,
      errorMessage: errorMessage,
      isRetryable: isRetryable ?? this.isRetryable,
      pendingToolUse:
          clearPendingToolUse ? null : (pendingToolUse ?? this.pendingToolUse),
    );
  }

  /// Get messages in Claude API format.
  ///
  /// Filters out system messages (handled separately) and converts
  /// each message to the API format.
  List<Map<String, dynamic>> toClaudeMessages() {
    return messages
        .where((m) => m.role != ChatRole.system)
        .map((m) => m.toClaudeFormat())
        .toList();
  }

  /// Get system prompt if present.
  String? getSystemPrompt() {
    final systemMsg =
        messages.where((m) => m.role == ChatRole.system).firstOrNull;
    return systemMsg?.content as String?;
  }

  /// Check if conversation has started.
  bool get hasMessages => messages.isNotEmpty;

  /// Check if currently loading.
  bool get isLoading => viewState == ChatViewState.loading;

  /// Check if in error state.
  bool get hasError => viewState == ChatViewState.error;

  /// Check if there's a pending tool interaction.
  bool get hasPendingToolUse => pendingToolUse != null;

  /// Get the last message in the conversation.
  ChatMessage? get lastMessage => messages.isEmpty ? null : messages.last;

  /// Get count of messages.
  int get messageCount => messages.length;
}
