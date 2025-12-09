// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_button_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$TextButtonStyleTailorMixin on ThemeExtension<TextButtonStyle> {
  SurfaceStyle get enabledStyle;
  SurfaceStyle get disabledStyle;
  SurfaceStyle get hoverStyle;
  SurfaceStyle get pressedStyle;
  Color get enabledContentColor;
  Color get disabledContentColor;
  TextStyle get smallTextStyle;
  TextStyle get mediumTextStyle;
  TextStyle get largeTextStyle;
  InteractionSpec get interaction;

  @override
  TextButtonStyle copyWith({
    SurfaceStyle? enabledStyle,
    SurfaceStyle? disabledStyle,
    SurfaceStyle? hoverStyle,
    SurfaceStyle? pressedStyle,
    Color? enabledContentColor,
    Color? disabledContentColor,
    TextStyle? smallTextStyle,
    TextStyle? mediumTextStyle,
    TextStyle? largeTextStyle,
    InteractionSpec? interaction,
  }) {
    return TextButtonStyle(
      enabledStyle: enabledStyle ?? this.enabledStyle,
      disabledStyle: disabledStyle ?? this.disabledStyle,
      hoverStyle: hoverStyle ?? this.hoverStyle,
      pressedStyle: pressedStyle ?? this.pressedStyle,
      enabledContentColor: enabledContentColor ?? this.enabledContentColor,
      disabledContentColor: disabledContentColor ?? this.disabledContentColor,
      smallTextStyle: smallTextStyle ?? this.smallTextStyle,
      mediumTextStyle: mediumTextStyle ?? this.mediumTextStyle,
      largeTextStyle: largeTextStyle ?? this.largeTextStyle,
      interaction: interaction ?? this.interaction,
    );
  }

  @override
  TextButtonStyle lerp(
      covariant ThemeExtension<TextButtonStyle>? other, double t) {
    if (other is! TextButtonStyle) return this as TextButtonStyle;
    return TextButtonStyle(
      enabledStyle: t < 0.5 ? enabledStyle : other.enabledStyle,
      disabledStyle: t < 0.5 ? disabledStyle : other.disabledStyle,
      hoverStyle: t < 0.5 ? hoverStyle : other.hoverStyle,
      pressedStyle: t < 0.5 ? pressedStyle : other.pressedStyle,
      enabledContentColor:
          Color.lerp(enabledContentColor, other.enabledContentColor, t)!,
      disabledContentColor:
          Color.lerp(disabledContentColor, other.disabledContentColor, t)!,
      smallTextStyle: TextStyle.lerp(smallTextStyle, other.smallTextStyle, t)!,
      mediumTextStyle:
          TextStyle.lerp(mediumTextStyle, other.mediumTextStyle, t)!,
      largeTextStyle: TextStyle.lerp(largeTextStyle, other.largeTextStyle, t)!,
      interaction: t < 0.5 ? interaction : other.interaction,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextButtonStyle &&
            const DeepCollectionEquality()
                .equals(enabledStyle, other.enabledStyle) &&
            const DeepCollectionEquality()
                .equals(disabledStyle, other.disabledStyle) &&
            const DeepCollectionEquality()
                .equals(hoverStyle, other.hoverStyle) &&
            const DeepCollectionEquality()
                .equals(pressedStyle, other.pressedStyle) &&
            const DeepCollectionEquality()
                .equals(enabledContentColor, other.enabledContentColor) &&
            const DeepCollectionEquality()
                .equals(disabledContentColor, other.disabledContentColor) &&
            const DeepCollectionEquality()
                .equals(smallTextStyle, other.smallTextStyle) &&
            const DeepCollectionEquality()
                .equals(mediumTextStyle, other.mediumTextStyle) &&
            const DeepCollectionEquality()
                .equals(largeTextStyle, other.largeTextStyle) &&
            const DeepCollectionEquality()
                .equals(interaction, other.interaction));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(enabledStyle),
      const DeepCollectionEquality().hash(disabledStyle),
      const DeepCollectionEquality().hash(hoverStyle),
      const DeepCollectionEquality().hash(pressedStyle),
      const DeepCollectionEquality().hash(enabledContentColor),
      const DeepCollectionEquality().hash(disabledContentColor),
      const DeepCollectionEquality().hash(smallTextStyle),
      const DeepCollectionEquality().hash(mediumTextStyle),
      const DeepCollectionEquality().hash(largeTextStyle),
      const DeepCollectionEquality().hash(interaction),
    );
  }
}

extension TextButtonStyleBuildContextProps on BuildContext {
  TextButtonStyle get textButtonStyle =>
      Theme.of(this).extension<TextButtonStyle>()!;

  /// Surface style for enabled state
  /// Constitution 6.1: Uses SurfaceStyle for AppSurface integration
  SurfaceStyle get enabledStyle => textButtonStyle.enabledStyle;

  /// Surface style for disabled state
  SurfaceStyle get disabledStyle => textButtonStyle.disabledStyle;

  /// Surface style for hover state (web/desktop)
  SurfaceStyle get hoverStyle => textButtonStyle.hoverStyle;

  /// Surface style for pressed state
  SurfaceStyle get pressedStyle => textButtonStyle.pressedStyle;

  /// Content color for enabled state (text and icons)
  Color get enabledContentColor => textButtonStyle.enabledContentColor;

  /// Content color for disabled state (text and icons)
  Color get disabledContentColor => textButtonStyle.disabledContentColor;

  /// Text style for small buttons
  TextStyle get smallTextStyle => textButtonStyle.smallTextStyle;

  /// Text style for medium buttons
  TextStyle get mediumTextStyle => textButtonStyle.mediumTextStyle;

  /// Text style for large buttons
  TextStyle get largeTextStyle => textButtonStyle.largeTextStyle;

  /// Interaction specifications for animations and feedback
  InteractionSpec get interaction => textButtonStyle.interaction;
}
