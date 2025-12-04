import 'package:flutter/material.dart';

/// Data class representing a single menu item.
class AppPopupMenuItem<T> {
  const AppPopupMenuItem({
    required this.value,
    required this.label,
    this.icon,
    this.isDestructive = false,
    this.enabled = true,
    this.hasSubmenu = false,
  }) : assert(label.length > 0, 'Menu item label cannot be empty');

  /// Return value when selected.
  final T value;

  /// Display text.
  final String label;

  /// Optional leading icon.
  final IconData? icon;

  /// Destructive action flag.
  final bool isDestructive;

  /// Item enabled state.
  final bool enabled;

  /// Whether this item opens a submenu (shows chevron indicator).
  final bool hasSubmenu;
}
