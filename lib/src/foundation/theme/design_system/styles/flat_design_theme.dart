import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/toggle_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class FlatDesignTheme extends AppDesignTheme {
  const FlatDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.toggleStyle,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
  });

  factory FlatDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
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
        backgroundColor: scheme.surfaceContainerHighest,
        borderColor: scheme.outline,
        borderWidth: 1.0,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.1),
        borderColor: scheme.primary,
        borderWidth: 1.0,
        borderRadius: 4.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.primary,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.icon,
        inactiveType: ToggleContentType.none, // 關閉時什麼都不顯示
        activeIcon: Icons.check,
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'Roboto',
        displayFontFamily: 'Roboto',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      spacingFactor: 1.0,
    );
  }

  factory FlatDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
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
        backgroundColor: scheme.surfaceContainerHighest,
        borderColor: scheme.outline,
        borderWidth: 1.0,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.2),
        borderColor: scheme.primary,
        borderWidth: 1.0,
        borderRadius: 4.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.primary,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.icon,
        inactiveType: ToggleContentType.none, // 關閉時什麼都不顯示
        activeIcon: Icons.check,
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'Roboto',
        displayFontFamily: 'Roboto',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      spacingFactor: 1.0,
    );
  }
}
