// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'glass_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$GlassThemeTailorMixin on ThemeExtension<GlassTheme> {
  Color get baseColor;
  Color get borderColor;
  double get blurStrength;
  Color get shadowColor;

  @override
  GlassTheme copyWith({
    Color? baseColor,
    Color? borderColor,
    double? blurStrength,
    Color? shadowColor,
  }) {
    return GlassTheme(
      baseColor: baseColor ?? this.baseColor,
      borderColor: borderColor ?? this.borderColor,
      blurStrength: blurStrength ?? this.blurStrength,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  GlassTheme lerp(covariant ThemeExtension<GlassTheme>? other, double t) {
    if (other is! GlassTheme) return this as GlassTheme;
    return GlassTheme(
      baseColor: Color.lerp(baseColor, other.baseColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      blurStrength: t < 0.5 ? blurStrength : other.blurStrength,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GlassTheme &&
            const DeepCollectionEquality().equals(baseColor, other.baseColor) &&
            const DeepCollectionEquality()
                .equals(borderColor, other.borderColor) &&
            const DeepCollectionEquality()
                .equals(blurStrength, other.blurStrength) &&
            const DeepCollectionEquality()
                .equals(shadowColor, other.shadowColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(baseColor),
      const DeepCollectionEquality().hash(borderColor),
      const DeepCollectionEquality().hash(blurStrength),
      const DeepCollectionEquality().hash(shadowColor),
    );
  }
}

extension GlassThemeBuildContextProps on BuildContext {
  GlassTheme get glassTheme => Theme.of(this).extension<GlassTheme>()!;
  Color get baseColor => glassTheme.baseColor;
  Color get borderColor => glassTheme.borderColor;
  double get blurStrength => glassTheme.blurStrength;
  Color get shadowColor => glassTheme.shadowColor;
}
