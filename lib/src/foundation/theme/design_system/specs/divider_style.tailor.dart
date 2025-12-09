// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'divider_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$DividerStyleTailorMixin on ThemeExtension<DividerStyle> {
  Color get color;
  Color? get secondaryColor;
  double get thickness;
  double get indent;
  double get endIndent;
  double get glowStrength;
  DividerPattern get pattern;

  @override
  DividerStyle copyWith({
    Color? color,
    Color? secondaryColor,
    double? thickness,
    double? indent,
    double? endIndent,
    double? glowStrength,
    DividerPattern? pattern,
  }) {
    return DividerStyle(
      color: color ?? this.color,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      thickness: thickness ?? this.thickness,
      indent: indent ?? this.indent,
      endIndent: endIndent ?? this.endIndent,
      glowStrength: glowStrength ?? this.glowStrength,
      pattern: pattern ?? this.pattern,
    );
  }

  @override
  DividerStyle lerp(covariant ThemeExtension<DividerStyle>? other, double t) {
    if (other is! DividerStyle) return this as DividerStyle;
    return DividerStyle(
      color: Color.lerp(color, other.color, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      thickness: t < 0.5 ? thickness : other.thickness,
      indent: t < 0.5 ? indent : other.indent,
      endIndent: t < 0.5 ? endIndent : other.endIndent,
      glowStrength: t < 0.5 ? glowStrength : other.glowStrength,
      pattern: t < 0.5 ? pattern : other.pattern,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DividerStyle &&
            const DeepCollectionEquality().equals(color, other.color) &&
            const DeepCollectionEquality()
                .equals(secondaryColor, other.secondaryColor) &&
            const DeepCollectionEquality().equals(thickness, other.thickness) &&
            const DeepCollectionEquality().equals(indent, other.indent) &&
            const DeepCollectionEquality().equals(endIndent, other.endIndent) &&
            const DeepCollectionEquality()
                .equals(glowStrength, other.glowStrength) &&
            const DeepCollectionEquality().equals(pattern, other.pattern));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(secondaryColor),
      const DeepCollectionEquality().hash(thickness),
      const DeepCollectionEquality().hash(indent),
      const DeepCollectionEquality().hash(endIndent),
      const DeepCollectionEquality().hash(glowStrength),
      const DeepCollectionEquality().hash(pattern),
    );
  }
}

extension DividerStyleBuildContextProps on BuildContext {
  DividerStyle get dividerStyle => Theme.of(this).extension<DividerStyle>()!;

  /// Primary divider color.
  Color get color => dividerStyle.color;

  /// Secondary color for gradient or pattern effects.
  Color? get secondaryColor => dividerStyle.secondaryColor;

  /// Divider line thickness.
  double get thickness => dividerStyle.thickness;

  /// Left/start indent.
  double get indent => dividerStyle.indent;

  /// Right/end indent.
  double get endIndent => dividerStyle.endIndent;

  /// Glow effect strength (0 for none).
  double get glowStrength => dividerStyle.glowStrength;

  /// Divider line pattern (solid, dashed, jagged).
  DividerPattern get pattern => dividerStyle.pattern;
}
