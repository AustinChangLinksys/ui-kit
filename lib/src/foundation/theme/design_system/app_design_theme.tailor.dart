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
  TabsStyle get tabsStyle;
  StepperStyle get stepperStyle;
  BreadcrumbStyle get breadcrumbStyle;
  ExpansionPanelStyle get expansionPanelStyle;
  CarouselStyle get carouselStyle;
  ChipGroupStyle get chipGroupStyle;
  TopologySpec get topologySpec;
  TableStyle get tableStyle;
  SlideActionStyle get slideActionStyle;
  ExpandableFabStyle get expandableFabStyle;
  GaugeStyle get gaugeStyle;
  RangeInputStyle get rangeInputStyle;
  PinInputStyle get pinInputStyle;
  PasswordInputStyle get passwordInputStyle;
  SheetStyle get sheetStyle;

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
    TabsStyle? tabsStyle,
    StepperStyle? stepperStyle,
    BreadcrumbStyle? breadcrumbStyle,
    ExpansionPanelStyle? expansionPanelStyle,
    CarouselStyle? carouselStyle,
    ChipGroupStyle? chipGroupStyle,
    TopologySpec? topologySpec,
    TableStyle? tableStyle,
    SlideActionStyle? slideActionStyle,
    ExpandableFabStyle? expandableFabStyle,
    GaugeStyle? gaugeStyle,
    RangeInputStyle? rangeInputStyle,
    PinInputStyle? pinInputStyle,
    PasswordInputStyle? passwordInputStyle,
    SheetStyle? sheetStyle,
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
      tabsStyle: tabsStyle ?? this.tabsStyle,
      stepperStyle: stepperStyle ?? this.stepperStyle,
      breadcrumbStyle: breadcrumbStyle ?? this.breadcrumbStyle,
      expansionPanelStyle: expansionPanelStyle ?? this.expansionPanelStyle,
      carouselStyle: carouselStyle ?? this.carouselStyle,
      chipGroupStyle: chipGroupStyle ?? this.chipGroupStyle,
      topologySpec: topologySpec ?? this.topologySpec,
      tableStyle: tableStyle ?? this.tableStyle,
      slideActionStyle: slideActionStyle ?? this.slideActionStyle,
      expandableFabStyle: expandableFabStyle ?? this.expandableFabStyle,
      gaugeStyle: gaugeStyle ?? this.gaugeStyle,
      rangeInputStyle: rangeInputStyle ?? this.rangeInputStyle,
      pinInputStyle: pinInputStyle ?? this.pinInputStyle,
      passwordInputStyle: passwordInputStyle ?? this.passwordInputStyle,
      sheetStyle: sheetStyle ?? this.sheetStyle,
    );
  }

  @override
  AppDesignTheme lerp(
      covariant ThemeExtension<AppDesignTheme>? other, double t) {
    if (other is! AppDesignTheme) return this as AppDesignTheme;
    return AppDesignTheme(
      toggleStyle: toggleStyle.lerp(other.toggleStyle, t),
      skeletonStyle: skeletonStyle.lerp(other.skeletonStyle, t),
      inputStyle: inputStyle.lerp(other.inputStyle, t),
      loaderStyle: loaderStyle.lerp(other.loaderStyle, t),
      toastStyle: toastStyle.lerp(other.toastStyle, t),
      dividerStyle: dividerStyle.lerp(other.dividerStyle, t),
      networkInputStyle: t < 0.5 ? networkInputStyle : other.networkInputStyle,
      surfaceBase: t < 0.5 ? surfaceBase : other.surfaceBase,
      surfaceElevated: t < 0.5 ? surfaceElevated : other.surfaceElevated,
      surfaceHighlight: t < 0.5 ? surfaceHighlight : other.surfaceHighlight,
      surfaceSecondary: t < 0.5 ? surfaceSecondary : other.surfaceSecondary,
      surfaceTertiary: t < 0.5 ? surfaceTertiary : other.surfaceTertiary,
      typography: t < 0.5 ? typography : other.typography,
      animation: animation.lerp(other.animation, t),
      spacingFactor: t < 0.5 ? spacingFactor : other.spacingFactor,
      layoutSpec: t < 0.5 ? layoutSpec : other.layoutSpec,
      buttonHeight: t < 0.5 ? buttonHeight : other.buttonHeight,
      navigationStyle: navigationStyle.lerp(other.navigationStyle, t),
      appBarStyle: appBarStyle.lerp(other.appBarStyle, t),
      menuStyle: menuStyle.lerp(other.menuStyle, t),
      dialogStyle: dialogStyle.lerp(other.dialogStyle, t),
      motion: t < 0.5 ? motion : other.motion,
      visualEffects: t < 0.5 ? visualEffects : other.visualEffects,
      iconStyle: t < 0.5 ? iconStyle : other.iconStyle,
      tabsStyle: tabsStyle.lerp(other.tabsStyle, t),
      stepperStyle: stepperStyle.lerp(other.stepperStyle, t),
      breadcrumbStyle: breadcrumbStyle.lerp(other.breadcrumbStyle, t),
      expansionPanelStyle:
          expansionPanelStyle.lerp(other.expansionPanelStyle, t),
      carouselStyle: carouselStyle.lerp(other.carouselStyle, t),
      chipGroupStyle: chipGroupStyle.lerp(other.chipGroupStyle, t),
      topologySpec: topologySpec.lerp(other.topologySpec, t),
      tableStyle: tableStyle.lerp(other.tableStyle, t),
      slideActionStyle: slideActionStyle.lerp(other.slideActionStyle, t),
      expandableFabStyle: expandableFabStyle.lerp(other.expandableFabStyle, t),
      gaugeStyle: gaugeStyle.lerp(other.gaugeStyle, t),
      rangeInputStyle: rangeInputStyle.lerp(other.rangeInputStyle, t),
      pinInputStyle: pinInputStyle.lerp(other.pinInputStyle, t),
      passwordInputStyle: passwordInputStyle.lerp(other.passwordInputStyle, t),
      sheetStyle: sheetStyle.lerp(other.sheetStyle, t),
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
                .equals(chipGroupStyle, other.chipGroupStyle) &&
            const DeepCollectionEquality()
                .equals(topologySpec, other.topologySpec) &&
            const DeepCollectionEquality()
                .equals(tableStyle, other.tableStyle) &&
            const DeepCollectionEquality()
                .equals(slideActionStyle, other.slideActionStyle) &&
            const DeepCollectionEquality()
                .equals(expandableFabStyle, other.expandableFabStyle) &&
            const DeepCollectionEquality()
                .equals(gaugeStyle, other.gaugeStyle) &&
            const DeepCollectionEquality()
                .equals(rangeInputStyle, other.rangeInputStyle) &&
            const DeepCollectionEquality()
                .equals(pinInputStyle, other.pinInputStyle) &&
            const DeepCollectionEquality()
                .equals(passwordInputStyle, other.passwordInputStyle) &&
            const DeepCollectionEquality()
                .equals(sheetStyle, other.sheetStyle));
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
      const DeepCollectionEquality().hash(tabsStyle),
      const DeepCollectionEquality().hash(stepperStyle),
      const DeepCollectionEquality().hash(breadcrumbStyle),
      const DeepCollectionEquality().hash(expansionPanelStyle),
      const DeepCollectionEquality().hash(carouselStyle),
      const DeepCollectionEquality().hash(chipGroupStyle),
      const DeepCollectionEquality().hash(topologySpec),
      const DeepCollectionEquality().hash(tableStyle),
      const DeepCollectionEquality().hash(slideActionStyle),
      const DeepCollectionEquality().hash(expandableFabStyle),
      const DeepCollectionEquality().hash(gaugeStyle),
      const DeepCollectionEquality().hash(rangeInputStyle),
      const DeepCollectionEquality().hash(pinInputStyle),
      const DeepCollectionEquality().hash(passwordInputStyle),
      const DeepCollectionEquality().hash(sheetStyle),
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
  TabsStyle get tabsStyle => appDesignTheme.tabsStyle;
  StepperStyle get stepperStyle => appDesignTheme.stepperStyle;
  BreadcrumbStyle get breadcrumbStyle => appDesignTheme.breadcrumbStyle;
  ExpansionPanelStyle get expansionPanelStyle =>
      appDesignTheme.expansionPanelStyle;
  CarouselStyle get carouselStyle => appDesignTheme.carouselStyle;
  ChipGroupStyle get chipGroupStyle => appDesignTheme.chipGroupStyle;
  TopologySpec get topologySpec => appDesignTheme.topologySpec;
  TableStyle get tableStyle => appDesignTheme.tableStyle;
  SlideActionStyle get slideActionStyle => appDesignTheme.slideActionStyle;
  ExpandableFabStyle get expandableFabStyle =>
      appDesignTheme.expandableFabStyle;
  GaugeStyle get gaugeStyle => appDesignTheme.gaugeStyle;
  RangeInputStyle get rangeInputStyle => appDesignTheme.rangeInputStyle;
  PinInputStyle get pinInputStyle => appDesignTheme.pinInputStyle;
  PasswordInputStyle get passwordInputStyle =>
      appDesignTheme.passwordInputStyle;

  /// Unified sheet style for both bottom sheets and side sheets.
  ///
  /// Composes [OverlaySpec] for overlay appearance and animation.
  /// Use this instead of [bottomSheetStyle] and [sideSheetStyle] for new code.
  SheetStyle get sheetStyle => appDesignTheme.sheetStyle;
}
