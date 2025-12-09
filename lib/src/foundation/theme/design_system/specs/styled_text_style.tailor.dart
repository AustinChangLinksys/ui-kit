// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'styled_text_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$StyledTextStyleTailorMixin on ThemeExtension<StyledTextStyle> {
  TextStyle get baseTextStyle;
  StateColorSpec get linkColors;
  AnimationSpec get linkAnimation;
  TextStyle get largeTextStyle;
  TextStyle get smallTextStyle;
  TextStyle get boldTextStyle;
  TextStyle get italicTextStyle;
  TextStyle get underlineTextStyle;
  TextStyle get colorTextStyle;
  TextDecoration get linkDecoration;
  double get linkDecorationThickness;
  List<Shadow>? get linkShadows;
  Color? get linkBackgroundColor;

  @override
  StyledTextStyle copyWith({
    TextStyle? baseTextStyle,
    StateColorSpec? linkColors,
    AnimationSpec? linkAnimation,
    TextStyle? largeTextStyle,
    TextStyle? smallTextStyle,
    TextStyle? boldTextStyle,
    TextStyle? italicTextStyle,
    TextStyle? underlineTextStyle,
    TextStyle? colorTextStyle,
    TextDecoration? linkDecoration,
    double? linkDecorationThickness,
    List<Shadow>? linkShadows,
    Color? linkBackgroundColor,
  }) {
    return StyledTextStyle(
      baseTextStyle: baseTextStyle ?? this.baseTextStyle,
      linkColors: linkColors ?? this.linkColors,
      linkAnimation: linkAnimation ?? this.linkAnimation,
      largeTextStyle: largeTextStyle ?? this.largeTextStyle,
      smallTextStyle: smallTextStyle ?? this.smallTextStyle,
      boldTextStyle: boldTextStyle ?? this.boldTextStyle,
      italicTextStyle: italicTextStyle ?? this.italicTextStyle,
      underlineTextStyle: underlineTextStyle ?? this.underlineTextStyle,
      colorTextStyle: colorTextStyle ?? this.colorTextStyle,
      linkDecoration: linkDecoration ?? this.linkDecoration,
      linkDecorationThickness:
          linkDecorationThickness ?? this.linkDecorationThickness,
      linkShadows: linkShadows ?? this.linkShadows,
      linkBackgroundColor: linkBackgroundColor ?? this.linkBackgroundColor,
    );
  }

  @override
  StyledTextStyle lerp(
      covariant ThemeExtension<StyledTextStyle>? other, double t) {
    if (other is! StyledTextStyle) return this as StyledTextStyle;
    return StyledTextStyle(
      baseTextStyle: TextStyle.lerp(baseTextStyle, other.baseTextStyle, t)!,
      linkColors: linkColors.lerp(other.linkColors, t),
      linkAnimation: linkAnimation.lerp(other.linkAnimation, t),
      largeTextStyle: TextStyle.lerp(largeTextStyle, other.largeTextStyle, t)!,
      smallTextStyle: TextStyle.lerp(smallTextStyle, other.smallTextStyle, t)!,
      boldTextStyle: TextStyle.lerp(boldTextStyle, other.boldTextStyle, t)!,
      italicTextStyle:
          TextStyle.lerp(italicTextStyle, other.italicTextStyle, t)!,
      underlineTextStyle:
          TextStyle.lerp(underlineTextStyle, other.underlineTextStyle, t)!,
      colorTextStyle: TextStyle.lerp(colorTextStyle, other.colorTextStyle, t)!,
      linkDecoration: t < 0.5 ? linkDecoration : other.linkDecoration,
      linkDecorationThickness:
          t < 0.5 ? linkDecorationThickness : other.linkDecorationThickness,
      linkShadows: t < 0.5 ? linkShadows : other.linkShadows,
      linkBackgroundColor:
          Color.lerp(linkBackgroundColor, other.linkBackgroundColor, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StyledTextStyle &&
            const DeepCollectionEquality()
                .equals(baseTextStyle, other.baseTextStyle) &&
            const DeepCollectionEquality()
                .equals(linkColors, other.linkColors) &&
            const DeepCollectionEquality()
                .equals(linkAnimation, other.linkAnimation) &&
            const DeepCollectionEquality()
                .equals(largeTextStyle, other.largeTextStyle) &&
            const DeepCollectionEquality()
                .equals(smallTextStyle, other.smallTextStyle) &&
            const DeepCollectionEquality()
                .equals(boldTextStyle, other.boldTextStyle) &&
            const DeepCollectionEquality()
                .equals(italicTextStyle, other.italicTextStyle) &&
            const DeepCollectionEquality()
                .equals(underlineTextStyle, other.underlineTextStyle) &&
            const DeepCollectionEquality()
                .equals(colorTextStyle, other.colorTextStyle) &&
            const DeepCollectionEquality()
                .equals(linkDecoration, other.linkDecoration) &&
            const DeepCollectionEquality().equals(
                linkDecorationThickness, other.linkDecorationThickness) &&
            const DeepCollectionEquality()
                .equals(linkShadows, other.linkShadows) &&
            const DeepCollectionEquality()
                .equals(linkBackgroundColor, other.linkBackgroundColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(baseTextStyle),
      const DeepCollectionEquality().hash(linkColors),
      const DeepCollectionEquality().hash(linkAnimation),
      const DeepCollectionEquality().hash(largeTextStyle),
      const DeepCollectionEquality().hash(smallTextStyle),
      const DeepCollectionEquality().hash(boldTextStyle),
      const DeepCollectionEquality().hash(italicTextStyle),
      const DeepCollectionEquality().hash(underlineTextStyle),
      const DeepCollectionEquality().hash(colorTextStyle),
      const DeepCollectionEquality().hash(linkDecoration),
      const DeepCollectionEquality().hash(linkDecorationThickness),
      const DeepCollectionEquality().hash(linkShadows),
      const DeepCollectionEquality().hash(linkBackgroundColor),
    );
  }
}

extension StyledTextStyleBuildContextProps on BuildContext {
  StyledTextStyle get styledTextStyle =>
      Theme.of(this).extension<StyledTextStyle>()!;

  /// Base text style - uses theme typography tokens
  TextStyle get baseTextStyle => styledTextStyle.baseTextStyle;

  /// Color specification for link states (normal/hover/pressed/disabled)
  StateColorSpec get linkColors => styledTextStyle.linkColors;

  /// Animation specification for link interactions
  AnimationSpec get linkAnimation => styledTextStyle.linkAnimation;

  /// Typography token for large text variant
  TextStyle get largeTextStyle => styledTextStyle.largeTextStyle;

  /// Typography token for small text variant
  TextStyle get smallTextStyle => styledTextStyle.smallTextStyle;

  /// Typography token for bold text variant
  TextStyle get boldTextStyle => styledTextStyle.boldTextStyle;

  /// Typography token for italic text variant
  TextStyle get italicTextStyle => styledTextStyle.italicTextStyle;

  /// Typography token for underlined text variant
  TextStyle get underlineTextStyle => styledTextStyle.underlineTextStyle;

  /// Typography token for colored text variant
  TextStyle get colorTextStyle => styledTextStyle.colorTextStyle;

  /// Link text decoration (underline, none, etc.)
  TextDecoration get linkDecoration => styledTextStyle.linkDecoration;

  /// Link text decoration thickness
  double get linkDecorationThickness => styledTextStyle.linkDecorationThickness;

  /// Optional shadows for link text (used in Glass theme)
  List<Shadow>? get linkShadows => styledTextStyle.linkShadows;

  /// Optional background color for link text (used in Brutal theme)
  Color? get linkBackgroundColor => styledTextStyle.linkBackgroundColor;
}
