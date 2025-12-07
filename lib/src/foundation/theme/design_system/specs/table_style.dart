import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

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
    required this.modeTransitionDuration,
  });

  // Appearance
  @override
  final Color? headerBackground; // Nullable for Glass (transparent)
  @override
  final Color rowBackground;
  @override
  final Color gridColor;
  @override
  final double gridWidth; // 0.0 for Glass, 1.0+ for Pixel
  @override
  final bool showVerticalGrid;

  // Interaction Colors (IoC)
  @override
  final Color? hoverRowBackground;
  @override
  final Color? hoverRowContentColor;

  // Metrics
  @override
  final EdgeInsetsGeometry cellPadding; // Dense vs Spacious
  @override
  final double rowHeight;
  @override
  final TextStyle headerTextStyle;
  @override
  final TextStyle cellTextStyle;

  // Behavior
  @override
  final bool invertRowOnHover; // For Pixel style
  @override
  final bool glowRowOnHover; // For Glass style
  @override
  final Duration modeTransitionDuration; // 0ms for Pixel, 500ms for Glass
}