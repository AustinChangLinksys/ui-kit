import 'package:flutter/material.dart';
import 'app_color_scheme.dart';
import 'app_theme_config.dart';

class AppColorFactory {
  /// Generates an [AppColorScheme] based on the provided [AppThemeConfig].
  ///
  /// The generation follows a waterfall process:
  /// 1. Base Material Scheme Generation (Seed + Overrides)
  /// 2. Style Semantic Calculation (Derived from Base)
  /// 3. Assembly (Applying Config Overrides)
  static AppColorScheme generateNeumorphic(AppThemeConfig config) {
    // ----------------------------------------------------
    // Step 1: Base Scheme Generation (Material Layer)
    // ----------------------------------------------------
    final seed = config.seedColor ?? Colors.blue;

    // Use fromSeed but allow Material properties to be overridden by config
    // This ensures that if config.primary changes, the entire base scheme adapts
    final base = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: config.brightness,
      primary: config.primary,
      secondary: config.secondary,
      tertiary: config.tertiary,
      surface: config.surface,
      error: config.error,
    );

    final isLight = config.brightness == Brightness.light;

    // ----------------------------------------------------
    // Step 2: Semantic Calculation & Harmonization (Style Layer)
    // ----------------------------------------------------

    // Logic: Signal Strong (Green mixed with Primary)
    // Harmonization: Mix 20% of primary into Green
    final calculatedSignalStrong = Color.alphaBlend(
      base.primary.withValues(alpha: 0.2), // 20% tint
      Colors.green,
    ).withValues(alpha: 0.6);

    // Logic: Overlay (Black/White mixed with Primary)
    final baseBarrier = isLight ? Colors.black : Colors.white;
    final calculatedOverlay = Color.alphaBlend(
      base.primary.withValues(alpha: 0.05), // 5% tint
      baseBarrier,
    ).withValues(alpha: 0.2);

    // Logic: Neumorphic Specifics (Shadows/Glows)
    final styleShadow = isLight
        ? Color.alphaBlend(base.shadow.withValues(alpha: 0.2), base.surface)
        : Color.alphaBlend(base.shadow.withValues(alpha: 0.6), base.surface);

    final glowColor = isLight
        ? Color.alphaBlend(base.outline.withValues(alpha: 0.5), base.surface)
        : Color.alphaBlend(base.outline.withValues(alpha: 0.1), base.surface);

    // ----------------------------------------------------
    // Step 3: Assembly (Standard + Semantic)
    // ----------------------------------------------------
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

      // Semantic Mapping (Default Logic for now)
      highContrastBorder: config.customHighContrastBorder ??
          (isLight ? base.primary : base.onSurface), // Invert for Dark Mode
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

  /// Generates a Glass-style [AppColorScheme].
  static AppColorScheme generateGlass(AppThemeConfig config) {
    // Reusing base generation logic
    final seed = config.seedColor ?? Colors.blue;
    final base = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: config.brightness,
      primary: config.primary,
      secondary: config.secondary,
      tertiary: config.tertiary,
      surface: config.surface,
      error: config.error,
    );
    final isLight = config.brightness == Brightness.light;

    // Glass Specifics:
    // Background is often semi-transparent
    final styleBackground = base.surface.withValues(alpha: 0.7); 
    
    // Borders are subtle white/light for glass effect
    final subtleBorder = isLight 
        ? Colors.white.withValues(alpha: 0.4) 
        : Colors.white.withValues(alpha: 0.1);

