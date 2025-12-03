import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';

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
  });

  factory FlatDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
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
    );
  }

  factory FlatDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
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
    );
  }
}
