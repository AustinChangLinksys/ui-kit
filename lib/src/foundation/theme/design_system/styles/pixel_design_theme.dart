import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';

class PixelDesignTheme extends AppDesignTheme {
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
  });

  factory PixelDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
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
        texture: AppTextures.pixelGrid,
        textureOpacity: 0.25, // Light mode: pixel grid visible but not overwhelming
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
    );
  }

  factory PixelDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
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
        texture: AppTextures.pixelGrid,
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
    );
  }
}
