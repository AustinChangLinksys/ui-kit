import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/range_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/pin_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/password_input_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class GlassDesignTheme extends AppDesignTheme {
  // Factory 1: Create from Config
  factory GlassDesignTheme.fromConfig(AppThemeConfig config) {
    final colors = AppColorFactory.generateGlass(config);
    return GlassDesignTheme._raw(colors);
  }

  // Factory 2: Raw Mode (AppColorScheme driven)
  factory GlassDesignTheme._raw(AppColorScheme colors) {
    // Glass specific adjustments if needed, otherwise trust colors
    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.subtleBorder,
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: colors.glowColor.withValues(alpha: 0.1), // Soft glow
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          )
        ],
        blurStrength: 25.0,
        contentColor: colors.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: colors.styleBackground
            .withValues(alpha: 0.15), // Slightly more opaque
        borderColor: colors.subtleBorder,
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
        blurStrength: 35.0,
        contentColor: colors.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: colors.primary.withValues(alpha: 0.15),
        borderColor: colors.subtleBorder,
        borderWidth: 1.5,
        borderRadius: 24.0,
        blurStrength: 20.0,
        shadows: [
          BoxShadow(
            color: colors.glowColor,
            blurRadius: 12,
            spreadRadius: -2,
            offset: const Offset(0, 4),
          )
        ],
        contentColor: colors.primary,
        interaction: const InteractionSpec(
          pressedScale: 0.92,
          pressedOpacity: 0.8,
          hoverOpacity: 0.9,
          pressedOffset: Offset.zero,
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: colors.secondary.withValues(alpha: 0.12),
        borderColor: colors.subtleBorder.withValues(alpha: 0.5),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 15.0,
        shadows: [
          BoxShadow(
            color: colors.secondary.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: colors.onSecondary,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: colors.tertiary.withValues(alpha: 0.15),
        borderColor: colors.tertiary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 12.0,
        shadows: [
          BoxShadow(
            color: colors.tertiary.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: colors.tertiary,
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: colors.primary.withValues(alpha: 0.02),
        highlightColor: colors.primary.withValues(alpha: 0.12),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 24.0,
      ),
      toggleStyle: ToggleStyle(
        activeType: ToggleContentType.grip,
        inactiveType: ToggleContentType.grip,
        activeTrackStyle: SurfaceStyle(
          backgroundColor: colors.primary.withValues(alpha: 0.5),
          borderColor: colors.subtleBorder,
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: colors.primary.withValues(alpha: 0.3), blurRadius: 12)
          ],
          blurStrength: 15.0,
          contentColor: colors.onPrimary,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHigh.withValues(alpha: 0.1),
          borderColor: colors.subtleBorder,
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: colors.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: colors.surface.withValues(alpha: 0.9),
          borderColor: colors.outline,
          borderWidth: 0.0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: colors.shadow.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          blurStrength: 5.0,
          contentColor: colors.primary,
        ),
      ),
      inputStyle: InputStyle(
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: colors.subtleBorder,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          blurStrength: 0,
          shadows: const [],
          customBorder: Border(
              bottom: BorderSide(color: colors.subtleBorder, width: 1.5)),
        ),
        outlineStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.subtleBorder,
          contentColor: colors.onSurface,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: [
            BoxShadow(
                color: colors.styleShadow.withValues(alpha: 0.05),
                blurRadius: 8)
          ],
          blurStrength: 10.0,
        ),
        filledStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHigh.withValues(alpha: 0.05),
          borderColor: Colors.transparent,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0,
        ),
        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: colors.primary.withValues(alpha: 0.6),
          contentColor: colors.onSurface,
          shadows: [
            BoxShadow(
                color: colors.primary.withValues(alpha: 0.3), blurRadius: 12)
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
        strokeWidth: 4.0,
        size: 48.0,
        period: const Duration(milliseconds: 1500),
        shadows: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.6),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(16),
        backgroundColor: colors.surface.withValues(alpha: 0.6),
        textStyle: appTextTheme.bodyMedium!.copyWith(color: colors.onSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: colors.subtleBorder,
        thickness: 1.0,
        glowStrength: 6.0,
        pattern: DividerPattern.solid,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.glowingDot,
        macAddressSeparator: ':',
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
      spacingFactor: 1.0,
      buttonHeight: 44.0,
      navigationStyle: const NavigationStyle(
        height: 72.0,
        isFloating: true,
        floatingMargin: 24.0,
        itemSpacing: 16.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 20.0,
        marginTablet: 32.0,
        marginDesktop: 80.0,
        gutterMobile: 20.0,
        gutterTablet: 24.0,
        gutterDesktop: 32.0,
      ),
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.subtleBorder,
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 25.0,
          contentColor: colors.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: colors.subtleBorder.withValues(alpha: 0.5),
          thickness: 1.0,
          pattern: DividerPattern.solid,
          glowStrength: 4.0,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 25.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.subtleBorder,
          borderWidth: 1.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: -5,
            ),
          ],
          blurStrength: 20.0,
          contentColor: colors.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: colors.primary.withValues(alpha: 0.1),
          borderColor: colors.primary.withValues(alpha: 0.2),
          borderWidth: 1.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: colors.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground.withValues(alpha: 0.8),
          borderColor: colors.subtleBorder,
          borderWidth: 1.5,
          borderRadius: 24.0,
          shadows: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: -5,
            ),
          ],
          blurStrength: 30.0,
          contentColor: colors.onSurface,
        ),
        barrierColor: colors.overlayColor,
        barrierBlur: 10.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 12.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const GlassMotion(),
      visualEffects: GlobalEffectsType.noiseOverlay,
      iconStyle: AppIconStyle.thinStroke,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: colors.overlayColor,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        topBorderRadius: 16.0,
        dragHandleHeight: 8.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: colors.overlayColor,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        blurStrength: 20.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: colors.primary,
        inactiveTextColor: colors.onSurface,
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
        inactiveLinkColor: colors.onSurfaceVariant,
        separatorColor: colors.outline,
        separatorText: ' / ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: colors.surfaceContainer,
        expandedBackgroundColor: colors.surfaceContainerHigh,
        headerTextColor: colors.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 300),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: colors.primary,
        navButtonHoverColor: colors.primary.withValues(alpha: 0.8),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: colors.surfaceContainer,
        unselectedText: colors.onSurface,
        selectedBackground: colors.primary.withValues(alpha: 0.2),
        selectedText: colors.onSurface,
        selectedBorderColor: colors.primary,
        borderRadius: 20.0,
      ),
      tableStyle: TableStyle(
        headerBackground: null,
        rowBackground: colors.surface.withValues(alpha: 0.05),
        gridColor: Colors.transparent,
        gridWidth: 0.0,
        showVerticalGrid: false,
        cellPadding: const EdgeInsets.all(16.0),
        rowHeight: 64.0,
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: colors.onSurface),
        cellTextStyle:
            appTextTheme.bodyMedium!.copyWith(color: colors.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: true,
        hoverRowBackground: colors.primary.withValues(alpha: 0.1),
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 500),
      ),
      topologySpec: _buildTopologySpec(
          colors.toMaterialScheme(brightness: Brightness.light),
          isLight: true), // Temporary until topology uses AppColorScheme
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: colors.surface.withValues(alpha: 0.2), // Translucent
          borderColor: colors.subtleBorder,
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 20.0,
          contentColor: colors.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor:
              colors.error.withValues(alpha: 0.6), // Translucent error
          borderColor: colors.error,
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 20.0,
          contentColor: colors.onError,
        ),
        borderRadius: BorderRadius.circular(16.0), // Organic rounded shape
        contentColor: colors.onSurface,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 500),
        animationCurve: Curves.easeOutExpo, // Fluid
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle,
        distance: 100.0,
        type: FabAnimationType.float, // Bubble effect
        overlayColor: colors.scrim.withValues(alpha: 0.2),
        enableBlur: true,
        showDitherPattern: false,
        glowEffect: true,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.gradient, // Neon gradient
        cap: GaugeCapType.comet, // Comet tail
        trackColor: colors.outline.withValues(alpha: 0.1),
        indicatorColor: colors.signalStrong,
        showTicks: false,
        strokeWidth: 16.0,
        enableGlow: true, // Neon glow
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false, // Separated boxes
        customSeparator: null, // Glowing beam handled by renderer
        activeBorderColor: colors.signalStrong, // Neon glow
        spacing: 8.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.circle, // Orb
        fillOnInput: false,
        glowOnActive: true, // Pulse
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: colors.signalStrong),
        cellSpacing: 12.0,
        cellSize: 56.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_circle_outline, // Glowing check
        pendingIcon: Icons.circle_outlined,
        ruleTextStyle: appTextTheme.bodySmall!
            .copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
        showRuleListBackground: true, // Glass panel
        validColor: colors.signalStrong, // Neon green
        pendingColor: colors.onSurface.withValues(alpha: 0.5),
      ),
    );
  }

  const GlassDesignTheme._({
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
    required super.rangeInputStyle,
    required super.pinInputStyle,
    required super.passwordInputStyle,
  });

  // Light Mode (Liquid Water)
  factory GlassDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final glassBaseColor = scheme.surface.withValues(alpha: 0.02);
    final overlayColor = scheme.scrim.withValues(alpha: 0.2);

    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: glassBaseColor,
        borderColor: scheme.outline.withValues(alpha: 0.5),
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          )
        ],
        blurStrength: 25.0,
        contentColor: scheme.onSurface,
      ),
      // ... (rest of light factory is mostly same, just confirming no texture usage here)
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.1),
        borderColor: scheme.outline.withValues(alpha: 0.6),
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
        blurStrength: 35.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.15),
        borderColor: scheme.outline.withValues(alpha: 0.5),
        borderWidth: 1.5,
        borderRadius: 24.0,
        blurStrength: 20.0,
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.25),
            blurRadius: 12,
            spreadRadius: -2,
            offset: const Offset(0, 4),
          )
        ],
        contentColor: scheme.primary,
        interaction: const InteractionSpec(
          pressedScale: 0.92,
          pressedOpacity: 0.8,
          hoverOpacity: 0.9,
          pressedOffset: Offset.zero,
        ),
      ),
      // Secondary (Tonal) Surface - Medium emphasis, selected/active states
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.secondary.withValues(alpha: 0.12),
        borderColor: scheme.outline.withValues(alpha: 0.4),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 15.0,
        shadows: [
          BoxShadow(
            color: scheme.secondary.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: scheme.secondary.withValues(alpha: 0.8),
      ),
      // Tertiary (Accent) Surface - Decorative or special emphasis
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: 0.15),
        borderColor: scheme.tertiary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 12.0,
        shadows: [
          BoxShadow(
            color: scheme.tertiary.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: scheme.tertiary,
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.primary.withValues(alpha: 0.02),
        highlightColor: scheme.primary.withValues(alpha: 0.12),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 24.0,
      ),
      toggleStyle: ToggleStyle(
        activeType: ToggleContentType.grip,
        inactiveType: ToggleContentType.grip,
        activeTrackStyle: SurfaceStyle(
          backgroundColor: scheme.primary.withValues(alpha: 0.5),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3), blurRadius: 12)
          ],
          blurStrength: 15.0,
          contentColor: scheme.onPrimary,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor:
              scheme.surfaceContainerHighest.withValues(alpha: 0.1),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: scheme.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.9),
          borderColor: scheme.outline,
          borderWidth: 0.0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          blurStrength: 5.0,
          contentColor: scheme.primary,
        ),
      ),
      inputStyle: InputStyle(
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.outline.withValues(alpha: 0.3), // Required
          contentColor: scheme.onSurface, // Required
          borderWidth: 0,
          borderRadius: 0,
          blurStrength: 0,
          shadows: const [],
          customBorder: Border(
              bottom: BorderSide(
                  color: scheme.outline.withValues(alpha: 0.3), width: 1.5)),
        ),
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor:
              scheme.surfaceContainerHighest.withValues(alpha: 0.1),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          contentColor: scheme.onSurface,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: [
            BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.05), blurRadius: 8)
          ],
          blurStrength: 10.0,
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor:
              scheme.surfaceContainerHighest.withValues(alpha: 0.05),
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary.withValues(alpha: 0.6),
          contentColor: scheme.onSurface,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3), blurRadius: 12)
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
        strokeWidth: 4.0,
        size: 48.0,
        period: const Duration(milliseconds: 1500),
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.6),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(16),
        backgroundColor: scheme.surface.withValues(alpha: 0.6),
        textStyle: appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: scheme.outline.withValues(alpha: 0.3),
        thickness: 1.0,
        glowStrength: 6.0,
        pattern: DividerPattern.solid,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.glowingDot,
        macAddressSeparator: ':',
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
      spacingFactor: 1.0,
      buttonHeight: 44.0,
      navigationStyle: const NavigationStyle(
        height: 72.0,
        isFloating: true,
        floatingMargin: 24.0,
        itemSpacing: 16.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 20.0,
        marginTablet: 32.0,
        marginDesktop: 80.0,
        gutterMobile: 20.0,
        gutterTablet: 24.0,
        gutterDesktop: 32.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles (Glass Light)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.6),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 25.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.outline.withValues(alpha: 0.2),
          thickness: 1.0,
          pattern: DividerPattern.solid,
          glowStrength: 4.0,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 25.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.7),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: -5,
            ),
          ],
          blurStrength: 20.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.primary.withValues(alpha: 0.1),
          borderColor: scheme.primary.withValues(alpha: 0.2),
          borderWidth: 1.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.8),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.5,
          borderRadius: 24.0,
          shadows: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: -5,
            ),
          ],
          blurStrength: 30.0,
          contentColor: scheme.onSurface,
        ),
        barrierColor: scheme.scrim.withValues(alpha: 0.3),
        barrierBlur: 10.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 12.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const GlassMotion(),
      visualEffects: GlobalEffectsType.noiseOverlay,
      iconStyle: AppIconStyle
          .thinStroke, // Or vectorFilled, depending on Glass style preference
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        topBorderRadius: 16.0,
        dragHandleHeight: 8.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        blurStrength: 20.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: scheme.primary,
        inactiveTextColor: scheme.onSurface,
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
        separatorText: ' / ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surfaceContainer,
        expandedBackgroundColor: scheme.surfaceContainerHigh,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 300),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: scheme.primary,
        navButtonHoverColor: scheme.primary.withValues(alpha: 0.8),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: scheme.surfaceContainer,
        unselectedText: scheme.onSurface,
        selectedBackground: scheme.primary.withValues(alpha: 0.2),
        selectedText: scheme.onSurface,
        selectedBorderColor: scheme.primary,
        borderRadius: 20.0,
      ),
      tableStyle: TableStyle(
        headerBackground: null,
        rowBackground: scheme.surface.withValues(alpha: 0.05),
        gridColor: Colors.transparent,
        gridWidth: 0.0,
        showVerticalGrid: false,
        cellPadding: const EdgeInsets.all(16.0),
        rowHeight: 64.0,
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: scheme.onSurface),
        cellTextStyle:
            appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: true,
        hoverRowBackground: scheme.primary.withValues(alpha: 0.1),
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 500),
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: true),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.2),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 20.0,
          contentColor: scheme.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: scheme.error.withValues(alpha: 0.6),
          borderColor: scheme.error.withValues(alpha: 0.5),
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 20.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.circular(16.0),
        contentColor: scheme.onSurface,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 500),
        animationCurve: Curves.easeOutExpo,
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle,
        distance: 100.0,
        type: FabAnimationType.float,
        overlayColor: scheme.scrim.withValues(alpha: 0.2),
        enableBlur: true,
        showDitherPattern: false,
        glowEffect: true,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.gradient,
        cap: GaugeCapType.comet,
        trackColor: scheme.outline.withValues(alpha: 0.1),
        indicatorColor: scheme.primary,
        showTicks: false,
        strokeWidth: 16.0,
        enableGlow: true,
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false,
        customSeparator: null,
        activeBorderColor: scheme.primary,
        spacing: 8.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.circle,
        fillOnInput: false,
        glowOnActive: true,
        textStyle: appTextTheme.headlineMedium!.copyWith(color: scheme.primary),
        cellSpacing: 12.0,
        cellSize: 56.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_circle_outline,
        pendingIcon: Icons.circle_outlined,
        ruleTextStyle: appTextTheme.bodySmall!
            .copyWith(color: scheme.onSurface.withValues(alpha: 0.7)),
        showRuleListBackground: true,
        validColor: scheme.primary,
        pendingColor: scheme.onSurface.withValues(alpha: 0.5),
      ),
    );
  }

  factory GlassDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final overlayColor = scheme.inverseSurface.withValues(alpha: 0.2);
    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.shadow.withValues(alpha: 0.3),
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.3),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
        blurStrength: 25.0,
        contentColor: scheme.onSurface,
        // UPDATED: Use AppTextureAssets.noise
        texture: AppTextureAssets.noise,
        textureOpacity: 0.05,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.05),
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(color: scheme.shadow.withValues(alpha: 0.5), blurRadius: 32)
        ],
        blurStrength: 35.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.2),
        borderColor: scheme.primary.withValues(alpha: 0.4),
        borderWidth: 1.5,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
              color: scheme.primary.withValues(alpha: 0.2),
              blurRadius: 16,
              spreadRadius: 2)
        ],
        blurStrength: 20.0,
        contentColor: scheme.onPrimary,
        interaction: const InteractionSpec(
          pressedScale: 0.92,
          pressedOpacity: 0.8,
          hoverOpacity: 0.9,
          pressedOffset: Offset.zero,
        ),
        // UPDATED: Use AppTextureAssets.pixelGrid
        texture: AppTextureAssets.pixelGrid,
        textureOpacity: 0.08,
      ),
      // Secondary (Tonal) Surface - Medium emphasis, selected/active states (Dark mode)
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.secondary.withValues(alpha: 0.25),
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 15.0,
        shadows: [
          BoxShadow(
            color: scheme.secondary.withValues(alpha: 0.15),
            blurRadius: 10,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: scheme.onSecondary.withValues(alpha: 0.8),
      ),
      // Tertiary (Accent) Surface - Decorative or special emphasis (Dark mode)
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: 0.2),
        borderColor: scheme.tertiary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 12.0,
        shadows: [
          BoxShadow(
            color: scheme.tertiary.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: scheme.tertiary,
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.primary.withValues(alpha: 0.05),
        highlightColor: scheme.primary.withValues(alpha: 0.2),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 24.0,
      ),
      toggleStyle: ToggleStyle(
        activeType: ToggleContentType.grip,
        inactiveType: ToggleContentType.grip,
        activeTrackStyle: SurfaceStyle(
          backgroundColor: scheme.primary.withValues(alpha: 0.4),
          borderColor: scheme.outline.withValues(alpha: 0.1),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.2), blurRadius: 12)
          ],
          blurStrength: 10.0,
          contentColor: scheme.onPrimary,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor:
              scheme.surfaceContainerHighest.withValues(alpha: 0.05),
          borderColor: scheme.outline.withValues(alpha: 0.1),
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: scheme.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.9),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.5),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          blurStrength: 5.0,
          contentColor: scheme.primary,
        ),
      ),
      inputStyle: InputStyle(
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.outline.withValues(alpha: 0.3), // Required
          contentColor: scheme.onSurface, // Required
          borderWidth: 0,
          borderRadius: 0,
          blurStrength: 0,
          shadows: const [],
          customBorder: Border(
              bottom: BorderSide(
                  color: scheme.outline.withValues(alpha: 0.3), width: 1.5)),
        ),
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor:
              scheme.surfaceContainerHighest.withValues(alpha: 0.1),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          contentColor: scheme.onSurface,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: [
            BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.05), blurRadius: 8)
          ],
          blurStrength: 10.0,
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor:
              scheme.surfaceContainerHighest.withValues(alpha: 0.05),
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary.withValues(alpha: 0.6),
          contentColor: scheme.onSurface,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3), blurRadius: 12)
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
        strokeWidth: 4.0,
        size: 48.0,
        period: const Duration(milliseconds: 1500),
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.6),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(16),
        backgroundColor: scheme.surface.withValues(alpha: 0.6),
        textStyle: appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: scheme.outline.withValues(alpha: 0.3),
        thickness: 1.0,
        glowStrength: 6.0,
        pattern: DividerPattern.solid,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.glowingDot,
        macAddressSeparator: ':',
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
      spacingFactor: 1.0,
      buttonHeight: 44.0,
      navigationStyle: const NavigationStyle(
        height: 72.0,
        isFloating: true,
        floatingMargin: 24.0,
        itemSpacing: 16.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 20.0,
        marginTablet: 32.0,
        marginDesktop: 80.0,
        gutterMobile: 20.0,
        gutterTablet: 24.0,
        gutterDesktop: 32.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles (Glass Dark)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.shadow.withValues(alpha: 0.4),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 25.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.outline.withValues(alpha: 0.15),
          thickness: 1.0,
          pattern: DividerPattern.solid,
          glowStrength: 4.0,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 25.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.shadow.withValues(alpha: 0.6),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 1.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.4),
              blurRadius: 24,
            ),
          ],
          blurStrength: 20.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.primary.withValues(alpha: 0.15),
          borderColor: scheme.primary.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.shadow.withValues(alpha: 0.7),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 1.5,
          borderRadius: 24.0,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.5),
              blurRadius: 32,
            ),
          ],
          blurStrength: 30.0,
          contentColor: scheme.onSurface,
        ),
        barrierColor: scheme.scrim.withValues(alpha: 0.4),
        barrierBlur: 10.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 12.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const GlassMotion(),
      visualEffects: GlobalEffectsType.noiseOverlay,
      iconStyle: AppIconStyle.thinStroke, // Or vectorFilled
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        topBorderRadius: 16.0,
        dragHandleHeight: 8.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        blurStrength: 20.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: scheme.primary,
        inactiveTextColor: scheme.onSurface,
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
        separatorText: ' / ',
        itemTextStyle: appTextTheme.bodyMedium!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surfaceContainer,
        expandedBackgroundColor: scheme.surfaceContainerHigh,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 300),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: scheme.primary,
        navButtonHoverColor: scheme.primary.withValues(alpha: 0.8),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.easeInOutCubic,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: scheme.surfaceContainer,
        unselectedText: scheme.onSurface,
        selectedBackground: scheme.primary.withValues(alpha: 0.2),
        selectedText: scheme.onSurface,
        selectedBorderColor: scheme.primary,
        borderRadius: 20.0,
      ),
      tableStyle: TableStyle(
        headerBackground: null,
        rowBackground: scheme.surface.withValues(alpha: 0.05),
        gridColor: Colors.transparent,
        gridWidth: 0.0,
        showVerticalGrid: false,
        cellPadding: const EdgeInsets.all(16.0),
        rowHeight: 64.0,
        headerTextStyle:
            appTextTheme.labelLarge!.copyWith(color: scheme.onSurface),
        cellTextStyle:
            appTextTheme.bodyMedium!.copyWith(color: scheme.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: true,
        hoverRowBackground: scheme.primary.withValues(alpha: 0.1),
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 500),
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: false),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.2),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 20.0,
          contentColor: scheme.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: scheme.error.withValues(alpha: 0.6),
          borderColor: scheme.error.withValues(alpha: 0.5),
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 20.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.circular(16.0),
        contentColor: scheme.onSurface,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 500),
        animationCurve: Curves.easeOutExpo,
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.circle,
        distance: 100.0,
        type: FabAnimationType.float,
        overlayColor: scheme.scrim.withValues(alpha: 0.2),
        enableBlur: true,
        showDitherPattern: false,
        glowEffect: true,
        highContrastBorder: false,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.gradient,
        cap: GaugeCapType.comet,
        trackColor: scheme.outline.withValues(alpha: 0.1),
        indicatorColor: scheme.primary,
        showTicks: false,
        strokeWidth: 16.0,
        enableGlow: true,
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false,
        customSeparator: null,
        activeBorderColor: scheme.primary,
        spacing: 8.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.circle,
        fillOnInput: false,
        glowOnActive: true,
        textStyle: appTextTheme.headlineMedium!.copyWith(color: scheme.primary),
        cellSpacing: 12.0,
        cellSize: 56.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_circle_outline,
        pendingIcon: Icons.circle_outlined,
        ruleTextStyle: appTextTheme.bodySmall!
            .copyWith(color: scheme.onSurface.withValues(alpha: 0.7)),
        showRuleListBackground: true,
        validColor: scheme.primary,
        pendingColor: scheme.onSurface.withValues(alpha: 0.5),
      ),
    );
  }

  /// Builds topology spec for Glass theme with organic, fluid visual language.
  static TopologySpec _buildTopologySpec(ColorScheme scheme,
      {required bool isLight}) {
    final primaryGlow = scheme.primary.withValues(alpha: isLight ? 0.3 : 0.4);
    final secondaryGlow =
        scheme.secondary.withValues(alpha: isLight ? 0.25 : 0.35);
    final errorColor = scheme.error;
    final surfaceColor = scheme.surface.withValues(alpha: isLight ? 0.7 : 0.5);
    final successColor = isLight
        ? const Color(0xFF4CAF50) // Material Green for light mode
        : const Color(0xFF66BB6A); // Lighter green for dark mode
    final warningColor = isLight
        ? const Color(0xFFFF9800) // Material Orange for light mode
        : const Color(0xFFFFB74D); // Lighter orange for dark mode

    return TopologySpec(
      // Gateway styles - breathing pulse effect
      gatewayNormalStyle: NodeStyle(
        backgroundColor:
            scheme.primary.withValues(alpha: isLight ? 0.15 : 0.25),
        borderColor: scheme.primary.withValues(alpha: 0.4),
        borderWidth: 2.0,
        borderRadius: 999.0, // Circular
        glowColor: primaryGlow,
        glowRadius: 20.0,
        size: 72.0,
        iconColor: scheme.primary,
      ),
      gatewayHighLoadStyle: NodeStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: isLight ? 0.2 : 0.3),
        borderColor: scheme.tertiary.withValues(alpha: 0.5),
        borderWidth: 2.5,
        borderRadius: 999.0,
        glowColor: scheme.tertiary.withValues(alpha: 0.4),
        glowRadius: 24.0,
        size: 72.0,
        iconColor: scheme.tertiary,
      ),
      gatewayOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.1),
        borderColor: scheme.outline.withValues(alpha: 0.3),
        borderWidth: 1.5,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 72.0,
        iconColor: scheme.outline,
      ),

      // Extender styles - liquid level effect
      extenderNormalStyle: NodeStyle(
        backgroundColor: secondaryGlow,
        borderColor: scheme.secondary.withValues(alpha: 0.3),
        borderWidth: 1.5,
        borderRadius: 20.0,
        glowColor: secondaryGlow,
        glowRadius: 12.0,
        size: 56.0,
        iconColor: scheme.secondary,
      ),
      extenderHighLoadStyle: NodeStyle(
        backgroundColor:
            scheme.tertiary.withValues(alpha: isLight ? 0.25 : 0.35),
        borderColor: scheme.tertiary.withValues(alpha: 0.4),
        borderWidth: 2.0,
        borderRadius: 20.0,
        glowColor: scheme.tertiary.withValues(alpha: 0.35),
        glowRadius: 16.0,
        size: 56.0,
        iconColor: scheme.tertiary,
      ),
      extenderOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.08),
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 20.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 56.0,
        iconColor: scheme.outline,
      ),

      // Client styles - orbital satellites
      clientNormalStyle: NodeStyle(
        backgroundColor: surfaceColor,
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 32.0,
        iconColor: scheme.onSurface,
      ),
      clientOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.05),
        borderColor: scheme.outline.withValues(alpha: 0.15),
        borderWidth: 1.0,
        borderRadius: 999.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 32.0,
        iconColor: scheme.outline,
      ),

      // Link styles
      ethernetLinkStyle: LinkStyle(
        color: scheme.outline.withValues(alpha: 0.6),
        width: 2.0,
        dashPattern: null, // Solid line
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: Duration.zero,
      ),
      wifiStrongStyle: LinkStyle(
        color: successColor.withValues(alpha: 0.7),
        width: 2.0,
        dashPattern: const [8.0, 4.0],
        glowColor: successColor.withValues(alpha: 0.2),
        glowRadius: 4.0,
        animationDuration: const Duration(milliseconds: 1500),
      ),
      wifiMediumStyle: LinkStyle(
        color: warningColor.withValues(alpha: 0.7),
        width: 2.0,
        dashPattern: const [6.0, 4.0],
        glowColor: warningColor.withValues(alpha: 0.15),
        glowRadius: 3.0,
        animationDuration: const Duration(milliseconds: 2000),
      ),
      wifiWeakStyle: LinkStyle(
        color: errorColor.withValues(alpha: 0.7),
        width: 1.5,
        dashPattern: const [4.0, 4.0],
        glowColor: errorColor.withValues(alpha: 0.1),
        glowRadius: 2.0,
        animationDuration: const Duration(milliseconds: 2500),
      ),
      wifiUnknownStyle: LinkStyle(
        color: scheme.outline.withValues(alpha: 0.4),
        width: 1.5,
        dashPattern: const [4.0, 6.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 2000),
      ),

      // Layout
      nodeSpacing: 100.0,
      linkCurvature: 0.3,
      orbitRadius: 60.0,
      orbitSpeed: const Duration(seconds: 20),
    );
  }
}
