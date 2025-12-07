import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'gauge_style.tailor.dart';

enum GaugeRenderType {
  gradient,
  segmented,
  solid,
}

enum GaugeCapType {
  round,
  butt,
  comet,
  bead,
}

@TailorMixin()
class GaugeStyle extends ThemeExtension<GaugeStyle> with _$GaugeStyleTailorMixin {
  // Rendering Strategy
  @override
  final GaugeRenderType type;
  @override
  final GaugeCapType cap;

  // Colors & visual props
  @override
  final Color trackColor;
  @override
  final Color indicatorColor; // Primary indicator color for the progress arc
  @override
  final bool showTicks;
  @override
  final int? tickCount;
  @override
  final double? tickInterval;
  @override
  final double strokeWidth;
  @override
  final bool enableGlow;

  // Arc geometry (matching AnimatedMeter)
  @override
  final double fillRatio; // 0.8 = 288 degrees (like old AnimatedMeter)
  @override
  final double offsetAngle; // Starting offset angle

  // Marker configuration
  @override
  final double markerRadius;
  @override
  final bool displayMarkerValues;
  @override
  final Color markerColor;

  // Inner glow effect
  @override
  final double innerGlowWidth;
  @override
  final double innerGlowOpacity;

  // Animation
  @override
  final Duration animationDuration;
  @override
  final Curve animationCurve;

  GaugeStyle({
    required this.type,
    required this.cap,
    required this.trackColor,
    required this.indicatorColor,
    required this.showTicks,
    this.tickCount,
    this.tickInterval,
    required this.strokeWidth,
    required this.enableGlow,
    this.fillRatio = 0.8,
    this.offsetAngle = 0.942, // (2π/20) * 3 ≈ 0.942 radians (54 degrees)
    this.markerRadius = 4.0,
    this.displayMarkerValues = true,
    this.markerColor = Colors.white,
    this.innerGlowWidth = 80.0,
    this.innerGlowOpacity = 0.1,
    this.animationDuration = const Duration(milliseconds: 100),
    this.animationCurve = Curves.easeOut,
  });
}
