import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/password_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/pin_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/range_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart'
    as shared;
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/styled_text_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/page_layout_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/bottom_bar_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/menu_style.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/motion/neumorphic_motion.dart';

class NeumorphicDesignTheme extends AppDesignTheme {
  // Factory 1: Create from Config (Lazy/Custom Mode)
  factory NeumorphicDesignTheme.fromConfig(AppThemeConfig config) {
    final colors = AppColorFactory.generateNeumorphic(config);
    return NeumorphicDesignTheme._raw(colors);
  }

  // Factory 2: Raw Mode (Internal Assembly)
  factory NeumorphicDesignTheme._raw(AppColorScheme colors) {
    final isLight = colors.surface.computeLuminance() >
        0.5; // Approximate check if needed, or rely on colors

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
            color: colors.glowColor.withValues(
                alpha: isLight
                    ? 0.7
                    : 0.15), // Adjust strength based on surface assumption or specific color
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
        borderColor: colors
            .highContrastBorder, // Use highContrastBorder for highlight border
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
        animation: AnimationSpec.standard,
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
                color: colors.styleShadow.withValues(alpha: 0.3),
                offset: const Offset(2, 2),
                blurRadius: 4)
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
          customBorder: Border(
              bottom: BorderSide(
                  color: colors.styleShadow.withValues(alpha: 0.3),
                  width: 1.0)),
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
        secondaryColor:
            colors.glowColor.withValues(alpha: 0.5), // Light/Glow for secondary
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
      navigationStyle: NavigationStyle(
        height: 88.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 12.0,
        animation: AnimationSpec.standard,
        itemColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.onSurface.withValues(alpha: 0.5),
        ),
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
        backgroundColor: colors.styleBackground,
        foregroundColor: colors.onSurface,
        surfaceColor: colors.styleBackground,
        shadowColor: colors.styleShadow,
        elevation: 0.0,
        height: 56.0,
        titleTextStyle: TextStyle(
          color: colors.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        actionIconSize: 24.0,
        leadingIconSize: 24.0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        actionSpacing: 12.0,
        borderRadius: BorderRadius.zero,
        border: null,
        centerTitle: false,
        titleSpacing: 16.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
        containerStyle: BoxDecoration(
          color: colors.styleBackground,
          boxShadow: [
            BoxShadow(
              color: colors.glowColor,
              offset: const Offset(-3, -3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: colors.styleShadow,
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        dividerStyle: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colors.subtleBorder,
              width: 1.0,
            ),
          ),
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
                color: colors.glowColor,
                offset: const Offset(-4, -4),
                blurRadius: 8),
            BoxShadow(
                color: colors.styleShadow,
                offset: const Offset(4, 4),
                blurRadius: 8),
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
            BoxShadow(
                color: colors.glowColor,
                offset: const Offset(-6, -6),
                blurRadius: 12),
            BoxShadow(
                color: colors.styleShadow,
                offset: const Offset(6, 6),
                blurRadius: 12),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        overlay: OverlaySpec(
          scrimColor: colors.overlayColor.withValues(alpha: 0.4),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
      ),
      motion: const NeumorphicMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 20.0,
        width: 280.0,
        dragHandleHeight: 6.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.onSurface.withValues(alpha: 0.6),
        ),
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
        animation: AnimationSpec.standard,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.onSurface.withValues(alpha: 0.6),
        ),
        separatorColor: colors.outline,
        separatorText: ' • ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: colors.surface,
        expandedBackgroundColor: colors.surfaceContainer,
        headerTextColor: colors.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.primary.withValues(alpha: 0.75),
          hover: colors.primary.withValues(alpha: 0.75),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOutQuad,
        ),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: colors.primary.withValues(alpha: 0.12),
          inactive: colors.surface,
        ),
        textColors: StateColorSpec(
          active: colors.onSurface,
          inactive: colors.onSurface,
        ),
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
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: colors.onSurfaceVariant),
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
      topologySpec: _buildTopologySpecFromColors(colors),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: colors.glowColor.withValues(alpha: 0.6),
                offset: const Offset(-3, -3),
                blurRadius: 5),
            BoxShadow(
                color: colors.styleShadow.withValues(alpha: 0.15),
                offset: const Offset(3, 3),
                blurRadius: 5)
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
                color: colors.glowColor.withValues(alpha: 0.3),
                offset: const Offset(-2, -2),
                blurRadius: 4),
            BoxShadow(
                color: colors.styleShadow.withValues(alpha: 0.3),
                offset: const Offset(2, 2),
                blurRadius: 4)
          ],
          blurStrength: 0.0,
          contentColor: colors.onError,
        ),
        borderRadius: BorderRadius.circular(12.0),
        contentColor: colors.onSurface,
        iconSize: 24.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle, // Soft circle usually
        distance: 80.0,
        type: FabAnimationType.fanOut, // Or easeOut
        overlay: OverlaySpec(
          scrimColor: colors.scrim.withValues(alpha: 0.2),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType
            .solid, // Or convex fill if custom painter supports it
        cap: GaugeCapType.bead, // Bead at tip
        trackColor: colors.styleShadow
            .withValues(alpha: 0.2), // Inner shadow track usually
        indicatorColor: colors.primary, // Soft primary for Neumorphic
        showTicks: false,
        strokeWidth: 14.0,
        enableGlow: false,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false,
        customSeparator: null,
        activeBorderColor: colors.primary,
        spacing: 12.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.recess,
        fillOnInput: false,
        glowOnActive: true,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: colors.onSurface),
        cellSpacing: 12.0,
        cellSize: 52.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_circle_outline,
        pendingIcon: Icons.radio_button_unchecked,
        ruleTextStyle:
            appTextTheme.bodySmall!.copyWith(color: colors.onSurfaceVariant),
        showRuleListBackground: false,
        validColor: colors.primary,
        pendingColor: colors.onSurfaceVariant,
      ),
      styledTextStyle: _createNeumorphicStyledTextStyle(colors, appTextTheme),
      buttonStyle: _createNeumorphicTextAppButtonStyleForScheme(
          colors.toMaterialScheme(brightness: Brightness.light), appTextTheme),
      pageLayoutStyle: PageLayoutStyle.defaultStyle(
        colorScheme: colors.toMaterialScheme(brightness: Brightness.light),
        spacing: 20.0,
      ),
      bottomBarStyle: BottomBarStyle.defaultStyle(
        colorScheme: colors.toMaterialScheme(brightness: Brightness.light),
        textTheme: appTextTheme,
      ),
      pageMenuStyle: AppMenuThemeStyle.defaultStyle(
        colorScheme: colors.toMaterialScheme(brightness: Brightness.light),
        textTheme: appTextTheme,
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
        animation: const shared.AnimationSpec(
          duration: Duration.zero,
          curve: Curves.linear,
        ),
      ),
      wifiStrongStyle: LinkStyle(
        color: colors.semanticSuccess,
        width: 2.0,
        dashPattern: const [6.0, 3.0],
        glowColor: colors.semanticGlow,
        glowRadius: 3.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 1800),
          curve: Curves.linear,
        ),
      ),
      wifiMediumStyle: LinkStyle(
        color: colors.tertiaryContainer.withValues(alpha: 0.8),
        width: 2.0,
        dashPattern: const [5.0, 3.0],
        glowColor: colors.tertiaryContainer.withValues(alpha: 0.2),
        glowRadius: 2.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2200),
          curve: Curves.linear,
        ),
      ),
      wifiWeakStyle: LinkStyle(
        color: colors.semanticDanger,
        width: 1.5,
        dashPattern: const [4.0, 3.0],
        glowColor: colors.semanticDanger.withValues(alpha: 0.15),
        glowRadius: 2.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2600),
          curve: Curves.linear,
        ),
      ),
      wifiUnknownStyle: LinkStyle(
        color: colors.outline.withValues(alpha: 0.4),
        width: 1.5,
        dashPattern: const [4.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2200),
          curve: Curves.linear,
        ),
      ),
      nodeSpacing: 95.0,
      linkCurvature: 0.25,
      orbitRadius: 58.0,
      orbitSpeed: const Duration(seconds: 22),

      // View transition animation - smooth, gradual timing for Neumorphic theme
      viewTransition: const shared.AnimationSpec(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ),
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
    required super.styledTextStyle,
    required super.buttonStyle,
    required super.pageLayoutStyle,
    required super.bottomBarStyle,
    required super.pageMenuStyle,
  });

  // Default to Light, providing a default ColorScheme
  factory NeumorphicDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final lightBaseColor = scheme.surface;
    final lightShadow = Color.alphaBlend(
        scheme.outline.withValues(alpha: 0.5), scheme.surface); // White shadow
    final darkShadow = Color.alphaBlend(
        scheme.shadow.withValues(alpha: 0.2), scheme.surface); // Black shadow
    final highlightBorderColor = scheme.primary;
    final neuBase = scheme.surface;
    final neuShadow = scheme.shadow.withValues(alpha: 0.3);
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
        animation: AnimationSpec.standard,
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
        color: scheme.shadow.withValues(alpha: 0.4),
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
      navigationStyle: NavigationStyle(
        height:
            88.0, // height, because soft plastic needs more breathing space to present the shadow
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 12.0,
        animation: AnimationSpec.standard,
        itemColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurface.withValues(alpha: 0.5),
        ),
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
        backgroundColor: lightBaseColor,
        foregroundColor: scheme.onSurface,
        surfaceColor: lightBaseColor,
        shadowColor: darkShadow,
        elevation: 0.0,
        height: 56.0,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        actionIconSize: 24.0,
        leadingIconSize: 24.0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        actionSpacing: 12.0,
        borderRadius: BorderRadius.zero,
        border: null,
        centerTitle: false,
        titleSpacing: 16.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
        containerStyle: BoxDecoration(
          color: lightBaseColor,
          boxShadow: [
            BoxShadow(
              color: lightShadow,
              offset: const Offset(-3, -3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: darkShadow,
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        dividerStyle: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: scheme.outlineVariant,
              width: 1.0,
            ),
          ),
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: lightBaseColor,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
                color: lightShadow,
                offset: const Offset(-4, -4),
                blurRadius: 8),
            BoxShadow(
                color: darkShadow, offset: const Offset(4, 4), blurRadius: 8),
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
            BoxShadow(
                color: lightShadow,
                offset: const Offset(-6, -6),
                blurRadius: 12),
            BoxShadow(
                color: darkShadow, offset: const Offset(6, 6), blurRadius: 12),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.4),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
      ),
      motion: const NeumorphicMotion(), // Assuming NeumorphicMotion
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 20.0,
        width: 280.0,
        dragHandleHeight: 6.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
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
        animation: AnimationSpec.standard,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
        separatorColor: scheme.outline,
        separatorText: ' • ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surface,
        expandedBackgroundColor: scheme.surfaceContainer,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.primary.withValues(alpha: 0.75),
          hover: scheme.primary.withValues(alpha: 0.75),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOutQuad,
        ),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: scheme.primary.withValues(alpha: 0.12),
          inactive: scheme.surface,
        ),
        textColors: StateColorSpec(
          active: scheme.onSurface,
          inactive: scheme.onSurface,
        ),
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
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: scheme.onSurfaceVariant),
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
          backgroundColor: scheme.surface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: lightShadow,
                offset: const Offset(-3, -3),
                blurRadius: 5),
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
                color: lightShadow.withValues(alpha: 0.3),
                offset: const Offset(-2, -2),
                blurRadius: 4),
            BoxShadow(
                color: darkShadow.withValues(alpha: 0.3),
                offset: const Offset(2, 2),
                blurRadius: 4)
          ],
          blurStrength: 0.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.circular(12.0),
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
          scrimColor: scheme.scrim.withValues(alpha: 0.2),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid,
        cap: GaugeCapType.bead,
        trackColor: scheme.shadow.withValues(alpha: 0.2),
        indicatorColor: scheme.primary, // Soft primary for Neumorphic theme
        showTicks: false,
        strokeWidth: 14.0,
        enableGlow: false,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false,
        customSeparator: null,
        activeBorderColor: scheme.primary,
        spacing: 12.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.recess,
        fillOnInput: false,
        glowOnActive: true,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: scheme.onSurface),
        cellSpacing: 12.0,
        cellSize: 52.0,
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
      styledTextStyle:
          _createNeumorphicStyledTextStyleForScheme(scheme, appTextTheme),
      buttonStyle:
          _createNeumorphicTextAppButtonStyleForScheme(scheme, appTextTheme),
      pageLayoutStyle: PageLayoutStyle.defaultStyle(
        colorScheme: scheme,
        spacing: 20.0,
      ),
      bottomBarStyle: BottomBarStyle.defaultStyle(
        colorScheme: scheme,
        textTheme: appTextTheme,
      ),
      pageMenuStyle: AppMenuThemeStyle.defaultStyle(
        colorScheme: scheme,
        textTheme: appTextTheme,
      ),
    );
  }

  factory NeumorphicDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final darkBaseColor = scheme.surface;
    final darkLightShadow = Color.alphaBlend(
        scheme.outline.withValues(alpha: 0.1), scheme.surface); // Light shadow
    final darkDarkShadow = Color.alphaBlend(
        scheme.shadow.withValues(alpha: 0.6), scheme.surface); // Dark shadow
    final darkHighlightBorderColor = scheme.primary;
    final neuBase = scheme.surface;
    final neuShadow = scheme.shadow.withValues(alpha: 0.3);

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
        animation: AnimationSpec.standard,
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
      navigationStyle: NavigationStyle(
        height:
            88.0, // height, because soft plastic needs more breathing space to present the shadow
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 12.0,
        animation: AnimationSpec.standard,
        itemColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurface.withValues(alpha: 0.5),
        ),
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
        backgroundColor: darkBaseColor,
        foregroundColor: scheme.onSurface,
        surfaceColor: darkBaseColor,
        shadowColor: darkDarkShadow,
        elevation: 0.0,
        height: 56.0,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        actionIconSize: 24.0,
        leadingIconSize: 24.0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        actionSpacing: 12.0,
        borderRadius: BorderRadius.zero,
        border: null,
        centerTitle: false,
        titleSpacing: 16.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
        containerStyle: BoxDecoration(
          color: darkBaseColor,
          boxShadow: [
            BoxShadow(
              color: darkLightShadow,
              offset: const Offset(-3, -3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: darkDarkShadow,
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        dividerStyle: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: scheme.outlineVariant,
              width: 1.0,
            ),
          ),
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: darkBaseColor,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
                color: darkLightShadow,
                offset: const Offset(-4, -4),
                blurRadius: 8),
            BoxShadow(
                color: darkDarkShadow,
                offset: const Offset(4, 4),
                blurRadius: 8),
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
            BoxShadow(
                color: darkLightShadow,
                offset: const Offset(-6, -6),
                blurRadius: 12),
            BoxShadow(
                color: darkDarkShadow,
                offset: const Offset(6, 6),
                blurRadius: 12),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.5),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
      ),
      motion: const NeumorphicMotion(), // Assuming NeumorphicMotion
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 20.0,
        width: 280.0,
        dragHandleHeight: 6.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
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
        animation: AnimationSpec.standard,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
        separatorColor: scheme.outline,
        separatorText: ' • ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surface,
        expandedBackgroundColor: scheme.surfaceContainer,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.primary.withValues(alpha: 0.75),
          hover: scheme.primary.withValues(alpha: 0.75),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOutQuad,
        ),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: scheme.primary.withValues(alpha: 0.12),
          inactive: scheme.surface,
        ),
        textColors: StateColorSpec(
          active: scheme.onSurface,
          inactive: scheme.onSurface,
        ),
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
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: scheme.onSurfaceVariant),
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
          backgroundColor: scheme.surface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: darkLightShadow,
                offset: const Offset(-3, -3),
                blurRadius: 5),
            BoxShadow(
                color: darkDarkShadow,
                offset: const Offset(3, 3),
                blurRadius: 5)
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
                color: darkLightShadow.withValues(alpha: 0.3),
                offset: const Offset(-2, -2),
                blurRadius: 4),
            BoxShadow(
                color: darkDarkShadow.withValues(alpha: 0.3),
                offset: const Offset(2, 2),
                blurRadius: 4)
          ],
          blurStrength: 0.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.circular(12.0),
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
          scrimColor: scheme.scrim.withValues(alpha: 0.2),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
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
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false,
        customSeparator: null,
        activeBorderColor: scheme.primary,
        spacing: 12.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.recess,
        fillOnInput: false,
        glowOnActive: true,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: scheme.onSurface),
        cellSpacing: 12.0,
        cellSize: 52.0,
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
      styledTextStyle:
          _createNeumorphicStyledTextStyleForDark(scheme, appTextTheme),
      buttonStyle:
          _createNeumorphicTextAppButtonStyleForScheme(scheme, appTextTheme),
      pageLayoutStyle: PageLayoutStyle.defaultStyle(
        colorScheme: scheme,
        spacing: 20.0,
      ),
      bottomBarStyle: BottomBarStyle.defaultStyle(
        colorScheme: scheme,
        textTheme: appTextTheme,
      ),
      pageMenuStyle: AppMenuThemeStyle.defaultStyle(
        colorScheme: scheme,
        textTheme: appTextTheme,
      ),
    );
  }

  /// Builds topology spec for Neumorphic theme with soft, embossed aesthetic.
  static TopologySpec _buildTopologySpec(ColorScheme scheme,
      {required bool isLight}) {
    final baseColor = scheme.surface;
    final lightShadow = isLight
        ? Color.alphaBlend(
            scheme.outline.withValues(alpha: 0.5), scheme.surface)
        : Color.alphaBlend(
            scheme.outline.withValues(alpha: 0.1), scheme.surface);

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
        animation: const shared.AnimationSpec(
          duration: Duration.zero,
          curve: Curves.linear,
        ),
      ),
      wifiStrongStyle: LinkStyle(
        color: scheme.tertiary.withValues(alpha: 0.6),
        width: 2.0,
        dashPattern: const [6.0, 3.0],
        glowColor: scheme.tertiary.withValues(alpha: 0.1),
        glowRadius: 3.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 1800),
          curve: Curves.linear,
        ),
      ),
      wifiMediumStyle: LinkStyle(
        color: scheme.tertiaryContainer.withValues(alpha: 0.8),
        width: 2.0,
        dashPattern: const [5.0, 3.0],
        glowColor: scheme.tertiaryContainer.withValues(alpha: 0.2),
        glowRadius: 2.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2200),
          curve: Curves.linear,
        ),
      ),
      wifiWeakStyle: LinkStyle(
        color: scheme.error.withValues(alpha: 0.6),
        width: 1.5,
        dashPattern: const [4.0, 3.0],
        glowColor: scheme.error.withValues(alpha: 0.1),
        glowRadius: 2.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2600),
          curve: Curves.linear,
        ),
      ),
      wifiUnknownStyle: LinkStyle(
        color: scheme.outline.withValues(alpha: 0.4),
        width: 1.5,
        dashPattern: const [4.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
          duration: Duration(milliseconds: 2200),
          curve: Curves.linear,
        ),
      ),

      // Layout - soft spacing
      nodeSpacing: 95.0,
      linkCurvature: 0.25,
      orbitRadius: 58.0,
      orbitSpeed: const Duration(seconds: 22),

      // View transition animation - smooth, gradual timing for Neumorphic theme
      viewTransition: const shared.AnimationSpec(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ),
    );
  }

  /// Creates StyledTextStyle for Neumorphic theme with AppColorScheme (fromConfig factory)
  /// Neumorphic theme: Soft shadows, gentle transitions, raised/pressed effects
  static StyledTextStyle _createNeumorphicStyledTextStyle(
    AppColorScheme colors,
    TextTheme textTheme,
  ) {
    return StyledTextStyle(
      baseTextStyle: textTheme.bodyMedium!.copyWith(
        color: colors.onSurface,
      ),
      linkColors: StateColorSpec(
        active: colors.primary,
        inactive: colors.primary.withValues(alpha: 0.8),
        hover: colors.primary.withValues(alpha: 0.9),
        pressed: colors.primary,
      ),
      linkAnimation: const shared.AnimationSpec(
        duration: Duration(
            milliseconds: 400), // Neumorphic theme smooth gradual timing
        curve: Curves.easeInOut,
      ),
      largeTextStyle: textTheme.titleMedium!.copyWith(
        color: colors.onSurface,
      ),
      smallTextStyle: textTheme.bodySmall!.copyWith(
        color: colors.onSurface.withValues(alpha: 0.8),
      ),
      boldTextStyle: textTheme.labelLarge!.copyWith(
        color: colors.onSurface,
        fontWeight: FontWeight.w600, // Moderately bold for Neumorphic
      ),
      italicTextStyle: textTheme.bodyMedium!.copyWith(
        color: colors.onSurface,
        fontStyle: FontStyle.italic,
      ),
      underlineTextStyle: textTheme.bodyMedium!.copyWith(
        color: colors.onSurface,
        decoration: TextDecoration.underline,
        decorationThickness: 1.5, // Slightly thicker for soft shadow effect
      ),
      colorTextStyle: textTheme.bodyMedium!.copyWith(
        color: colors.primary,
      ),
      linkDecoration: TextDecoration.none,
      linkDecorationThickness: 0.0,
      // Neumorphic theme special effect: soft text shadows
      linkShadows: [
        Shadow(
          color: colors.styleShadow.withValues(alpha: 0.3),
          offset: const Offset(1, 1),
          blurRadius: 2.0,
        ),
        Shadow(
          color: colors.glowColor.withValues(alpha: 0.5),
          offset: const Offset(-1, -1),
          blurRadius: 2.0,
        ),
      ],
    );
  }

  /// Creates StyledTextStyle for Neumorphic theme with ColorScheme (light/dark factories)
  static StyledTextStyle _createNeumorphicStyledTextStyleForScheme(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    final isLight = scheme.brightness == Brightness.light;
    return StyledTextStyle(
      baseTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
      ),
      linkColors: StateColorSpec(
        active: scheme.primary,
        inactive: scheme.primary.withValues(alpha: 0.8),
        hover: scheme.primary.withValues(alpha: 0.9),
        pressed: scheme.primary,
      ),
      linkAnimation: const shared.AnimationSpec(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ),
      largeTextStyle: textTheme.titleMedium!.copyWith(
        color: scheme.onSurface,
      ),
      smallTextStyle: textTheme.bodySmall!.copyWith(
        color: scheme.onSurface.withValues(alpha: 0.8),
      ),
      boldTextStyle: textTheme.labelLarge!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      italicTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        fontStyle: FontStyle.italic,
      ),
      underlineTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        decoration: TextDecoration.underline,
        decorationThickness: 1.5,
      ),
      colorTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.primary,
      ),
      linkDecoration: TextDecoration.none,
      linkDecorationThickness: 0.0,
      // Neumorphic theme special effect: soft dual shadows (raised effect)
      linkShadows: [
        Shadow(
          color: isLight
              ? Colors.black.withValues(alpha: 0.2)
              : Colors.black.withValues(alpha: 0.4),
          offset: const Offset(1, 1),
          blurRadius: 2.0,
        ),
        Shadow(
          color: isLight
              ? Colors.white.withValues(alpha: 0.8)
              : scheme.surface.withValues(alpha: 0.6),
          offset: const Offset(-1, -1),
          blurRadius: 2.0,
        ),
      ],
    );
  }

  /// Creates StyledTextStyle for Neumorphic theme dark mode
  static StyledTextStyle _createNeumorphicStyledTextStyleForDark(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    return StyledTextStyle(
      baseTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
      ),
      linkColors: StateColorSpec(
        active: scheme.primary,
        inactive: scheme.primary.withValues(alpha: 0.8),
        hover: scheme.primary.withValues(alpha: 0.9),
        pressed: scheme.primary,
      ),
      linkAnimation: const shared.AnimationSpec(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ),
      largeTextStyle: textTheme.titleMedium!.copyWith(
        color: scheme.onSurface,
      ),
      smallTextStyle: textTheme.bodySmall!.copyWith(
        color: scheme.onSurface.withValues(alpha: 0.8),
      ),
      boldTextStyle: textTheme.labelLarge!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      italicTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        fontStyle: FontStyle.italic,
      ),
      underlineTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        decoration: TextDecoration.underline,
        decorationThickness: 1.5,
      ),
      colorTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.primary,
      ),
      linkDecoration: TextDecoration.none,
      linkDecorationThickness: 0.0,
      // Dark mode Neumorphic: stronger shadows for raised effect
      linkShadows: [
        Shadow(
          color: scheme.shadow.withValues(alpha: 0.4),
          offset: const Offset(1, 1),
          blurRadius: 2.0,
        ),
        Shadow(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
          offset: const Offset(-1, -1),
          blurRadius: 2.0,
        ),
      ],
    );
  }

  /// Creates unified AppButtonStyle for Neumorphic theme with ColorScheme
  static AppButtonStyle _createNeumorphicTextAppButtonStyleForScheme(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    final isLight = scheme.brightness == Brightness.light;

    // Neumorphic dual shadow system
    final lightShadow = isLight
        ? Colors.white.withValues(alpha: 0.8)
        : scheme.surface.withValues(alpha: 0.2);
    final darkShadow = isLight
        ? Colors.black.withValues(alpha: 0.2)
        : scheme.shadow.withValues(alpha: 0.5);

    // Create neumorphic-themed surface styles with soft dual shadows
    final filledSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: scheme.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 12.0, // Soft neumorphic corners
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
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
      ),
      disabled: SurfaceStyle(
        backgroundColor: scheme.onSurface.withValues(alpha: 0.12),
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.onSurface.withValues(alpha: 0.38),
        shadows: [
          BoxShadow(
            color: lightShadow.withValues(alpha: 0.3),
            offset: const Offset(-2, -2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: darkShadow.withValues(alpha: 0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      hovered: SurfaceStyle(
        backgroundColor: scheme.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
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
      ),
      pressed: SurfaceStyle(
        backgroundColor: scheme.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
        shadows: [
          // Pressed state: inset shadows (reversed light/dark)
          BoxShadow(
            color: darkShadow,
            offset: const Offset(-2, -2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: lightShadow.withValues(alpha: 0.6),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );

    final outlineSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.primary.withValues(alpha: 0.6),
        borderWidth: 1.5,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          // Inset shadow for outline variant
          BoxShadow(
            color: darkShadow,
            offset: const Offset(-2, -2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: lightShadow.withValues(alpha: 0.7),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      disabled: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.primary.withValues(alpha: 0.25),
        borderWidth: 1.5,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.primary.withValues(alpha: 0.38),
        shadows: [
          BoxShadow(
            color: darkShadow.withValues(alpha: 0.3),
            offset: const Offset(-1, -1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: lightShadow.withValues(alpha: 0.3),
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      hovered: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.primary.withValues(alpha: 0.7),
        borderWidth: 1.5,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          // More pronounced inset on hover
          BoxShadow(
            color: darkShadow,
            offset: const Offset(-3, -3),
            blurRadius: 6,
          ),
          BoxShadow(
            color: lightShadow.withValues(alpha: 0.8),
            offset: const Offset(3, 3),
            blurRadius: 6,
          ),
        ],
      ),
      pressed: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.primary.withValues(alpha: 0.8),
        borderWidth: 1.5,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          // Deep inset when pressed
          BoxShadow(
            color: darkShadow.withValues(alpha: 0.8),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: lightShadow.withValues(alpha: 0.5),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
    );

    final textSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
      ),
      disabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.primary.withValues(alpha: 0.38),
      ),
      hovered: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          // Subtle raised effect on hover
          BoxShadow(
            color: lightShadow.withValues(alpha: 0.6),
            offset: const Offset(-2, -2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: darkShadow.withValues(alpha: 0.6),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      pressed: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 12.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          // Subtle inset on press
          BoxShadow(
            color: darkShadow.withValues(alpha: 0.4),
            offset: const Offset(-1, -1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: lightShadow.withValues(alpha: 0.4),
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
    );

    // Create color specs
    final filledContentColors = StateColorSpec(
      active: scheme.onPrimary,
      inactive: scheme.onPrimary.withValues(alpha: 0.8),
      disabled: scheme.onSurface.withValues(alpha: 0.38),
      hover: scheme.onPrimary,
      pressed: scheme.onPrimary,
    );

    final outlineContentColors = StateColorSpec(
      active: scheme.primary,
      inactive: scheme.primary.withValues(alpha: 0.8),
      disabled: scheme.primary.withValues(alpha: 0.38),
      hover: scheme.primary,
      pressed: scheme.primary,
    );

    final textContentColors = StateColorSpec(
      active: scheme.primary,
      inactive: scheme.primary.withValues(alpha: 0.8),
      disabled: scheme.primary.withValues(alpha: 0.38),
      hover: scheme.primary,
      pressed: scheme.primary,
    );

    // Create text styles with soft weight for neumorphic theme
    final textStyles = ButtonTextStyles(
      small: textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w500,
        color: scheme.primary,
      ),
      medium: textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w500,
        color: scheme.primary,
      ),
      large: textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600, // Slightly bolder for large
        color: scheme.primary,
      ),
    );

    // Create size spec with neumorphic proportions
    const sizeSpec = ButtonSizeSpec(
      smallHeight: 36.0, // Slightly taller for shadow visibility
      mediumHeight: 52.0,
      largeHeight: 60.0, // More height for shadow effect
      smallPadding: EdgeInsets.symmetric(horizontal: 20.0),
      mediumPadding: EdgeInsets.symmetric(horizontal: 28.0),
      largePadding: EdgeInsets.symmetric(horizontal: 36.0),
      iconSpacing: 12.0, // More space for soft aesthetic
    );

    // Create interaction spec with neumorphic animations
    const interaction = InteractionSpec(
      pressedScale: 0.98, // Subtle scale for soft press effect
      hoverOpacity: 1.0, // No opacity changes - use shadows instead
      pressedOpacity: 1.0, // No opacity changes
      pressedOffset: Offset.zero, // No offset - use shadow changes instead
    );

    return AppButtonStyle(
      filledSurfaces: filledSurfaces,
      filledContentColors: filledContentColors,
      outlineSurfaces: outlineSurfaces,
      outlineContentColors: outlineContentColors,
      textSurfaces: textSurfaces,
      textContentColors: textContentColors,
      textStyles: textStyles,
      sizeSpec: sizeSpec,
      interaction: interaction,
    );
  }
}
