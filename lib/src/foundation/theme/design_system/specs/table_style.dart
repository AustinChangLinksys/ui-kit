import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'shared/animation_spec.dart';

part 'table_style.tailor.dart';

@TailorMixin()
class TableStyle extends ThemeExtension<TableStyle> with _$TableStyleTailorMixin {
  const TableStyle({
    required this.headerBackground,
    required this.rowBackground,
    required this.gridColor,
    required this.gridWidth,
    required this.showVerticalGrid,
    required this.cellPadding,
    required this.rowHeight,
    required this.headerTextStyle,
    required this.cellTextStyle,
    required this.invertRowOnHover,
    required this.glowRowOnHover,
    required this.hoverRowBackground,
    required this.hoverRowContentColor,
    required this.modeTransition,
  });

  // Appearance
  /// Nullable for Glass (transparent)
  @override
  final Color? headerBackground;

  @override
  final Color rowBackground;

  @override
  final Color gridColor;

  /// 0.0 for Glass, 1.0+ for Pixel
  @override
  final double gridWidth;

  @override
  final bool showVerticalGrid;

  // Interaction Colors (IoC)
  @override
  final Color? hoverRowBackground;

  @override
  final Color? hoverRowContentColor;

  // Metrics
  /// Dense vs Spacious
  @override
  final EdgeInsetsGeometry cellPadding;

  @override
  final double rowHeight;

  @override
  final TextStyle headerTextStyle;

  @override
  final TextStyle cellTextStyle;

  // Behavior
  /// For Pixel style
  @override
  final bool invertRowOnHover;

  /// For Glass style
  @override
  final bool glowRowOnHover;

  /// Animation timing for mode transitions (0ms for Pixel, 500ms for Glass)
  @override
  final AnimationSpec modeTransition;

  // --- Backward Compatibility Getters ---

  /// Mode transition duration (convenience getter for backward compatibility)
  @override
  Duration get modeTransitionDuration => modeTransition.duration;
}
