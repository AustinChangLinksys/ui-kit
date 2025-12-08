import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'shared/overlay_spec.dart';

part 'expandable_fab_style.tailor.dart';

enum FabAnimationType {
  fanOut,
  float,
  gridSnap,
  spring,
}

@TailorMixin()
class ExpandableFabStyle extends ThemeExtension<ExpandableFabStyle>
    with _$ExpandableFabStyleTailorMixin {
  const ExpandableFabStyle({
    required this.shape,
    required this.distance,
    required this.type,
    required this.overlay,
    required this.showDitherPattern,
    required this.glowEffect,
    required this.highContrastBorder,
  });

  /// Shape & Geometry - Circle vs Square
  @override
  final BoxShape shape;

  /// Distance of satellite actions
  @override
  final double distance;

  /// Animation strategy
  @override
  final FabAnimationType type;

  /// Overlay appearance (scrim, blur, animation)
  @override
  final OverlaySpec overlay;

  /// Pixel theme dither pattern
  @override
  final bool showDitherPattern;

  /// Glass theme glow effect
  @override
  final bool glowEffect;

  /// Pixel/Brutal high contrast border
  @override
  final bool highContrastBorder;

  // --- Backward Compatibility Getters ---

  /// Overlay color (convenience getter for backward compatibility)
  @override
  Color get overlayColor => overlay.scrimColor;

  /// Enable blur (convenience getter for backward compatibility)
  @override
  bool get enableBlur => overlay.blurStrength > 0;
}
