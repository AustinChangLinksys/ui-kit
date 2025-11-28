import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/toggle_style.dart';
import 'surface_style.dart';

part 'app_design_theme.tailor.dart';

@TailorMixin()
class AppDesignTheme extends ThemeExtension<AppDesignTheme>
    with _$AppDesignThemeTailorMixin {

  // Toggle Styles
  @override
  final ToggleStyle toggleStyle;
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
    required this.toggleStyle,
    required this.typography,
    required this.animation,
    required this.spacingFactor,
  });
}
