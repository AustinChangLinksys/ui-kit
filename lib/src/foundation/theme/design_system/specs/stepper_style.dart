import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'shared/shared_specs.dart';

part 'stepper_style.tailor.dart';

/// Style specification for stepper components (AppStepper).
///
/// Composes [AnimationSpec] for transition timing.
///
/// Example:
/// ```dart
/// StepperStyle(
///   activeStepColor: Colors.blue,
///   completedStepColor: Colors.green,
///   pendingStepColor: Colors.grey,
///   connectorColor: Colors.blue,
///   stepSize: 48.0,
///   useDashedConnector: false,
///   animation: AnimationSpec.standard,
/// )
/// ```
@TailorMixin()
class StepperStyle extends ThemeExtension<StepperStyle>
    with _$StepperStyleTailorMixin {
  const StepperStyle({
    required this.activeStepColor,
    required this.completedStepColor,
    required this.pendingStepColor,
    required this.connectorColor,
    required this.stepSize,
    required this.useDashedConnector,
    required this.animation,
  });

  /// Color of the active step indicator
  @override
  final Color activeStepColor;

  /// Color of completed step indicators
  @override
  final Color completedStepColor;

  /// Color of pending step indicators
  @override
  final Color pendingStepColor;

  /// Color of connector lines between steps
  @override
  final Color connectorColor;

  /// Size of step indicators (diameter)
  @override
  final double stepSize;

  /// Use dashed connector lines (Pixel theme)
  @override
  final bool useDashedConnector;

  /// Animation timing for step transitions
  @override
  final AnimationSpec animation;

  // --- Backward Compatibility Getters ---

  /// @deprecated Use [animation.duration] instead
  @override
  Duration get animationDuration => animation.duration;

  /// @deprecated Use [animation.curve] instead
  @override
  Curve get animationCurve => animation.curve;
}
