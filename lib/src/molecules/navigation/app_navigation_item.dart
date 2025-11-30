import 'package:flutter/widgets.dart';

/// Represents a single item in the [AppNavigationBar].
class AppNavigationItem {
  const AppNavigationItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  /// The icon to display when the item is not selected.
  final Widget icon;

  /// The text label for the item.
  final String label;

  /// The icon to display when the item is selected.
  /// If null, [icon] is used.
  final Widget? activeIcon;
}
