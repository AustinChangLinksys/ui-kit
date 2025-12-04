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
    this.animationDuration = const Duration(milliseconds: 300),
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

  /// Animation duration for step transitions
  @override
  final Duration animationDuration;

  /// Default style for fallback when theme is not available
  static const defaultStyle = StepperStyle(
    activeStepColor: Color(0xFF2196F3),
    completedStepColor: Color(0xFF4CAF50),
    pendingStepColor: Color(0xFFBDBDBD),
    connectorColor: Color(0xFF2196F3),
    stepSize: 48,
    useDashedConnector: false,
    animationDuration: Duration(milliseconds: 300),
  );
}
