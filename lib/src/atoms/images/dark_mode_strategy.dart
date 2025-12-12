import 'package:flutter/material.dart';

/// Strategy for adapting images/SVGs in dark mode when no dark variant is provided.
///
/// Usage:
/// ```dart
/// AppImage.asset(
///   image: Assets.images.product,
///   darkStrategy: DarkModeStrategy.dimming,
/// )
/// ```
enum DarkModeStrategy {
  /// No adjustment - image is used as-is in both modes.
  /// Best for: images already designed for both light/dark modes.
  none,

  /// Apply darkening filter (10% black overlay).
  /// Best for: white product images, device photos with light backgrounds.
  dimming,

  /// Invert colors (black↔white).
  /// Best for: black/white line art, simple icons.
  invert,

  /// Reduce saturation and slightly adjust brightness.
  /// Best for: colorful photos, illustrations that are too vibrant in dark mode.
  desaturate,

  /// Reduce contrast (compress brightness range).
  /// Best for: high-contrast images that are harsh in dark mode.
  lowContrast,
}

/// Returns the [ColorFilter] for the given [DarkModeStrategy].
///
/// Returns `null` for [DarkModeStrategy.none].
ColorFilter? getColorFilterForStrategy(DarkModeStrategy strategy) {
  switch (strategy) {
    case DarkModeStrategy.none:
      return null;

    case DarkModeStrategy.dimming:
      // 10% black overlay to soften bright images
      return const ColorFilter.mode(
        Color(0x1A000000), // Colors.black12 equivalent
        BlendMode.darken,
      );

    case DarkModeStrategy.invert:
      // Color matrix for inverting RGB channels
      return const ColorFilter.matrix(<double>[
        -1, 0, 0, 0, 255, //
        0, -1, 0, 0, 255, //
        0, 0, -1, 0, 255, //
        0, 0, 0, 1, 0, //
      ]);

    case DarkModeStrategy.desaturate:
      // Reduce saturation by 40% and slightly dim
      // Luminance coefficients: R=0.2126, G=0.7152, B=0.0722
      const double saturation = 0.6; // 60% of original saturation
      const double brightness = 0.9; // 90% brightness
      const double lr = 0.2126 * (1 - saturation);
      const double lg = 0.7152 * (1 - saturation);
      const double lb = 0.0722 * (1 - saturation);
      return const ColorFilter.matrix(<double>[
        (lr + saturation) * brightness,
        lg * brightness,
        lb * brightness,
        0,
        0,
        lr * brightness,
        (lg + saturation) * brightness,
        lb * brightness,
        0,
        0,
        lr * brightness,
        lg * brightness,
        (lb + saturation) * brightness,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ]);

    case DarkModeStrategy.lowContrast:
      // Compress contrast: move values toward middle gray
      // Formula: output = (input - 0.5) * contrast + 0.5 + brightness
      const double contrast = 0.7; // 70% of original contrast
      const double offset = (1 - contrast) / 2 * 255;
      return const ColorFilter.matrix(<double>[
        contrast,
        0,
        0,
        0,
        offset,
        0,
        contrast,
        0,
        0,
        offset,
        0,
        0,
        contrast,
        0,
        offset,
        0,
        0,
        0,
        1,
        0,
      ]);
  }
}
