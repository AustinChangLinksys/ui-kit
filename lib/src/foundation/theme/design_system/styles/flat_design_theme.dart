import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/range_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/pin_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/password_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart'
    as shared;
// Import AppIconStyle

class FlatDesignTheme extends AppDesignTheme {
  // Factory 1: Create from Config
  factory FlatDesignTheme.fromConfig(AppThemeConfig config) {
    final colors = AppColorFactory.generateFlat(config);
    return FlatDesignTheme._raw(colors);
  }

  // Factory 2: Raw Mode (AppColorScheme driven)
  factory FlatDesignTheme._raw(AppColorScheme colors) {

    return FlatDesignTheme._(
      // 1. Global Surface Definition (for Card, Dialog, etc.)
      surfaceBase: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.subtleBorder, // Use semantic border color
        borderWidth: 1.0,
        borderRadius: 8.0,
        shadows: const [], // Flat style usually has no shadows
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: colors.surfaceContainerLow,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: [
          BoxShadow(
            color: colors.shadow.withValues(
                alpha: 0.05), // Very faint natural shadow for elevation
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: colors.primary,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: colors.onPrimary,
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 0.6,
          hoverOpacity: 0.9,
          pressedOffset: Offset.zero,
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: colors.secondaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: colors.onSecondaryContainer,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: colors.tertiaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: colors.onTertiaryContainer,
      ),

      // 2. Toggle Specialization (iOS Style)
      toggleStyle: ToggleStyle(
        // Content settings: iOS style is clean, no Icon or text
        activeType: ToggleContentType.none,
        inactiveType: ToggleContentType.none,

        // Style override: Active Track (on state)
        activeTrackStyle: SurfaceStyle(
          backgroundColor: colors.primary,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: const [],
          blurStrength: 0,
          contentColor: colors.onPrimary,
        ),

        // Style override: Inactive Track (off state)
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHighest,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: const [],
          blurStrength: 0,
          contentColor: colors.onSurfaceVariant,
        ),

        // Style override: Thumb (white sphere usually)
        thumbStyle: SurfaceStyle(
          backgroundColor:
              colors.surface, // Thumb usually pure white in Flat/iOS
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
          blurStrength: 0,
          contentColor:
              colors.primary, // If Thumb has content, use primary color
        ),
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: colors.onSurface.withValues(alpha: 0.08),
        highlightColor: colors.onSurface.withValues(alpha: 0.2),
        animationType: SkeletonAnimationType.shimmer,
        borderRadius: 8.0,
        animation: AnimationSpec.standard,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHighest,
          borderColor: colors.outlineVariant,
          contentColor: colors.onSurface,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0.0,
        ),
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: colors.outlineVariant,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder: Border(
              bottom: BorderSide(color: colors.outlineVariant, width: 1.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHighest,
          borderColor: Colors.transparent,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: colors.primary,
          contentColor: colors.primary,
          blurStrength: 0,
        ),
        errorModifier: SurfaceStyle(
          backgroundColor: colors.error.withValues(alpha: 0.05),
          borderColor: colors.error,
          contentColor: colors.error,
          blurStrength: 0,
        ),
      ),
      loaderStyle: LoaderStyle(
        type: LoaderType.circular,
        color: colors.primary,
        strokeWidth: 4.0,
        size: 32.0,
        period: const Duration(seconds: 1),
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(8),
        backgroundColor:
            colors.scrim, // inverseSurface often map to scrim or distinct
        textStyle: appTextTheme.bodyMedium!
            .copyWith(color: colors.surface), // onInverseSurface
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: colors.outlineVariant,
        thickness: 1.0,
        pattern: DividerPattern.solid,
        indent: 16.0,
        endIndent: 16.0,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.dot,
        macAddressSeparator: '-',
      ),
      // 3. Other Global Settings
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut, // Smooth curve
      ),
      spacingFactor: 1.0,
      buttonHeight: 48.0,
      navigationStyle: NavigationStyle(
        height: 64.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 0.0,
        animation: AnimationSpec.standard,
        itemColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.onSurface.withValues(alpha: 0.6),
        ),
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 16.0,
        marginTablet: 24.0,
        marginDesktop: 64.0,
        gutterMobile: 16.0,
        gutterTablet: 24.0,
        gutterDesktop: 24.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.surface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: colors.outlineVariant,
          thickness: 1.0,
          pattern: DividerPattern.solid,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerLow,
          borderColor: colors.outlineVariant,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHighest,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: colors.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerLow,
          borderColor: colors.outlineVariant,
          borderWidth: 1.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        overlay: OverlaySpec(
          scrimColor: colors.overlayColor,
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 8.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const FlatMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 12.0,
        width: 280.0,
        dragHandleHeight: 4.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.onSurfaceVariant,
        ),
        indicatorColor: colors.primary,
        tabBackgroundColor: colors.surface,
        animationDuration: const Duration(milliseconds: 250),
        indicatorThickness: 2.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: colors.primary,
        completedStepColor: colors.secondary,
        pendingStepColor: colors.surfaceContainerHighest,
        connectorColor: colors.outline,
        stepSize: 36.0,
        useDashedConnector: false,
        animation: AnimationSpec.standard,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.onSurfaceVariant,
        ),
        separatorColor: colors.outlineVariant,
        separatorText: ' / ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: colors.surfaceContainerHighest,
        expandedBackgroundColor: colors.surface,
        headerTextColor: colors.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        ),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.primary.withValues(alpha: 0.7),
          hover: colors.primary.withValues(alpha: 0.7),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: colors.primary.withValues(alpha: 0.15),
          inactive: colors.surfaceContainerHighest,
        ),
        textColors: StateColorSpec(
          active: colors.onSurface,
          inactive: colors.onSurface,
        ),
        selectedBorderColor: colors.primary,
        borderRadius: 16.0,
      ),
      tableStyle: TableStyle(
        headerBackground: colors.surfaceContainerLow,
        rowBackground: colors.surface,
        gridColor: colors.outlineVariant,
        gridWidth: 1.0,
        showVerticalGrid: false,
        cellPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 52.0,
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: colors.onSurface),
        cellTextStyle:
            appTextTheme.bodyMedium!.copyWith(color: colors.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: colors.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransition: const shared.AnimationSpec(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        ),
      ),
      topologySpec: _buildTopologySpec(
          colors.toMaterialScheme(brightness: Brightness.light),
          isLight: true), // Temp until topology update
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainer,
          borderColor: colors.subtleBorder,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: colors.error,
          borderColor: colors.subtleBorder,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: colors.onError,
        ),
        borderRadius: BorderRadius.circular(8.0), // Subtle rounding
        contentColor: colors.onSurface,
        iconSize: 24.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle,
        distance: 80.0,
        type: FabAnimationType.fanOut,
        overlay: OverlaySpec(
          scrimColor: colors.scrim.withValues(alpha: 0.3),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.gradient,
        cap: GaugeCapType.round,
        trackColor: colors.outlineVariant.withValues(alpha: 0.3),
        showTicks: false,
        strokeWidth: 12.0,
        enableGlow: false,
        indicatorColor: colors.primary, // Theme primary for Flat
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        ),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: true, // Unified Box
        customSeparator: null,
        activeBorderColor: colors.primary,
        spacing: 0.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.underline,
        fillOnInput: false,
        glowOnActive: false,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: colors.onSurface),
        cellSpacing: 16.0,
        cellSize: 48.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_circle_outline,
        pendingIcon: Icons.radio_button_unchecked,
        ruleTextStyle:
            appTextTheme.bodySmall!.copyWith(color: colors.onSurfaceVariant),
        showRuleListBackground: false,
        validColor: colors
            .primary, // Green usually, but primary for flat consistency? Spec says primary for Active/Focus. Rules say green. Let's use SignalStrong/Primary.
        pendingColor: colors.onSurfaceVariant,
      ),
    );
  }

  const FlatDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.surfaceSecondary,
    required super.surfaceTertiary,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
    required super.toggleStyle,
    required super.skeletonStyle,
    required super.buttonHeight,
    required super.navigationStyle,
    required super.inputStyle,
    required super.loaderStyle,
    required super.toastStyle,
    required super.dividerStyle,
    required super.networkInputStyle,
    required super.layoutSpec,
    required super.appBarStyle,
    required super.menuStyle,
    required super.dialogStyle,
    required super.motion,
    required super.visualEffects,
    required super.iconStyle,
    required super.sheetStyle,
    required super.tabsStyle,
    required super.stepperStyle,
    required super.breadcrumbStyle,
    required super.expansionPanelStyle,
    required super.carouselStyle,
    required super.chipGroupStyle,
    required super.tableStyle,
    required super.topologySpec,
    required super.slideActionStyle,
    required super.expandableFabStyle,
    required super.gaugeStyle,
    required super.rangeInputStyle,
    required super.pinInputStyle,
    required super.passwordInputStyle,
  });

  factory FlatDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;

    // Define semantic color variables (Token-First)
    final activeColor = scheme.primary;
    final inactiveColor = scheme
        .surfaceContainerHighest; // Neutral gray, suitable for unselected tracks
    final thumbColor =
        scheme.surface; // iOS style Thumb usually remains pure white
    final faintFill = scheme.surfaceContainerHighest;
    final greyOutline = scheme.outlineVariant;
    return FlatDesignTheme._(
      // 1. Global Surface Definition (for Card, Dialog, etc.)
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.outlineVariant, // Use semantic border color
        borderWidth: 1.0,
        borderRadius: 8.0,
        shadows: const [], // Flat style usually has no shadows, or very faint ones
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerLow,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: activeColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 0.6,
          hoverOpacity: 0.9,
          pressedOffset: Offset.zero,
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.secondaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onSecondaryContainer,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onTertiaryContainer,
      ),

      // 2. Toggle Specialization (iOS Style)
      toggleStyle: ToggleStyle(
        // Content settings: iOS style is clean, no Icon or text
        activeType: ToggleContentType.none,
        inactiveType: ToggleContentType.none,

        // Style override: Active Track (on state)
        activeTrackStyle: SurfaceStyle(
          backgroundColor: activeColor,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: const [],
          blurStrength: 0,
          contentColor: scheme.onPrimary,
        ),

        // Style override: Inactive Track (off state)
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: inactiveColor,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: const [],
          blurStrength: 0,
          contentColor: scheme.onSurfaceVariant,
        ),

        // Style override: Thumb (white sphere)
        thumbStyle: SurfaceStyle(
          backgroundColor: thumbColor,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
          blurStrength: 0,
          contentColor: activeColor, // If Thumb has content, use primary color
        ),
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.onSurface.withValues(alpha: 0.08),
        highlightColor: scheme.onSurface.withValues(alpha: 0.2),
        animationType: SkeletonAnimationType.shimmer,
        borderRadius: 8.0,
        animation: AnimationSpec.standard,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: faintFill,
          borderColor: greyOutline,
          contentColor: scheme.onSurface,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0.0,
        ),
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: greyOutline,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: greyOutline, width: 1.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: faintFill,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary,
          contentColor: scheme.primary,
          blurStrength: 0,
        ),
        errorModifier: SurfaceStyle(
          backgroundColor: scheme.error.withValues(alpha: 0.05),
          borderColor: scheme.error,
          contentColor: scheme.error,
          blurStrength: 0,
        ),
      ),
      loaderStyle: LoaderStyle(
        type: LoaderType.circular,
        color: scheme.primary,
        strokeWidth: 4.0,
        size: 32.0,
        period: const Duration(seconds: 1),
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: scheme.inverseSurface,
        textStyle:
            appTextTheme.bodyMedium!.copyWith(color: scheme.onInverseSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: scheme.outlineVariant,
        thickness: 1.0,
        pattern: DividerPattern.solid,
        indent: 16.0,
        endIndent: 16.0,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.dot,
        macAddressSeparator: '-',
      ),
      // 3. Other Global Settings
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut, // Smooth curve
      ),
      spacingFactor: 1.0,
      buttonHeight: 48.0,
      navigationStyle: NavigationStyle(
        height: 64.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 0.0,
        animation: AnimationSpec.standard,
        itemColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 16.0,
        marginTablet: 24.0,
        marginDesktop: 64.0,
        gutterMobile: 16.0,
        gutterTablet: 24.0,
        gutterDesktop: 24.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.outlineVariant,
          thickness: 1.0,
          pattern: DividerPattern.solid,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerLow,
          borderColor: scheme.outlineVariant,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerLow,
          borderColor: scheme.outlineVariant,
          borderWidth: 1.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.5),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 8.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const FlatMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 12.0,
        width: 280.0,
        dragHandleHeight: 4.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
        indicatorColor: scheme.primary,
        tabBackgroundColor: scheme.surface,
        animationDuration: const Duration(milliseconds: 250),
        indicatorThickness: 2.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: scheme.primary,
        completedStepColor: scheme.secondary,
        pendingStepColor: scheme.surfaceContainerHighest,
        connectorColor: scheme.outline,
        stepSize: 36.0,
        useDashedConnector: false,
        animation: AnimationSpec.standard,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
        separatorColor: scheme.outlineVariant,
        separatorText: ' / ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surfaceContainerHighest,
        expandedBackgroundColor: scheme.surface,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        ),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.primary.withValues(alpha: 0.7),
          hover: scheme.primary.withValues(alpha: 0.7),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: scheme.primary.withValues(alpha: 0.15),
          inactive: scheme.surfaceContainerHighest,
        ),
        textColors: StateColorSpec(
          active: scheme.onSurface,
          inactive: scheme.onSurface,
        ),
        selectedBorderColor: scheme.primary,
        borderRadius: 16.0,
      ),
      tableStyle: TableStyle(
        headerBackground: scheme.surfaceContainerLow,
        rowBackground: scheme.surface,
        gridColor: scheme.outlineVariant,
        gridWidth: 1.0,
        showVerticalGrid: false,
        cellPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 52.0,
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: scheme.onSurface),
        cellTextStyle:
            appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: scheme.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransition: const shared.AnimationSpec(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        ),
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: true),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainer,
          borderColor: greyOutline,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: scheme.error,
          borderColor: greyOutline,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.circular(8.0),
        contentColor: scheme.onSurface,
        iconSize: 24.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle,
        distance: 80.0,
        type: FabAnimationType.fanOut,
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.3),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.gradient,
        cap: GaugeCapType.round,
        trackColor: scheme.outlineVariant.withValues(alpha: 0.3),
        indicatorColor: scheme.primary,
        showTicks: false,
        strokeWidth: 12.0,
        enableGlow: false,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        ),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: true,
        customSeparator: null,
        activeBorderColor: scheme.primary,
        spacing: 0.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.underline,
        fillOnInput: false,
        glowOnActive: false,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: scheme.onSurface),
        cellSpacing: 16.0,
        cellSize: 48.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_circle_outline,
        pendingIcon: Icons.radio_button_unchecked,
        ruleTextStyle:
            appTextTheme.bodySmall!.copyWith(color: scheme.onSurfaceVariant),
        showRuleListBackground: false,
        validColor: scheme.primary,
        pendingColor: scheme.onSurfaceVariant,
      ),
    );
  }

  factory FlatDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;

    // Dark Mode color mapping
    final activeColor = scheme.primary;
    final inactiveColor = scheme.surfaceContainerHighest;
    final thumbColor =
        scheme.surface; // Thumb remains white in Dark Mode to maintain contrast
    final faintFill = scheme.surfaceContainerHighest;
    final greyOutline = scheme.outlineVariant;

    return FlatDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.outlineVariant,
        borderWidth: 1.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerLow,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: activeColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 0.6,
          hoverOpacity: 0.9,
          pressedOffset: Offset.zero,
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.secondaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onSecondaryContainer,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onTertiaryContainer,
      ),
      toggleStyle: ToggleStyle(
        activeType: ToggleContentType.none,
        inactiveType: ToggleContentType.none,
        activeTrackStyle: SurfaceStyle(
          backgroundColor: activeColor,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: const [],
          blurStrength: 0,
          contentColor: scheme.onPrimary,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: inactiveColor,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: const [],
          blurStrength: 0,
          contentColor: scheme.onSurfaceVariant,
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: thumbColor,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
          blurStrength: 0,
          contentColor: activeColor,
        ),
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.surfaceContainerHighest,
        highlightColor:
            scheme.surfaceContainerHighest.withValues(alpha: 0.5).withBlue(255),
        animationType: SkeletonAnimationType.shimmer,
        borderRadius: 8.0,
        animation: AnimationSpec.standard,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: faintFill,
          borderColor: greyOutline,
          contentColor: scheme.onSurface,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0.0,
        ),
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: greyOutline,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: greyOutline, width: 1.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: faintFill,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary,
          contentColor: scheme.primary,
          blurStrength: 0,
        ),
        errorModifier: SurfaceStyle(
          backgroundColor: scheme.error.withValues(alpha: 0.05),
          borderColor: scheme.error,
          contentColor: scheme.error,
          blurStrength: 0,
        ),
      ),
      loaderStyle: LoaderStyle(
        color: scheme.primary,
        strokeWidth: 4.0,
        size: 32.0,
        period: const Duration(seconds: 1),
        type: LoaderType.circular,
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: scheme.inverseSurface,
        textStyle:
            appTextTheme.bodyMedium!.copyWith(color: scheme.onInverseSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: scheme.outlineVariant,
        thickness: 1.0,
        pattern: DividerPattern.solid,
        indent: 16.0,
        endIndent: 16.0,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.dot,
        macAddressSeparator: '-',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      ),
      spacingFactor: 1.0,
      buttonHeight: 48.0,
      navigationStyle: NavigationStyle(
        height: 64.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 0.0,
        animation: AnimationSpec.standard,
        itemColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 16.0,
        marginTablet: 24.0,
        marginDesktop: 64.0,
        gutterMobile: 16.0,
        gutterTablet: 24.0,
        gutterDesktop: 24.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles (Dark)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.outlineVariant,
          thickness: 1.0,
          pattern: DividerPattern.solid,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerLow,
          borderColor: scheme.outlineVariant,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 4.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerLow,
          borderColor: scheme.outlineVariant,
          borderWidth: 1.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.6),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 8.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const FlatMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 12.0,
        width: 280.0,
        dragHandleHeight: 4.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
        indicatorColor: scheme.primary,
        tabBackgroundColor: scheme.surface,
        animationDuration: const Duration(milliseconds: 250),
        indicatorThickness: 2.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: scheme.primary,
        completedStepColor: scheme.secondary,
        pendingStepColor: scheme.surfaceContainerHighest,
        connectorColor: scheme.outline,
        stepSize: 36.0,
        useDashedConnector: false,
        animation: AnimationSpec.standard,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
        separatorColor: scheme.outlineVariant,
        separatorText: ' / ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surfaceContainerHighest,
        expandedBackgroundColor: scheme.surface,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        ),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.primary.withValues(alpha: 0.7),
          hover: scheme.primary.withValues(alpha: 0.7),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: scheme.primary.withValues(alpha: 0.15),
          inactive: scheme.surfaceContainerHighest,
        ),
        textColors: StateColorSpec(
          active: scheme.onSurface,
          inactive: scheme.onSurface,
        ),
        selectedBorderColor: scheme.primary,
        borderRadius: 16.0,
      ),
      tableStyle: TableStyle(
        headerBackground: scheme.surfaceContainerLow,
        rowBackground: scheme.surface,
        gridColor: scheme.outlineVariant,
        gridWidth: 1.0,
        showVerticalGrid: false,
        cellPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 52.0,
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: scheme.onSurface),
        cellTextStyle:
            appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: scheme.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransition: const shared.AnimationSpec(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        ),
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: false),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainer,
          borderColor: greyOutline,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: scheme.error,
          borderColor: greyOutline,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.circular(8.0),
        contentColor: scheme.onSurface,
        iconSize: 24.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle,
        distance: 80.0,
        type: FabAnimationType.fanOut,
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.3),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.gradient,
        cap: GaugeCapType.round,
        trackColor: scheme.outlineVariant.withValues(alpha: 0.3),
        indicatorColor: scheme.primary,
        showTicks: false,
        strokeWidth: 12.0,
        enableGlow: false,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        ),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: true,
        customSeparator: null,
        activeBorderColor: scheme.primary,
        spacing: 0.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.underline,
        fillOnInput: false,
        glowOnActive: false,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: scheme.onSurface),
        cellSpacing: 16.0,
        cellSize: 48.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_circle_outline,
        pendingIcon: Icons.radio_button_unchecked,
        ruleTextStyle:
            appTextTheme.bodySmall!.copyWith(color: scheme.onSurfaceVariant),
        showRuleListBackground: false,
        validColor: scheme.primary,
        pendingColor: scheme.onSurfaceVariant,
      ),
    );
  }

  /// Builds topology spec for Flat theme with clean, minimal aesthetic.
  static TopologySpec _buildTopologySpec(ColorScheme scheme,
      {required bool isLight}) {
    return TopologySpec(
      // Gateway styles - clean circles
      gatewayNormalStyle: NodeStyle(
        backgroundColor: scheme.primary,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 64.0,
        iconColor: scheme.onPrimary,
      ),
      gatewayHighLoadStyle: NodeStyle(
        backgroundColor: scheme.tertiary,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 64.0,
        iconColor: scheme.onTertiary,
      ),
      gatewayOfflineStyle: NodeStyle(
        backgroundColor: scheme.surfaceContainerHighest,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 64.0,
        iconColor: scheme.onSurfaceVariant,
      ),

      // Extender styles
      extenderNormalStyle: NodeStyle(
        backgroundColor: scheme.secondaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 52.0,
        iconColor: scheme.onSecondaryContainer,
      ),
      extenderHighLoadStyle: NodeStyle(
        backgroundColor: scheme.tertiaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 52.0,
        iconColor: scheme.onTertiaryContainer,
      ),
      extenderOfflineStyle: NodeStyle(
        backgroundColor: scheme.surfaceContainerHigh,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 52.0,
        iconColor: scheme.onSurfaceVariant,
      ),

      // Client styles
      clientNormalStyle: NodeStyle(
        backgroundColor: scheme.surfaceContainerHighest,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 32.0,
        iconColor: scheme.onSurface,
      ),
      clientOfflineStyle: NodeStyle(
        backgroundColor: scheme.surfaceContainerLow,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 32.0,
        iconColor: scheme.outlineVariant,
      ),

      // Link styles - clean lines
      ethernetLinkStyle: LinkStyle(
        color: scheme.outline,
        width: 2.0,
        dashPattern: null,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
          duration: Duration.zero,
          curve: Curves.linear,
        ),
      ),
      wifiStrongStyle: LinkStyle(
        color: scheme.tertiary,
        width: 2.0,
        dashPattern: const [6.0, 3.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 1500),
          curve: Curves.linear,
        ),
      ),
      wifiMediumStyle: LinkStyle(
        color: scheme.tertiaryContainer,
        width: 2.0,
        dashPattern: const [5.0, 3.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2000),
          curve: Curves.linear,
        ),
      ),
      wifiWeakStyle: LinkStyle(
        color: scheme.error,
        width: 1.5,
        dashPattern: const [4.0, 3.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2500),
          curve: Curves.linear,
        ),
      ),
      wifiUnknownStyle: LinkStyle(
        color: scheme.outlineVariant,
        width: 1.5,
        dashPattern: const [4.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2000),
          curve: Curves.linear,
        ),
      ),

      // Layout
      nodeSpacing: 90.0,
      linkCurvature: 0.2,
      orbitRadius: 55.0,
      orbitSpeed: const Duration(seconds: 18),
    );
  }
}
