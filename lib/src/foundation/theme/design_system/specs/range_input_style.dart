import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'range_input_style.tailor.dart';

@TailorMixin()
class RangeInputStyle extends ThemeExtension<RangeInputStyle>
    with _$RangeInputStyleTailorMixin {
  @override
  final bool mergeContainers; // Flat (Unified Box) vs Glass (Separated)
  @override
  final Widget? customSeparator; // Pixel (ASCII Icon) vs Flat (Text)
  @override
  final Color activeBorderColor; // semanticSuccess vs primary
  @override
  final double spacing; // Gap between inputs

  RangeInputStyle({
    required this.mergeContainers,
    this.customSeparator,
    required this.activeBorderColor,
    required this.spacing,
  });
}
