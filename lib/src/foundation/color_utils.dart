import 'package:flutter/material.dart';

/// Color utility functions for the UI Kit.
///
/// These utilities provide dynamic color calculations for accessibility
/// and theming purposes.
class ColorUtils {
  ColorUtils._();

  /// Computes an appropriate foreground (text/icon) color for a given background.
  ///
  /// Uses WCAG luminance calculation to determine if the background is
  /// "light" or "dark", then returns black or white accordingly.
  ///
  /// **Usage:**
  /// ```dart
  /// final backgroundColor = scheme.semanticSuccess;
  /// final textColor = ColorUtils.computeContrastColor(backgroundColor);
  /// ```
  ///
  /// **Parameters:**
  /// - [background]: The background color to compute contrast for.
  /// - [lightForeground]: The color to use on dark backgrounds. Defaults to white.
  /// - [darkForeground]: The color to use on light backgrounds. Defaults to black.
  /// - [threshold]: Luminance threshold (0.0-1.0). Higher values favor dark foreground.
  ///   Defaults to 0.5 (standard WCAG).
  ///
  /// **Returns:** An appropriate foreground color for the given background.
  static Color computeContrastColor(
    Color background, {
    Color lightForeground = Colors.white,
    Color darkForeground = Colors.black,
    double threshold = 0.5,
  }) {
    final luminance = background.computeLuminance();
    return luminance > threshold ? darkForeground : lightForeground;
  }

  /// Computes a foreground color with a specific opacity.
  ///
  /// Useful for secondary text or disabled states on colored backgrounds.
  ///
  /// **Usage:**
  /// ```dart
  /// final secondaryText = ColorUtils.computeContrastColorWithOpacity(
  ///   scheme.semanticWarning,
  ///   opacity: 0.7,
  /// );
  /// ```
  static Color computeContrastColorWithOpacity(
    Color background, {
    double opacity = 1.0,
    Color lightForeground = Colors.white,
    Color darkForeground = Colors.black,
    double threshold = 0.5,
  }) {
    final baseColor = computeContrastColor(
      background,
      lightForeground: lightForeground,
      darkForeground: darkForeground,
      threshold: threshold,
    );
    return baseColor.withValues(alpha: opacity);
  }

  /// Checks if a color is considered "light" based on its luminance.
  ///
  /// **Returns:** `true` if the color's luminance is above the threshold.
  static bool isLightColor(Color color, {double threshold = 0.5}) {
    return color.computeLuminance() > threshold;
  }

  /// Checks if a color is considered "dark" based on its luminance.
  ///
  /// **Returns:** `true` if the color's luminance is below or equal to the threshold.
  static bool isDarkColor(Color color, {double threshold = 0.5}) {
    return !isLightColor(color, threshold: threshold);
  }

  /// Blends two colors together with a given ratio.
  ///
  /// **Parameters:**
  /// - [color1]: The first color.
  /// - [color2]: The second color.
  /// - [ratio]: The blend ratio (0.0 = 100% color1, 1.0 = 100% color2).
  ///
  /// **Returns:** The blended color.
  static Color blend(Color color1, Color color2, double ratio) {
    return Color.lerp(color1, color2, ratio.clamp(0.0, 1.0))!;
  }
}
