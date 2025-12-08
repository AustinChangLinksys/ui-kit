// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$InputStyleTailorMixin on ThemeExtension<InputStyle> {
  SurfaceStyle get outlineStyle;
  SurfaceStyle get underlineStyle;
  SurfaceStyle get filledStyle;
  SurfaceStyle get focusModifier;
  SurfaceStyle get errorModifier;

  @override
  InputStyle copyWith({
    SurfaceStyle? outlineStyle,
    SurfaceStyle? underlineStyle,
    SurfaceStyle? filledStyle,
    SurfaceStyle? focusModifier,
    SurfaceStyle? errorModifier,
  }) {
    return InputStyle(
      outlineStyle: outlineStyle ?? this.outlineStyle,
      underlineStyle: underlineStyle ?? this.underlineStyle,
      filledStyle: filledStyle ?? this.filledStyle,
      focusModifier: focusModifier ?? this.focusModifier,
      errorModifier: errorModifier ?? this.errorModifier,
    );
  }

  @override
  InputStyle lerp(covariant ThemeExtension<InputStyle>? other, double t) {
    if (other is! InputStyle) return this as InputStyle;
    return InputStyle(
      outlineStyle: t < 0.5 ? outlineStyle : other.outlineStyle,
      underlineStyle: t < 0.5 ? underlineStyle : other.underlineStyle,
      filledStyle: t < 0.5 ? filledStyle : other.filledStyle,
      focusModifier: t < 0.5 ? focusModifier : other.focusModifier,
      errorModifier: t < 0.5 ? errorModifier : other.errorModifier,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InputStyle &&
            const DeepCollectionEquality()
                .equals(outlineStyle, other.outlineStyle) &&
            const DeepCollectionEquality()
                .equals(underlineStyle, other.underlineStyle) &&
            const DeepCollectionEquality()
                .equals(filledStyle, other.filledStyle) &&
            const DeepCollectionEquality()
                .equals(focusModifier, other.focusModifier) &&
            const DeepCollectionEquality()
                .equals(errorModifier, other.errorModifier));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(outlineStyle),
      const DeepCollectionEquality().hash(underlineStyle),
      const DeepCollectionEquality().hash(filledStyle),
      const DeepCollectionEquality().hash(focusModifier),
      const DeepCollectionEquality().hash(errorModifier),
    );
  }
}

extension InputStyleBuildContextProps on BuildContext {
  InputStyle get inputStyle => Theme.of(this).extension<InputStyle>()!;

  /// Outline style variant for input fields.
  SurfaceStyle get outlineStyle => inputStyle.outlineStyle;

  /// Underline style variant for input fields.
  SurfaceStyle get underlineStyle => inputStyle.underlineStyle;

  /// Filled style variant for input fields.
  SurfaceStyle get filledStyle => inputStyle.filledStyle;

  /// Style modifier applied when input is focused.
  SurfaceStyle get focusModifier => inputStyle.focusModifier;

  /// Style modifier applied when input has an error.
  SurfaceStyle get errorModifier => inputStyle.errorModifier;
}
