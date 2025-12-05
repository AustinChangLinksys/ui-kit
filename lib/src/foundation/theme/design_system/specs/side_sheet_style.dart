import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'side_sheet_style.tailor.dart';

@TailorMixin()
class SideSheetStyle extends ThemeExtension<SideSheetStyle>
    with _$SideSheetStyleTailorMixin {
  const SideSheetStyle({
    required this.width,
    required this.overlayColor,
    required this.animationDuration,
    required this.animationCurve,
    required this.blurStrength,
    required this.enableDithering,
  });

  /// Width of the side sheet (drawer)
  @override
  final double width;

  /// Scrim overlay color when sheet is open
  @override
  final Color overlayColor;

  /// Animation duration for slide in/out
  @override
  final Duration animationDuration;

  /// Animation curve for slide transitions
  @override
  final Curve animationCurve;

  /// Blur strength for glass effect (0 for non-glass themes)
  @override
  final double blurStrength;

  /// Enable dithering texture (Pixel theme)
  @override
  final bool enableDithering;
}
