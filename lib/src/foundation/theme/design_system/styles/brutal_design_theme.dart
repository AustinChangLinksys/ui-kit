import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/motion/brutal_motion.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/password_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/pin_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/range_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart'
    as shared;
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/styled_text_style.dart';
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
        backgroundColor: colors
            .error, // Brutal often uses error/warning colors for highlight or primary
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
        backgroundColor: colors
            .surfaceContainerHighest, // Solid color for better contrast in Brutal
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
        animation: AnimationSpec.fast,
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
          customBorder: Border(
              bottom: BorderSide(color: colors.highContrastBorder, width: 3.0)),
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
              color: colors.styleShadow,
              offset: const Offset(4, 4),
              blurRadius: 0),
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
      navigationStyle: NavigationStyle(
        height: 80.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 8.0,
        animation: AnimationSpec.fast,
        itemColors: StateColorSpec(
          active: colors.onSurface,
          inactive: colors.onSurface.withValues(alpha: 0.5),
        ),
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
        overlay: OverlaySpec(
          scrimColor: isLight
              ? colors.onSurface.withValues(alpha: 0.5)
              : colors.surface.withValues(alpha: 0.6),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
      ),
      motion: const BrutalMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 0.0, // Brutal has sharp corners
        width: 280.0,
        dragHandleHeight: 6.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: colors.onPrimary, // Assuming White/Black
          inactive: colors.onSurface.withValues(alpha: 0.5),
        ),
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
        animation: AnimationSpec.fast,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.onSurface.withValues(alpha: 0.5),
        ),
        separatorColor: colors.primary,
        separatorText: ' > ',
        itemTextStyle: appTextTheme.labelLarge!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: colors.surface,
        expandedBackgroundColor: colors.surfaceContainer,
        headerTextColor: colors.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 150), curve: Curves.easeInOut),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.primary,
          hover: colors.primary.withValues(alpha: 0.8),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 150), curve: Curves.easeOut),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: colors.primary,
          inactive: colors.surfaceContainer,
        ),
        textColors: StateColorSpec(
          active: colors.onPrimary,
          inactive: colors.onSurface,
        ),
        selectedBorderColor: colors.highContrastBorder,
        borderRadius: 4.0,
      ),
      tableStyle: TableStyle(
        headerBackground: colors.surface,
        rowBackground: colors.surface,
        gridColor: colors.highContrastBorder,
        gridWidth: 3.0,
        showVerticalGrid: true,
        cellPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 56.0,
        headerTextStyle:
            appTextTheme.titleMedium!.copyWith(color: colors.onSurface),
        cellTextStyle:
            appTextTheme.labelLarge!.copyWith(color: colors.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: colors.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransition: const shared.AnimationSpec(
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut),
      ),
      topologySpec: _buildTopologySpec(
          colors.toMaterialScheme(
              brightness: isLight ? Brightness.light : Brightness.dark),
          isLight: isLight),
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
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 400), curve: Curves.elasticOut),
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.rectangle, // Or geometric mix
        distance: 80.0,
        type: FabAnimationType.spring, // Heavy bounce
        overlay: OverlaySpec(
          scrimColor: colors.scrim.withValues(alpha: 0.5),
          blurStrength: 0.0,
          animation: const shared.AnimationSpec(
              duration: Duration(milliseconds: 200), curve: Curves.easeOut),
        ),
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: true,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid, // Solid stroke
        cap: GaugeCapType.butt, // Sharp cut-off
        trackColor: colors.highContrastBorder, // Thick outline
        indicatorColor: colors.tertiary, // Bold accent for Brutal theme
        showTicks: false,
        strokeWidth: 20.0,
        enableGlow: false,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 100), curve: Curves.linear),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false,
        customSeparator: null,
        activeBorderColor: colors.highContrastBorder,
        spacing: 8.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.box,
        fillOnInput: true,
        glowOnActive: false,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: colors.onSurface),
        cellSpacing: 8.0,
        cellSize: 56.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_box,
        pendingIcon: Icons.check_box_outline_blank,
        ruleTextStyle: appTextTheme.bodySmall!
            .copyWith(fontWeight: FontWeight.bold, color: colors.onSurface),
        showRuleListBackground: false,
        validColor: colors.onSurface,
        pendingColor: colors.onSurface.withValues(alpha: 0.5),
      ),
      styledTextStyle: _createBrutalStyledTextStyle(colors, appTextTheme),
      buttonStyle: _createBrutalAppButtonStyle(colors, appTextTheme),
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
  });

  // Helper function to intensify colors for Brutal theme
  static Color _intensifyColor(Color baseColor, {required bool isDark}) {
    final hsl = HSLColor.fromColor(baseColor);
    if (isDark) {
      // For dark mode: increase saturation and lightness for more vibrant colors
      return hsl.withSaturation((hsl.saturation * 1.4).clamp(0.0, 1.0))
                .withLightness((hsl.lightness * 1.2).clamp(0.0, 1.0))
                .toColor();
    } else {
      // For light mode: increase saturation and slightly decrease lightness for intensity
      return hsl.withSaturation((hsl.saturation * 1.5).clamp(0.0, 1.0))
                .withLightness((hsl.lightness * 0.8).clamp(0.0, 1.0))
                .toColor();
    }
  }

  // Helper function to get contrasting text color
  static Color _getContrastingTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  factory BrutalDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
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
        backgroundColor: _intensifyColor(scheme.primary, isDark: scheme.brightness == Brightness.dark), // Intensified primary for more brutal contrast
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
        contentColor: _getContrastingTextColor(_intensifyColor(scheme.primary, isDark: scheme.brightness == Brightness.dark)),
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset(4, 4),
        ),
      ),
      // Secondary (Tonal) Surface - Medium emphasis with mechanical aesthetic
      surfaceSecondary: SurfaceStyle(
        backgroundColor: _intensifyColor(scheme.secondary, isDark: scheme.brightness == Brightness.dark), // Intensified secondary for brutal contrast
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
        contentColor: _getContrastingTextColor(_intensifyColor(scheme.secondary, isDark: scheme.brightness == Brightness.dark)),
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
        animation: AnimationSpec.fast,
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
              color: scheme.onSurface,
              offset: const Offset(4, 4),
              blurRadius: 0),
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
      navigationStyle: NavigationStyle(
        height: 80.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 8.0,
        animation: AnimationSpec.fast,
        itemColors: StateColorSpec(
          active: scheme.onSurface,
          inactive: scheme.onSurface.withValues(alpha: 0.5),
        ),
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
        overlay: OverlaySpec(
          scrimColor: scheme.onSurface.withValues(alpha: 0.5),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
      ),
      motion: const BrutalMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 0.0, // Brutal has sharp corners
        width: 280.0,
        dragHandleHeight: 6.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: scheme.onPrimary,
          inactive: scheme.onSurface.withValues(alpha: 0.6),
        ),
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
        animation: AnimationSpec.fast,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurface.withValues(alpha: 0.5),
        ),
        separatorColor: scheme.primary,
        separatorText: ' > ',
        itemTextStyle: appTextTheme.labelLarge!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surface,
        expandedBackgroundColor: scheme.surfaceContainer,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 150), curve: Curves.easeInOut),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.primary,
          hover: scheme.primary.withValues(alpha: 0.8),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 150), curve: Curves.easeOut),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.surfaceContainer,
        ),
        textColors: StateColorSpec(
          active: scheme.onPrimary,
          inactive: scheme.onSurface,
        ),
        selectedBorderColor: scheme.primary,
        borderRadius: 4.0,
      ),
      tableStyle: TableStyle(
        headerBackground: scheme.surface,
        rowBackground: scheme.surface,
        gridColor: scheme.onSurface,
        gridWidth: 3.0,
        showVerticalGrid: true,
        cellPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 56.0,
        headerTextStyle:
            appTextTheme.titleMedium!.copyWith(color: scheme.onSurface),
        cellTextStyle:
            appTextTheme.labelLarge!.copyWith(color: scheme.onSurface),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: scheme.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransition: const shared.AnimationSpec(
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut),
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
          contentColor: _getContrastingTextColor(_intensifyColor(scheme.primary, isDark: scheme.brightness == Brightness.dark)),
        ),
        borderRadius: BorderRadius.zero,
        contentColor: scheme.onSurface,
        iconSize: 24.0,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 400), curve: Curves.elasticOut),
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.rectangle,
        distance: 80.0,
        type: FabAnimationType.spring,
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.5),
          blurStrength: 0.0,
          animation: const shared.AnimationSpec(
              duration: Duration(milliseconds: 200), curve: Curves.easeOut),
        ),
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: true,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid,
        cap: GaugeCapType.butt,
        trackColor: scheme.onSurface,
        indicatorColor: scheme.tertiary, // Bold accent for Brutal theme
        showTicks: false,
        strokeWidth: 20.0,
        enableGlow: false,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 100), curve: Curves.linear),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false,
        customSeparator: null,
        activeBorderColor: scheme.onSurface,
        spacing: 8.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.box,
        fillOnInput: true,
        glowOnActive: false,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: scheme.onSurface),
        cellSpacing: 8.0,
        cellSize: 56.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_box,
        pendingIcon: Icons.check_box_outline_blank,
        ruleTextStyle: appTextTheme.bodySmall!
            .copyWith(fontWeight: FontWeight.bold, color: scheme.onSurface),
        showRuleListBackground: false,
        validColor: scheme.onSurface,
        pendingColor: scheme.onSurface.withValues(alpha: 0.5),
      ),
      styledTextStyle:
          _createBrutalStyledTextStyleForScheme(scheme, appTextTheme),
      buttonStyle: _createBrutalAppButtonStyleForScheme(scheme, appTextTheme),
    );
  }

  factory BrutalDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final black = scheme.onSurface;

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
        backgroundColor: _intensifyColor(scheme.primary, isDark: scheme.brightness == Brightness.dark), // Intensified primary for more brutal contrast
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
        contentColor: _getContrastingTextColor(_intensifyColor(scheme.primary, isDark: scheme.brightness == Brightness.dark)),
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset(4, 4),
        ),
      ),
      // Secondary (Tonal) Surface - Medium emphasis with mechanical aesthetic (Dark mode)
      surfaceSecondary: SurfaceStyle(
        backgroundColor: _intensifyColor(scheme.secondary, isDark: scheme.brightness == Brightness.dark), // Intensified secondary for brutal contrast
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
        contentColor: _getContrastingTextColor(_intensifyColor(scheme.secondary, isDark: scheme.brightness == Brightness.dark)),
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
        animation: AnimationSpec.fast,
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
              color: scheme.onSurface,
              offset: const Offset(4, 4),
              blurRadius: 0),
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
      navigationStyle: NavigationStyle(
        height: 80.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 8.0,
        animation: AnimationSpec.fast,
        itemColors: StateColorSpec(
          active: scheme.onSurface,
          inactive: scheme.onSurface.withValues(alpha: 0.5),
        ),
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
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.6),
          blurStrength: 0.0,
          animation: shared.AnimationSpec.standard,
        ),
      ),
      motion: const BrutalMotion(),
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,
      sheetStyle: const SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 0.0, // Brutal has sharp corners
        width: 280.0,
        dragHandleHeight: 6.0,
        enableDithering: false,
      ),
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: scheme.onPrimary,
          inactive: scheme.onSurface.withValues(alpha: 0.6),
        ),
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
        animation: AnimationSpec.fast,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        linkColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurface.withValues(alpha: 0.5),
        ),
        separatorColor: scheme.primary,
        separatorText: ' > ',
        itemTextStyle: appTextTheme.labelLarge!,
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: scheme.surface,
        expandedBackgroundColor: scheme.surfaceContainer,
        headerTextColor: scheme.onSurface,
        expandIcon: Icons.expand_more,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 150), curve: Curves.easeInOut),
      ),
      carouselStyle: CarouselStyle(
        navButtonColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.primary,
          hover: scheme.primary.withValues(alpha: 0.8),
        ),
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 150), curve: Curves.easeOut),
        useSnapScroll: false,
        navButtonSize: 48.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        backgroundColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.surfaceContainer,
        ),
        textColors: StateColorSpec(
          active: scheme.onPrimary,
          inactive: scheme.onSurface,
        ),
        selectedBorderColor: scheme.primary,
        borderRadius: 4.0,
      ),
      tableStyle: TableStyle(
        headerBackground: scheme.surface,
        rowBackground: scheme.surface,
        gridColor: black,
        gridWidth: 3.0,
        showVerticalGrid: true,
        cellPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        rowHeight: 56.0,
        headerTextStyle: appTextTheme.titleMedium!.copyWith(color: black),
        cellTextStyle: appTextTheme.labelLarge!.copyWith(color: black),
        invertRowOnHover: false,
        glowRowOnHover: false,
        hoverRowBackground: scheme.surfaceContainerHighest,
        hoverRowContentColor: null,
        modeTransition: const shared.AnimationSpec(
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut),
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
          contentColor: _getContrastingTextColor(_intensifyColor(scheme.primary, isDark: scheme.brightness == Brightness.dark)),
        ),
        borderRadius: BorderRadius.zero,
        contentColor: black,
        iconSize: 24.0,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 400), curve: Curves.elasticOut),
      ),
      expandableFabStyle: ExpandableFabStyle(
        shape: BoxShape.rectangle,
        distance: 80.0,
        type: FabAnimationType.spring,
        overlay: OverlaySpec(
          scrimColor: scheme.scrim.withValues(alpha: 0.5),
          blurStrength: 0.0,
          animation: const shared.AnimationSpec(
              duration: Duration(milliseconds: 200), curve: Curves.easeOut),
        ),
        showDitherPattern: false,
        glowEffect: false,
        highContrastBorder: true,
      ),
      gaugeStyle: GaugeStyle(
        type: GaugeRenderType.solid,
        cap: GaugeCapType.butt,
        trackColor: black,
        indicatorColor: scheme.tertiary, // Bold accent for Brutal theme
        showTicks: false,
        strokeWidth: 20.0,
        enableGlow: false,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 100), curve: Curves.linear),
      ),
      rangeInputStyle: RangeInputStyle(
        mergeContainers: false,
        customSeparator: null,
        activeBorderColor: black,
        spacing: 8.0,
      ),
      pinInputStyle: PinInputStyle(
        cellShape: PinCellShape.box,
        fillOnInput: true,
        glowOnActive: false,
        textStyle:
            appTextTheme.headlineMedium!.copyWith(color: scheme.onSurface),
        cellSpacing: 8.0,
        cellSize: 56.0,
      ),
      passwordInputStyle: PasswordInputStyle(
        validIcon: Icons.check_box,
        pendingIcon: Icons.check_box_outline_blank,
        ruleTextStyle: appTextTheme.bodySmall!
            .copyWith(fontWeight: FontWeight.bold, color: black),
        showRuleListBackground: false,
        validColor: black,
        pendingColor: black.withValues(alpha: 0.5),
      ),
      styledTextStyle:
          _createBrutalStyledTextStyleForDark(scheme, appTextTheme),
      buttonStyle: _createBrutalAppButtonStyleForScheme(scheme, appTextTheme),
    );
  }

  /// Builds topology spec for Brutal theme with mechanical, industrial aesthetic.
  static TopologySpec _buildTopologySpec(ColorScheme scheme,
      {required bool isLight}) {
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
        animation: const shared.AnimationSpec(
            duration: Duration.zero, curve: Curves.linear),
      ),
      wifiStrongStyle: LinkStyle(
        color: scheme.tertiary,
        width: 3.0,
        dashPattern: const [8.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 800), curve: Curves.linear),
      ),
      wifiMediumStyle: LinkStyle(
        color: scheme.secondary,
        width: 3.0,
        dashPattern: const [6.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 1000), curve: Curves.linear),
      ),
      wifiWeakStyle: LinkStyle(
        color: errorColor,
        width: 2.0,
        dashPattern: const [4.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 1200), curve: Curves.linear),
      ),
      wifiUnknownStyle: LinkStyle(
        color: scheme.outline,
        width: 2.0,
        dashPattern: const [4.0, 6.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animation: const shared.AnimationSpec(
            duration: Duration(milliseconds: 1000), curve: Curves.linear),
      ),

      // Layout - grid-based
      nodeSpacing: 120.0,
      linkCurvature: 0.0, // Straight lines
      orbitRadius: 70.0,
      orbitSpeed: const Duration(seconds: 15),

      // View transition animation - quick, sharp timing for Brutal theme
      viewTransition: const shared.AnimationSpec(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      ),
    );
  }

  /// Creates StyledTextStyle for Brutal theme with AppColorScheme (fromConfig factory)
  /// Brutal theme: Bold borders, solid colors, high contrast
  static StyledTextStyle _createBrutalStyledTextStyle(
    AppColorScheme colors,
    TextTheme textTheme,
  ) {
    return StyledTextStyle(
      baseTextStyle: textTheme.bodyMedium!.copyWith(
        color: colors.onSurface,
        fontWeight: FontWeight.w500, // Slightly bolder for Brutal theme
      ),
      linkColors: StateColorSpec(
        active: colors.onSurface,
        inactive: colors.onSurface,
        hover: colors.onSurface,
        pressed: colors.onSurface,
      ),
      linkAnimation: const shared.AnimationSpec(
        duration:
            Duration(milliseconds: 150), // Brutal theme snappy transitions
        curve: Curves.easeOut,
      ),
      largeTextStyle: textTheme.titleMedium!.copyWith(
        color: colors.onSurface,
        fontWeight: FontWeight.bold, // Extra bold for large text
      ),
      smallTextStyle: textTheme.bodySmall!.copyWith(
        color: colors.onSurface,
        fontWeight: FontWeight.w600, // Bold small text for high contrast
      ),
      boldTextStyle: textTheme.labelLarge!.copyWith(
        color: colors.onSurface,
        fontWeight: FontWeight.w900, // Ultra bold
      ),
      italicTextStyle: textTheme.bodyMedium!.copyWith(
        color: colors.onSurface,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
      underlineTextStyle: textTheme.bodyMedium!.copyWith(
        color: colors.onSurface,
        decoration: TextDecoration.underline,
        decorationThickness: 2.0, // Thick underline for Brutal theme
        fontWeight: FontWeight.w500,
      ),
      colorTextStyle: textTheme.bodyMedium!.copyWith(
        color: colors.primary,
        fontWeight: FontWeight.w600,
      ),
      linkDecoration: TextDecoration.none,
      linkDecorationThickness: 0.0,
      // Brutal theme special effect: solid background color for links
      linkBackgroundColor: colors.primary,
    );
  }

  /// Creates StyledTextStyle for Brutal theme with ColorScheme (light factory)
  static StyledTextStyle _createBrutalStyledTextStyleForScheme(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    return StyledTextStyle(
      baseTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      linkColors: StateColorSpec(
        active: scheme.onSurface,
        inactive: scheme.onSurface,
        hover: scheme.onSurface,
        pressed: scheme.onSurface,
      ),
      linkAnimation: const shared.AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
      ),
      largeTextStyle: textTheme.titleMedium!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      smallTextStyle: textTheme.bodySmall!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      boldTextStyle: textTheme.labelLarge!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w900,
      ),
      italicTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
      underlineTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        decoration: TextDecoration.underline,
        decorationThickness: 2.0,
        fontWeight: FontWeight.w500,
      ),
      colorTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.primary,
        fontWeight: FontWeight.w600,
      ),
      linkDecoration: TextDecoration.none,
      linkDecorationThickness: 0.0,
      linkBackgroundColor: scheme.primary,
    );
  }

  /// Creates StyledTextStyle for Brutal theme dark mode
  static StyledTextStyle _createBrutalStyledTextStyleForDark(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    return StyledTextStyle(
      baseTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      linkColors: StateColorSpec(
        active: scheme.onSurface,
        inactive: scheme.onSurface,
        hover: scheme.onSurface,
        pressed: scheme.onSurface,
      ),
      linkAnimation: const shared.AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
      ),
      largeTextStyle: textTheme.titleMedium!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      smallTextStyle: textTheme.bodySmall!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      boldTextStyle: textTheme.labelLarge!.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w900,
      ),
      italicTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
      underlineTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.onSurface,
        decoration: TextDecoration.underline,
        decorationThickness: 2.0,
        fontWeight: FontWeight.w500,
      ),
      colorTextStyle: textTheme.bodyMedium!.copyWith(
        color: scheme.primary,
        fontWeight: FontWeight.w600,
      ),
      linkDecoration: TextDecoration.none,
      linkDecorationThickness: 0.0,
      linkBackgroundColor: scheme.primary,
    );
  }

  /// Creates unified AppButtonStyle for Brutal theme with AppColorScheme
  /// Brutal characteristics: Sharp corners (0.0 radius), bold borders (3.0 width),
  /// high contrast colors, block shadows with no blur, diagonal line textures
  static AppButtonStyle _createBrutalAppButtonStyle(
    AppColorScheme colors,
    TextTheme textTheme,
  ) {
    // Create brutal-themed surface styles with sharp edges and block shadows
    final filledSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: colors.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0, // Sharp corners
        blurStrength: 0.0,
        contentColor: colors.onPrimary,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0, // No blur for block shadow
            offset: const Offset(4, 4),
          ),
        ],
        texture: AppTextureAssets.diagonalLines,
        textureOpacity: 0.15,
      ),
      disabled: SurfaceStyle(
        backgroundColor: colors.onSurface.withValues(alpha: 0.12),
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.onSurface.withValues(alpha: 0.38),
      ),
      hovered: SurfaceStyle(
        backgroundColor: colors.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.onPrimary,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(6, 6), // Larger shadow on hover
          ),
        ],
        texture: AppTextureAssets.diagonalLines,
        textureOpacity: 0.2,
      ),
      pressed: SurfaceStyle(
        backgroundColor: colors.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.onPrimary,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(2, 2), // Smaller shadow when pressed
          ),
        ],
        texture: AppTextureAssets.diagonalLines,
        textureOpacity: 0.25,
      ),
    );

    final outlineSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: colors.primary,
        borderWidth: 3.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.primary,
      ),
      disabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: colors.primary.withValues(alpha: 0.38),
        borderWidth: 3.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.primary.withValues(alpha: 0.38),
      ),
      hovered: SurfaceStyle(
        backgroundColor: colors.primary.withValues(alpha: 0.08),
        borderColor: colors.primary,
        borderWidth: 4.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.primary,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      pressed: SurfaceStyle(
        backgroundColor: colors.primary.withValues(alpha: 0.16),
        borderColor: colors.primary,
        borderWidth: 3.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.primary,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );

    final textSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.primary,
      ),
      disabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.primary.withValues(alpha: 0.38),
      ),
      hovered: SurfaceStyle(
        backgroundColor: colors.primary.withValues(alpha: 0.08),
        borderColor: colors.highContrastBorder,
        borderWidth: 2.0, // Show border on hover for brutal effect
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.primary,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      pressed: SurfaceStyle(
        backgroundColor: colors.primary.withValues(alpha: 0.16),
        borderColor: colors.highContrastBorder,
        borderWidth: 3.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: colors.primary,
        shadows: [
          BoxShadow(
            color: colors.styleShadow,
            blurRadius: 0,
            offset: const Offset(4, 4),
          ),
        ],
      ),
    );

    // Create color specs
    final filledContentColors = StateColorSpec(
      active: colors.onPrimary,
      inactive: colors.onPrimary.withValues(alpha: 0.8),
      disabled: colors.onSurface.withValues(alpha: 0.38),
      hover: colors.onPrimary,
      pressed: colors.onPrimary,
    );

    final outlineContentColors = StateColorSpec(
      active: colors.primary,
      inactive: colors.primary.withValues(alpha: 0.8),
      disabled: colors.primary.withValues(alpha: 0.38),
      hover: colors.primary,
      pressed: colors.primary,
    );

    final textContentColors = StateColorSpec(
      active: colors.primary,
      inactive: colors.primary.withValues(alpha: 0.8),
      disabled: colors.primary.withValues(alpha: 0.38),
      hover: colors.primary,
      pressed: colors.primary,
    );

    // Create text styles with bold weight for brutal theme
    final textStyles = ButtonTextStyles(
      small: textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w800, // Extra bold for brutal theme
        color: colors.primary,
      ),
      medium: textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w800,
        color: colors.primary,
      ),
      large: textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w800,
        color: colors.primary,
      ),
    );

    // Create size spec with brutal proportions
    const sizeSpec = ButtonSizeSpec(
      smallHeight: 36.0, // Slightly taller for brutal impact
      mediumHeight: 52.0,
      largeHeight: 64.0,
      smallPadding: EdgeInsets.symmetric(horizontal: 20.0),
      mediumPadding: EdgeInsets.symmetric(horizontal: 28.0),
      largePadding: EdgeInsets.symmetric(horizontal: 36.0),
      iconSpacing: 12.0, // More spacing for brutal aesthetic
    );

    // Create interaction spec with brutal animations
    const interaction = InteractionSpec(
      pressedScale: 1.0, // No scale - brutal buttons don't shrink
      hoverOpacity: 1.0, // No opacity changes - harsh and direct
      pressedOpacity: 1.0, // No opacity changes
      pressedOffset: Offset(2, 2), // Brutal offset effect when pressed
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

  /// Creates unified AppButtonStyle for Brutal theme with ColorScheme
  static AppButtonStyle _createBrutalAppButtonStyleForScheme(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    // Similar implementation but using ColorScheme instead of AppColorScheme
    final filledSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: scheme.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.8),
            blurRadius: 0,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      disabled: SurfaceStyle(
        backgroundColor: scheme.onSurface.withValues(alpha: 0.12),
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.onSurface.withValues(alpha: 0.38),
      ),
      hovered: SurfaceStyle(
        backgroundColor: scheme.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.8),
            blurRadius: 0,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      pressed: SurfaceStyle(
        backgroundColor: scheme.primary,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.8),
            blurRadius: 0,
            offset: const Offset(2, 2),
          ),
        ],
      ),
    );

    final outlineSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: scheme.primary,
        borderWidth: 3.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
      ),
      disabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: scheme.primary.withValues(alpha: 0.38),
        borderWidth: 3.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.primary.withValues(alpha: 0.38),
      ),
      hovered: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.08),
        borderColor: scheme.primary,
        borderWidth: 4.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.8),
            blurRadius: 0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      pressed: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.16),
        borderColor: scheme.primary,
        borderWidth: 3.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.8),
            blurRadius: 0,
            offset: const Offset(1, 1),
          ),
        ],
      ),
    );

    final textSurfaces = ButtonSurfaceStates(
      enabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
      ),
      disabled: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.primary.withValues(alpha: 0.38),
      ),
      hovered: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.08),
        borderColor: scheme.onSurface,
        borderWidth: 2.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.8),
            blurRadius: 0,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      pressed: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.16),
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        blurStrength: 0.0,
        contentColor: scheme.primary,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.8),
            blurRadius: 0,
            offset: const Offset(4, 4),
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

    // Create text styles with bold weight
    final textStyles = ButtonTextStyles(
      small: textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w800,
        color: scheme.primary,
      ),
      medium: textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w800,
        color: scheme.primary,
      ),
      large: textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w800,
        color: scheme.primary,
      ),
    );

    // Create size spec
    const sizeSpec = ButtonSizeSpec(
      smallHeight: 36.0,
      mediumHeight: 52.0,
      largeHeight: 64.0,
      smallPadding: EdgeInsets.symmetric(horizontal: 20.0),
      mediumPadding: EdgeInsets.symmetric(horizontal: 28.0),
      largePadding: EdgeInsets.symmetric(horizontal: 36.0),
      iconSpacing: 12.0,
    );

    // Create interaction spec
    const interaction = InteractionSpec(
      pressedScale: 1.0, // No scale - brutal buttons don't shrink
      hoverOpacity: 1.0, // No opacity changes - harsh and direct
      pressedOpacity: 1.0, // No opacity changes
      pressedOffset: Offset(2, 2), // Brutal offset effect when pressed
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
