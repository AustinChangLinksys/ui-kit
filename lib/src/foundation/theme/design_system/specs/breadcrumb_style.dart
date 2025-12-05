import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'breadcrumb_style.tailor.dart';

@TailorMixin()
class BreadcrumbStyle extends ThemeExtension<BreadcrumbStyle>
    with _$BreadcrumbStyleTailorMixin {
  const BreadcrumbStyle({
    required this.activeLinkColor,
    required this.inactiveLinkColor,
    required this.separatorColor,
    required this.separatorText,
    required this.itemTextStyle,
  });

  /// Color of tappable breadcrumb items
  @override
  final Color activeLinkColor;

  /// Color of the current location (non-tappable)
  @override
  final Color inactiveLinkColor;

  /// Color of separator characters
  @override
  final Color separatorColor;

  /// Separator text between items (/, >, |, etc.)
  @override
  final String separatorText;

  /// Text style for breadcrumb items
  @override
  final TextStyle itemTextStyle;
}
