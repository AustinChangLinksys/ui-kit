// lib/src/foundation/theme/design_system/specs/toggle_style.dart

import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

enum ToggleContentType {
  none, // Blank
  text, // Display text (I/O)
  icon, // Display icon (Check/Close)
  grip, // Display non-slip texture (Glass style)
  dot, // Display concave dot (Neumorphic style)
}

class ToggleStyle {
  // Original content settings
  final ToggleContentType activeType;
  final ToggleContentType inactiveType;
  final String? activeText;
  final String? inactiveText;
  final IconData? activeIcon;
  final IconData? inactiveIcon;

  // Component-specific style override (Optional)
  // If these are null, AppSwitch will fall back to using the global surfaceBase/Highlight
  final SurfaceStyle? activeTrackStyle; // Track when open
  final SurfaceStyle? inactiveTrackStyle; // Track when closed
  final SurfaceStyle? thumbStyle; // Thumb style

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

  ToggleStyle copyWith({
    ToggleContentType? activeType,
    ToggleContentType? inactiveType,
    String? activeText,
    String? inactiveText,
    IconData? activeIcon,
    IconData? inactiveIcon,
    SurfaceStyle? activeTrackStyle,
    SurfaceStyle? inactiveTrackStyle,
    SurfaceStyle? thumbStyle,
  }) {
    return ToggleStyle(
      activeType: activeType ?? this.activeType,
      inactiveType: inactiveType ?? this.inactiveType,
      activeText: activeText ?? this.activeText,
      inactiveText: inactiveText ?? this.inactiveText,
      activeIcon: activeIcon ?? this.activeIcon,
      inactiveIcon: inactiveIcon ?? this.inactiveIcon,
      activeTrackStyle: activeTrackStyle ?? this.activeTrackStyle,
      inactiveTrackStyle: inactiveTrackStyle ?? this.inactiveTrackStyle,
      thumbStyle: thumbStyle ?? this.thumbStyle,
    );
  }
}
