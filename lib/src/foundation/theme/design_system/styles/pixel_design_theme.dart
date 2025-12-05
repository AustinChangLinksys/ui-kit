import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';

class PixelDesignTheme extends AppDesignTheme {
  // Factory 1: Create from Config
  factory PixelDesignTheme.fromConfig(AppThemeConfig config) {
    final colors = AppColorFactory.generatePixel(config);
    return PixelDesignTheme._raw(colors);
  }

  // Factory 2: Raw Mode (AppColorScheme driven)
  factory PixelDesignTheme._raw(AppColorScheme colors) {
    final isLight = colors.surface.computeLuminance() > 0.5;
    final overlayColor = isLight
        ? Colors.black.withValues(alpha: 0.4)
        : Colors.white.withValues(alpha: 0.4);

    return PixelDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.highContrastBorder,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
        texture: AppTextureAssets.pixelGrid,
        textureOpacity: isLight ? 0.25 : 0.35,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: colors.surfaceContainer,
        borderColor: colors.highContrastBorder,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow.withValues(alpha: 0.5),
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: colors.error, // Pixel theme often uses bold colors like error for highlight
        borderColor: colors.highContrastBorder,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow.withValues(alpha: 0.3),
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
          pressedOffset: Offset(2, 2),
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: colors.surfaceContainerHighest, // Just using container colors
        borderColor: colors.highContrastBorder,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: colors.tertiaryContainer,
        borderColor: colors.highContrastBorder,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: colors.styleShadow.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: colors.onTertiaryContainer,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'ON',
        inactiveText: 'OFF',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: colors.shadow.withValues(alpha: 0.1),
        highlightColor: colors.shadow.withValues(alpha: 0.2),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 2.0,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.highContrastBorder,
          contentColor: colors.onSurface,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(
                color: colors.styleShadow.withValues(alpha: 0.3),
                offset: const Offset(2, 2),
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
              Border(bottom: BorderSide(color: colors.highContrastBorder, width: 2.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: colors.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: colors.onSurface,
          borderWidth: 0,
          borderRadius: 2.0,
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
        size: 24.0,
        period: const Duration(milliseconds: 600),
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
              color: colors.styleShadow.withValues(alpha: 0.2),
              offset: const Offset(2, 2),
              blurRadius: 0),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        backgroundColor: colors.surface,
        textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'NeueHaasGrotTextRound',
            color: colors.onSurface),
        displayDuration: const Duration(seconds: 2),
      ),
      dividerStyle: DividerStyle(
        color: colors.highContrastBorder,
        thickness: 2.0,
        pattern: DividerPattern.dashed,
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
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      ),
      spacingFactor: 1.0,
      buttonHeight: 40.0,
      navigationStyle: const NavigationStyle(
        height: 64.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 4.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 16.0,
        marginTablet: 32.0,
        marginDesktop: 64.0,
        gutterMobile: 16.0,
        gutterTablet: 24.0,
        gutterDesktop: 32.0,
      ),
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.highContrastBorder,
          borderWidth: 2.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: colors.highContrastBorder,
          thickness: 2.0,
          pattern: DividerPattern.dashed,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.highContrastBorder,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(
              color: colors.highContrastBorder.withValues(alpha: 0.4),
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
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: colors.onSurface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: colors.surface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: colors.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: colors.styleBackground,
          borderColor: colors.highContrastBorder,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(
              color: colors.highContrastBorder.withValues(alpha: 0.4),
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: colors.onSurface,
        ),
        barrierColor: overlayColor,
        barrierBlur: 0.0,
      ),
      motion: const PixelMotion(),
      visualEffects:
          GlobalEffectsType.crtShader, // Example of applying CRT to Pixel theme
      iconStyle: AppIconStyle.pixelated,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        topBorderRadius: 0.0,
        dragHandleHeight: 16.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 256.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        blurStrength: 0.0,
        enableDithering: true,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: colors.onPrimary, // Assuming white/black
        inactiveTextColor: colors.onSurface.withValues(alpha: 0.5),
        indicatorColor: colors.onPrimary,
        tabBackgroundColor: colors.primary,
        animationDuration: const Duration(milliseconds: 100),
        indicatorThickness: 4.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: colors.primary,
        completedStepColor: colors.secondary,
        pendingStepColor: colors.surfaceContainerHighest,
        connectorColor: colors.outline,
        stepSize: 48.0,
        useDashedConnector: true,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: colors.primary,
        inactiveLinkColor: colors.onSurface.withValues(alpha: 0.5),
        separatorColor: colors.primary,
        separatorText: ' > ',
        itemTextStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: colors.surface, // Or black
        expandedBackgroundColor: colors.surfaceContainer,
        headerTextColor: colors.onSurface, // Or white
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 100),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: colors.onSurface,
        navButtonHoverColor: colors.outline,
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        useSnapScroll: true,
        navButtonSize: 64.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: colors.surfaceContainerHighest,
        unselectedText: colors.onSurface,
        selectedBackground: colors.primary,
        selectedText: colors.onPrimary,
        selectedBorderColor: colors.highContrastBorder,
        borderRadius: 0.0,
      ),
      topologySpec: _buildTopologySpec(colors.toMaterialScheme(brightness: isLight ? Brightness.light : Brightness.dark), isLight: isLight),
    );
  }

  // Private constructor, used to receive all properties and can be called by Factory
  const PixelDesignTheme._({
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
    required super.topologySpec,
  });

  factory PixelDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final overlayColor = Colors.black.withValues(alpha: 0.4);
    return PixelDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.onSurface,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
        texture: AppTextureAssets.pixelGrid,
        textureOpacity:
            0.25, // Light mode: pixel grid visible but not overwhelming
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.primaryContainer,
        borderColor: scheme.onSurface,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.5),
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onPrimaryContainer,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.error,
        borderColor: scheme.onSurface,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.3),
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
          pressedOffset: Offset(2, 2),
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.secondaryContainer,
        borderColor: scheme.onSurface,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSecondaryContainer,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiaryContainer,
        borderColor: scheme.onSurface,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onTertiaryContainer,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'ON',
        inactiveText: 'OFF',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.shadow.withValues(alpha: 0.1),
        highlightColor: scheme.shadow.withValues(alpha: 0.2),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 2.0,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          contentColor: scheme.onSurface,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(
                color: scheme.onSurface.withValues(alpha: 0.3),
                offset: const Offset(2, 2),
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
              Border(bottom: BorderSide(color: scheme.onSurface, width: 2.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 2.0,
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
        size: 24.0,
        period: const Duration(milliseconds: 600),
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.2),
              offset: const Offset(2, 2),
              blurRadius: 0),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        backgroundColor: scheme.surface,
        textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'NeueHaasGrotTextRound',
            color: scheme.onSurface),
        displayDuration: const Duration(seconds: 2),
      ),
      dividerStyle: DividerStyle(
        color: scheme.onSurface,
        thickness: 2.0,
        pattern: DividerPattern.dashed,
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
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      ),
      spacingFactor: 1.0,
      buttonHeight: 40.0,
      navigationStyle: const NavigationStyle(
        height: 64.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 4.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 16.0,
        marginTablet: 32.0,
        marginDesktop: 64.0,
        gutterMobile: 16.0,
        gutterTablet: 24.0,
        gutterDesktop: 32.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles (Pixel Light)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          borderWidth: 2.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.onSurface,
          thickness: 2.0,
          pattern: DividerPattern.dashed,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(
              color: scheme.onSurface.withValues(alpha: 0.4),
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
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.onSurface,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.surface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(
              color: scheme.onSurface.withValues(alpha: 0.4),
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        barrierColor: Colors.black.withValues(alpha: 0.5),
        barrierBlur: 0.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(16.0),
        buttonSpacing: 8.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const PixelMotion(),
      visualEffects:
          GlobalEffectsType.crtShader, // Example of applying CRT to Pixel theme
      iconStyle: AppIconStyle.pixelated,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        topBorderRadius: 0.0,
        dragHandleHeight: 16.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 256.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        blurStrength: 0.0,
        enableDithering: true,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: Colors.white,
        inactiveTextColor: Colors.grey.shade400,
        indicatorColor: Colors.white,
        tabBackgroundColor: Colors.black,
        animationDuration: const Duration(milliseconds: 100),
        indicatorThickness: 4.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: Colors.white,
        completedStepColor: Colors.grey.shade600,
        pendingStepColor: Colors.grey.shade800,
        connectorColor: Colors.grey.shade600,
        stepSize: 48.0,
        useDashedConnector: true,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: Colors.white,
        inactiveLinkColor: Colors.grey.shade300,
        separatorColor: Colors.white,
        separatorText: ' > ',
        itemTextStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: Colors.black,
        expandedBackgroundColor: Colors.grey.shade900,
        headerTextColor: Colors.white,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 100),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: Colors.white,
        navButtonHoverColor: Colors.grey.shade200,
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        useSnapScroll: true,
        navButtonSize: 64.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: Colors.grey.shade800,
        unselectedText: Colors.white,
        selectedBackground: Colors.white,
        selectedText: Colors.black,
        selectedBorderColor: Colors.white,
        borderRadius: 0.0,
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: true),
    );
  }

  factory PixelDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final overlayColor = Colors.white.withValues(alpha: 0.4);
    final black = scheme.onSurface;

    return PixelDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: black,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: black.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: black,
        texture: AppTextureAssets.pixelGrid,
        textureOpacity: 0.35, // Dark mode: pixel grid more prominent
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.primaryContainer,
        borderColor: black,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: black.withValues(alpha: 0.5),
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onPrimaryContainer,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.error,
        borderColor: black,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: black.withValues(alpha: 0.3),
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
          pressedOffset: Offset(2, 2),
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.secondaryContainer,
        borderColor: black,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: black.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSecondaryContainer,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiaryContainer,
        borderColor: black,
        borderWidth: 2.0,
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
            color: black.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onTertiaryContainer,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'ON',
        inactiveText: 'OFF',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.onSurface.withValues(alpha: 0.08),
        highlightColor: scheme.onSurface.withValues(alpha: 0.16),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 2.0,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          contentColor: black,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(color: black, offset: const Offset(2, 2), blurRadius: 0)
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
          customBorder: Border(bottom: BorderSide(color: black, width: 2.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: black,
          borderWidth: 0,
          borderRadius: 2.0,
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
        size: 24.0,
        period: const Duration(milliseconds: 600),
        borderRadius: 2.0,
        shadows: [
          BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.4),
              offset: const Offset(2, 2),
              blurRadius: 0),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        backgroundColor: scheme.surface,
        textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'NeueHaasGrotTextRound',
            color: black),
        displayDuration: const Duration(seconds: 2),
      ),
      dividerStyle: DividerStyle(
        color: black,
        thickness: 2.0,
        pattern: DividerPattern.dashed,
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
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      ),
      spacingFactor: 1.0,
      buttonHeight: 40.0,
      navigationStyle: const NavigationStyle(
        height: 64.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 4.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 16.0,
        marginTablet: 32.0,
        marginDesktop: 64.0,
        gutterMobile: 16.0,
        gutterTablet: 24.0,
        gutterDesktop: 32.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles (Pixel Dark)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          borderWidth: 2.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 0.0,
          contentColor: black,
        ),
        dividerStyle: DividerStyle(
          color: black,
          thickness: 2.0,
          pattern: DividerPattern.dashed,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 0.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(
              color: black.withValues(alpha: 0.5),
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
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: black,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: black,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.surface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 0.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          borderWidth: 2.0,
          borderRadius: 2.0,
          shadows: [
            BoxShadow(
              color: black.withValues(alpha: 0.5),
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
          blurStrength: 0.0,
          contentColor: black,
        ),
        barrierColor: Colors.black.withValues(alpha: 0.6),
        barrierBlur: 0.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(16.0),
        buttonSpacing: 8.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
      motion: const PixelMotion(),
      visualEffects: GlobalEffectsType.crtShader,
      iconStyle: AppIconStyle.pixelated,
      bottomSheetStyle: BottomSheetStyle(
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        topBorderRadius: 0.0,
        dragHandleHeight: 16.0,
      ),
      sideSheetStyle: SideSheetStyle(
        width: 256.0,
        overlayColor: overlayColor,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        blurStrength: 0.0,
        enableDithering: true,
      ),
      tabsStyle: TabsStyle(
        activeTextColor: Colors.white,
        inactiveTextColor: Colors.grey.shade400,
        indicatorColor: Colors.white,
        tabBackgroundColor: Colors.black,
        animationDuration: const Duration(milliseconds: 100),
        indicatorThickness: 4.0,
      ),
      stepperStyle: StepperStyle(
        activeStepColor: Colors.white,
        completedStepColor: Colors.grey.shade600,
        pendingStepColor: Colors.grey.shade800,
        connectorColor: Colors.grey.shade600,
        stepSize: 48.0,
        useDashedConnector: true,
      ),
      breadcrumbStyle: BreadcrumbStyle(
        activeLinkColor: Colors.white,
        inactiveLinkColor: Colors.grey.shade300,
        separatorColor: Colors.white,
        separatorText: ' > ',
        itemTextStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
      ),
      expansionPanelStyle: ExpansionPanelStyle(
        headerColor: Colors.black,
        expandedBackgroundColor: Colors.grey.shade900,
        headerTextColor: Colors.white,
        expandIcon: Icons.expand_more,
        animationDuration: const Duration(milliseconds: 100),
      ),
      carouselStyle: CarouselStyle(
        navButtonColor: Colors.white,
        navButtonHoverColor: Colors.grey.shade200,
        previousIcon: Icons.arrow_back,
        nextIcon: Icons.arrow_forward,
        animationDuration: const Duration(milliseconds: 100),
        animationCurve: Curves.linear,
        useSnapScroll: true,
        navButtonSize: 64.0,
      ),
      chipGroupStyle: ChipGroupStyle(
        unselectedBackground: Colors.grey.shade800,
        unselectedText: Colors.white,
        selectedBackground: Colors.white,
        selectedText: Colors.black,
        selectedBorderColor: Colors.white,
        borderRadius: 0.0,
      ),
      topologySpec: _buildTopologySpec(scheme, isLight: false),
    );
  }

  /// Builds topology spec for Pixel theme with retro 8-bit aesthetic.
  static TopologySpec _buildTopologySpec(ColorScheme scheme,
      {required bool isLight}) {
    final borderColor = scheme.onSurface;
    final errorColor = scheme.error;

    return TopologySpec(
      // Gateway styles - chunky pixel blocks
      gatewayNormalStyle: NodeStyle(
        backgroundColor: scheme.primaryContainer,
        borderColor: borderColor,
        borderWidth: 2.0,
        borderRadius: 2.0, // Slightly rounded for pixel feel
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 64.0,
        iconColor: scheme.onPrimaryContainer,
      ),
      gatewayHighLoadStyle: NodeStyle(
        backgroundColor: errorColor,
        borderColor: borderColor,
        borderWidth: 2.0,
        borderRadius: 2.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 64.0,
        iconColor: scheme.onError,
      ),
      gatewayOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.4),
        borderColor: scheme.outline,
        borderWidth: 2.0,
        borderRadius: 2.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 64.0,
        iconColor: scheme.outline,
      ),

      // Extender styles - pixel squares
      extenderNormalStyle: NodeStyle(
        backgroundColor: scheme.secondaryContainer,
        borderColor: borderColor,
        borderWidth: 2.0,
        borderRadius: 2.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 48.0,
        iconColor: scheme.onSecondaryContainer,
      ),
      extenderHighLoadStyle: NodeStyle(
        backgroundColor: errorColor.withValues(alpha: 0.9),
        borderColor: borderColor,
        borderWidth: 2.0,
        borderRadius: 2.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 48.0,
        iconColor: scheme.onError,
      ),
      extenderOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.3),
        borderColor: scheme.outline,
        borderWidth: 2.0,
        borderRadius: 2.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 48.0,
        iconColor: scheme.outline,
      ),

      // Client styles - small pixel dots
      clientNormalStyle: NodeStyle(
        backgroundColor: scheme.tertiaryContainer,
        borderColor: borderColor,
        borderWidth: 2.0,
        borderRadius: 2.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 28.0,
        iconColor: scheme.onTertiaryContainer,
      ),
      clientOfflineStyle: NodeStyle(
        backgroundColor: scheme.outline.withValues(alpha: 0.2),
        borderColor: scheme.outline,
        borderWidth: 1.5,
        borderRadius: 2.0,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        size: 28.0,
        iconColor: scheme.outline,
      ),

      // Link styles - pixelated connections
      ethernetLinkStyle: LinkStyle(
        color: borderColor,
        width: 2.0,
        dashPattern: null,
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: Duration.zero,
      ),
      wifiStrongStyle: const LinkStyle(
        color: Colors.green,
        width: 2.0,
        dashPattern: [4.0, 2.0], // Shorter dashes for pixel feel
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: Duration(milliseconds: 600),
      ),
      wifiMediumStyle: const LinkStyle(
        color: Colors.orange,
        width: 2.0,
        dashPattern: [4.0, 2.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: Duration(milliseconds: 800),
      ),
      wifiWeakStyle: LinkStyle(
        color: errorColor,
        width: 2.0,
        dashPattern: const [2.0, 2.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 1000),
      ),
      wifiUnknownStyle: LinkStyle(
        color: scheme.outline,
        width: 2.0,
        dashPattern: const [2.0, 4.0],
        glowColor: Colors.transparent,
        glowRadius: 0.0,
        animationDuration: const Duration(milliseconds: 800),
      ),

      // Layout - grid-aligned
      nodeSpacing: 80.0, // Snappier grid
      linkCurvature: 0.0, // Straight lines for pixel art
      orbitRadius: 50.0,
      orbitSpeed: const Duration(seconds: 12), // Faster for retro feel
    );
  }
}
