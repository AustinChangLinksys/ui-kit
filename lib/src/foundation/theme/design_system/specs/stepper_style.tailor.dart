// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stepper_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$StepperStyleTailorMixin on ThemeExtension<StepperStyle> {
  Color get activeStepColor;
  Color get completedStepColor;
  Color get pendingStepColor;
  Color get connectorColor;
  double get stepSize;
  bool get useDashedConnector;
  AnimationSpec get animation;
  Duration get animationDuration;
  Curve get animationCurve;

  @override
  StepperStyle copyWith({
    Color? activeStepColor,
    Color? completedStepColor,
    Color? pendingStepColor,
    Color? connectorColor,
    double? stepSize,
    bool? useDashedConnector,
    AnimationSpec? animation,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return StepperStyle(
      activeStepColor: activeStepColor ?? this.activeStepColor,
      completedStepColor: completedStepColor ?? this.completedStepColor,
      pendingStepColor: pendingStepColor ?? this.pendingStepColor,
      connectorColor: connectorColor ?? this.connectorColor,
      stepSize: stepSize ?? this.stepSize,
      useDashedConnector: useDashedConnector ?? this.useDashedConnector,
      animation: animation ?? this.animation,
    );
  }

  @override
  StepperStyle lerp(covariant ThemeExtension<StepperStyle>? other, double t) {
    if (other is! StepperStyle) return this as StepperStyle;
    return StepperStyle(
      activeStepColor: Color.lerp(activeStepColor, other.activeStepColor, t)!,
      completedStepColor:
          Color.lerp(completedStepColor, other.completedStepColor, t)!,
      pendingStepColor:
          Color.lerp(pendingStepColor, other.pendingStepColor, t)!,
      connectorColor: Color.lerp(connectorColor, other.connectorColor, t)!,
      stepSize: t < 0.5 ? stepSize : other.stepSize,
      useDashedConnector:
          t < 0.5 ? useDashedConnector : other.useDashedConnector,
      animation: animation.lerp(other.animation, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StepperStyle &&
            const DeepCollectionEquality()
                .equals(activeStepColor, other.activeStepColor) &&
            const DeepCollectionEquality()
                .equals(completedStepColor, other.completedStepColor) &&
            const DeepCollectionEquality()
                .equals(pendingStepColor, other.pendingStepColor) &&
            const DeepCollectionEquality()
                .equals(connectorColor, other.connectorColor) &&
            const DeepCollectionEquality().equals(stepSize, other.stepSize) &&
            const DeepCollectionEquality()
                .equals(useDashedConnector, other.useDashedConnector) &&
            const DeepCollectionEquality().equals(animation, other.animation) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration) &&
            const DeepCollectionEquality()
                .equals(animationCurve, other.animationCurve));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(activeStepColor),
      const DeepCollectionEquality().hash(completedStepColor),
      const DeepCollectionEquality().hash(pendingStepColor),
      const DeepCollectionEquality().hash(connectorColor),
      const DeepCollectionEquality().hash(stepSize),
      const DeepCollectionEquality().hash(useDashedConnector),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
    );
  }
}

extension StepperStyleBuildContextProps on BuildContext {
  StepperStyle get stepperStyle => Theme.of(this).extension<StepperStyle>()!;

  /// Color of the active step indicator
  Color get activeStepColor => stepperStyle.activeStepColor;

  /// Color of completed step indicators
  Color get completedStepColor => stepperStyle.completedStepColor;

  /// Color of pending step indicators
  Color get pendingStepColor => stepperStyle.pendingStepColor;

  /// Color of connector lines between steps
  Color get connectorColor => stepperStyle.connectorColor;

  /// Size of step indicators (diameter)
  double get stepSize => stepperStyle.stepSize;

  /// Use dashed connector lines (Pixel theme)
  bool get useDashedConnector => stepperStyle.useDashedConnector;

  /// Animation timing for step transitions
  AnimationSpec get animation => stepperStyle.animation;
  Duration get animationDuration => stepperStyle.animationDuration;
  Curve get animationCurve => stepperStyle.animationCurve;
}