    // Assemble
    return AppColorScheme(
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

      highContrastBorder: config.customHighContrastBorder ?? base.onSurface,
      subtleBorder: subtleBorder,
      styleBackground: styleBackground,
      styleShadow: base.shadow.withValues(alpha: 0.2), // Softer shadow for glass
      glowColor: config.customGlowColor ?? base.primary.withValues(alpha: 0.3), // Glass glow

      signalStrong: config.customSignalStrong ?? Colors.green,
      signalWeak: config.customSignalWeak ?? Colors.orange,
      signalGlow: (config.customSignalStrong ?? Colors.green).withValues(alpha: 0.4),

      activeFillColor: base.primary.withValues(alpha: 0.2),
      activeContentColor: base.primary,
      overlayColor: config.customOverlayColor ?? Colors.black.withValues(alpha: 0.3),
    );
  }

  /// Generates a Brutal-style [AppColorScheme].
  static AppColorScheme generateBrutal(AppThemeConfig config) {
    // 1. Base
    final seed = config.seedColor ?? Colors.blue;
    final base = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: config.brightness,
      primary: config.primary,
      secondary: config.secondary,
      tertiary: config.tertiary,
      surface: config.surface,
      error: config.error,
    );
    final isLight = config.brightness == Brightness.light;

    // 2. Brutal Style Logic
    // High contrast is key.
    const solidBlack = Colors.black;
    const solidWhite = Colors.white;
    final highContrast = isLight ? solidBlack : solidWhite;
    
    // Brutal shadows are usually hard and dark/light
    final styleShadow = isLight ? solidBlack : solidWhite;

    // 3. Assemble
    return AppColorScheme(
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

      highContrastBorder: config.customHighContrastBorder ?? highContrast,
      subtleBorder: highContrast, // Brutal often uses same border for everything
      styleBackground: base.surface,
      styleShadow: styleShadow,
      glowColor: Colors.transparent, // Brutal rarely uses glow

      // Signals can be standard but maybe bolder
      signalStrong: config.customSignalStrong ?? Colors.green,
      signalWeak: config.customSignalWeak ?? base.error,
      signalGlow: Colors.transparent,

      activeFillColor: base.primary, // Solid fill
      activeContentColor: base.onPrimary,
      
      overlayColor: config.customOverlayColor ?? highContrast.withValues(alpha: 0.5), // Halftone pattern often used, but color is solid-ish
    );
  }

  /// Generates a Flat-style [AppColorScheme].
  static AppColorScheme generateFlat(AppThemeConfig config) {
    final seed = config.seedColor ?? Colors.blue;
    final base = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: config.brightness,
      primary: config.primary,
      secondary: config.secondary,
      tertiary: config.tertiary,
      surface: config.surface,
      error: config.error,
    );

    // Flat Specifics:
    // Minimalist. Shadows are rare.
    const styleShadow = Colors.transparent;
    const glowColor = Colors.transparent;
    
    // Borders are functional but not heavy
    final subtleBorder = base.outlineVariant;
    final highContrastBorder = base.outline;

    return AppColorScheme(
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

      highContrastBorder: config.customHighContrastBorder ?? highContrastBorder,
      subtleBorder: subtleBorder,
      styleBackground: base.surface,
      styleShadow: styleShadow,
      glowColor: glowColor,

      signalStrong: config.customSignalStrong ?? Colors.green,
      signalWeak: config.customSignalWeak ?? Colors.orange,
      signalGlow: Colors.transparent,

      activeFillColor: base.primaryContainer,
      activeContentColor: base.onPrimaryContainer,
      
      overlayColor: config.customOverlayColor ?? base.scrim.withValues(alpha: 0.3),
    );
  }

  /// Generates a Pixel-style [AppColorScheme].
  static AppColorScheme generatePixel(AppThemeConfig config) {
    final seed = config.seedColor ?? Colors.blue;
    final base = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: config.brightness,
      primary: config.primary,
      secondary: config.secondary,
      tertiary: config.tertiary,
      surface: config.surface,
      error: config.error,
    );
    final isLight = config.brightness == Brightness.light;

    // Pixel Specifics:
    // Retro feel. High contrast borders.
    final highContrast = isLight ? Colors.black : Colors.white;
    final styleShadow = highContrast;
    
    // Borders are always visible
    final subtleBorder = highContrast.withValues(alpha: 0.5);

    return AppColorScheme(
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

      highContrastBorder: config.customHighContrastBorder ?? highContrast,
      subtleBorder: subtleBorder,
      styleBackground: base.surface,
      styleShadow: styleShadow,
      glowColor: Colors.transparent, // No glow in standard pixel UI

      signalStrong: config.customSignalStrong ?? Colors.green,
      signalWeak: config.customSignalWeak ?? Colors.orange,
      signalGlow: Colors.transparent,

      activeFillColor: base.primary,
      activeContentColor: base.onPrimary,
      
      overlayColor: config.customOverlayColor ?? highContrast.withValues(alpha: 0.5), // Dithering simulated by alpha or texture
    );
  }
}