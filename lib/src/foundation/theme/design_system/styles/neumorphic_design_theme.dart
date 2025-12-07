import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/motion/neumorphic_motion.dart'; // Assuming NeumorphicMotion is created

class NeumorphicDesignTheme extends AppDesignTheme {
  // Factory 1: Create from Config (Lazy/Custom Mode)
  factory NeumorphicDesignTheme.fromConfig(AppThemeConfig config) {
    final colors = AppColorFactory.generateNeumorphic(config);
    return NeumorphicDesignTheme._raw(colors);
  }

  // Factory 2: Raw Mode (Internal Assembly)
  factory NeumorphicDesignTheme._raw(AppColorScheme colors) {
    final isLight = colors.surface.computeLuminance() > 0.5; // Approximate check if needed, or rely on colors
    
    // Mapping AppColorScheme to Neumorphic Styles
    // lightShadow (Highlight) -> colors.glowColor
    // darkShadow (Shadow) -> colors.styleShadow
    
    return NeumorphicDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: colors.glowColor,
            offset: const Offset(-6, -6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: colors.styleShadow,
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 20.0,
        shadows: [
          BoxShadow(
            color: colors.glowColor.withValues(alpha: isLight ? 0.7 : 0.15), // Adjust strength based on surface assumption or specific color
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: colors.styleShadow.withValues(alpha: isLight ? 0.3 : 0.8),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.highContrastBorder, // Use highContrastBorder for highlight border
        borderWidth: 1.5,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: colors.glowColor,
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: colors.styleShadow,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
        blurStrength: 0.0,
        contentColor: colors.highContrastBorder,
        interaction: const InteractionSpec(
          pressedScale: 0.98,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset.zero,
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 14.0,
        shadows: [
          BoxShadow(
            color: colors.glowColor.withValues(alpha: 0.6),
            offset: const Offset(-3, -3),
            blurRadius: 5,
          ),
          BoxShadow(
            color: colors.styleShadow.withValues(alpha: 0.15),
            offset: const Offset(3, 3),
            blurRadius: 5,
          ),
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 14.0,
        shadows: [
          BoxShadow(
            color: colors.glowColor.withValues(alpha: 0.6),
            offset: const Offset(-2, -2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: colors.styleShadow.withValues(alpha: 0.15),
            offset: const Offset(2, 2),
            blurRadius: 5,
          ),
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.dot,
        inactiveType: ToggleContentType.dot,
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: colors.styleBackground,
        highlightColor: colors.styleBackground.withValues(alpha: 0.9),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 12.0,
      ),
      inputStyle: InputStyle(
        outlineStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: Colors.transparent,
          contentColor: colors.onSurface,
          borderWidth: 0.0,
          borderRadius: 12.0,
          shadows: [
            BoxShadow(
                color: colors.styleShadow.withValues(alpha: 0.3), offset: const Offset(2, 2), blurRadius: 4)
          ],
          blurStrength: 0.0,
        ),
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: colors.styleShadow.withValues(alpha: 0.3), width: 1.0)),
        ),
        filledStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 12.0,
          shadows: const [],
          blurStrength: 0,
        ),
        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: colors.primary,
          contentColor: colors.primary,
          shadows: [
            BoxShadow(
                color: colors.primary.withValues(alpha: 0.5), blurRadius: 8)
          ],
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
        backgroundColor: colors.surfaceContainerHighest.withValues(alpha: 0.5),
        strokeWidth: 6.0,
        size: 40.0,
        period: const Duration(milliseconds: 1200),
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(16),
        backgroundColor: colors.surface,
        textStyle: appTextTheme.bodyMedium!.copyWith(color: colors.onSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: colors.styleShadow.withValues(alpha: 0.4),
        secondaryColor: colors.glowColor.withValues(alpha: 0.5), // Light/Glow for secondary
        thickness: 1.5,
        pattern: DividerPattern.solid,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.dot,
        macAddressSeparator: ':',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
      spacingFactor: 1.2,
      buttonHeight: 52.0,
      navigationStyle: const NavigationStyle(
        height: 88.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 12.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 24.0,
        marginTablet: 40.0,
        marginDesktop: 80.0,
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(color: colors.glowColor, offset: const Offset(-3, -3), blurRadius: 6),
            BoxShadow(color: colors.styleShadow, offset: const Offset(3, 3), blurRadius: 6),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: colors.subtleBorder,
          thickness: 1.0,
          pattern: DividerPattern.solid,
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(color: colors.glowColor, offset: const Offset(-4, -4), blurRadius: 8),
            BoxShadow(color: colors.styleShadow, offset: const Offset(4, 4), blurRadius: 8),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHighest,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: colors.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 24.0,
          shadows: [
            BoxShadow(color: colors.glowColor, offset: const Offset(-6, -6), blurRadius: 12),
            BoxShadow(color: colors.styleShadow, offset: const Offset(6, 6), blurRadius: 12),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        barrierColor: colors.overlayColor.withValues(alpha: 0.4),
        barrierBlur: 0.0,
      ),
      motion: const NeumorphicMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: colors.overlayColor,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        topBorderRadius: 20.0,
        dragHandleHeight: 8.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: colors.overlayColor,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        blurStrength: 0.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: colors.primary,
        inactiveTextColor: colors.onSurface.withValues(alpha: 0.6),
        indicatorColor: colors.primary,
        tabBackgroundColor: colors.surface,
        animationDuration: const Duration(milliseconds: 300),
        indicatorThickness: 2.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: colors.primary,
        completedStepColor: colors.secondary,
        pendingStepColor: colors.outlineVariant,
        connectorColor: colors.outline,
        stepSize: 40.0,
        useDashedConnector: false,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: colors.primary,
        inactiveLinkColor: colors.onSurface.withValues(alpha: 0.6),
        separatorColor: colors.outline,
        separatorText: ' • ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: colors.surface,
        expandedBackgroundColor: colors.surfaceContainer,
        headerTextColor: colors.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 300),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: colors.primary,
        navButtonHoverColor: colors.primary.withValues(alpha: 0.75),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: colors.surface,
        unselectedText: colors.onSurface,
        selectedBackground: colors.primary.withValues(alpha: 0.12),
        selectedText: colors.onSurface,
        selectedBorderColor: colors.primary,
        borderRadius: 18.0,
      ),
      tableStyle: TableStyle(
        headerBackground: null,
        rowBackground: Colors.transparent,
        gridColor: Colors.transparent,
        gridWidth: 0.0,
        showVerticalGrid: false,
        cellPadding: const EdgeInsets.all(16.0),
        rowHeight: 56.0,
        headerTextStyle: appTextTheme.labelLarge!.copyWith(color: colors.onSurfaceVariant),
        cellTextStyle: appTextTheme.bodyMedium!.copyWith(color: colors.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: colors.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 200),
      ),
      topologySpec: _buildTopologySpecFromColors(colors),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: colors.glowColor.withValues(alpha: 0.6), offset: const Offset(-3, -3), blurRadius: 5),
            BoxShadow(
                color: colors.styleShadow.withValues(alpha: 0.15), offset: const Offset(3, 3), blurRadius: 5)
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: colors.error.withValues(alpha: 0.15),
          borderColor: colors.error,
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: colors.glowColor.withValues(alpha: 0.3), offset: const Offset(-2, -2), blurRadius: 4),
            BoxShadow(
                color: colors.styleShadow.withValues(alpha: 0.3), offset: const Offset(2, 2), blurRadius: 4)
          ],
          blurStrength: 0.0,
          contentColor: colors.onError,
        ),
        borderRadius: BorderRadius.circular(12.0), // Medium soft rounding
        contentColor: colors.onSurface,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOut,
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle, // Soft circle usually
        distance: 80.0,
        type: FabAnimationType.fanOut, // Or easeOut
        overlayColor: colors.scrim.withValues(alpha: 0.2),
        enableBlur: false,
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid, // Or convex fill if custom painter supports it
        cap: GaugeCapType.bead, // Bead at tip
        trackColor: colors.styleShadow.withValues(alpha: 0.2), // Inner shadow track usually
        indicatorColor: colors.primary, // Soft primary for Neumorphic
        showTicks: false,
        strokeWidth: 14.0,
        enableGlow: false,
      ),
    );
  }

  static TopologySpec _buildTopologySpecFromColors(AppColorScheme colors) {
    return TopologySpec(
      gatewayNormalStyle: NodeStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.primary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 999.0,
        glowColor: colors.glowColor,
        glowRadius: 8.0,
        size: 68.0,
        iconColor: colors.primary,
      ),
      gatewayHighLoadStyle: NodeStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.tertiary.withValues(alpha: 0.4),
        borderWidth: 1.5,
        borderRadius: 999.0,
        glowColor: colors.tertiary.withValues(alpha: 0.2),
        glowRadius: 10.0,
        size: 68.0,
        iconColor: colors.tertiary,
      ),
      gatewayOfflineStyle: NodeStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.outline.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 68.0,
        iconColor: colors.outline,
      ),
      extenderNormalStyle: NodeStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.secondary.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 16.0,
        glowColor: colors.glowColor,
        glowRadius: 6.0,
        size: 54.0,
        iconColor: colors.secondary,
      ),
      extenderHighLoadStyle: NodeStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.tertiary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 16.0,
        glowColor: colors.tertiary.withValues(alpha: 0.15),
        glowRadius: 8.0,
        size: 54.0,
        iconColor: colors.tertiary,
      ),
      extenderOfflineStyle: NodeStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.outline.withValues(alpha: 0.15),
        borderWidth: 1.0,
        borderRadius: 16.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 54.0,
        iconColor: colors.outline,
      ),
      clientNormalStyle: NodeStyle(
        backgroundColor: colors.styleBackground,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: colors.glowColor,
        glowRadius: 4.0,
        size: 32.0,
        iconColor: colors.onSurface,
      ),
      clientOfflineStyle: NodeStyle(
        backgroundColor: colors.styleBackground,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 32.0,
        iconColor: colors.outline,
      ),
      ethernetLinkStyle: LinkStyle(
        color: colors.outline.withValues(alpha: 0.5),
        width: 2.0,
        dashPattern: null,
        glowColor: colors.glowColor,
        glowRadius: 2.0,
        animationDuration: Duration.zero,
      ),
      wifiStrongStyle: LinkStyle(
        color: colors.signalStrong,
        width: 2.0,
        dashPattern: const [6.0, 3.0],
        glowColor: colors.signalGlow,
        glowRadius: 3.0,
        animationDuration: const Duration(milliseconds: 1800),
      ),
      wifiMediumStyle: LinkStyle(
        color: colors.tertiaryContainer.withValues(alpha: 0.8),
        width: 2.0,
        dashPattern: const [5.0, 3.0],
        glowColor: colors.tertiaryContainer.withValues(alpha: 0.2),
        glowRadius: 2.0,
        animationDuration: const Duration(milliseconds: 2200),
      ),
      wifiWeakStyle: LinkStyle(
        color: colors.signalWeak,
        width: 1.5,
        dashPattern: const [4.0, 3.0],
        glowColor: colors.signalWeak.withValues(alpha: 0.15),
        glowRadius: 2.0,
        animationDuration: const Duration(milliseconds: 2600),
      ),
      wifiUnknownStyle: LinkStyle(
        color: colors.outline.withValues(alpha: 0.4),
        width: 1.5,
        dashPattern: const [4.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 2200),
      ),
      nodeSpacing: 95.0,
      linkCurvature: 0.25,
      orbitRadius: 58.0,
      orbitSpeed: const Duration(seconds: 22),
    );
  }

  NeumorphicDesignTheme._({
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
    required super.tableStyle,
    required super.topologySpec,
    required super.slideActionStyle,
    required super.expandableFabStyle,
    required super.gaugeStyle,
  });

  // Default to Light, providing a default ColorScheme
  factory NeumorphicDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final overlayColor = scheme.scrim.withValues(alpha: 0.2);
    final lightBaseColor = scheme.surface;
    final lightShadow = Color.alphaBlend(
        scheme.outline.withValues(alpha: 0.5), scheme.surface); // White shadow
    final darkShadow = Color.alphaBlend(
        scheme.shadow.withValues(alpha: 0.2), scheme.surface); // Black shadow
    final highlightBorderColor = scheme.primary;
    final neuBase = scheme.surface;
    final neuShadow = AppPalette.neumorphicLightShadow.withValues(alpha: 0.3);
    return NeumorphicDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: lightShadow,
            offset: const Offset(-6, -6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: darkShadow,
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 20.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                scheme.outline.withValues(alpha: 0.7), scheme.surface),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color.alphaBlend(
                scheme.shadow.withValues(alpha: 0.3), scheme.surface),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: highlightBorderColor,
        borderWidth: 1.5,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: lightShadow,
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: darkShadow,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
        blurStrength: 0.0,
        contentColor: highlightBorderColor,
        interaction: const InteractionSpec(
          pressedScale: 0.98,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset.zero,
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 14.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                scheme.outline.withValues(alpha: 0.6), scheme.surface),
            offset: const Offset(-3, -3),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Color.alphaBlend(
                scheme.shadow.withValues(alpha: 0.15), scheme.surface),
            offset: const Offset(3, 3),
            blurRadius: 5,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 14.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                scheme.outline.withValues(alpha: 0.6), scheme.surface),
            offset: const Offset(-2, -2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Color.alphaBlend(
                scheme.shadow.withValues(alpha: 0.15), scheme.surface),
            offset: const Offset(2, 2),
            blurRadius: 5,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.dot, // dot
        inactiveType: ToggleContentType.dot,
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.surface,
        highlightColor: scheme.surface.withValues(alpha: 0.9),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 12.0,
      ),
      inputStyle: InputStyle(
        // outline style
        outlineStyle: SurfaceStyle(
          backgroundColor: neuBase,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0.0,
          borderRadius: 12.0,
          shadows: [
            BoxShadow(
                color: neuShadow, offset: const Offset(2, 2), blurRadius: 4)
          ],
          blurStrength: 0.0,
        ),
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: neuShadow, width: 1.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 12.0,
          shadows: const [],
          blurStrength: 0,
        ),

        // focus modifier
        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary,
          contentColor: scheme.primary,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.5), blurRadius: 8)
          ],
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
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        strokeWidth: 6.0,
        size: 40.0,
        period: const Duration(milliseconds: 1200),
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(16),
        backgroundColor: scheme.surface,
        textStyle: appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: AppPalette.neumorphicLightShadow.withValues(alpha: 0.4),
        secondaryColor: scheme.surface,
        thickness: 1.5,
        pattern: DividerPattern.solid,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.dot,
        macAddressSeparator: ':',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
      spacingFactor: 1.2,
      buttonHeight: 52.0,
      navigationStyle: const NavigationStyle(
        height:
            88.0, // height, because soft plastic needs more breathing space to present the shadow
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 12.0,
      ),
      layoutSpec: const LayoutSpec(
        // For diffused shadows, margins cannot be too small
        marginMobile: 24.0,
        marginTablet: 40.0,
        marginDesktop: 80.0,

        // Gutter must be greater than (Shadow Blur Radius * 2), otherwise shadows will overlap
        // Assuming max Shadow Blur is 10, Gutter should be at least 20-24
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),

      // Phase 2: Graceful defaults (Neumorphic style)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: lightBaseColor,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(color: lightShadow, offset: const Offset(-3, -3), blurRadius: 6),
            BoxShadow(color: darkShadow, offset: const Offset(3, 3), blurRadius: 6),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.outlineVariant,
          thickness: 1.0,
          pattern: DividerPattern.solid,
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: lightBaseColor,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(color: lightShadow, offset: const Offset(-4, -4), blurRadius: 8),
            BoxShadow(color: darkShadow, offset: const Offset(4, 4), blurRadius: 8),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: lightBaseColor,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 24.0,
          shadows: [
            BoxShadow(color: lightShadow, offset: const Offset(-6, -6), blurRadius: 12),
            BoxShadow(color: darkShadow, offset: const Offset(6, 6), blurRadius: 12),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        barrierColor: scheme.scrim.withValues(alpha: 0.4),
        barrierBlur: 0.0,
      ),
      motion: const NeumorphicMotion(), // Assuming NeumorphicMotion
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        topBorderRadius: 20.0,
        dragHandleHeight: 8.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        blurStrength: 0.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: scheme.primary,
        inactiveTextColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        tabBackgroundColor: scheme.surface,
        animationDuration: const Duration(milliseconds: 300),
        indicatorThickness: 2.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: scheme.primary,
        completedStepColor: scheme.secondary,
        pendingStepColor: scheme.outlineVariant,
        connectorColor: scheme.outline,
        stepSize: 40.0,
        useDashedConnector: false,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: scheme.primary,
        inactiveLinkColor: scheme.onSurfaceVariant,
        separatorColor: scheme.outline,
        separatorText: ' • ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surface,
        expandedBackgroundColor: scheme.surfaceContainer,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 300),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: scheme.primary,
        navButtonHoverColor: scheme.primary.withValues(alpha: 0.75),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: scheme.surface,
        unselectedText: scheme.onSurface,
        selectedBackground: scheme.primary.withValues(alpha: 0.12),
        selectedText: scheme.onSurface,
        selectedBorderColor: scheme.primary,
        borderRadius: 18.0,
      ),
      tableStyle: TableStyle(
        headerBackground: null,
        rowBackground: Colors.transparent,
        gridColor: Colors.transparent,
        gridWidth: 0.0,
        showVerticalGrid: false,
        cellPadding: const EdgeInsets.all(16.0),
        rowHeight: 56.0,
        headerTextStyle: appTextTheme.labelLarge!.copyWith(color: scheme.onSurfaceVariant),
        cellTextStyle: appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: scheme.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 200),
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: true),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: lightShadow, offset: const Offset(-3, -3), blurRadius: 5),
            BoxShadow(
                color: darkShadow, offset: const Offset(3, 3), blurRadius: 5)
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: scheme.error.withValues(alpha: 0.15),
          borderColor: scheme.error,
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: lightShadow.withValues(alpha: 0.3), offset: const Offset(-2, -2), blurRadius: 4),
            BoxShadow(
                color: darkShadow.withValues(alpha: 0.3), offset: const Offset(2, 2), blurRadius: 4)
          ],
          blurStrength: 0.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.circular(12.0),
        contentColor: scheme.onSurface,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOut,
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle,
        distance: 80.0,
        type: FabAnimationType.fanOut,
        overlayColor: scheme.scrim.withValues(alpha: 0.2),
        enableBlur: false,
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid,
        cap: GaugeCapType.bead,
        trackColor: AppPalette.neumorphicLightShadow.withValues(alpha: 0.2),
        indicatorColor: Colors.indigo, // Soft indigo for Neumorphic theme
        showTicks: false,
        strokeWidth: 14.0,
        enableGlow: false,
      ),
    );
  }

  factory NeumorphicDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final overlayColor = scheme.inverseSurface.withValues(alpha: 0.2);
    final darkBaseColor = scheme.surface;
    final darkLightShadow = Color.alphaBlend(
        scheme.outline.withValues(alpha: 0.1), scheme.surface); // Light shadow
    final darkDarkShadow = Color.alphaBlend(
        scheme.shadow.withValues(alpha: 0.6), scheme.surface); // Dark shadow
    final darkHighlightBorderColor = scheme.primary;
    final neuBase = scheme.surface;
    final neuShadow = AppPalette.neumorphicLightShadow.withValues(alpha: 0.3);

    return NeumorphicDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: darkLightShadow,
            offset: const Offset(-5, -5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: darkDarkShadow,
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 20.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                scheme.outline.withValues(alpha: 0.15), scheme.surface),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color.alphaBlend(
                scheme.shadow.withValues(alpha: 0.8), scheme.surface),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: darkHighlightBorderColor,
        borderWidth: 1.5,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: darkLightShadow,
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: darkDarkShadow,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
        blurStrength: 0.0,
        contentColor: darkHighlightBorderColor,
        interaction: const InteractionSpec(
          pressedScale: 0.98,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset.zero,
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 14.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                scheme.outline.withValues(alpha: 0.08), scheme.surface),
            offset: const Offset(-3, -3),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Color.alphaBlend(
                scheme.shadow.withValues(alpha: 0.5), scheme.surface),
            offset: const Offset(3, 3),
            blurRadius: 5,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 14.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                scheme.outline.withValues(alpha: 0.08), scheme.surface),
            offset: const Offset(-2, -2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Color.alphaBlend(
                scheme.shadow.withValues(alpha: 0.5), scheme.surface),
            offset: const Offset(2, 2),
            blurRadius: 5,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.dot, // dot
        inactiveType: ToggleContentType.dot,
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.surface,
        highlightColor: scheme.surface.withValues(alpha: 0.8),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 12.0,
      ),
      inputStyle: InputStyle(
        // outline style
        outlineStyle: SurfaceStyle(
          backgroundColor: neuBase,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0.0,
          borderRadius: 12.0,
          // Simulate concave effect
          shadows: [
            BoxShadow(
                color: neuShadow, offset: const Offset(2, 2), blurRadius: 4)
          ],
          blurStrength: 0.0,
        ),
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: neuShadow, width: 1.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 12.0,
          shadows: const [],
          blurStrength: 0,
        ),

        // focus modifier
        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary,
          contentColor: scheme.primary,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.5), blurRadius: 8)
          ],
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
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        strokeWidth: 6.0,
        size: 40.0,
        period: const Duration(milliseconds: 1200),
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(16),
        backgroundColor: scheme.surface,
        textStyle: appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        // 深色模式下的凹槽
        color: scheme.shadow.withValues(alpha: 0.5),
        secondaryColor: scheme.outline.withValues(alpha: 0.1),
        thickness: 1.5,
        pattern: DividerPattern.solid,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.dot,
        macAddressSeparator: ':',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
      spacingFactor: 1.2,
      buttonHeight: 52.0,
      navigationStyle: const NavigationStyle(
        height:
            88.0, // height, because soft plastic needs more breathing space to present the shadow
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 12.0,
      ),
      layoutSpec: const LayoutSpec(
        // For diffused shadows, margins cannot be too small
        marginMobile: 24.0,
        marginTablet: 40.0,
        marginDesktop: 80.0,

        // Gutter must be greater than (Shadow Blur Radius * 2), otherwise shadows will overlap
        // Assuming max Shadow Blur is 10, Gutter should be at least 20-24
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),

      // Phase 2: Graceful defaults (Neumorphic Dark)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: darkBaseColor,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(color: darkLightShadow, offset: const Offset(-3, -3), blurRadius: 6),
            BoxShadow(color: darkDarkShadow, offset: const Offset(3, 3), blurRadius: 6),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.outlineVariant,
          thickness: 1.0,
          pattern: DividerPattern.solid,
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: darkBaseColor,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(color: darkLightShadow, offset: const Offset(-4, -4), blurRadius: 8),
            BoxShadow(color: darkDarkShadow, offset: const Offset(4, 4), blurRadius: 8),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 12.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: darkBaseColor,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 24.0,
          shadows: [
            BoxShadow(color: darkLightShadow, offset: const Offset(-6, -6), blurRadius: 12),
            BoxShadow(color: darkDarkShadow, offset: const Offset(6, 6), blurRadius: 12),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        barrierColor: scheme.scrim.withValues(alpha: 0.5),
        barrierBlur: 0.0,
      ),
      motion: const NeumorphicMotion(), // Assuming NeumorphicMotion
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        topBorderRadius: 20.0,
        dragHandleHeight: 8.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        blurStrength: 0.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: scheme.primary,
        inactiveTextColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        tabBackgroundColor: scheme.surface,
        animationDuration: const Duration(milliseconds: 300),
        indicatorThickness: 2.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: scheme.primary,
        completedStepColor: scheme.secondary,
        pendingStepColor: scheme.outlineVariant,
        connectorColor: scheme.outline,
        stepSize: 40.0,
        useDashedConnector: false,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: scheme.primary,
        inactiveLinkColor: scheme.onSurfaceVariant,
        separatorColor: scheme.outline,
        separatorText: ' • ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surface,
        expandedBackgroundColor: scheme.surfaceContainer,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 300),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: scheme.primary,
        navButtonHoverColor: scheme.primary.withValues(alpha: 0.75),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutQuad,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: scheme.surface,
        unselectedText: scheme.onSurface,
        selectedBackground: scheme.primary.withValues(alpha: 0.12),
        selectedText: scheme.onSurface,
        selectedBorderColor: scheme.primary,
        borderRadius: 18.0,
      ),
      tableStyle: TableStyle(
        headerBackground: null,
        rowBackground: Colors.transparent,
        gridColor: Colors.transparent,
        gridWidth: 0.0,
        showVerticalGrid: false,
        cellPadding: const EdgeInsets.all(16.0),
        rowHeight: 56.0,
        headerTextStyle: appTextTheme.labelLarge!.copyWith(color: scheme.onSurfaceVariant),
        cellTextStyle: appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: scheme.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 200),
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: false),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: darkLightShadow, offset: const Offset(-3, -3), blurRadius: 5),
            BoxShadow(
                color: darkDarkShadow, offset: const Offset(3, 3), blurRadius: 5)
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: scheme.error.withValues(alpha: 0.15),
          borderColor: scheme.error,
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: darkLightShadow.withValues(alpha: 0.3), offset: const Offset(-2, -2), blurRadius: 4),
            BoxShadow(
                color: darkDarkShadow.withValues(alpha: 0.3), offset: const Offset(2, 2), blurRadius: 4)
          ],
          blurStrength: 0.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.circular(12.0),
        contentColor: scheme.onSurface,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOut,
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle,
        distance: 80.0,
        type: FabAnimationType.fanOut,
        overlayColor: scheme.scrim.withValues(alpha: 0.2),
        enableBlur: false,
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid,
        cap: GaugeCapType.bead,
        trackColor: scheme.shadow.withValues(alpha: 0.2),
        indicatorColor: scheme.primary,
        showTicks: false,
        strokeWidth: 14.0,
        enableGlow: false,
      ),
    );
  }

  /// Builds topology spec for Neumorphic theme with soft, embossed aesthetic.
  static TopologySpec _buildTopologySpec(ColorScheme scheme, {required bool isLight}) {
    final baseColor = scheme.surface;
    final lightShadow = isLight
        ? Color.alphaBlend(scheme.outline.withValues(alpha: 0.5), scheme.surface)
        : Color.alphaBlend(scheme.outline.withValues(alpha: 0.1), scheme.surface);

    return TopologySpec(
      // Gateway styles - soft embossed circles
      gatewayNormalStyle: NodeStyle(
        backgroundColor: baseColor,
        borderColor: scheme.primary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 999.0,
        glowColor: lightShadow,
        glowRadius: 8.0,
        size: 68.0,
        iconColor: scheme.primary,
      ),
      gatewayHighLoadStyle: NodeStyle(
        backgroundColor: baseColor,
        borderColor: scheme.tertiary.withValues(alpha: 0.4),
        borderWidth: 1.5,
        borderRadius: 999.0,
        glowColor: scheme.tertiary.withValues(alpha: 0.2),
        glowRadius: 10.0,
        size: 68.0,
        iconColor: scheme.tertiary,
      ),
      gatewayOfflineStyle: NodeStyle(
        backgroundColor: baseColor,
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 68.0,
        iconColor: scheme.outline,
      ),

      // Extender styles - soft rounded rectangles
      extenderNormalStyle: NodeStyle(
        backgroundColor: baseColor,
        borderColor: scheme.secondary.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 16.0,
        glowColor: lightShadow,
        glowRadius: 6.0,
        size: 54.0,
        iconColor: scheme.secondary,
      ),
      extenderHighLoadStyle: NodeStyle(
        backgroundColor: baseColor,
        borderColor: scheme.tertiary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 16.0,
        glowColor: scheme.tertiary.withValues(alpha: 0.15),
        glowRadius: 8.0,
        size: 54.0,
        iconColor: scheme.tertiary,
      ),
      extenderOfflineStyle: NodeStyle(
        backgroundColor: baseColor,
        borderColor: scheme.outline.withValues(alpha: 0.15),
        borderWidth: 1.0,
        borderRadius: 16.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 54.0,
        iconColor: scheme.outline,
      ),

      // Client styles - small soft circles
      clientNormalStyle: NodeStyle(
        backgroundColor: baseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: lightShadow,
        glowRadius: 4.0,
        size: 32.0,
        iconColor: scheme.onSurface,
      ),
      clientOfflineStyle: NodeStyle(
        backgroundColor: baseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 32.0,
        iconColor: scheme.outline,
      ),

      // Link styles - soft connections
      ethernetLinkStyle: LinkStyle(
        color: scheme.outline.withValues(alpha: 0.5),
        width: 2.0,
        dashPattern: null,
        glowColor: lightShadow,
        glowRadius: 2.0,
        animationDuration: Duration.zero,
      ),
      wifiStrongStyle: LinkStyle(
        color: scheme.tertiary.withValues(alpha: 0.6),
        width: 2.0,
        dashPattern: const [6.0, 3.0],
        glowColor: scheme.tertiary.withValues(alpha: 0.1),
        glowRadius: 3.0,
        animationDuration: const Duration(milliseconds: 1800),
      ),
      wifiMediumStyle: LinkStyle(
        color: scheme.tertiaryContainer.withValues(alpha: 0.8),
        width: 2.0,
        dashPattern: const [5.0, 3.0],
        glowColor: scheme.tertiaryContainer.withValues(alpha: 0.2),
        glowRadius: 2.0,
        animationDuration: const Duration(milliseconds: 2200),
      ),
      wifiWeakStyle: LinkStyle(
        color: scheme.error.withValues(alpha: 0.6),
        width: 1.5,
        dashPattern: const [4.0, 3.0],
        glowColor: scheme.error.withValues(alpha: 0.1),
        glowRadius: 2.0,
        animationDuration: const Duration(milliseconds: 2600),
      ),
      wifiUnknownStyle: LinkStyle(
        color: scheme.outline.withValues(alpha: 0.4),
        width: 1.5,
        dashPattern: const [4.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 2200),
      ),

      // Layout - soft spacing
      nodeSpacing: 95.0,
      linkCurvature: 0.25,
      orbitRadius: 58.0,
      orbitSpeed: const Duration(seconds: 22),
    );
  }
}
