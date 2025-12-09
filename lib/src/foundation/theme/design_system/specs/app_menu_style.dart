import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'surface_style.dart';

part 'app_menu_style.tailor.dart';

/// Style specification for PopupMenu container and items.
/// Named AppMenuStyle to avoid conflict with Flutter's MenuStyle.
///
/// Example:
/// ```dart
/// AppMenuStyle(
///   containerStyle: SurfaceStyle(...),
///   itemStyle: SurfaceStyle(...),
///   itemHoverStyle: SurfaceStyle(...),
///   destructiveItemStyle: SurfaceStyle(...),
///   itemHeight: 48.0,
/// )
/// ```
@TailorMixin()
class AppMenuStyle extends ThemeExtension<AppMenuStyle>
    with _$AppMenuStyleTailorMixin {
  const AppMenuStyle({
    required this.containerStyle,
    required this.itemStyle,
    required this.itemHoverStyle,
    required this.destructiveItemStyle,
    this.itemHeight = 48.0,
    this.itemHorizontalPadding = 16.0,
    this.iconSize = 24.0,
    this.iconLabelSpacing = 12.0,
  });

  /// Popup container background, border, shadow.
  @override
  final SurfaceStyle containerStyle;

  /// Default menu item appearance.
  @override
  final SurfaceStyle itemStyle;

  /// Hovered/focused item appearance.
  @override
  final SurfaceStyle itemHoverStyle;

  /// Destructive action item (error color).
  @override
  final SurfaceStyle destructiveItemStyle;

  /// Minimum item height (48.0 for a11y).
  @override
  final double itemHeight;

  /// Horizontal padding inside items.
  @override
  final double itemHorizontalPadding;

  /// Leading icon size.
  @override
  final double iconSize;

  /// Gap between icon and label.
  @override
  final double iconLabelSpacing;
}
