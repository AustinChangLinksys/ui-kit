import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'shared/animation_spec.dart';
import 'shared/state_color_spec.dart';

part 'carousel_style.tailor.dart';

@TailorMixin()
class CarouselStyle extends ThemeExtension<CarouselStyle>
    with _$CarouselStyleTailorMixin {
  const CarouselStyle({
    required this.navButtonColors,
    required this.previousIcon,
    required this.nextIcon,
    required this.animation,
    this.useSnapScroll = false,
    this.navButtonSize = 48.0,
  });

  /// Navigation button colors (inactive/hover states)
  @override
  final StateColorSpec navButtonColors;

  /// Icon for previous button
  @override
  final IconData previousIcon;

  /// Icon for next button
  @override
  final IconData nextIcon;

  /// Animation timing for item transitions
  @override
  final AnimationSpec animation;

  /// Use snap scroll instead of smooth scroll (Pixel theme)
  @override
  final bool useSnapScroll;

  /// Size of navigation buttons (Pixel theme has larger buttons)
  @override
  final double navButtonSize;

  // --- Backward Compatibility Getters ---

  /// Animation duration (convenience getter for backward compatibility)
  @override
  Duration get animationDuration => animation.duration;

  /// Animation curve (convenience getter for backward compatibility)
  @override
  Curve get animationCurve => animation.curve;

  /// Navigation button color (convenience getter for backward compatibility)
  @override
  Color get navButtonColor => navButtonColors.inactive;

  /// Navigation button hover color (convenience getter for backward compatibility)
  @override
  Color get navButtonHoverColor =>
      navButtonColors.hover ?? navButtonColors.active;
}
