import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'expandable_fab_style.tailor.dart';

enum FabAnimationType {
  fanOut,
  float,
  gridSnap,
  spring,
}

@TailorMixin()
class ExpandableFabStyle extends ThemeExtension<ExpandableFabStyle> with _$ExpandableFabStyleTailorMixin {
  // Shape & Geometry
  @override
  final BoxShape shape;         // Circle vs Square
  @override
  final double distance;        // Distance of satellite actions
  @override
  final FabAnimationType type;  // Animation strategy
  
  // Overlay/Scrim
  @override
  final Color overlayColor;
  @override
  final bool enableBlur;        // Glass
  @override
  final bool showDitherPattern; // Pixel
  
  // Visuals
  @override
  final bool glowEffect;        // Glass
  @override
  final bool highContrastBorder; // Pixel/Brutal

  ExpandableFabStyle({
    required this.shape,
    required this.distance,
    required this.type,
    required this.overlayColor,
    required this.enableBlur,
    required this.showDitherPattern,
    required this.glowEffect,
    required this.highContrastBorder,
  });
}
