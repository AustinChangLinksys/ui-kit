import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/toggle_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class FlatDesignTheme extends AppDesignTheme {
  const FlatDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
    required super.toggleStyle,
    required super.skeletonStyle,
  });

  factory FlatDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    // Define semantic color variables (Token-First)
    final activeColor = scheme.primary;
    final inactiveColor = scheme
        .surfaceContainerHighest; // Neutral gray, suitable for unselected tracks
    const thumbColor =
        Colors.white; // iOS style Thumb usually remains pure white

    return FlatDesignTheme._(
      // --- 1. Global Surface Definition (for Card, Dialog, etc.) ---
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.outlineVariant, // Use semantic border color
        borderWidth: 1.0,
        borderRadius: 12.0,
        shadows: const [], // Flat style usually has no shadows, or very faint ones
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerLow,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 12.0,
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
        borderRadius: 12.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
      ),

      // --- 2. Toggle Specialization (iOS Style) ---
      toggleStyle: ToggleStyle(
        // Content settings: iOS style is clean, no Icon or text
        activeType: ToggleContentType.none,
        inactiveType: ToggleContentType.none,

        // Style override: Active Track (on state)
        activeTrackStyle: SurfaceStyle(
          backgroundColor: activeColor,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 99, // 膠囊形狀
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
        borderRadius: 12.0,
      ),
      // --- 3. Other Global Settings ---
      typography: const TypographySpec(
        bodyFontFamily: 'San Francisco', // or System Default
        displayFontFamily: 'San Francisco',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut, // Smooth curve
      ),
      spacingFactor: 1.0,
    );
  }

  factory FlatDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    // Dark Mode color mapping
    final activeColor = scheme.primary;
    final inactiveColor = scheme.surfaceContainerHighest;
    const thumbColor =
        Colors.white; // Thumb remains white in Dark Mode to maintain contrast

    return FlatDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.outlineVariant,
        borderWidth: 1.0,
        borderRadius: 12.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerLow,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 12.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: activeColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 12.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
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
              color: Colors.black.withValues(alpha: 0.3),
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
        borderRadius: 12.0,
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'San Francisco',
        displayFontFamily: 'San Francisco',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      ),
      spacingFactor: 1.0,
    );
  }
}
