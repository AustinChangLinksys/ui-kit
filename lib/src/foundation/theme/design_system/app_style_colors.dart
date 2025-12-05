import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_palette.dart';

@immutable
class AppStyleColors extends ThemeExtension<AppStyleColors> {
  /// High contrast border (Pixel: solid, Glass: translucent)
  final Color highContrastBorder;

  /// Glow/Edge light (changes with Seed)
  final Color glowColor;

  /// Glass background (with opacity)
  final Color glassBackground;

  /// Stylized shadow (Pixel: solid, Glass: colored)
  final Color shadowColor;

  const AppStyleColors({
    required this.highContrastBorder,
    required this.glowColor,
    required this.glassBackground,
    required this.shadowColor,
  });

  @override
  AppStyleColors copyWith({
    Color? highContrastBorder,
    Color? glowColor,
    Color? glassBackground,
    Color? shadowColor,
  }) {
    return AppStyleColors(
      highContrastBorder: highContrastBorder ?? this.highContrastBorder,
      glowColor: glowColor ?? this.glowColor,
      glassBackground: glassBackground ?? this.glassBackground,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  AppStyleColors lerp(ThemeExtension<AppStyleColors>? other, double t) {
    if (other is! AppStyleColors) {
      return this;
    }
    return AppStyleColors(
      highContrastBorder:
          Color.lerp(highContrastBorder, other.highContrastBorder, t)!,
      glowColor: Color.lerp(glowColor, other.glowColor, t)!,
      glassBackground: Color.lerp(glassBackground, other.glassBackground, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
    );
  }

  // --- Factory Strategies ---

  factory AppStyleColors.pixel(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;
    return AppStyleColors(
      highContrastBorder: scheme.onSurface,
      shadowColor: isDark ? scheme.primaryContainer : scheme.onSurface,
      glowColor: AppPalette.transparent,
      glassBackground: scheme.surface, // Pixel is usually opaque
    );
  }

  factory AppStyleColors.glass(ColorScheme scheme) {
    return AppStyleColors(
      highContrastBorder: AppPalette.white.withValues(alpha: 0.2),
      glowColor: scheme.primary.withValues(alpha: 0.4),
      glassBackground: scheme.surface.withValues(alpha: 0.7),
      shadowColor: scheme.shadow.withValues(alpha: 0.1),
    );
  }

  factory AppStyleColors.flat(ColorScheme scheme) {
    return AppStyleColors(
      highContrastBorder: scheme.outlineVariant,
      glowColor: AppPalette.transparent,
      glassBackground: scheme.surface,
      shadowColor: scheme.shadow.withValues(alpha: 0.05),
    );
  }

  factory AppStyleColors.brutal(ColorScheme scheme) {
    return AppStyleColors(
      highContrastBorder: scheme.onSurface,
      glowColor: AppPalette.transparent,
      glassBackground: scheme.surface,
      shadowColor: scheme.onSurface, // Hard shadow
    );
  }

  factory AppStyleColors.neumorphic(ColorScheme scheme) {
    return AppStyleColors(
      highContrastBorder: AppPalette.transparent,
      glowColor: AppPalette.transparent,
      glassBackground: scheme.surface,
      shadowColor: scheme.shadow.withValues(alpha: 0.2),
    );
  }
}
