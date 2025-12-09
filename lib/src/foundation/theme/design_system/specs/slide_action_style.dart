import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/surface_style.dart';

import 'shared/animation_spec.dart';

part 'slide_action_style.tailor.dart';

@TailorMixin()
class SlideActionStyle extends ThemeExtension<SlideActionStyle>
    with _$SlideActionStyleTailorMixin {
  const SlideActionStyle({
    required this.standardStyle,
    required this.destructiveStyle,
    required this.borderRadius,
    required this.contentColor,
    required this.iconSize,
    required this.animation,
  });

  /// Appearance - now directly SurfaceStyle
  @override
  final SurfaceStyle standardStyle;

  @override
  final SurfaceStyle destructiveStyle;

  /// Shape - border radius for the action container
  @override
  final BorderRadius borderRadius;

  /// Content color for icons/text inside the actions
  @override
  final Color contentColor;

  @override
  final double iconSize;

  /// Animation timing for slide transitions
  @override
  final AnimationSpec animation;

  // --- Backward Compatibility Getters ---

  /// Animation duration (convenience getter for backward compatibility)
  @override
  Duration get animationDuration => animation.duration;

  /// Animation curve (convenience getter for backward compatibility)
  @override
  Curve get animationCurve => animation.curve;
}
