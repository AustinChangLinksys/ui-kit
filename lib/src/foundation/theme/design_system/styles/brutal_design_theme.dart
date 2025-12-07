import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/motion/brutal_motion.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';

class BrutalDesignTheme extends AppDesignTheme {
  // Factory 1: Create from Config
  factory BrutalDesignTheme.fromConfig(AppThemeConfig config) {
    final colors = AppColorFactory.generateBrutal(config);
    return BrutalDesignTheme._raw(colors);
  }

  // Factory 2: Raw Mode (AppColorScheme driven)
  factory BrutalDesignTheme._raw(AppColorScheme colors) {
    final isLight = colors.surface.computeLuminance() > 0.5;
    final bottomSheetOverlay = isLight
        ? colors.onSurface.withValues(alpha: 0.5)
        : colors.surface.withValues(alpha: 0.6);
    final sideSheetOverlay = isLight
        ? colors.onSurface.withValues(alpha: 0.6)
        : colors.surface.withValues(alpha: 0.6);

    return BrutalDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.highContrastBorder,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
        texture: AppTextureAssets.diagonalLines,
        textureOpacity: isLight ? 0.20 : 0.30,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: colors.surfaceContainer,
        borderColor: colors.highContrastBorder,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(8, 8),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: colors.error, // Brutal often uses error/warning colors for highlight or primary
        borderColor: colors.highContrastBorder,
        borderWidth: 3.0,
        borderRadius: 4.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onError,
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset(4, 4),
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: colors.surfaceContainerHighest,  // Solid color for better contrast in Brutal
        borderColor: colors.highContrastBorder,
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: colors.tertiary.withValues(alpha: 0.2),
        borderColor: colors.tertiary,
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: colors.tertiary,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.tertiary,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'I',
        inactiveText: 'O',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: colors.shadow.withValues(alpha: 0.15),
        highlightColor: colors.shadow.withValues(alpha: 0.3),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 0.0,
      ),
      inputStyle: InputStyle(
        outlineStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.highContrastBorder,
          contentColor: colors.onSurface,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: colors.styleShadow,
                offset: const Offset(4, 4),
                blurRadius: 0)
          ],
          blurStrength: 0.0,
        ),
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: colors.highContrastBorder,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: colors.highContrastBorder, width: 3.0)),
        ),
        filledStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 0,
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
        type: LoaderType.block,
        color: colors.primary,
        strokeWidth: 0,
        size: 32.0,
        period: const Duration(milliseconds: 800),
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
              color: colors.styleShadow, offset: const Offset(4, 4), blurRadius: 0),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        backgroundColor: colors.surface,
        textStyle: appTextTheme.titleMedium!.copyWith(color: colors.onSurface),
        displayDuration: const Duration(seconds: 2),
      ),
      dividerStyle: DividerStyle(
        color: colors.highContrastBorder,
        thickness: 3.0,
        pattern: DividerPattern.jagged,
        indent: 0.0,
        endIndent: 0.0,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.squareBlock,
        macAddressSeparator: '-',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
      buttonHeight: 56.0,
      navigationStyle: const NavigationStyle(
        height: 80.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 8.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 24.0,
        marginTablet: 48.0,
        marginDesktop: 120.0,
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.highContrastBorder,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: colors.highContrastBorder,
          thickness: 3.0,
          pattern: DividerPattern.solid,
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.highContrastBorder,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: colors.styleShadow,
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: colors.onSurface,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: colors.surface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: colors.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.highContrastBorder,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: colors.highContrastBorder,
              blurRadius: 0,
              offset: const Offset(6, 6),
            ),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        barrierColor: bottomSheetOverlay,
        barrierBlur: 0.0,
      ),
      motion: const BrutalMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: bottomSheetOverlay,
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.linear,
        topBorderRadius: 0.0,
        dragHandleHeight: 12.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: sideSheetOverlay,
        animationDuration: const Duration(milliseconds: 150),
        animationCurve: Curves.linear,
        blurStrength: 0.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: colors.onPrimary, // Assuming White/Black
        inactiveTextColor: colors.onSurface.withValues(alpha: 0.5),
        indicatorColor: colors.onPrimary,
        tabBackgroundColor: colors.primary, // Black tabs?
        animationDuration: const Duration(milliseconds: 150),
        indicatorThickness: 3.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: colors.primary,
        completedStepColor: colors.secondary,
        pendingStepColor: colors.surfaceContainerHighest,
        connectorColor: colors.outline,
        stepSize: 44.0,
        useDashedConnector: false,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: colors.primary,
        inactiveLinkColor: colors.onSurface.withValues(alpha: 0.5),
        separatorColor: colors.primary,
        separatorText: ' > ',
        itemTextStyle: appTextTheme.labelLarge!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: colors.surface,
        expandedBackgroundColor: colors.surfaceContainer,
        headerTextColor: colors.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 150),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: colors.onSurface,
        navButtonHoverColor: colors.outline,
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 150),
        animationCurve: Curves.linear,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: colors.surfaceContainer,
        unselectedText: colors.onSurface,
        selectedBackground: colors.primary,
        selectedText: colors.onPrimary,
        selectedBorderColor: colors.highContrastBorder,
        borderRadius: 4.0,
      ),
      tableStyle: TableStyle(
        headerBackground: colors.surface,
        rowBackground: colors.surface,
        gridColor: colors.highContrastBorder,
        gridWidth: 3.0,
        showVerticalGrid: true,
        cellPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 56.0,
        headerTextStyle: appTextTheme.titleMedium!.copyWith(color: colors.onSurface),
        cellTextStyle: appTextTheme.labelLarge!.copyWith(color: colors.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: colors.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 200),
      ),
      topologySpec: _buildTopologySpec(colors.toMaterialScheme(brightness: isLight ? Brightness.light : Brightness.dark), isLight: isLight),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainer,
          borderColor: colors.highContrastBorder,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: colors.styleShadow,
              blurRadius: 0,
              offset: const Offset(4, 4),
            )
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: colors.error,
          borderColor: colors.highContrastBorder,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: colors.styleShadow,
              blurRadius: 0,
              offset: const Offset(4, 4),
            )
          ],
          blurStrength: 0.0,
          contentColor: colors.onError,
        ),
        borderRadius: BorderRadius.zero, // Sharp corners
        contentColor: colors.onSurface,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 400), // Heavy Elastic
        animationCurve: Curves.elasticOut,
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.rectangle, // Or geometric mix
        distance: 80.0,
        type: FabAnimationType.spring, // Heavy bounce
        overlayColor: colors.scrim.withValues(alpha: 0.5), // High contrast
        enableBlur: false,
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: true,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid, // Solid stroke
        cap: GaugeCapType.butt, // Sharp cut-off
        trackColor: colors.highContrastBorder, // Thick outline
        indicatorColor: Colors.yellow, // Bold red for Brutal theme
        showTicks: false,
        strokeWidth: 20.0,
        enableGlow: false,
      ),
    );
  }

  // Private constructor, used to receive all properties and can be called by Factory
  const BrutalDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.surfaceSecondary,
    required super.surfaceTertiary,
    required super.toggleStyle,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
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

  factory BrutalDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final bottomSheetOverlay = scheme.onSurface.withValues(alpha: 0.5);
    final sideSheetOverlay = scheme.onSurface.withValues(alpha: 0.6);
    return BrutalDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface, // Use ColorScheme's surface
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface, // Use ColorScheme's onSurface as shadow
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
        texture: AppTextureAssets.diagonalLines,
        textureOpacity: 0.20, // Light mode: caution stripe visible but subtle
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor:
            scheme.primaryContainer, // Use ColorScheme's primaryContainer
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(8, 8),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onPrimaryContainer,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.error, // Use ColorScheme's error
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 4.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onError,
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset(4, 4),
        ),
      ),
      // Secondary (Tonal) Surface - Medium emphasis with mechanical aesthetic
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerHighest,  // Solid color for better contrast in Brutal
        borderColor: scheme.onSurface,
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      // Tertiary (Accent) Surface - Decorative with mechanical aesthetic
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: 0.2),
        borderColor: scheme.tertiary,
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.tertiary,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.tertiary,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'I',
        inactiveText: 'O',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.shadow.withValues(alpha: 0.15),
        highlightColor: scheme.shadow.withValues(alpha: 0.3),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 0.0,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          contentColor: scheme.onSurface,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: scheme.onSurface,
                offset: const Offset(4, 4),
                blurRadius: 0)
          ],
          blurStrength: 0.0,
        ),
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.onSurface,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: scheme.onSurface, width: 3.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
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
        type: LoaderType.block,
        color: scheme.primary,
        strokeWidth: 0,
        size: 32.0,
        period: const Duration(milliseconds: 800),
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
              color: scheme.onSurface, offset: const Offset(4, 4), blurRadius: 0),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        backgroundColor: scheme.surface,
        textStyle: appTextTheme.titleMedium!.copyWith(color: scheme.onSurface),
        displayDuration: const Duration(seconds: 2),
      ),
      dividerStyle: DividerStyle(
        color: scheme.onSurface,
        thickness: 3.0,
        pattern: DividerPattern.jagged,
        indent: 0.0,
        endIndent: 0.0,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.squareBlock,
        macAddressSeparator: '-',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
      buttonHeight: 56.0,
      navigationStyle: const NavigationStyle(
        height: 80.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 8.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 24.0,
        marginTablet: 48.0,
        marginDesktop: 120.0,
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),

      // Phase 2: Graceful defaults (Brutal Light)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.onSurface,
          thickness: 3.0,
          pattern: DividerPattern.solid,
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: scheme.onSurface,
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.onSurface,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.surface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: scheme.onSurface,
              blurRadius: 0,
              offset: const Offset(6, 6),
            ),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        barrierColor: scheme.onSurface.withValues(alpha: 0.5),
        barrierBlur: 0.0,
      ),
      motion: const BrutalMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: bottomSheetOverlay,
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.linear,
        topBorderRadius: 0.0,
        dragHandleHeight: 12.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: sideSheetOverlay,
        animationDuration: const Duration(milliseconds: 150),
        animationCurve: Curves.linear,
        blurStrength: 0.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: scheme.onPrimary,
        inactiveTextColor: scheme.onSurface.withValues(alpha: 0.6),
        indicatorColor: scheme.onPrimary,
        tabBackgroundColor: scheme.primary,
        animationDuration: const Duration(milliseconds: 150),
        indicatorThickness: 3.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: scheme.primary,
        completedStepColor: scheme.secondary,
        pendingStepColor: scheme.surfaceContainerHighest,
        connectorColor: scheme.outline,
        stepSize: 44.0,
        useDashedConnector: false,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: scheme.primary,
        inactiveLinkColor: scheme.onSurface.withValues(alpha: 0.5),
        separatorColor: scheme.primary,
        separatorText: ' > ',
        itemTextStyle: appTextTheme.labelLarge!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surface,
        expandedBackgroundColor: scheme.surfaceContainer,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 150),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: scheme.onSurface,
        navButtonHoverColor: scheme.outline,
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 150),
        animationCurve: Curves.linear,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: scheme.surfaceContainer,
        unselectedText: scheme.onSurface,
        selectedBackground: scheme.primary,
        selectedText: scheme.onPrimary,
        selectedBorderColor: scheme.primary,
        borderRadius: 4.0,
      ),
      tableStyle: TableStyle(
        headerBackground: scheme.surface,
        rowBackground: scheme.surface,
        gridColor: scheme.onSurface,
        gridWidth: 3.0,
        showVerticalGrid: true,
        cellPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 56.0,
        headerTextStyle: appTextTheme.titleMedium!.copyWith(color: scheme.onSurface),
        cellTextStyle: appTextTheme.labelLarge!.copyWith(color: scheme.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: scheme.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 200),
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: true),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainer,
          borderColor: scheme.onSurface,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: scheme.onSurface,
              blurRadius: 0,
              offset: const Offset(4, 4),
            )
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: scheme.error,
          borderColor: scheme.onSurface,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: scheme.onSurface,
              blurRadius: 0,
              offset: const Offset(4, 4),
            )
          ],
          blurStrength: 0.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.zero,
        contentColor: scheme.onSurface,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.elasticOut,
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.rectangle,
        distance: 80.0,
        type: FabAnimationType.spring,
        overlayColor: scheme.scrim.withValues(alpha: 0.5),
        enableBlur: false,
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: true,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid,
        cap: GaugeCapType.butt,
        trackColor: scheme.onSurface,
        indicatorColor: Colors.yellow,
        showTicks: false,
        strokeWidth: 20.0,
        enableGlow: false,
      ),
    );
  }

  factory BrutalDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final black = scheme.onSurface;
    final bottomSheetOverlay = scheme.surface.withValues(alpha: 0.6);
    final sideSheetOverlay = scheme.surface.withValues(alpha: 0.6);

    return BrutalDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
        texture: AppTextureAssets.diagonalLines,
        textureOpacity: 0.30, // Dark mode: caution stripe more prominent
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor:
            scheme.primaryContainer, // Use ColorScheme's primaryContainer
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(8, 8),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onPrimaryContainer,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.error, // Use ColorScheme's error
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 4.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onError,
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset(4, 4),
        ),
      ),
      // Secondary (Tonal) Surface - Medium emphasis with mechanical aesthetic (Dark mode)
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerHighest,  // Solid color for better contrast in Brutal
        borderColor: scheme.outline,
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.4),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      // Tertiary (Accent) Surface - Decorative with mechanical aesthetic (Dark mode)
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: 0.25),
        borderColor: scheme.tertiary.withValues(alpha: 0.6),
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.tertiary.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.tertiary,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'I',
        inactiveText: 'O',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.onSurface.withValues(alpha: 0.1),
        highlightColor: scheme.onSurface.withValues(alpha: 0.4),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 0.0,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          contentColor: black,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(color: black, offset: const Offset(4, 4), blurRadius: 0)
          ],
          blurStrength: 0.0,
        ),
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: black,
          contentColor: black,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder: Border(bottom: BorderSide(color: black, width: 3.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: black,
          borderWidth: 0,
          borderRadius: 0,
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
        type: LoaderType.block,
        color: scheme.primary,
        strokeWidth: 0,
        size: 32.0,
        period: const Duration(milliseconds: 800),
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
              color: scheme.onSurface, offset: const Offset(4, 4), blurRadius: 0),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        backgroundColor: scheme.surface,
        textStyle: appTextTheme.titleMedium!.copyWith(color: scheme.onSurface),
        displayDuration: const Duration(seconds: 2),
      ),
      dividerStyle: DividerStyle(
        color: scheme.onSurface,
        thickness: 3.0,
        pattern: DividerPattern.jagged,
        indent: 0.0,
        endIndent: 0.0,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.squareBlock,
        macAddressSeparator: '-',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
      buttonHeight: 56.0,
      navigationStyle: const NavigationStyle(
        height: 80.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 8.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 24.0,
        marginTablet: 48.0,
        marginDesktop: 120.0,
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),

      // Phase 2: Graceful defaults (Brutal Dark)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: black,
        ),
        dividerStyle: DividerStyle(
          color: black,
          thickness: 3.0,
          pattern: DividerPattern.solid,
        ),
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: black,
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: black,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: black,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: black,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.surface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: black,
              blurRadius: 0,
              offset: const Offset(6, 6),
            ),
          ],
          blurStrength: 0.0,
          contentColor: black,
        ),
        barrierColor: scheme.scrim.withValues(alpha: 0.6),
        barrierBlur: 0.0,
      ),
      motion: const BrutalMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: bottomSheetOverlay,
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.linear,
        topBorderRadius: 0.0,
        dragHandleHeight: 12.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 280.0,
        overlayColor: sideSheetOverlay,
        animationDuration: const Duration(milliseconds: 150),
        animationCurve: Curves.linear,
        blurStrength: 0.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: scheme.onPrimary,
        inactiveTextColor: scheme.onSurface.withValues(alpha: 0.6),
        indicatorColor: scheme.onPrimary,
        tabBackgroundColor: scheme.primary,
        animationDuration: const Duration(milliseconds: 150),
        indicatorThickness: 3.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: scheme.primary,
        completedStepColor: scheme.secondary,
        pendingStepColor: scheme.surfaceContainerHighest,
        connectorColor: scheme.outline,
        stepSize: 44.0,
        useDashedConnector: false,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: scheme.primary,
        inactiveLinkColor: scheme.onSurface.withValues(alpha: 0.5),
        separatorColor: scheme.primary,
        separatorText: ' > ',
        itemTextStyle: appTextTheme.labelLarge!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surface,
        expandedBackgroundColor: scheme.surfaceContainer,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 150),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: scheme.onSurface,
        navButtonHoverColor: scheme.outline,
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 150),
        animationCurve: Curves.linear,
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: scheme.surfaceContainer,
        unselectedText: scheme.onSurface,
        selectedBackground: scheme.primary,
        selectedText: scheme.onPrimary,
        selectedBorderColor: scheme.primary,
        borderRadius: 4.0,
      ),
      tableStyle: TableStyle(
        headerBackground: scheme.surface,
        rowBackground: scheme.surface,
        gridColor: black,
        gridWidth: 3.0,
        showVerticalGrid: true,
        cellPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 56.0,
        headerTextStyle: appTextTheme.titleMedium!.copyWith(color: black),
        cellTextStyle: appTextTheme.labelLarge!.copyWith(color: black),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: scheme.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransitionDuration: const Duration(milliseconds: 200),
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: false),
      slideActionStyle: SlideActionStyle(
        standardStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainer,
          borderColor: black,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: black,
              blurRadius: 0,
              offset: const Offset(4, 4),
            )
          ],
          blurStrength: 0.0,
          contentColor: black,
        ),
        destructiveStyle: SurfaceStyle(
          backgroundColor: scheme.error,
          borderColor: black,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
              color: black,
              blurRadius: 0,
              offset: const Offset(4, 4),
            )
          ],
          blurStrength: 0.0,
          contentColor: scheme.onError,
        ),
        borderRadius: BorderRadius.zero,
        contentColor: black,
        iconSize: 24.0,
        animationDuration: const Duration(milliseconds: 400),
        animationCurve: Curves.elasticOut,
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.rectangle,
        distance: 80.0,
        type: FabAnimationType.spring,
        overlayColor: scheme.scrim.withValues(alpha: 0.5),
        enableBlur: false,
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: true,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid,
        cap: GaugeCapType.butt,
        trackColor: scheme.onSurface,
        indicatorColor: Colors.yellow,
        showTicks: false,
        strokeWidth: 20.0,
        enableGlow: false,
      ),
    );
  }

  /// Builds topology spec for Brutal theme with mechanical, industrial aesthetic.
  static TopologySpec _buildTopologySpec(ColorScheme scheme, {required bool isLight}) {
    final borderColor = scheme.onSurface;
    final errorColor = scheme.error;

    return TopologySpec(
      // Gateway styles - mechanical hub
      gatewayNormalStyle: NodeStyle(
        backgroundColor: scheme.surface,
        borderColor: borderColor,
        borderWidth: 3.0,
        borderRadius: 0.0, // Sharp corners
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 72.0,
        iconColor: borderColor,
      ),
      gatewayHighLoadStyle: NodeStyle(
        backgroundColor: errorColor,
        borderColor: borderColor,
        borderWidth: 3.0,
        borderRadius: 0.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 72.0,
        iconColor: scheme.onError,
      ),
      gatewayOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.3),
        borderColor: scheme.outline,
        borderWidth: 2.0,
        borderRadius: 0.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 72.0,
        iconColor: scheme.outline,
      ),

      // Extender styles - industrial nodes
      extenderNormalStyle: NodeStyle(
        backgroundColor: scheme.primaryContainer,
        borderColor: borderColor,
        borderWidth: 3.0,
        borderRadius: 0.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 56.0,
        iconColor: scheme.onPrimaryContainer,
      ),
      extenderHighLoadStyle: NodeStyle(
        backgroundColor: errorColor.withValues(alpha: 0.8),
        borderColor: borderColor,
        borderWidth: 3.0,
        borderRadius: 0.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 56.0,
        iconColor: scheme.onError,
      ),
      extenderOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.2),
        borderColor: scheme.outline,
        borderWidth: 2.0,
        borderRadius: 0.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 56.0,
        iconColor: scheme.outline,
      ),

      // Client styles - compact terminals
      clientNormalStyle: NodeStyle(
        backgroundColor: scheme.surface,
        borderColor: borderColor,
        borderWidth: 2.0,
        borderRadius: 0.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 32.0,
        iconColor: borderColor,
      ),
      clientOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.15),
        borderColor: scheme.outline,
        borderWidth: 1.5,
        borderRadius: 0.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 32.0,
        iconColor: scheme.outline,
      ),

      // Link styles - industrial connections
      ethernetLinkStyle: LinkStyle(
        color: borderColor,
        width: 3.0,
        dashPattern: null,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: Duration.zero,
      ),
      wifiStrongStyle: LinkStyle(
        color: scheme.tertiary,
        width: 3.0,
        dashPattern: const [8.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 800),
      ),
      wifiMediumStyle: LinkStyle(
        color: scheme.secondary,
        width: 3.0,
        dashPattern: const [6.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 1000),
      ),
      wifiWeakStyle: LinkStyle(
        color: errorColor,
        width: 2.0,
        dashPattern: const [4.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 1200),
      ),
      wifiUnknownStyle: LinkStyle(
        color: scheme.outline,
        width: 2.0,
        dashPattern: const [4.0, 6.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 1000),
      ),

      // Layout - grid-based
      nodeSpacing: 120.0,
      linkCurvature: 0.0, // Straight lines
      orbitRadius: 70.0,
      orbitSpeed: const Duration(seconds: 15),
    );
  }
}
