// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_design_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppDesignThemeTailorMixin on ThemeExtension<AppDesignTheme> {
  SurfaceStyle get surfaceBase;
  SurfaceStyle get surfaceElevated;
  SurfaceStyle get surfaceHighlight;
  TypographySpec get typography;
  AnimationSpec get animation;
  double get spacingFactor;

  @override
  AppDesignTheme copyWith({
    SurfaceStyle? surfaceBase,
    SurfaceStyle? surfaceElevated,
    SurfaceStyle? surfaceHighlight,
    TypographySpec? typography,
    AnimationSpec? animation,
    double? spacingFactor,
  }) {
    return AppDesignTheme(
      surfaceBase: surfaceBase ?? this.surfaceBase,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
      typography: typography ?? this.typography,
      animation: animation ?? this.animation,
      spacingFactor: spacingFactor ?? this.spacingFactor,
    );
  }

  @override
  AppDesignTheme lerp(
      covariant ThemeExtension<AppDesignTheme>? other, double t) {
    if (other is! AppDesignTheme) return this as AppDesignTheme;
    return AppDesignTheme(
      surfaceBase: t < 0.5 ? surfaceBase : other.surfaceBase,
      surfaceElevated: t < 0.5 ? surfaceElevated : other.surfaceElevated,
      surfaceHighlight: t < 0.5 ? surfaceHighlight : other.surfaceHighlight,
      typography: t < 0.5 ? typography : other.typography,
      animation: t < 0.5 ? animation : other.animation,
      spacingFactor: t < 0.5 ? spacingFactor : other.spacingFactor,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppDesignTheme &&
            const DeepCollectionEquality()
                .equals(surfaceBase, other.surfaceBase) &&
            const DeepCollectionEquality()
                .equals(surfaceElevated, other.surfaceElevated) &&
            const DeepCollectionEquality()
                .equals(surfaceHighlight, other.surfaceHighlight) &&
            const DeepCollectionEquality()
                .equals(typography, other.typography) &&
            const DeepCollectionEquality().equals(animation, other.animation) &&
            const DeepCollectionEquality()
                .equals(spacingFactor, other.spacingFactor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(surfaceBase),
      const DeepCollectionEquality().hash(surfaceElevated),
      const DeepCollectionEquality().hash(surfaceHighlight),
      const DeepCollectionEquality().hash(typography),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(spacingFactor),
    );
  }
}

extension AppDesignThemeBuildContextProps on BuildContext {
  AppDesignTheme get appDesignTheme =>
      Theme.of(this).extension<AppDesignTheme>()!;
  SurfaceStyle get surfaceBase => appDesignTheme.surfaceBase;
  SurfaceStyle get surfaceElevated => appDesignTheme.surfaceElevated;
  SurfaceStyle get surfaceHighlight => appDesignTheme.surfaceHighlight;
  TypographySpec get typography => appDesignTheme.typography;
  AnimationSpec get animation => appDesignTheme.animation;
  double get spacingFactor => appDesignTheme.spacingFactor;
}
