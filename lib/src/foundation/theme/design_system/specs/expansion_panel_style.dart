import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'expansion_panel_style.tailor.dart';

@TailorMixin()
class ExpansionPanelStyle extends ThemeExtension<ExpansionPanelStyle>
    with _$ExpansionPanelStyleTailorMixin {
  const ExpansionPanelStyle({
    required this.headerColor,
    required this.expandedBackgroundColor,
    required this.headerTextColor,
    required this.expandIcon,
    required this.animationDuration,
  });

  /// Background color of panel headers
  @override
  final Color headerColor;

  /// Background color when panel is expanded
  @override
  final Color expandedBackgroundColor;

  /// Text color of header text
  @override
  final Color headerTextColor;

  /// Icon used for expand/collapse indicator
  @override
  final IconData expandIcon;

  /// Animation duration for expand/collapse
  @override
  final Duration animationDuration;
}
