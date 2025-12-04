import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'stepper_style.tailor.dart';

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
}
