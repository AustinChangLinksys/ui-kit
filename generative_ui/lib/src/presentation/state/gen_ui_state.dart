import 'package:generative_ui/src/domain/entities/llm_response.dart';

/// Represents the view state of GenUI rendering container
enum GenUiViewState {
  /// Initial state before any user input or rendering
  initial,

  /// Loading state while Phase 1 orchestrator processes request
  loading,

  /// Data state when orchestrator returns response
  data,

  /// Error state when orchestrator throws exception
  error,
}

/// Container for GenUI rendering state management
class GenUiState {
  /// Current view state
  final GenUiViewState viewState;

  /// The LLMResponse from Phase 1 orchestrator (present when viewState == data)
  final LLMResponse? response;

  /// Error message when rendering fails (present when viewState == error)
  final String? errorMessage;

  const GenUiState({
    this.viewState = GenUiViewState.initial,
    this.response,
    this.errorMessage,
  });

  /// Create a copy of this state with specified fields replaced
  GenUiState copyWith({
    GenUiViewState? viewState,
    LLMResponse? response,
    String? errorMessage,
  }) {
    return GenUiState(
      viewState: viewState ?? this.viewState,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'GenUiState(viewState: $viewState, response: ${response != null ? 'LLMResponse' : 'null'}, errorMessage: $errorMessage)';
}
