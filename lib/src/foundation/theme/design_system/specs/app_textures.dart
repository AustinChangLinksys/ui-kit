import 'package:flutter/material.dart';

/// Defines different texture patterns that can be applied to surfaces.
/// These are typically rendered as shaders or overlaid images.
enum AppTextures {
  none,
  noise,
  pixelGrid,
  scanlines,
}

/// Extension on [AppTextures] to provide utility methods.
extension AppTexturesExtension on AppTextures {
  /// Returns a descriptive name for the texture.
  String get name {
    switch (this) {
      case AppTextures.none:
        return 'None';
      case AppTextures.noise:
        return 'Noise';
      case AppTextures.pixelGrid:
        return 'Pixel Grid';
      case AppTextures.scanlines:
        return 'Scanlines';
    }
  }

  /// Returns true if the texture is active (not 'none').
  bool get isActive => this != AppTextures.none;

  /// Returns the corresponding [BlendMode] for this texture.
  /// Used for overlaying textures on a background.
  BlendMode get blendMode {
    switch (this) {
      case AppTextures.noise:
        return BlendMode.overlay;
      case AppTextures.pixelGrid:
        return BlendMode.srcOver;
      case AppTextures.scanlines:
        return BlendMode.srcOver;
      case AppTextures.none:
        return BlendMode.srcOver; // Not used when none
    }
  }
}
