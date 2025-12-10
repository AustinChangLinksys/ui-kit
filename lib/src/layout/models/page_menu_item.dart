import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Enum defining menu positioning options for responsive layout
enum MenuPosition {
  /// Menu appears on the left side of the content
  left,

  /// Menu appears on the right side of the content
  right,

  /// Menu appears at the top (mobile/tablet mode)
  top,

  /// Menu is hidden
  none,
}

/// Configuration class for individual page menu items
///
/// This class follows UI Kit constitutional compliance by using Equatable
/// for value equality and providing immutable configuration options.
class PageMenuItem extends Equatable {
  /// The display label for the menu item
  final String label;

  /// The icon to display with the menu item
  final IconData? icon;

  /// Whether this menu item is currently selected
  final bool isSelected;

  /// Whether this menu item is enabled (interactive)
  final bool enabled;

  /// Callback when the menu item is tapped
  final VoidCallback? onTap;

  /// Whether this is a divider item (visual separator)
  final bool isDivider;

  /// Creates a regular menu item
  const PageMenuItem({
    required this.label,
    this.icon,
    this.isSelected = false,
    this.enabled = true,
    this.onTap,
  }) : isDivider = false;

  /// Creates a divider menu item (visual separator)
  const PageMenuItem.divider()
      : label = '',
        icon = null,
        isSelected = false,
        enabled = false,
        onTap = null,
        isDivider = true;

  /// Factory constructor for navigation menu items
  factory PageMenuItem.navigation({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return PageMenuItem(
      label: label,
      icon: icon,
      onTap: onTap,
      isSelected: isSelected,
      enabled: true,
    );
  }

  /// Factory constructor for action menu items (usually appear in app bar)
  factory PageMenuItem.action({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return PageMenuItem(
      label: label,
      icon: icon,
      onTap: onTap,
      enabled: enabled,
      isSelected: false,
    );
  }

  /// Factory constructor for settings menu items
  factory PageMenuItem.settings({
    required String label,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return PageMenuItem(
      label: label,
      icon: Icons.settings,
      onTap: onTap,
      isSelected: isSelected,
      enabled: true,
    );
  }

  /// Factory constructor for help/info menu items
  factory PageMenuItem.help({
    required String label,
    required VoidCallback onTap,
  }) {
    return PageMenuItem(
      label: label,
      icon: Icons.help_outline,
      onTap: onTap,
      isSelected: false,
      enabled: true,
    );
  }

  /// Creates a copy of this menu item with the given fields replaced
  PageMenuItem copyWith({
    String? label,
    IconData? icon,
    bool? isSelected,
    bool? enabled,
    VoidCallback? onTap,
  }) {
    if (isDivider) {
      return const PageMenuItem.divider();
    }

    return PageMenuItem(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
      enabled: enabled ?? this.enabled,
      onTap: onTap ?? this.onTap,
    );
  }

  @override
  List<Object?> get props => [
        label,
        icon,
        isSelected,
        enabled,
        onTap,
        isDivider,
      ];

  @override
  bool get stringify => true;
}