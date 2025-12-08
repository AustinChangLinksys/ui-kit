// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'range_input_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$RangeInputStyleTailorMixin on ThemeExtension<RangeInputStyle> {
  bool get mergeContainers;
  Widget? get customSeparator;
  Color get activeBorderColor;
  double get spacing;

  @override
  RangeInputStyle copyWith({
    bool? mergeContainers,
    Widget? customSeparator,
    Color? activeBorderColor,
    double? spacing,
  }) {
    return RangeInputStyle(
      mergeContainers: mergeContainers ?? this.mergeContainers,
      customSeparator: customSeparator ?? this.customSeparator,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      spacing: spacing ?? this.spacing,
    );
  }

  @override
  RangeInputStyle lerp(
      covariant ThemeExtension<RangeInputStyle>? other, double t) {
    if (other is! RangeInputStyle) return this as RangeInputStyle;
    return RangeInputStyle(
      mergeContainers: t < 0.5 ? mergeContainers : other.mergeContainers,
      customSeparator: t < 0.5 ? customSeparator : other.customSeparator,
      activeBorderColor:
          Color.lerp(activeBorderColor, other.activeBorderColor, t)!,
      spacing: t < 0.5 ? spacing : other.spacing,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RangeInputStyle &&
            const DeepCollectionEquality()
                .equals(mergeContainers, other.mergeContainers) &&
            const DeepCollectionEquality()
                .equals(customSeparator, other.customSeparator) &&
            const DeepCollectionEquality()
                .equals(activeBorderColor, other.activeBorderColor) &&
            const DeepCollectionEquality().equals(spacing, other.spacing));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(mergeContainers),
      const DeepCollectionEquality().hash(customSeparator),
      const DeepCollectionEquality().hash(activeBorderColor),
      const DeepCollectionEquality().hash(spacing),
    );
  }
}

extension RangeInputStyleBuildContextProps on BuildContext {
  RangeInputStyle get rangeInputStyle =>
      Theme.of(this).extension<RangeInputStyle>()!;
  bool get mergeContainers => rangeInputStyle.mergeContainers;
  Widget? get customSeparator => rangeInputStyle.customSeparator;
  Color get activeBorderColor => rangeInputStyle.activeBorderColor;
  double get spacing => rangeInputStyle.spacing;
}
