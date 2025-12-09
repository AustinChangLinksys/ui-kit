// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dialog_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$DialogStyleTailorMixin on ThemeExtension<DialogStyle> {
  SurfaceStyle get containerStyle;
  OverlaySpec get overlay;
  double get maxWidth;
  EdgeInsets get padding;
  double get buttonSpacing;
  MainAxisAlignment get buttonAlignment;
  Color get barrierColor;
  double get barrierBlur;

  @override
  DialogStyle copyWith({
    SurfaceStyle? containerStyle,
    OverlaySpec? overlay,
    double? maxWidth,
    EdgeInsets? padding,
    double? buttonSpacing,
    MainAxisAlignment? buttonAlignment,
    Color? barrierColor,
    double? barrierBlur,
  }) {
    return DialogStyle(
      containerStyle: containerStyle ?? this.containerStyle,
      overlay: overlay ?? this.overlay,
      maxWidth: maxWidth ?? this.maxWidth,
      padding: padding ?? this.padding,
      buttonSpacing: buttonSpacing ?? this.buttonSpacing,
      buttonAlignment: buttonAlignment ?? this.buttonAlignment,
    );
  }

  @override
  DialogStyle lerp(covariant ThemeExtension<DialogStyle>? other, double t) {
    if (other is! DialogStyle) return this as DialogStyle;
    return DialogStyle(
      containerStyle: t < 0.5 ? containerStyle : other.containerStyle,
      overlay: overlay.lerp(other.overlay, t),
      maxWidth: t < 0.5 ? maxWidth : other.maxWidth,
      padding: t < 0.5 ? padding : other.padding,
      buttonSpacing: t < 0.5 ? buttonSpacing : other.buttonSpacing,
      buttonAlignment: t < 0.5 ? buttonAlignment : other.buttonAlignment,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DialogStyle &&
            const DeepCollectionEquality()
                .equals(containerStyle, other.containerStyle) &&
            const DeepCollectionEquality().equals(overlay, other.overlay) &&
            const DeepCollectionEquality().equals(maxWidth, other.maxWidth) &&
            const DeepCollectionEquality().equals(padding, other.padding) &&
            const DeepCollectionEquality()
                .equals(buttonSpacing, other.buttonSpacing) &&
            const DeepCollectionEquality()
                .equals(buttonAlignment, other.buttonAlignment) &&
            const DeepCollectionEquality()
                .equals(barrierColor, other.barrierColor) &&
            const DeepCollectionEquality()
                .equals(barrierBlur, other.barrierBlur));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(containerStyle),
      const DeepCollectionEquality().hash(overlay),
      const DeepCollectionEquality().hash(maxWidth),
      const DeepCollectionEquality().hash(padding),
      const DeepCollectionEquality().hash(buttonSpacing),
      const DeepCollectionEquality().hash(buttonAlignment),
      const DeepCollectionEquality().hash(barrierColor),
      const DeepCollectionEquality().hash(barrierBlur),
    );
  }
}

extension DialogStyleBuildContextProps on BuildContext {
  DialogStyle get dialogStyle => Theme.of(this).extension<DialogStyle>()!;

  /// Dialog box background, border, shadow.
  SurfaceStyle get containerStyle => dialogStyle.containerStyle;

  /// Overlay specification for backdrop (scrim color, blur, animation).
  /// Replaces individual barrierColor and barrierBlur properties.
  OverlaySpec get overlay => dialogStyle.overlay;

  /// Maximum dialog width.
  double get maxWidth => dialogStyle.maxWidth;

  /// Internal content padding.
  EdgeInsets get padding => dialogStyle.padding;

  /// Gap between action buttons.
  double get buttonSpacing => dialogStyle.buttonSpacing;

  /// Button row alignment.
  MainAxisAlignment get buttonAlignment => dialogStyle.buttonAlignment;
  Color get barrierColor => dialogStyle.barrierColor;
  double get barrierBlur => dialogStyle.barrierBlur;
}
