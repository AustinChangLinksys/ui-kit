import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'pin_input_style.tailor.dart';

enum PinCellShape {
  underline,
  box,
  circle,
  recess,
}

@TailorMixin()
class PinInputStyle extends ThemeExtension<PinInputStyle> with _$PinInputStyleTailorMixin {
  @override
  final PinCellShape cellShape;
  @override
  final bool fillOnInput;       // Pixel (Invert colors)
  @override
  final bool glowOnActive;      // Glass
  @override
  final TextStyle textStyle;    // Mono for Pixel
  @override
  final double cellSpacing;
  @override
  final double cellSize;

  PinInputStyle({
    required this.cellShape,
    required this.fillOnInput,
    required this.glowOnActive,
    required this.textStyle,
    required this.cellSpacing,
    required this.cellSize,
  });
}
