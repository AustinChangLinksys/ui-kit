// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slide_action_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SlideActionStyleTailorMixin on ThemeExtension<SlideActionStyle> {
  SurfaceStyle get standardStyle;
  SurfaceStyle get destructiveStyle;
  BorderRadius get borderRadius;
  Color get contentColor;
  double get iconSize;
  AnimationSpec get animation;
  Duration get animationDuration;
  Curve get animationCurve;

  @override
  SlideActionStyle copyWith({
    SurfaceStyle? standardStyle,
    SurfaceStyle? destructiveStyle,
    BorderRadius? borderRadius,
    Color? contentColor,
    double? iconSize,
    AnimationSpec? animation,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return SlideActionStyle(
      standardStyle: standardStyle ?? this.standardStyle,
      destructiveStyle: destructiveStyle ?? this.destructiveStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      contentColor: contentColor ?? this.contentColor,
      iconSize: iconSize ?? this.iconSize,
      animation: animation ?? this.animation,
    );
  }

  @override
  SlideActionStyle lerp(
      covariant ThemeExtension<SlideActionStyle>? other, double t) {
    if (other is! SlideActionStyle) return this as SlideActionStyle;
    return SlideActionStyle(
      standardStyle: t < 0.5 ? standardStyle : other.standardStyle,
      destructiveStyle: t < 0.5 ? destructiveStyle : other.destructiveStyle,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      contentColor: Color.lerp(contentColor, other.contentColor, t)!,
      iconSize: t < 0.5 ? iconSize : other.iconSize,
      animation: animation.lerp(other.animation, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SlideActionStyle &&
            const DeepCollectionEquality()
                .equals(standardStyle, other.standardStyle) &&
            const DeepCollectionEquality()
                .equals(destructiveStyle, other.destructiveStyle) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality()
                .equals(contentColor, other.contentColor) &&
            const DeepCollectionEquality().equals(iconSize, other.iconSize) &&
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
      const DeepCollectionEquality().hash(standardStyle),
      const DeepCollectionEquality().hash(destructiveStyle),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(contentColor),
      const DeepCollectionEquality().hash(iconSize),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
    );
  }
}

extension SlideActionStyleBuildContextProps on BuildContext {
  SlideActionStyle get slideActionStyle =>
      Theme.of(this).extension<SlideActionStyle>()!;

  /// Appearance - now directly SurfaceStyle
  SurfaceStyle get standardStyle => slideActionStyle.standardStyle;
  SurfaceStyle get destructiveStyle => slideActionStyle.destructiveStyle;

  /// Shape - border radius for the action container
  BorderRadius get borderRadius => slideActionStyle.borderRadius;

  /// Content color for icons/text inside the actions
  Color get contentColor => slideActionStyle.contentColor;
  double get iconSize => slideActionStyle.iconSize;

  /// Animation timing for slide transitions
  AnimationSpec get animation => slideActionStyle.animation;
  Duration get animationDuration => slideActionStyle.animationDuration;
  Curve get animationCurve => slideActionStyle.animationCurve;
}
