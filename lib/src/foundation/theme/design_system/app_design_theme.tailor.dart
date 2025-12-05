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
  LoaderStyle get loaderStyle;
  ToastStyle get toastStyle;
  DividerStyle get dividerStyle;
  NetworkInputStyle get networkInputStyle;
  SurfaceStyle get surfaceBase;
  SurfaceStyle get surfaceElevated;
  SurfaceStyle get surfaceHighlight;
  SurfaceStyle get surfaceSecondary;
  SurfaceStyle get surfaceTertiary;
  TypographySpec get typography;
  AnimationSpec get animation;
  double get spacingFactor;
  LayoutSpec get layoutSpec;
  double get buttonHeight;
  NavigationStyle get navigationStyle;
  AppBarStyle get appBarStyle;
  AppMenuStyle get menuStyle;
  DialogStyle get dialogStyle;
  AppMotion get motion;
  GlobalEffectsType get visualEffects;
  AppIconStyle get iconStyle;
  BottomSheetStyle get bottomSheetStyle;
  SideSheetStyle get sideSheetStyle;
  TabsStyle get tabsStyle;
  StepperStyle get stepperStyle;
  BreadcrumbStyle get breadcrumbStyle;
  ExpansionPanelStyle get expansionPanelStyle;
  CarouselStyle get carouselStyle;
  ChipGroupStyle get chipGroupStyle;

  @override
  AppDesignTheme copyWith({
    ToggleStyle? toggleStyle,
    SkeletonStyle? skeletonStyle,
    InputStyle? inputStyle,
    LoaderStyle? loaderStyle,
    ToastStyle? toastStyle,
    DividerStyle? dividerStyle,
    NetworkInputStyle? networkInputStyle,
    SurfaceStyle? surfaceBase,
    SurfaceStyle? surfaceElevated,
    SurfaceStyle? surfaceHighlight,
    SurfaceStyle? surfaceSecondary,
    SurfaceStyle? surfaceTertiary,
    TypographySpec? typography,
    AnimationSpec? animation,
    double? spacingFactor,
    LayoutSpec? layoutSpec,
    double? buttonHeight,
    NavigationStyle? navigationStyle,
    AppBarStyle? appBarStyle,
    AppMenuStyle? menuStyle,
    DialogStyle? dialogStyle,
    AppMotion? motion,
    GlobalEffectsType? visualEffects,
    AppIconStyle? iconStyle,
    BottomSheetStyle? bottomSheetStyle,
    SideSheetStyle? sideSheetStyle,
    TabsStyle? tabsStyle,
    StepperStyle? stepperStyle,
    BreadcrumbStyle? breadcrumbStyle,
    ExpansionPanelStyle? expansionPanelStyle,
    CarouselStyle? carouselStyle,
    ChipGroupStyle? chipGroupStyle,
  }) {
    return AppDesignTheme(
      toggleStyle: toggleStyle ?? this.toggleStyle,
      skeletonStyle: skeletonStyle ?? this.skeletonStyle,
      inputStyle: inputStyle ?? this.inputStyle,
      loaderStyle: loaderStyle ?? this.loaderStyle,
      toastStyle: toastStyle ?? this.toastStyle,
      dividerStyle: dividerStyle ?? this.dividerStyle,
      networkInputStyle: networkInputStyle ?? this.networkInputStyle,
      surfaceBase: surfaceBase ?? this.surfaceBase,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceTertiary: surfaceTertiary ?? this.surfaceTertiary,
      typography: typography ?? this.typography,
      animation: animation ?? this.animation,
      spacingFactor: spacingFactor ?? this.spacingFactor,
      layoutSpec: layoutSpec ?? this.layoutSpec,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      navigationStyle: navigationStyle ?? this.navigationStyle,
      appBarStyle: appBarStyle ?? this.appBarStyle,
      menuStyle: menuStyle ?? this.menuStyle,
      dialogStyle: dialogStyle ?? this.dialogStyle,
      motion: motion ?? this.motion,
      visualEffects: visualEffects ?? this.visualEffects,
      iconStyle: iconStyle ?? this.iconStyle,
      bottomSheetStyle: bottomSheetStyle ?? this.bottomSheetStyle,
      sideSheetStyle: sideSheetStyle ?? this.sideSheetStyle,
      tabsStyle: tabsStyle ?? this.tabsStyle,
      stepperStyle: stepperStyle ?? this.stepperStyle,
      breadcrumbStyle: breadcrumbStyle ?? this.breadcrumbStyle,
      expansionPanelStyle: expansionPanelStyle ?? this.expansionPanelStyle,
      carouselStyle: carouselStyle ?? this.carouselStyle,
      chipGroupStyle: chipGroupStyle ?? this.chipGroupStyle,
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
      loaderStyle: loaderStyle.lerp(other.loaderStyle, t),
      toastStyle: toastStyle.lerp(other.toastStyle, t),
      dividerStyle: t < 0.5 ? dividerStyle : other.dividerStyle,
      networkInputStyle: t < 0.5 ? networkInputStyle : other.networkInputStyle,
      surfaceBase: t < 0.5 ? surfaceBase : other.surfaceBase,
      surfaceElevated: t < 0.5 ? surfaceElevated : other.surfaceElevated,
      surfaceHighlight: t < 0.5 ? surfaceHighlight : other.surfaceHighlight,
      surfaceSecondary: t < 0.5 ? surfaceSecondary : other.surfaceSecondary,
      surfaceTertiary: t < 0.5 ? surfaceTertiary : other.surfaceTertiary,
      typography: t < 0.5 ? typography : other.typography,
      animation: t < 0.5 ? animation : other.animation,
      spacingFactor: t < 0.5 ? spacingFactor : other.spacingFactor,
      layoutSpec: t < 0.5 ? layoutSpec : other.layoutSpec,
      buttonHeight: t < 0.5 ? buttonHeight : other.buttonHeight,
      navigationStyle: t < 0.5 ? navigationStyle : other.navigationStyle,
      appBarStyle: t < 0.5 ? appBarStyle : other.appBarStyle,
      menuStyle: t < 0.5 ? menuStyle : other.menuStyle,
      dialogStyle: t < 0.5 ? dialogStyle : other.dialogStyle,
      motion: t < 0.5 ? motion : other.motion,
      visualEffects: t < 0.5 ? visualEffects : other.visualEffects,
      iconStyle: t < 0.5 ? iconStyle : other.iconStyle,
      bottomSheetStyle: bottomSheetStyle.lerp(other.bottomSheetStyle, t),
      sideSheetStyle: sideSheetStyle.lerp(other.sideSheetStyle, t),
      tabsStyle: tabsStyle.lerp(other.tabsStyle, t),
      stepperStyle: stepperStyle.lerp(other.stepperStyle, t),
      breadcrumbStyle: breadcrumbStyle.lerp(other.breadcrumbStyle, t),
      expansionPanelStyle:
          expansionPanelStyle.lerp(other.expansionPanelStyle, t),
      carouselStyle: carouselStyle.lerp(other.carouselStyle, t),
      chipGroupStyle: chipGroupStyle.lerp(other.chipGroupStyle, t),
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
                .equals(loaderStyle, other.loaderStyle) &&
            const DeepCollectionEquality()
                .equals(toastStyle, other.toastStyle) &&
            const DeepCollectionEquality()
                .equals(dividerStyle, other.dividerStyle) &&
            const DeepCollectionEquality()
                .equals(networkInputStyle, other.networkInputStyle) &&
            const DeepCollectionEquality()
                .equals(surfaceBase, other.surfaceBase) &&
            const DeepCollectionEquality()
                .equals(surfaceElevated, other.surfaceElevated) &&
            const DeepCollectionEquality()
                .equals(surfaceHighlight, other.surfaceHighlight) &&
            const DeepCollectionEquality()
                .equals(surfaceSecondary, other.surfaceSecondary) &&
            const DeepCollectionEquality()
                .equals(surfaceTertiary, other.surfaceTertiary) &&
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
                .equals(navigationStyle, other.navigationStyle) &&
            const DeepCollectionEquality()
                .equals(appBarStyle, other.appBarStyle) &&
            const DeepCollectionEquality().equals(menuStyle, other.menuStyle) &&
            const DeepCollectionEquality()
                .equals(dialogStyle, other.dialogStyle) &&
            const DeepCollectionEquality().equals(motion, other.motion) &&
            const DeepCollectionEquality()
                .equals(visualEffects, other.visualEffects) &&
            const DeepCollectionEquality().equals(iconStyle, other.iconStyle) &&
            const DeepCollectionEquality()
                .equals(bottomSheetStyle, other.bottomSheetStyle) &&
            const DeepCollectionEquality()
                .equals(sideSheetStyle, other.sideSheetStyle) &&
            const DeepCollectionEquality().equals(tabsStyle, other.tabsStyle) &&
            const DeepCollectionEquality()
                .equals(stepperStyle, other.stepperStyle) &&
            const DeepCollectionEquality()
                .equals(breadcrumbStyle, other.breadcrumbStyle) &&
            const DeepCollectionEquality()
                .equals(expansionPanelStyle, other.expansionPanelStyle) &&
            const DeepCollectionEquality()
                .equals(carouselStyle, other.carouselStyle) &&
            const DeepCollectionEquality()
                .equals(chipGroupStyle, other.chipGroupStyle));
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(toggleStyle),
      const DeepCollectionEquality().hash(skeletonStyle),
      const DeepCollectionEquality().hash(inputStyle),
      const DeepCollectionEquality().hash(loaderStyle),
      const DeepCollectionEquality().hash(toastStyle),
      const DeepCollectionEquality().hash(dividerStyle),
      const DeepCollectionEquality().hash(networkInputStyle),
      const DeepCollectionEquality().hash(surfaceBase),
      const DeepCollectionEquality().hash(surfaceElevated),
      const DeepCollectionEquality().hash(surfaceHighlight),
      const DeepCollectionEquality().hash(surfaceSecondary),
      const DeepCollectionEquality().hash(surfaceTertiary),
      const DeepCollectionEquality().hash(typography),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(spacingFactor),
      const DeepCollectionEquality().hash(layoutSpec),
      const DeepCollectionEquality().hash(buttonHeight),
      const DeepCollectionEquality().hash(navigationStyle),
      const DeepCollectionEquality().hash(appBarStyle),
      const DeepCollectionEquality().hash(menuStyle),
      const DeepCollectionEquality().hash(dialogStyle),
      const DeepCollectionEquality().hash(motion),
      const DeepCollectionEquality().hash(visualEffects),
      const DeepCollectionEquality().hash(iconStyle),
      const DeepCollectionEquality().hash(bottomSheetStyle),
      const DeepCollectionEquality().hash(sideSheetStyle),
      const DeepCollectionEquality().hash(tabsStyle),
      const DeepCollectionEquality().hash(stepperStyle),
      const DeepCollectionEquality().hash(breadcrumbStyle),
      const DeepCollectionEquality().hash(expansionPanelStyle),
      const DeepCollectionEquality().hash(carouselStyle),
      const DeepCollectionEquality().hash(chipGroupStyle),
    ]);
  }
}

