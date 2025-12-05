import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'tabs_style.tailor.dart';

@TailorMixin()
class TabsStyle extends ThemeExtension<TabsStyle>
    with _$TabsStyleTailorMixin {
  const TabsStyle({
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.indicatorColor,
    required this.tabBackgroundColor,
    required this.animationDuration,
    required this.indicatorThickness,
  });

  /// Text color for active tab
  @override
  final Color activeTextColor;

  /// Text color for inactive tabs
  @override
  final Color inactiveTextColor;

  /// Color of the active indicator (underline or background)
  @override
  final Color indicatorColor;

  /// Background color of tab buttons
  @override
  final Color tabBackgroundColor;

  /// Animation duration for indicator transitions
  @override
  final Duration animationDuration;

  /// Thickness of the indicator line
  @override
  final double indicatorThickness;
}
