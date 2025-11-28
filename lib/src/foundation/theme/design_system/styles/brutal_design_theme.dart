import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class BrutalDesignTheme extends AppDesignTheme {
  // 私有建構子，用於接收所有屬性，並可以被 Factory 呼叫
  const BrutalDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
  });

  factory BrutalDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    return BrutalDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface, // 使用 ColorScheme 的 surface
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface, // 使用 ColorScheme 的 onSurface 作為陰影
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.primaryContainer, // 使用 ColorScheme 的 primaryContainer
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
        backgroundColor: scheme.error, // 使用 ColorScheme 的 error
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
        backgroundColor: scheme.primaryContainer, // 使用 ColorScheme 的 primaryContainer
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
        backgroundColor: scheme.error, // 使用 ColorScheme 的 error
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
