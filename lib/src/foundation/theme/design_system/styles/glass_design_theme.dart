import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/toggle_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class GlassDesignTheme extends AppDesignTheme {
  const GlassDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
    required super.toggleStyle,
    required super.skeletonStyle,
  });

  // --- Light Mode (Liquid Water) ---
  factory GlassDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final glassBaseColor = scheme.surface.withValues(alpha: 0.02);

    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: glassBaseColor,
        borderColor: Colors.white.withValues(alpha: 0.5),
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
      surfaceElevated: SurfaceStyle(
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        borderColor: Colors.white.withValues(alpha: 0.6),
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
        backgroundColor: scheme.primary.withValues(alpha: 0.1), // 淡色液體
        borderColor: scheme.primary.withValues(alpha: 0.3),
        borderWidth: 1.5,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.15),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
        blurStrength: 15.0,
        contentColor: scheme.primary,
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
          borderColor: Colors.white.withValues(alpha: 0.2),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3), blurRadius: 12)
          ],
          blurStrength: 15.0,
          contentColor: Colors.white,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: Colors.grey.withValues(alpha: 0.1),
          borderColor: Colors.white.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: scheme.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: Colors.white.withValues(alpha: 0.9),
          borderColor: Colors.white,
          borderWidth: 0.0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          blurStrength: 5.0,
          contentColor: scheme.primary,
        ),
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 500), // 液體流動比較慢
        curve: Curves.easeInOutCubic,
      ),
      spacingFactor: 1.0,
    );
  }

  factory GlassDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: Colors.black.withValues(alpha: 0.2),
        borderColor: Colors.white.withValues(alpha: 0.1),
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 24)
        ],
        blurStrength: 25.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        borderColor: Colors.white.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 32)
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
          borderColor: Colors.white.withValues(alpha: 0.1),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.2), blurRadius: 12)
          ],
          blurStrength: 10.0,
          contentColor: Colors.white,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: Colors.white.withValues(alpha: 0.05),
          borderColor: Colors.white.withValues(alpha: 0.1),
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: scheme.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: Colors.grey.withValues(alpha: 0.9),
          borderColor: Colors.white.withValues(alpha: 0.2),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          blurStrength: 5.0,
          contentColor: scheme.primary,
        ),
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      ),
      spacingFactor: 1.0,
    );
  }
}
