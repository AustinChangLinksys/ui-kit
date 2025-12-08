import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'divider_style.dart';
import 'surface_style.dart';

part 'app_bar_style.tailor.dart';

/// Style specification for AppBar and SliverAppBar components.
///
/// Example:
/// ```dart
/// AppBarStyle(
///   containerStyle: SurfaceStyle(...),
///   dividerStyle: DividerStyle(...),
///   height: 56.0,
///   collapsedHeight: 56.0,
///   expandedHeight: 200.0,
///   flexibleSpaceBlur: 0.0,
/// )
/// ```
@TailorMixin()
class AppBarStyle extends ThemeExtension<AppBarStyle>
    with _$AppBarStyleTailorMixin {
  const AppBarStyle({
    required this.containerStyle,
    this.bottomContainerStyle,
    required this.dividerStyle,
    this.height = 56.0,
    this.collapsedHeight = 56.0,
    this.expandedHeight = 200.0,
    this.flexibleSpaceBlur = 0.0,
  });

  /// Background, border, shadow for main AppBar container.
  @override
  final SurfaceStyle containerStyle;

  /// Style for bottom area (TabBar container).
  @override
  final SurfaceStyle? bottomContainerStyle;

  /// Bottom divider (hairline for Flat, thick for Pixel).
  @override
  final DividerStyle dividerStyle;

  /// Standard AppBar height.
  @override
  final double height;

  /// Minimum height when SliverAppBar collapsed.
  @override
  final double collapsedHeight;

  /// Maximum height when SliverAppBar expanded.
  @override
  final double expandedHeight;

  /// Blur sigma for Glass mode flexibleSpace overlay (0 for non-Glass).
  @override
  final double flexibleSpaceBlur;
}
