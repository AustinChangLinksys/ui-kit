import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'carousel_style.tailor.dart';

@TailorMixin()
class CarouselStyle extends ThemeExtension<CarouselStyle>
    with _$CarouselStyleTailorMixin {
  const CarouselStyle({
    required this.navButtonColor,
    required this.navButtonHoverColor,
    required this.previousIcon,
    required this.nextIcon,
    required this.animationDuration,
    required this.animationCurve,
    this.useSnapScroll = false,
    this.navButtonSize = 48.0,
  });

  /// Color of navigation buttons
  @override
  final Color navButtonColor;

  /// Color of navigation buttons on hover
  @override
  final Color navButtonHoverColor;

  /// Icon for previous button
  @override
  final IconData previousIcon;

  /// Icon for next button
  @override
  final IconData nextIcon;

  /// Animation duration for item transitions
  @override
  final Duration animationDuration;

  /// Animation curve for item transitions
  @override
  final Curve animationCurve;

  /// Use snap scroll instead of smooth scroll (Pixel theme)
  @override
  final bool useSnapScroll;

  /// Size of navigation buttons (Pixel theme has larger buttons)
  @override
  final double navButtonSize;
}
