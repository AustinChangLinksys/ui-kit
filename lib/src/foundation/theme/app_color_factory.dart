import 'package:flutter/material.dart';
import 'app_color_scheme.dart';
import 'app_theme_config.dart';

class AppColorFactory {
  /// Generates an [AppColorScheme] based on the provided [AppThemeConfig].
  static AppColorScheme generateNeumorphic(AppThemeConfig config) {
    final base = _generateBaseScheme(config);
    final isLight = config.brightness == Brightness.light;

    // 2. Style Logic
    final calculatedSignalStrong = Color.alphaBlend(
      base.primary.withValues(alpha: 0.2),
      Colors.green,
    ).withValues(alpha: 0.6);

    final calculatedOverlay = Color.alphaBlend(
      base.primary.withValues(alpha: 0.05),
      isLight ? Colors.black : Colors.white,
    ).withValues(alpha: 0.2);

    final styleShadow = isLight
        ? Color.alphaBlend(base.shadow.withValues(alpha: 0.2), base.surface)
        : Color.alphaBlend(base.shadow.withValues(alpha: 0.6), base.surface);

    final glowColor = isLight
        ? Color.alphaBlend(base.primary.withValues(alpha: 0.2), base.surface)
        : Color.alphaBlend(base.primary.withValues(alpha: 0.1), base.surface);

    // 3. Assemble
    return _assembleScheme(
      base: base,
      highContrastBorder: config.customHighContrastBorder ??
          (isLight ? base.primary : base.onSurface),
      subtleBorder: isLight
          ? base.outline.withValues(alpha: 0.4)
          : base.shadow.withValues(alpha: 0.5),
      styleBackground: base.surface,
      styleShadow: styleShadow,
      glowColor: config.customGlowColor ?? glowColor,
      signalStrong: config.customSignalStrong ?? calculatedSignalStrong,
      signalWeak: config.customSignalWeak ?? base.error.withValues(alpha: 0.6),
      signalGlow: (config.customSignalStrong ?? calculatedSignalStrong)
          .withValues(alpha: 0.1),
      activeFillColor: base.primary.withValues(alpha: 0.12),
      activeContentColor: base.primary,
      overlayColor: config.customOverlayColor ?? calculatedOverlay,
    );
  }

  static AppColorScheme generateGlass(AppThemeConfig config) {
    final base = _generateBaseScheme(config);
    final isLight = config.brightness == Brightness.light;

    return _assembleScheme(
      base: base,
      highContrastBorder: config.customHighContrastBorder ?? base.onSurface,
      subtleBorder: isLight
          ? Colors.white.withValues(alpha: 0.4)
          : Colors.white.withValues(alpha: 0.1),
      styleBackground: base.surface.withValues(alpha: 0.7),
      styleShadow: base.shadow.withValues(alpha: 0.2),
      glowColor: config.customGlowColor ?? base.primary.withValues(alpha: 0.3),
      signalStrong: config.customSignalStrong ?? Colors.green,
      signalWeak: config.customSignalWeak ?? Colors.orange,
      signalGlow:
          (config.customSignalStrong ?? Colors.green).withValues(alpha: 0.4),
      activeFillColor: base.primary.withValues(alpha: 0.2),
      activeContentColor: base.primary,
      overlayColor:
          config.customOverlayColor ?? Colors.black.withValues(alpha: 0.3),
    );
  }

  static AppColorScheme generateBrutal(AppThemeConfig config) {
    final base = _generateBaseScheme(config);
    final isLight = config.brightness == Brightness.light;

    final solidBlack = Colors.black;
    final solidWhite = Colors.white;
    final highContrast = isLight ? solidBlack : solidWhite;
    final styleShadow = isLight ? solidBlack : solidWhite;

    return _assembleScheme(
      base: base,
      highContrastBorder: config.customHighContrastBorder ?? highContrast,
      subtleBorder: highContrast,
      styleBackground: base.surface,
      styleShadow: styleShadow,
      glowColor: Colors.transparent,
      signalStrong: config.customSignalStrong ?? Colors.green,
      signalWeak: config.customSignalWeak ?? base.error,
      signalGlow: Colors.transparent,
      activeFillColor: base.primary,
      activeContentColor: base.onPrimary,
      overlayColor:
          config.customOverlayColor ?? highContrast.withValues(alpha: 0.5),
    );
  }

