import 'package:flutter/material.dart';
import 'package:generative_ui/src/domain/entities/llm_response.dart';
import 'package:generative_ui/src/domain/usecases/orchestrate_ui_flow.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/state/gen_ui_state.dart';
import 'package:generative_ui/src/presentation/widgets/content_block_list.dart';
import 'package:generative_ui/src/presentation/widgets/dynamic_builder.dart';
import 'package:generative_ui/src/presentation/widgets/error_display.dart';
import 'package:generative_ui/src/presentation/widgets/loading_indicator.dart';

/// Container widget for GenUI content
///
/// Responsibilities:
/// - Manages the state of the UI (Initial, Loading, Data, Error)
/// - Orchestrates the flow via OrchestrateUIFlowUseCase
/// - Renders the content using DynamicWidgetBuilder
class GenUiContainer extends StatefulWidget {
  final OrchestrateUIFlowUseCase orchestrator;
  final IComponentRegistry registry;
  final LLMResponse? initialResponse;
  final VoidCallback? onComplete;

  const GenUiContainer({
    required this.orchestrator,
    required this.registry,
    this.initialResponse,
    this.onComplete,
    super.key,
  });

  @override
  State<GenUiContainer> createState() => GenUiContainerState();
}

class GenUiContainerState extends State<GenUiContainer> {
  late GenUiViewState _viewState;
  LLMResponse? _response;
  String? _errorMessage;
  String? _lastInput;

  @override
  void initState() {
    super.initState();
    if (widget.initialResponse != null) {
      _viewState = GenUiViewState.data;
      _response = widget.initialResponse;
    } else {
      _viewState = GenUiViewState.initial;
    }
  }

  /// Triggers the orchestration flow with user input
  Future<void> sendMessage(String userInput) async {
    _lastInput = userInput;
    setState(() {
      _viewState = GenUiViewState.loading;
      _errorMessage = null;
    });

    try {
      final response = await widget.orchestrator.execute(userInput);
      if (mounted) {
        setState(() {
          _response = response;
          _viewState = GenUiViewState.data;
        });
        widget.onComplete?.call();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _viewState = GenUiViewState.error;
        });
      }
    }
  }

  void _retry() {
    if (_lastInput != null) {
      sendMessage(_lastInput!);
    } else {
       setState(() {
         _viewState = GenUiViewState.initial;
       });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_viewState) {
      case GenUiViewState.initial:
        return const SizedBox.shrink();
      case GenUiViewState.loading:
        return const LoadingIndicator();
      case GenUiViewState.error:
        return ErrorDisplay(
          message: _errorMessage ?? 'Unknown error occurred',
          onRetry: _retry,
        );
      case GenUiViewState.data:
        if (_response == null) return const SizedBox.shrink();
        
        // Create builder instance
        final builder = DynamicWidgetBuilder(registry: widget.registry);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ContentBlockList(
              blocks: _response!.content,
              builder: builder,
            ),
          ),
        );
    }
  }
}
