import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/state_color_spec.dart';

part 'breadcrumb_style.tailor.dart';

@TailorMixin()
class BreadcrumbStyle extends ThemeExtension<BreadcrumbStyle>
    with _$BreadcrumbStyleTailorMixin {
  const BreadcrumbStyle({
    required this.linkColors,
    required this.separatorColor,
    required this.separatorText,
    required this.itemTextStyle,
  });

  /// State-based colors for breadcrumb links.
  /// Use [linkColors.resolve(isActive: isTappable)] to get the appropriate color.
  /// - active: tappable items (parent links)
  /// - inactive: current location (non-tappable)
  @override
  final StateColorSpec linkColors;

  /// Color of separator characters
  @override
  final Color separatorColor;

  /// Separator text between items (/, >, |, etc.)
  @override
  final String separatorText;

  /// Text style for breadcrumb items
  @override
  final TextStyle itemTextStyle;

  // --- Backward Compatibility ---

  /// Color of tappable breadcrumb items (convenience getter).
  @override
  Color get activeLinkColor => linkColors.active;

  /// Color of the current location (non-tappable) (convenience getter).
  @override
  Color get inactiveLinkColor => linkColors.inactive;

  /// Create a copy with selective overrides.
  BreadcrumbStyle withOverride({
    StateColorSpec? linkColors,
    Color? separatorColor,
    String? separatorText,
    TextStyle? itemTextStyle,
  }) {
    return BreadcrumbStyle(
      linkColors: linkColors ?? this.linkColors,
      separatorColor: separatorColor ?? this.separatorColor,
      separatorText: separatorText ?? this.separatorText,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
    );
  }
}