  static AppColorScheme generateFlat(AppThemeConfig config) {
    final base = _generateBaseScheme(config);

    return _assembleScheme(
      base: base,
      highContrastBorder: config.customHighContrastBorder ?? base.outline,
      subtleBorder: base.outlineVariant,
      styleBackground: base.surface,
      styleShadow: Colors.transparent,
      glowColor: Colors.transparent,
      signalStrong: config.customSignalStrong ?? Colors.green,
      signalWeak: config.customSignalWeak ?? Colors.orange,
      signalGlow: Colors.transparent,
      activeFillColor: base.primaryContainer,
      activeContentColor: base.onPrimaryContainer,
      overlayColor:
          config.customOverlayColor ?? base.scrim.withValues(alpha: 0.3),
    );
  }

  static AppColorScheme generatePixel(AppThemeConfig config) {
    final base = _generateBaseScheme(config);
    final isLight = config.brightness == Brightness.light;

    final highContrast = isLight ? Colors.black : Colors.white;
    final styleShadow = highContrast;
    final subtleBorder = highContrast.withValues(alpha: 0.5);

    return _assembleScheme(
      base: base,
      highContrastBorder: config.customHighContrastBorder ?? highContrast,
      subtleBorder: subtleBorder,
      styleBackground: base.surface,
      styleShadow: styleShadow,
      glowColor: Colors.transparent,
      signalStrong: config.customSignalStrong ?? Colors.green,
      signalWeak: config.customSignalWeak ?? Colors.orange,
      signalGlow: Colors.transparent,
      activeFillColor: base.primary,
      activeContentColor: base.onPrimary,
      overlayColor:
          config.customOverlayColor ?? highContrast.withValues(alpha: 0.5),
    );
  }

  // --- Helpers ---

  static ColorScheme _generateBaseScheme(AppThemeConfig config) {
    return ColorScheme.fromSeed(
      seedColor: config.seedColor ?? Colors.blue,
      brightness: config.brightness,
      primary: config.primary,
      secondary: config.secondary,
      tertiary: config.tertiary,
      surface: config.surface,
      error: config.error,
    );
  }

  static AppColorScheme _assembleScheme({
    required ColorScheme base,
    required Color highContrastBorder,
    required Color subtleBorder,
    required Color styleBackground,
    required Color styleShadow,
    required Color glowColor,
    required Color signalStrong,
    required Color signalWeak,
    required Color signalGlow,
    required Color activeFillColor,
    required Color activeContentColor,
    required Color overlayColor,
  }) {
    return AppColorScheme(
      // Standard Mapping
      primary: base.primary,
      onPrimary: base.onPrimary,
      primaryContainer: base.primaryContainer,
      onPrimaryContainer: base.onPrimaryContainer,
      secondary: base.secondary,
      onSecondary: base.onSecondary,
      secondaryContainer: base.secondaryContainer,
      onSecondaryContainer: base.onSecondaryContainer,
      tertiary: base.tertiary,
      onTertiary: base.onTertiary,
      tertiaryContainer: base.tertiaryContainer,
      onTertiaryContainer: base.onTertiaryContainer,
      error: base.error,
      onError: base.onError,
      errorContainer: base.errorContainer,
      onErrorContainer: base.onErrorContainer,
      surface: base.surface,
      onSurface: base.onSurface,
      onSurfaceVariant: base.onSurfaceVariant,
      surfaceTint: base.surfaceTint,
      outline: base.outline,
      outlineVariant: base.outlineVariant,
      shadow: base.shadow,
      scrim: base.scrim,
      surfaceContainer: base.surfaceContainer,
      surfaceContainerHigh: base.surfaceContainerHigh,
      surfaceContainerHighest: base.surfaceContainerHighest,
      surfaceContainerLow: base.surfaceContainerLow,
      surfaceContainerLowest: base.surfaceContainerLowest,
      inverseSurface: base.inverseSurface,
      onInverseSurface: base.onInverseSurface,
      inversePrimary: base.inversePrimary,

      // Semantic Mapping
      highContrastBorder: highContrastBorder,
      subtleBorder: subtleBorder,
      styleBackground: styleBackground,
      styleShadow: styleShadow,
      glowColor: glowColor,
      signalStrong: signalStrong,
      signalWeak: signalWeak,
      signalGlow: signalGlow,
      activeFillColor: activeFillColor,
      activeContentColor: activeContentColor,
      overlayColor: overlayColor,
    );
  }
}
