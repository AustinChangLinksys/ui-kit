import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class GlassDesignTheme extends AppDesignTheme {
  // 私有建構子，用於 Factory 方法呼叫
  const GlassDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
  });

  factory GlassDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    const tintOpacity = 0.05;
    final baseColor = Color.alphaBlend(
      scheme.primary.withValues(alpha: tintOpacity),
      scheme.surface.withValues(alpha: 0.1),
    );
    final borderColor = scheme.outlineVariant.withValues(alpha: 0.3);
    final shadowColor = scheme.shadow.withValues(alpha: 0.1);

    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: baseColor,
        borderColor: borderColor,
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          )
        ],
        blurStrength: 15.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: Color.alphaBlend(
            scheme.primary.withValues(alpha: tintOpacity + 0.05), baseColor),
        borderColor: borderColor,
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: shadowColor.withValues(alpha: shadowColor.a + 0.1),
            blurRadius: 30,
            spreadRadius: 4,
            offset: const Offset(0, 15),
          )
        ],
        blurStrength: 25.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: Color.alphaBlend(
            scheme.primary.withValues(alpha: tintOpacity + 0.1), baseColor),
        borderColor: scheme.primary.withValues(alpha: 0.5),
        borderWidth: 1.5,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        blurStrength: 10.0,
        contentColor: scheme.onSurface,
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ),
      spacingFactor: 1.0,
    );
  }

  factory GlassDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    const tintOpacity = 0.1;
    final baseColor = Color.alphaBlend(
      scheme.primary.withValues(alpha: tintOpacity),
      scheme.surface.withValues(alpha: 0.5),
    );
    final borderColor = scheme.outlineVariant.withValues(alpha: 0.3);
    final shadowColor = scheme.shadow.withValues(alpha: 0.3);

    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: baseColor,
        borderColor: borderColor,
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          )
        ],
        blurStrength: 15.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: Color.alphaBlend(
            scheme.primary.withValues(alpha: tintOpacity + 0.05), baseColor),
        borderColor: borderColor,
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: shadowColor.withValues(alpha: shadowColor.a + 0.1),
            blurRadius: 30,
            spreadRadius: 4,
            offset: const Offset(0, 15),
          )
        ],
        blurStrength: 25.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: Color.alphaBlend(
            scheme.primary.withValues(alpha: tintOpacity + 0.1), baseColor),
        borderColor: scheme.primary.withValues(alpha: 0.5),
        borderWidth: 1.5,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: shadowColor.withValues(alpha: shadowColor.a + 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        blurStrength: 10.0,
        contentColor: scheme.onSurface,
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ),
      spacingFactor: 1.0,
    );
  }
}
