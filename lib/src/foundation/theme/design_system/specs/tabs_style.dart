import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/state_color_spec.dart';

part 'tabs_style.tailor.dart';

@TailorMixin()
class TabsStyle extends ThemeExtension<TabsStyle>
    with _$TabsStyleTailorMixin {
  const TabsStyle({
    required this.textColors,
    required this.indicatorColor,
    required this.tabBackgroundColor,
    required this.animationDuration,
    required this.indicatorThickness,
  });

  /// State-based colors for tab text.
  /// Use [textColors.resolve(isActive: isSelected)] to get the appropriate color.
  @override
  final StateColorSpec textColors;

  /// Color of the active indicator (underline or background)
  @override
  final Color indicatorColor;

  /// Background color of tab buttons
  @override
  final Color tabBackgroundColor;

  /// Animation duration for indicator transitions
  @override
  final Duration animationDuration;

  /// Thickness of the indicator line
  @override
  final double indicatorThickness;

  // --- Backward Compatibility ---

  /// Text color for active tab (convenience getter).
  /// @Deprecated: Use [textColors.resolve(isActive: true)] instead.
  @override
  Color get activeTextColor => textColors.active;

  /// Text color for inactive tabs (convenience getter).
  /// @Deprecated: Use [textColors.resolve(isActive: false)] instead.
  @override
  Color get inactiveTextColor => textColors.inactive;

  /// Create a copy with selective overrides.
  TabsStyle withOverride({
    StateColorSpec? textColors,
    Color? indicatorColor,
    Color? tabBackgroundColor,
    Duration? animationDuration,
    double? indicatorThickness,
  }) {
    return TabsStyle(
      textColors: textColors ?? this.textColors,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      tabBackgroundColor: tabBackgroundColor ?? this.tabBackgroundColor,
      animationDuration: animationDuration ?? this.animationDuration,
      indicatorThickness: indicatorThickness ?? this.indicatorThickness,
    );
  }
}
