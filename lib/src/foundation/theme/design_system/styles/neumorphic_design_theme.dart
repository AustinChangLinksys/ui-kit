import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class NeumorphicDesignTheme extends AppDesignTheme {
  // 私有建構子，用於接收所有屬性
  NeumorphicDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
  });

  // Default to Light, providing a default ColorScheme
  factory NeumorphicDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final lightBaseColor = scheme.surface; // E0E5EC
    final lightShadow = Color.alphaBlend(
        Colors.white.withValues(alpha: 0.5), scheme.surface); // White shadow
    final darkShadow = Color.alphaBlend(
        Colors.black.withValues(alpha: 0.2), scheme.surface); // Black shadow
    final highlightBorderColor = scheme.primary;

    return NeumorphicDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: lightShadow,
            offset: const Offset(-6, -6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: darkShadow,
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 20.0,
        shadows: [
          BoxShadow(
            color:
                Color.alphaBlend(Colors.white.withValues(alpha: 0.7), scheme.surface),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color:
                Color.alphaBlend(Colors.black.withValues(alpha: 0.3), scheme.surface),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: highlightBorderColor,
        borderWidth: 1.5,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: lightShadow,
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: darkShadow,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
        blurStrength: 0.0,
        contentColor: highlightBorderColor,
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'Nunito',
        displayFontFamily: 'Nunito',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
      spacingFactor: 1.2,
    );
  }

  factory NeumorphicDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final darkBaseColor = scheme.surface; // 2D2D2D
    final darkLightShadow = Color.alphaBlend(
        Colors.white.withValues(alpha: 0.1), scheme.surface); // Light shadow
    final darkDarkShadow = Color.alphaBlend(
        Colors.black.withValues(alpha: 0.6), scheme.surface); // Dark shadow
    final darkHighlightBorderColor = scheme.primary;

    return NeumorphicDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: darkLightShadow,
            offset: const Offset(-5, -5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: darkDarkShadow,
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 20.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                Colors.white.withValues(alpha: 0.15), scheme.surface),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color:
                Color.alphaBlend(Colors.black.withValues(alpha: 0.8), scheme.surface),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: darkHighlightBorderColor,
        borderWidth: 1.5,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: darkLightShadow,
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: darkDarkShadow,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
        blurStrength: 0.0,
        contentColor: darkHighlightBorderColor,
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'Nunito',
        displayFontFamily: 'Nunito',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
      spacingFactor: 1.2,
    );
  }
}
