import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'chip_group_style.tailor.dart';

@TailorMixin()
class ChipGroupStyle extends ThemeExtension<ChipGroupStyle>
    with _$ChipGroupStyleTailorMixin {
  const ChipGroupStyle({
    required this.unselectedBackground,
    required this.unselectedText,
    required this.selectedBackground,
    required this.selectedText,
    required this.selectedBorderColor,
    required this.borderRadius,
  });

  /// Background color of unselected chips
  @override
  final Color unselectedBackground;

  /// Text color of unselected chips
  @override
  final Color unselectedText;

  /// Background color of selected chips
  @override
  final Color selectedBackground;

  /// Text color of selected chips
  @override
  final Color selectedText;

  /// Border color of selected chips
  @override
  final Color selectedBorderColor;

  /// Border radius for chip corners
  @override
  final double borderRadius;
}