extension AppDesignThemeBuildContextProps on BuildContext {
  AppDesignTheme get appDesignTheme =>
      Theme.of(this).extension<AppDesignTheme>()!;
  ToggleStyle get toggleStyle => appDesignTheme.toggleStyle;
  SkeletonStyle get skeletonStyle => appDesignTheme.skeletonStyle;
  InputStyle get inputStyle => appDesignTheme.inputStyle;
  LoaderStyle get loaderStyle => appDesignTheme.loaderStyle;
  ToastStyle get toastStyle => appDesignTheme.toastStyle;
  DividerStyle get dividerStyle => appDesignTheme.dividerStyle;
  NetworkInputStyle get networkInputStyle => appDesignTheme.networkInputStyle;
  SurfaceStyle get surfaceBase => appDesignTheme.surfaceBase;
  SurfaceStyle get surfaceElevated => appDesignTheme.surfaceElevated;
  SurfaceStyle get surfaceHighlight => appDesignTheme.surfaceHighlight;
  SurfaceStyle get surfaceSecondary => appDesignTheme.surfaceSecondary;
  SurfaceStyle get surfaceTertiary => appDesignTheme.surfaceTertiary;
  TypographySpec get typography => appDesignTheme.typography;
  AnimationSpec get animation => appDesignTheme.animation;
  double get spacingFactor => appDesignTheme.spacingFactor;
  LayoutSpec get layoutSpec => appDesignTheme.layoutSpec;
  double get buttonHeight => appDesignTheme.buttonHeight;
  NavigationStyle get navigationStyle => appDesignTheme.navigationStyle;
  AppBarStyle get appBarStyle => appDesignTheme.appBarStyle;
  AppMenuStyle get menuStyle => appDesignTheme.menuStyle;
  DialogStyle get dialogStyle => appDesignTheme.dialogStyle;
  AppMotion get motion => appDesignTheme.motion;
  GlobalEffectsType get visualEffects => appDesignTheme.visualEffects;
  AppIconStyle get iconStyle => appDesignTheme.iconStyle;
  BottomSheetStyle get bottomSheetStyle => appDesignTheme.bottomSheetStyle;
  SideSheetStyle get sideSheetStyle => appDesignTheme.sideSheetStyle;
  TabsStyle get tabsStyle => appDesignTheme.tabsStyle;
  StepperStyle get stepperStyle => appDesignTheme.stepperStyle;
  BreadcrumbStyle get breadcrumbStyle => appDesignTheme.breadcrumbStyle;
  ExpansionPanelStyle get expansionPanelStyle =>
      appDesignTheme.expansionPanelStyle;
  CarouselStyle get carouselStyle => appDesignTheme.carouselStyle;
  ChipGroupStyle get chipGroupStyle => appDesignTheme.chipGroupStyle;
}
