import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';
// Import GlobalEffectsType
// Import AppIconStyle

class FlatDesignTheme extends AppDesignTheme {
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
    required super.bottomSheetStyle,
    required super.sideSheetStyle,
    required super.tabsStyle,
    required super.stepperStyle,
    required super.breadcrumbStyle,
    required super.expansionPanelStyle,
    required super.carouselStyle,
    required super.chipGroupStyle,
    required super.topologySpec,
  });

  factory FlatDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final overlayColor = Colors.black.withValues(alpha: 0.15);
    // Define semantic color variables (Token-First)
    final activeColor = scheme.primary;
    final inactiveColor = scheme
        .surfaceContainerHighest; // Neutral gray, suitable for unselected tracks
    const thumbColor =
        Colors.white; // iOS style Thumb usually remains pure white
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
        textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: scheme.onInverseSurface),
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
      navigationStyle: const NavigationStyle(
        height: 64.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 0.0,
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
        barrierColor: Colors.black.withValues(alpha: 0.5),
        barrierBlur: 0.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 8.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const FlatMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        topBorderRadius: 12.0,
        dragHandleHeight: 6.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        blurStrength: 0.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: scheme.primary,
        inactiveTextColor: scheme.onSurfaceVariant,
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
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: scheme.primary,
        inactiveLinkColor: scheme.onSurfaceVariant,
        separatorColor: scheme.outlineVariant,
        separatorText: ' / ',
        itemTextStyle: const TextStyle(fontSize: 14),
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surfaceContainerHighest,
        expandedBackgroundColor: scheme.surface,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 250),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: scheme.primary,
        navButtonHoverColor: scheme.primary.withValues(alpha: 0.7),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: scheme.surfaceContainerHighest,
        unselectedText: scheme.onSurface,
        selectedBackground: scheme.primary.withValues(alpha: 0.15),
        selectedText: scheme.onSurface,
        selectedBorderColor: scheme.primary,
        borderRadius: 16.0,
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: true),
    );
  }

  factory FlatDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final overlayColor = Colors.white.withValues(alpha: 0.15);
    // Dark Mode color mapping
    final activeColor = scheme.primary;
    final inactiveColor = scheme.surfaceContainerHighest;
    const thumbColor =
        Colors.white; // Thumb remains white in Dark Mode to maintain contrast
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
        textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: scheme.onInverseSurface),
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
      navigationStyle: const NavigationStyle(
        height: 64.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 0.0,
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
        barrierColor: Colors.black.withValues(alpha: 0.6),
        barrierBlur: 0.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 8.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const FlatMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        topBorderRadius: 12.0,
        dragHandleHeight: 6.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        blurStrength: 0.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: scheme.primary,
        inactiveTextColor: scheme.onSurfaceVariant,
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
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: scheme.primary,
        inactiveLinkColor: scheme.onSurfaceVariant,
        separatorColor: scheme.outlineVariant,
        separatorText: ' / ',
        itemTextStyle: const TextStyle(fontSize: 14),
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surfaceContainerHighest,
        expandedBackgroundColor: scheme.surface,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 250),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: scheme.primary,
        navButtonHoverColor: scheme.primary.withValues(alpha: 0.7),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: scheme.surfaceContainerHighest,
        unselectedText: scheme.onSurface,
        selectedBackground: scheme.primary.withValues(alpha: 0.15),
        selectedText: scheme.onSurface,
        selectedBorderColor: scheme.primary,
        borderRadius: 16.0,
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: false),
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
        animationDuration: Duration.zero,
      ),
      wifiStrongStyle: const LinkStyle(
        color: Colors.green,
        width: 2.0,
        dashPattern: [6.0, 3.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: Duration(milliseconds: 1500),
      ),
      wifiMediumStyle: const LinkStyle(
        color: Colors.orange,
        width: 2.0,
        dashPattern: [5.0, 3.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: Duration(milliseconds: 2000),
      ),
      wifiWeakStyle: LinkStyle(
        color: scheme.error,
        width: 1.5,
        dashPattern: const [4.0, 3.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 2500),
      ),
      wifiUnknownStyle: LinkStyle(
        color: scheme.outlineVariant,
        width: 1.5,
        dashPattern: const [4.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 2000),
      ),

      // Layout
      nodeSpacing: 90.0,
      linkCurvature: 0.2,
      orbitRadius: 55.0,
      orbitSpeed: const Duration(seconds: 18),
    );
  }
}
