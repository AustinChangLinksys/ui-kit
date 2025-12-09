// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skeleton_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SkeletonStyleTailorMixin on ThemeExtension<SkeletonStyle> {
  Color get baseColor;
  Color get highlightColor;
  SkeletonAnimationType get animationType;
  double get borderRadius;
  AnimationSpec get animation;
  Duration get animationDuration;
  Curve get animationCurve;

  @override
  SkeletonStyle copyWith({
    Color? baseColor,
    Color? highlightColor,
    SkeletonAnimationType? animationType,
    double? borderRadius,
    AnimationSpec? animation,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return SkeletonStyle(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      animationType: animationType ?? this.animationType,
      borderRadius: borderRadius ?? this.borderRadius,
      animation: animation ?? this.animation,
    );
  }

  @override
  SkeletonStyle lerp(covariant ThemeExtension<SkeletonStyle>? other, double t) {
    if (other is! SkeletonStyle) return this as SkeletonStyle;
    return SkeletonStyle(
      baseColor: Color.lerp(baseColor, other.baseColor, t)!,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      animationType: t < 0.5 ? animationType : other.animationType,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      animation: animation.lerp(other.animation, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SkeletonStyle &&
            const DeepCollectionEquality().equals(baseColor, other.baseColor) &&
            const DeepCollectionEquality()
                .equals(highlightColor, other.highlightColor) &&
            const DeepCollectionEquality()
                .equals(animationType, other.animationType) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
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
      const DeepCollectionEquality().hash(baseColor),
      const DeepCollectionEquality().hash(highlightColor),
      const DeepCollectionEquality().hash(animationType),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
    );
  }
}

extension SkeletonStyleBuildContextProps on BuildContext {
  SkeletonStyle get skeletonStyle => Theme.of(this).extension<SkeletonStyle>()!;

  /// The background color of the skeleton shape.
  Color get baseColor => skeletonStyle.baseColor;

  /// The highlight/active color used in the animation.
  Color get highlightColor => skeletonStyle.highlightColor;

  /// The type of animation to perform.
  SkeletonAnimationType get animationType => skeletonStyle.animationType;

  /// Border radius for skeleton shapes.
  double get borderRadius => skeletonStyle.borderRadius;

  /// Animation timing for skeleton effects (shimmer/pulse/blink).
  AnimationSpec get animation => skeletonStyle.animation;
  Duration get animationDuration => skeletonStyle.animationDuration;
  Curve get animationCurve => skeletonStyle.animationCurve;
}
