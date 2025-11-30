import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/layout_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/navigation_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/toggle_style.dart';
import 'surface_style.dart';

part 'app_design_theme.tailor.dart';

@TailorMixin()
class AppDesignTheme extends ThemeExtension<AppDesignTheme>
    with _$AppDesignThemeTailorMixin {

  // Toggle Styles
  @override
  final ToggleStyle toggleStyle;

  // Skeleton Styles
  @override
  final SkeletonStyle skeletonStyle;

  // Input Styles
  @override
  final InputStyle inputStyle;

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
  @override
  final LayoutSpec layoutSpec;

  // Sizing
  @override
  final double buttonHeight;

  // Navigation Specs
  @override
  final NavigationStyle navigationStyle;

  const AppDesignTheme({
    required this.surfaceBase,
    required this.surfaceElevated,
    required this.surfaceHighlight,
    required this.toggleStyle,
    required this.skeletonStyle,
    required this.inputStyle,
    required this.typography,
    required this.animation,
    required this.spacingFactor,
    required this.buttonHeight,
    required this.navigationStyle,
    required this.layoutSpec,
  });
}
