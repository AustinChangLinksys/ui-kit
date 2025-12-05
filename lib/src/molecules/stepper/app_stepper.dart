import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

enum StepState {
  /// Step is not yet completed
  pending,

  /// Step is currently active
  active,

  /// Step is completed
  completed,
}

/// Configuration for individual stepper steps
class StepperStep {
  /// Unique identifier for the step
  final String id;

  /// Display label for the step
  final String label;

  /// Optional description below the step
  final String? description;

  /// Whether this step can be interacted with
  final bool enabled;

  const StepperStep({
    required this.id,
    required this.label,
    this.description,
    this.enabled = true,
  });
}

/// Determines how the stepper displays (linear steps in sequence or labeled nodes)
enum StepperVariant {
  /// Vertical stepper - steps displayed vertically
  vertical,

  /// Horizontal stepper - steps displayed horizontally
  horizontal,
}

/// AppStepper displays progress through a linear multi-step process
///
/// Provides visual indication of current step, completed steps, and navigation flow.
/// Theme-aware styling: smooth animations for most themes, pixel-perfect for Pixel theme.
class AppStepper extends StatefulWidget {
  /// List of steps to display
  final List<StepperStep> steps;

  /// Currently active step index
  final int currentStep;

  /// List of completed step indices
  final Set<int> completedSteps;

  /// Callback when user interacts with a step
  final ValueChanged<int>? onStepTapped;

  /// Display variant (vertical or horizontal)
  final StepperVariant variant;

  /// Optional style override
  final StepperStyle? style;

  /// Whether steps can be clicked to navigate
  final bool interactive;

  const AppStepper({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.completedSteps = const {},
    this.onStepTapped,
    this.variant = StepperVariant.horizontal,
    this.style,
    this.interactive = true,
  })  : assert(currentStep >= 0 && currentStep < 1000);

  @override
  State<AppStepper> createState() => _AppStepperState();
}

class _AppStepperState extends State<AppStepper> {
  late StepperStyle _style;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context).extension<AppDesignTheme>();
    _style = widget.style ?? theme?.stepperStyle ?? StepperStyle.defaultStyle;
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.steps;
    final currentIndex = widget.currentStep;
    final completedSteps = widget.completedSteps;

    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    // Render horizontal or vertical stepper
    return widget.variant == StepperVariant.horizontal
        ? _buildHorizontalStepper(steps, currentIndex, completedSteps)
        : _buildVerticalStepper(steps, currentIndex, completedSteps);
  }

  Widget _buildHorizontalStepper(
    List<StepperStep> steps,
    int currentIndex,
    Set<int> completedSteps,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Step indicators row - simplified for horizontal layout
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: _style.stepSize + 24,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                steps.length,
                (index) => _buildStepIndicator(
                  index: index,
                  step: steps[index],
                  isCurrent: index == currentIndex,
                  isCompleted: completedSteps.contains(index),
                  showConnector: index < steps.length - 1,
                  isLastStep: index == steps.length - 1,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Step label and description
        if (currentIndex < steps.length)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  steps[currentIndex].label,
                  fontWeight: FontWeight.bold,
                  color: _style.activeStepColor,
                ),
                if (steps[currentIndex].description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: AppText(
                      steps[currentIndex].description!,
                      variant: AppTextVariant.bodySmall,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildVerticalStepper(
    List<StepperStep> steps,
    int currentIndex,
    Set<int> completedSteps,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        steps.length,
        (index) => _buildStepRow(
          index: index,
          step: steps[index],
          isCurrent: index == currentIndex,
          isCompleted: completedSteps.contains(index),
          isLastStep: index == steps.length - 1,
        ),
      ),
    );
  }

  Widget _buildStepIndicator({
    required int index,
    required StepperStep step,
    required bool isCurrent,
    required bool isCompleted,
    required bool showConnector,
    required bool isLastStep,
  }) {
    final stepSize = _style.stepSize;
    Color indicatorColor;

    if (isCompleted) {
      indicatorColor = _style.completedStepColor;
    } else if (isCurrent) {
      indicatorColor = _style.activeStepColor;
    } else {
      indicatorColor = _style.pendingStepColor;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: widget.interactive && step.enabled
              ? () => widget.onStepTapped?.call(index)
              : null,
          child: _buildStepContent(
            indicatorColor: indicatorColor,
            isCompleted: isCompleted,
            stepNumber: index + 1,
            isCurrent: isCurrent,
            stepSize: stepSize,
          ),
        ),
        if (!isLastStep && showConnector)
          Container(
            height: 4,
            width: 24,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            color: _style.connectorColor,
          ),
      ],
    );
  }

  Widget _buildStepRow({
    required int index,
    required StepperStep step,
    required bool isCurrent,
    required bool isCompleted,
    required bool isLastStep,
  }) {
    final stepSize = _style.stepSize;
    Color indicatorColor;

    if (isCompleted) {
      indicatorColor = _style.completedStepColor;
    } else if (isCurrent) {
      indicatorColor = _style.activeStepColor;
    } else {
      indicatorColor = _style.pendingStepColor;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.interactive && step.enabled
                ? () => widget.onStepTapped?.call(index)
                : null,
            child: _buildStepContent(
              indicatorColor: indicatorColor,
              isCompleted: isCompleted,
              stepNumber: index + 1,
              isCurrent: isCurrent,
              stepSize: stepSize,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  step.label,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  color: isCurrent ? _style.activeStepColor : Colors.grey,
                ),
                if (step.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AppText(
                      step.description!,
                      variant: AppTextVariant.bodyExtraSmall,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent({
    required Color indicatorColor,
    required bool isCompleted,
    required int stepNumber,
    required bool isCurrent,
    required double stepSize,
  }) {
    // Note: Using Container instead of AppSurface for circular indicators
    // AppSurface is designed for rectangular surfaces and has border rendering
    // issues with BoxShape.circle
    return Container(
      width: stepSize,
      height: stepSize,
      decoration: BoxDecoration(
        color: indicatorColor,
        shape: BoxShape.circle,
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: indicatorColor.withValues(alpha: 0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : AppText(
                stepNumber.toString(),
                color: Colors.white,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
      ),
    );
  }
}
