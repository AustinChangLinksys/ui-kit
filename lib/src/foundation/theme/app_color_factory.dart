import 'dart:convert';

import 'package:flutter/material.dart';
import '../color_utils.dart';
import 'app_color_scheme.dart';
import 'app_theme_config.dart';

class AppColorFactory {
  /// Creates an [AppColorScheme] from a JSON string.
  ///
  /// If the JSON contains a `style` key, it generates the scheme using the corresponding
  /// factory method (e.g., `generateNeumorphic`) with the provided `config`.
  ///
  /// If `style` is not present or is 'custom', it attempts to parse a raw
  /// scheme definition directly from the JSON fields, falling back to a default
  /// scheme for any missing fields.
  static AppColorScheme createSchemeFromJson(String jsonString) {
    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      final style = map['style'] as String?;

      if (style != null && style != 'custom') {
        final configMap = map['config'] as Map<String, dynamic>? ?? {};
        final config = AppThemeConfig.fromJson(configMap);

        switch (style.toLowerCase()) {
          case 'glass':
            return generateGlass(config);
          case 'brutal':
            return generateBrutal(config);
          case 'flat':
            return generateFlat(config);
          case 'pixel':
            return generatePixel(config);
          case 'neumorphic':
          default:
            return generateNeumorphic(config);
        }
      }

      // Raw/Custom mode: Parse all fields directly
      // Fallback to a default base scheme (e.g. Neumorphic Light Blue) for missing fields
      final fallback =
          generateNeumorphic(const AppThemeConfig(seedColor: Colors.blue));

      Color parse(String key, Color defaultValue) {
        final value = map[key];
        if (value is int) return Color(value);
        if (value is String) {
          try {
            final hex = value.replaceAll('#', '');
            if (hex.length == 6) {
              return Color(int.parse('FF$hex', radix: 16));
            } else if (hex.length == 8) {
              return Color(int.parse(hex, radix: 16));
            }
          } catch (_) {}
        }
        return defaultValue;
      }

      return AppColorScheme(
        // M3 Core
        primary: parse('primary', fallback.primary),
        onPrimary: parse('onPrimary', fallback.onPrimary),
        primaryContainer: parse('primaryContainer', fallback.primaryContainer),
        onPrimaryContainer:
            parse('onPrimaryContainer', fallback.onPrimaryContainer),
        secondary: parse('secondary', fallback.secondary),
        onSecondary: parse('onSecondary', fallback.onSecondary),
        secondaryContainer:
            parse('secondaryContainer', fallback.secondaryContainer),
        onSecondaryContainer:
            parse('onSecondaryContainer', fallback.onSecondaryContainer),
        tertiary: parse('tertiary', fallback.tertiary),
        onTertiary: parse('onTertiary', fallback.onTertiary),
        tertiaryContainer:
            parse('tertiaryContainer', fallback.tertiaryContainer),
        onTertiaryContainer:
            parse('onTertiaryContainer', fallback.onTertiaryContainer),
        error: parse('error', fallback.error),
        onError: parse('onError', fallback.onError),
        errorContainer: parse('errorContainer', fallback.errorContainer),
        onErrorContainer: parse('onErrorContainer', fallback.onErrorContainer),

        // M3 Surface
        surface: parse('surface', fallback.surface),
        onSurface: parse('onSurface', fallback.onSurface),
        onSurfaceVariant: parse('onSurfaceVariant', fallback.onSurfaceVariant),
        surfaceTint: parse('surfaceTint', fallback.surfaceTint),
        surfaceContainer: parse('surfaceContainer', fallback.surfaceContainer),
        surfaceContainerHigh:
            parse('surfaceContainerHigh', fallback.surfaceContainerHigh),
        surfaceContainerHighest:
            parse('surfaceContainerHighest', fallback.surfaceContainerHighest),
        surfaceContainerLow:
            parse('surfaceContainerLow', fallback.surfaceContainerLow),
        surfaceContainerLowest:
            parse('surfaceContainerLowest', fallback.surfaceContainerLowest),
        inverseSurface: parse('inverseSurface', fallback.inverseSurface),
        onInverseSurface: parse('onInverseSurface', fallback.onInverseSurface),
        inversePrimary: parse('inversePrimary', fallback.inversePrimary),

        // M3 Utility
        outline: parse('outline', fallback.outline),
        outlineVariant: parse('outlineVariant', fallback.outlineVariant),
        shadow: parse('shadow', fallback.shadow),
        scrim: parse('scrim', fallback.scrim),

        // Semantic
        highContrastBorder:
            parse('highContrastBorder', fallback.highContrastBorder),
        subtleBorder: parse('subtleBorder', fallback.subtleBorder),
        styleBackground: parse('styleBackground', fallback.styleBackground),
        styleShadow: parse('styleShadow', fallback.styleShadow),
        glowColor: parse('glowColor', fallback.glowColor),
        semanticSuccess: parse('semanticSuccess', fallback.semanticSuccess),
        onSemanticSuccess:
            parse('onSemanticSuccess', fallback.onSemanticSuccess),
        semanticWarning: parse('semanticWarning', fallback.semanticWarning),
        onSemanticWarning:
            parse('onSemanticWarning', fallback.onSemanticWarning),
        semanticDanger: parse('semanticDanger', fallback.semanticDanger),
        onSemanticDanger: parse('onSemanticDanger', fallback.onSemanticDanger),
        semanticGlow: parse('semanticGlow', fallback.semanticGlow),
        activeFillColor: parse('activeFillColor', fallback.activeFillColor),
        activeContentColor:
            parse('activeContentColor', fallback.activeContentColor),
        overlayColor: parse('overlayColor', fallback.overlayColor),
      );
    } catch (e) {
      debugPrint('Error parsing scheme JSON: $e');
      return generateNeumorphic(const AppThemeConfig(seedColor: Colors.blue));
    }
  }

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
      semanticSuccess: config.customSemanticSuccess ?? calculatedSignalStrong,
      semanticWarning: Colors.orange,
      semanticDanger:
          config.customSemanticDanger ?? base.error.withValues(alpha: 0.6),
      semanticGlow: (config.customSemanticSuccess ?? calculatedSignalStrong)
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
      semanticSuccess: config.customSemanticSuccess ?? Colors.green,
      semanticWarning: config.customSemanticWarning ?? Colors.orange,
      semanticDanger: config.customSemanticDanger ?? Colors.red,
      semanticGlow:
          (config.customSemanticSuccess ?? Colors.green).withValues(alpha: 0.4),
      activeFillColor: base.primary.withValues(alpha: 0.2),
      activeContentColor: base.primary,
      overlayColor:
          config.customOverlayColor ?? Colors.black.withValues(alpha: 0.3),
    );
  }

  static AppColorScheme generateBrutal(AppThemeConfig config) {
    final base = _generateBaseScheme(config);
    final isLight = config.brightness == Brightness.light;

    const solidBlack = Colors.black;
    const solidWhite = Colors.white;
    final highContrast = isLight ? solidBlack : solidWhite;
    final styleShadow = isLight ? solidBlack : solidWhite;

    return _assembleScheme(
      base: base,
      highContrastBorder: config.customHighContrastBorder ?? highContrast,
      subtleBorder: highContrast,
      styleBackground: base.surface,
      styleShadow: styleShadow,
      glowColor: Colors.transparent,
      semanticSuccess: config.customSemanticSuccess ?? Colors.green,
      semanticWarning: config.customSemanticWarning ?? Colors.orange,
      semanticDanger: config.customSemanticDanger ?? base.error,
      semanticGlow: Colors.transparent,
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
      semanticSuccess: config.customSemanticSuccess ?? Colors.green,
      semanticWarning: config.customSemanticWarning ?? Colors.orange,
      semanticDanger: config.customSemanticDanger ?? Colors.red,
      semanticGlow: Colors.transparent,
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
      semanticSuccess: config.customSemanticSuccess ?? Colors.green,
      semanticWarning: config.customSemanticWarning ?? Colors.orange,
      semanticDanger: config.customSemanticDanger ?? Colors.red,
      semanticGlow: Colors.transparent,
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
    required Color semanticSuccess,
    required Color semanticWarning,
    required Color semanticDanger,
    required Color semanticGlow,
    required Color activeFillColor,
    required Color activeContentColor,
    required Color overlayColor,
  }) {
    // Compute foreground colors for semantic status colors
    final onSemanticSuccess = ColorUtils.computeContrastColor(semanticSuccess);
    final onSemanticWarning = ColorUtils.computeContrastColor(semanticWarning);
    final onSemanticDanger = ColorUtils.computeContrastColor(semanticDanger);

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
      semanticSuccess: semanticSuccess,
      onSemanticSuccess: onSemanticSuccess,
      semanticWarning: semanticWarning,
      onSemanticWarning: onSemanticWarning,
      semanticDanger: semanticDanger,
      onSemanticDanger: onSemanticDanger,
      semanticGlow: semanticGlow,
      activeFillColor: activeFillColor,
      activeContentColor: activeContentColor,
      overlayColor: overlayColor,
    );
  }
}
