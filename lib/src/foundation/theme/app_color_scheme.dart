import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_color_scheme.tailor.dart';

@TailorMixin()
class AppColorScheme extends ThemeExtension<AppColorScheme>
    with _$AppColorSchemeTailorMixin {
  // ==========================================================
  // 1. Material Standard Colors (Standard Layer)
  // ==========================================================
  @override
  final Color primary;
  @override
  final Color onPrimary;
  @override
  final Color primaryContainer;
  @override
  final Color onPrimaryContainer;

  @override
  final Color secondary;
  @override
  final Color onSecondary;
  @override
  final Color secondaryContainer;
  @override
  final Color onSecondaryContainer;

  @override
  final Color tertiary;
  @override
  final Color onTertiary;
  @override
  final Color tertiaryContainer;
  @override
  final Color onTertiaryContainer;

  @override
  final Color error;
  @override
  final Color onError;
  @override
  final Color errorContainer;

  @override
  final Color onErrorContainer;

  @override
  final Color surface;
  @override
  final Color onSurface;
  @override
  final Color onSurfaceVariant;
  @override
  final Color surfaceTint;

  @override
  final Color surfaceContainer;
  @override
  final Color surfaceContainerHigh;
  @override
  final Color surfaceContainerHighest;
  @override
  final Color surfaceContainerLow;
  @override
  final Color surfaceContainerLowest;

  @override
  final Color inverseSurface;
  @override
  final Color onInverseSurface;
  @override
  final Color inversePrimary;

  @override
  final Color outline;
  @override
  final Color outlineVariant;
  @override
  final Color shadow;
  @override
  final Color scrim;

  // ==========================================================
  // 2. Semantic Style Palette (Style Semantic Layer)
  // ==========================================================

  // Structure
  @override
  final Color highContrastBorder;
  @override
  final Color subtleBorder;
  @override
  final Color styleBackground;

  // Decoration
  @override
  final Color styleShadow;
  @override
  final Color glowColor;

  // Semantic Status Colors
  @override
  final Color semanticSuccess; // 🟢 Good state (background)
  @override
  final Color onSemanticSuccess; // 🟢 Good state (foreground)
  @override
  final Color semanticWarning; // 🟡 Moderate state (background)
  @override
  final Color onSemanticWarning; // 🟡 Moderate state (foreground)
  @override
  final Color semanticDanger; // 🔴 Bad state (background)
  @override
  final Color onSemanticDanger; // 🔴 Bad state (foreground)
  @override
  final Color semanticGlow; // Glow for positive states

  // State
  @override
  final Color activeFillColor;
  @override
  final Color activeContentColor;

  // Utility
  @override
  final Color overlayColor; // Barrier/Scrim overlay

  const AppColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.surfaceTint,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.surfaceContainerLow,
    required this.surfaceContainerLowest,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.highContrastBorder,
    required this.subtleBorder,
    required this.styleBackground,
    required this.styleShadow,
    required this.glowColor,
    required this.semanticSuccess,
    required this.onSemanticSuccess,
    required this.semanticWarning,
    required this.onSemanticWarning,
    required this.semanticDanger,
    required this.onSemanticDanger,
    required this.semanticGlow,
    required this.activeFillColor,
    required this.activeContentColor,
    required this.overlayColor,
  });

  /// Helper: Convert back to Flutter native ColorScheme (for MaterialApp)
  ColorScheme toMaterialScheme({required Brightness brightness}) {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      surfaceTint: surfaceTint,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainerLowest: surfaceContainerLowest,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
    );
  }
}
