import 'package:flutter/material.dart';
import 'package:generative_ui/src/domain/usecases/orchestrate_ui_flow.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/widgets/gen_ui_container.dart';

/// Public entry point widget for GenUI rendering system
///
/// GenUiWrapper provides the main interface for integrating GenUI into Flutter apps:
/// - Accepts Phase 1 orchestration logic via [orchestrator]
/// - Accepts component registry configured with UI Kit components via [registry]
/// - Manages rendering lifecycle and state transitions
/// - Exposes completion callback for orchestration loop closure
class GenUiWrapper extends StatelessWidget {
  /// Phase 1 orchestration use case for generating responses
  final OrchestrateUIFlowUseCase orchestrator;

  /// Component registry with pre-configured builders
  final IComponentRegistry registry;

  /// Optional callback when rendering completes
  final VoidCallback? onComplete;

  const GenUiWrapper({
    required this.orchestrator,
    required this.registry,
    this.onComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GenUiContainer(
      orchestrator: orchestrator,
      registry: registry,
      onComplete: onComplete,
    );
  }
}