// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_design_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppDesignThemeTailorMixin on ThemeExtension<AppDesignTheme> {
  ToggleStyle get toggleStyle;
  SkeletonStyle get skeletonStyle;
  InputStyle get inputStyle;
  SurfaceStyle get surfaceBase;
  SurfaceStyle get surfaceElevated;
  SurfaceStyle get surfaceHighlight;
  TypographySpec get typography;
  AnimationSpec get animation;
  double get spacingFactor;
  LayoutSpec get layoutSpec;
  double get buttonHeight;
  NavigationStyle get navigationStyle;

  @override
  AppDesignTheme copyWith({
    ToggleStyle? toggleStyle,
    SkeletonStyle? skeletonStyle,
    InputStyle? inputStyle,
    SurfaceStyle? surfaceBase,
    SurfaceStyle? surfaceElevated,
    SurfaceStyle? surfaceHighlight,
    TypographySpec? typography,
    AnimationSpec? animation,
    double? spacingFactor,
    LayoutSpec? layoutSpec,
    double? buttonHeight,
    NavigationStyle? navigationStyle,
  }) {
    return AppDesignTheme(
      toggleStyle: toggleStyle ?? this.toggleStyle,
      skeletonStyle: skeletonStyle ?? this.skeletonStyle,
      inputStyle: inputStyle ?? this.inputStyle,
      surfaceBase: surfaceBase ?? this.surfaceBase,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
      typography: typography ?? this.typography,
      animation: animation ?? this.animation,
      spacingFactor: spacingFactor ?? this.spacingFactor,
      layoutSpec: layoutSpec ?? this.layoutSpec,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      navigationStyle: navigationStyle ?? this.navigationStyle,
    );
  }

  @override
  AppDesignTheme lerp(
      covariant ThemeExtension<AppDesignTheme>? other, double t) {
    if (other is! AppDesignTheme) return this as AppDesignTheme;
    return AppDesignTheme(
      toggleStyle: t < 0.5 ? toggleStyle : other.toggleStyle,
      skeletonStyle: t < 0.5 ? skeletonStyle : other.skeletonStyle,
      inputStyle: t < 0.5 ? inputStyle : other.inputStyle,
      surfaceBase: t < 0.5 ? surfaceBase : other.surfaceBase,
      surfaceElevated: t < 0.5 ? surfaceElevated : other.surfaceElevated,
      surfaceHighlight: t < 0.5 ? surfaceHighlight : other.surfaceHighlight,
      typography: t < 0.5 ? typography : other.typography,
      animation: t < 0.5 ? animation : other.animation,
      spacingFactor: t < 0.5 ? spacingFactor : other.spacingFactor,
      layoutSpec: t < 0.5 ? layoutSpec : other.layoutSpec,
      buttonHeight: t < 0.5 ? buttonHeight : other.buttonHeight,
      navigationStyle: t < 0.5 ? navigationStyle : other.navigationStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppDesignTheme &&
            const DeepCollectionEquality()
                .equals(toggleStyle, other.toggleStyle) &&
            const DeepCollectionEquality()
                .equals(skeletonStyle, other.skeletonStyle) &&
            const DeepCollectionEquality()
                .equals(inputStyle, other.inputStyle) &&
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
                .equals(spacingFactor, other.spacingFactor) &&
            const DeepCollectionEquality()
                .equals(layoutSpec, other.layoutSpec) &&
            const DeepCollectionEquality()
                .equals(buttonHeight, other.buttonHeight) &&
            const DeepCollectionEquality()
                .equals(navigationStyle, other.navigationStyle));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(toggleStyle),
      const DeepCollectionEquality().hash(skeletonStyle),
      const DeepCollectionEquality().hash(inputStyle),
      const DeepCollectionEquality().hash(surfaceBase),
      const DeepCollectionEquality().hash(surfaceElevated),
      const DeepCollectionEquality().hash(surfaceHighlight),
      const DeepCollectionEquality().hash(typography),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(spacingFactor),
      const DeepCollectionEquality().hash(layoutSpec),
      const DeepCollectionEquality().hash(buttonHeight),
      const DeepCollectionEquality().hash(navigationStyle),
    );
  }
}

extension AppDesignThemeBuildContextProps on BuildContext {
  AppDesignTheme get appDesignTheme =>
      Theme.of(this).extension<AppDesignTheme>()!;
  ToggleStyle get toggleStyle => appDesignTheme.toggleStyle;
  SkeletonStyle get skeletonStyle => appDesignTheme.skeletonStyle;
  InputStyle get inputStyle => appDesignTheme.inputStyle;
  SurfaceStyle get surfaceBase => appDesignTheme.surfaceBase;
  SurfaceStyle get surfaceElevated => appDesignTheme.surfaceElevated;
  SurfaceStyle get surfaceHighlight => appDesignTheme.surfaceHighlight;
  TypographySpec get typography => appDesignTheme.typography;
  AnimationSpec get animation => appDesignTheme.animation;
  double get spacingFactor => appDesignTheme.spacingFactor;
  LayoutSpec get layoutSpec => appDesignTheme.layoutSpec;
  double get buttonHeight => appDesignTheme.buttonHeight;
  NavigationStyle get navigationStyle => appDesignTheme.navigationStyle;
}
