import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/state_color_spec.dart';

part 'chip_group_style.tailor.dart';

@TailorMixin()
class ChipGroupStyle extends ThemeExtension<ChipGroupStyle>
    with _$ChipGroupStyleTailorMixin {
  const ChipGroupStyle({
    required this.backgroundColors,
    required this.textColors,
    required this.selectedBorderColor,
    required this.borderRadius,
  });

  /// State-based colors for chip backgrounds.
  /// Use [backgroundColors.resolve(isActive: isSelected)] to get the appropriate color.
  @override
  final StateColorSpec backgroundColors;

  /// State-based colors for chip text.
  /// Use [textColors.resolve(isActive: isSelected)] to get the appropriate color.
  @override
  final StateColorSpec textColors;

  /// Border color of selected chips
  @override
  final Color selectedBorderColor;

  /// Border radius for chip corners
  @override
  final double borderRadius;

  // --- Backward Compatibility ---

  /// Background color of unselected chips (convenience getter).
  @override
  Color get unselectedBackground => backgroundColors.inactive;

  /// Text color of unselected chips (convenience getter).
  @override
  Color get unselectedText => textColors.inactive;

  /// Background color of selected chips (convenience getter).
  @override
  Color get selectedBackground => backgroundColors.active;

  /// Text color of selected chips (convenience getter).
  @override
  Color get selectedText => textColors.active;

  /// Create a copy with selective overrides.
  ChipGroupStyle withOverride({
    StateColorSpec? backgroundColors,
    StateColorSpec? textColors,
    Color? selectedBorderColor,
    double? borderRadius,
  }) {
    return ChipGroupStyle(
      backgroundColors: backgroundColors ?? this.backgroundColors,
      textColors: textColors ?? this.textColors,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
