import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/toggle_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class BrutalDesignTheme extends AppDesignTheme {
  // Private constructor, used to receive all properties and can be called by Factory
  const BrutalDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.toggleStyle,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
    required super.skeletonStyle,
  });

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
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.primaryContainer, // Use ColorScheme's primaryContainer
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
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'I',
        inactiveText: 'O',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: Colors.black.withValues(alpha: 0.15),
        highlightColor: Colors.black.withValues(alpha: 0.3),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 0.0,
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'Courier',
        displayFontFamily: 'Courier',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
    );
  }

  factory BrutalDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
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
      ),
            surfaceElevated: SurfaceStyle(
              backgroundColor: scheme.primaryContainer, // Use ColorScheme's primaryContainer
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
      typography: const TypographySpec(
        bodyFontFamily: 'Courier',
        displayFontFamily: 'Courier',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
    );
  }
}
