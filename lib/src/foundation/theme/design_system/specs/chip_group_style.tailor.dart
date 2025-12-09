// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chip_group_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ChipGroupStyleTailorMixin on ThemeExtension<ChipGroupStyle> {
  StateColorSpec get backgroundColors;
  StateColorSpec get textColors;
  Color get selectedBorderColor;
  double get borderRadius;
  Color get unselectedBackground;
  Color get unselectedText;
  Color get selectedBackground;
  Color get selectedText;

  @override
  ChipGroupStyle copyWith({
    StateColorSpec? backgroundColors,
    StateColorSpec? textColors,
    Color? selectedBorderColor,
    double? borderRadius,
    Color? unselectedBackground,
    Color? unselectedText,
    Color? selectedBackground,
    Color? selectedText,
  }) {
    return ChipGroupStyle(
      backgroundColors: backgroundColors ?? this.backgroundColors,
      textColors: textColors ?? this.textColors,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ChipGroupStyle lerp(
      covariant ThemeExtension<ChipGroupStyle>? other, double t) {
    if (other is! ChipGroupStyle) return this as ChipGroupStyle;
    return ChipGroupStyle(
      backgroundColors: backgroundColors.lerp(other.backgroundColors, t),
      textColors: textColors.lerp(other.textColors, t),
      selectedBorderColor:
          Color.lerp(selectedBorderColor, other.selectedBorderColor, t)!,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChipGroupStyle &&
            const DeepCollectionEquality()
                .equals(backgroundColors, other.backgroundColors) &&
            const DeepCollectionEquality()
                .equals(textColors, other.textColors) &&
            const DeepCollectionEquality()
                .equals(selectedBorderColor, other.selectedBorderColor) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality()
                .equals(unselectedBackground, other.unselectedBackground) &&
            const DeepCollectionEquality()
                .equals(unselectedText, other.unselectedText) &&
            const DeepCollectionEquality()
                .equals(selectedBackground, other.selectedBackground) &&
            const DeepCollectionEquality()
                .equals(selectedText, other.selectedText));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColors),
      const DeepCollectionEquality().hash(textColors),
      const DeepCollectionEquality().hash(selectedBorderColor),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(unselectedBackground),
      const DeepCollectionEquality().hash(unselectedText),
      const DeepCollectionEquality().hash(selectedBackground),
      const DeepCollectionEquality().hash(selectedText),
    );
  }
}

extension ChipGroupStyleBuildContextProps on BuildContext {
  ChipGroupStyle get chipGroupStyle =>
      Theme.of(this).extension<ChipGroupStyle>()!;

  /// State-based colors for chip backgrounds.
  /// Use [backgroundColors.resolve(isActive: isSelected)] to get the appropriate color.
  StateColorSpec get backgroundColors => chipGroupStyle.backgroundColors;

  /// State-based colors for chip text.
  /// Use [textColors.resolve(isActive: isSelected)] to get the appropriate color.
  StateColorSpec get textColors => chipGroupStyle.textColors;

  /// Border color of selected chips
  Color get selectedBorderColor => chipGroupStyle.selectedBorderColor;

  /// Border radius for chip corners
  double get borderRadius => chipGroupStyle.borderRadius;
  Color get unselectedBackground => chipGroupStyle.unselectedBackground;
  Color get unselectedText => chipGroupStyle.unselectedText;
  Color get selectedBackground => chipGroupStyle.selectedBackground;
  Color get selectedText => chipGroupStyle.selectedText;
}
