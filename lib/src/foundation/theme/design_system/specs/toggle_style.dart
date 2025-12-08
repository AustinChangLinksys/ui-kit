import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

part 'toggle_style.tailor.dart';

/// Content type displayed on toggle thumb.
enum ToggleContentType {
  none, // Blank
  text, // Display text (I/O)
  icon, // Display icon (Check/Close)
  grip, // Display non-slip texture (Glass style)
  dot, // Display concave dot (Neumorphic style)
}

/// Style specification for toggle/switch components.
///
/// Example:
/// ```dart
/// ToggleStyle(
///   activeType: ToggleContentType.icon,
///   inactiveType: ToggleContentType.none,
///   activeIcon: Icons.check,
/// )
/// ```
@TailorMixin()
class ToggleStyle extends ThemeExtension<ToggleStyle>
    with _$ToggleStyleTailorMixin {
  const ToggleStyle({
    this.activeType = ToggleContentType.none,
    this.inactiveType = ToggleContentType.none,
    this.activeText,
    this.inactiveText,
    this.activeIcon,
    this.inactiveIcon,
    this.activeTrackStyle,
    this.inactiveTrackStyle,
    this.thumbStyle,
  });

  /// Content type for active state.
  @override
  final ToggleContentType activeType;

  /// Content type for inactive state.
  @override
  final ToggleContentType inactiveType;

  /// Text displayed when active (if activeType is text).
  @override
  final String? activeText;

  /// Text displayed when inactive (if inactiveType is text).
  @override
  final String? inactiveText;

  /// Icon displayed when active (if activeType is icon).
  @override
  final IconData? activeIcon;

  /// Icon displayed when inactive (if inactiveType is icon).
  @override
  final IconData? inactiveIcon;

  // Component-specific style override (Optional)
  // If these are null, AppSwitch will fall back to using the global surfaceBase/Highlight
  /// Track style when toggle is active.
  @override
  final SurfaceStyle? activeTrackStyle;

  /// Track style when toggle is inactive.
  @override
  final SurfaceStyle? inactiveTrackStyle;

  /// Thumb style for the toggle.
  @override
  final SurfaceStyle? thumbStyle;
}
