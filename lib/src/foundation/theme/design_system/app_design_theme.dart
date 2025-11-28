import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'surface_style.dart';

part 'app_design_theme.tailor.dart';

@TailorMixin()
class AppDesignTheme extends ThemeExtension<AppDesignTheme>
    with _$AppDesignThemeTailorMixin {
  // Surface Styles (Containers)
  @override
  final SurfaceStyle surfaceBase;
  @override
  final SurfaceStyle surfaceElevated;
  @override
  final SurfaceStyle surfaceHighlight;

  // Specifications
  @override
  final TypographySpec typography;
  @override
  final AnimationSpec animation;
  @override
  final double spacingFactor;

  const AppDesignTheme({
    required this.surfaceBase,
    required this.surfaceElevated,
    required this.surfaceHighlight,
    required this.typography,
    required this.animation,
    required this.spacingFactor,
  });
}