// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chip_group_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ChipGroupStyleTailorMixin on ThemeExtension<ChipGroupStyle> {
  Color get unselectedBackground;
  Color get unselectedText;
  Color get selectedBackground;
  Color get selectedText;
  Color get selectedBorderColor;
  double get borderRadius;

  @override
  ChipGroupStyle copyWith({
    Color? unselectedBackground,
    Color? unselectedText,
    Color? selectedBackground,
    Color? selectedText,
    Color? selectedBorderColor,
    double? borderRadius,
  }) {
    return ChipGroupStyle(
      unselectedBackground: unselectedBackground ?? this.unselectedBackground,
      unselectedText: unselectedText ?? this.unselectedText,
      selectedBackground: selectedBackground ?? this.selectedBackground,
      selectedText: selectedText ?? this.selectedText,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ChipGroupStyle lerp(
      covariant ThemeExtension<ChipGroupStyle>? other, double t) {
    if (other is! ChipGroupStyle) return this as ChipGroupStyle;
    return ChipGroupStyle(
      unselectedBackground:
          Color.lerp(unselectedBackground, other.unselectedBackground, t)!,
      unselectedText: Color.lerp(unselectedText, other.unselectedText, t)!,
      selectedBackground:
          Color.lerp(selectedBackground, other.selectedBackground, t)!,
      selectedText: Color.lerp(selectedText, other.selectedText, t)!,
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
                .equals(unselectedBackground, other.unselectedBackground) &&
            const DeepCollectionEquality()
                .equals(unselectedText, other.unselectedText) &&
            const DeepCollectionEquality()
                .equals(selectedBackground, other.selectedBackground) &&
            const DeepCollectionEquality()
                .equals(selectedText, other.selectedText) &&
            const DeepCollectionEquality()
                .equals(selectedBorderColor, other.selectedBorderColor) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(unselectedBackground),
      const DeepCollectionEquality().hash(unselectedText),
      const DeepCollectionEquality().hash(selectedBackground),
      const DeepCollectionEquality().hash(selectedText),
      const DeepCollectionEquality().hash(selectedBorderColor),
      const DeepCollectionEquality().hash(borderRadius),
    );
  }
}

extension ChipGroupStyleBuildContextProps on BuildContext {
  ChipGroupStyle get chipGroupStyle =>
      Theme.of(this).extension<ChipGroupStyle>()!;

  /// Background color of unselected chips
  Color get unselectedBackground => chipGroupStyle.unselectedBackground;

  /// Text color of unselected chips
  Color get unselectedText => chipGroupStyle.unselectedText;

  /// Background color of selected chips
  Color get selectedBackground => chipGroupStyle.selectedBackground;

  /// Text color of selected chips
  Color get selectedText => chipGroupStyle.selectedText;

  /// Border color of selected chips
  Color get selectedBorderColor => chipGroupStyle.selectedBorderColor;

  /// Border radius for chip corners
  double get borderRadius => chipGroupStyle.borderRadius;
}
