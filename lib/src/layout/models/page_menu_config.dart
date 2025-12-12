import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'page_menu_item.dart';

/// Configuration class for responsive page menu display and behavior
///
/// This class follows UI Kit constitutional compliance by using Equatable
/// for value equality and providing immutable configuration options.
///
/// Use [menuPosition] on AppPageView to control where menu items appear.
/// The system automatically handles responsive behavior based on screen size.
class PageMenuConfig extends Equatable {
  /// Optional title for the menu (typically shown on desktop sidebar)
  final String? title;

  /// List of menu items to display
  final List<PageMenuItem> items;

  /// Whether to use large menu styling (desktop sidebar)
  final bool largeMenu;

  /// Icon to use for the main trigger button (especially for FAB mode)
  /// Also serves as a fallback for mobile menu trigger if needed
  final IconData? icon;

  /// Custom location for the Floating Action Button
  final FloatingActionButtonLocation? fabLocation;

  /// Creates a new PageMenuConfig instance
  const PageMenuConfig({
    this.title,
    this.items = const [],
    this.largeMenu = false,
    this.icon,
    this.fabLocation,
  });

  /// Creates a copy of this config with the given fields replaced
  PageMenuConfig copyWith({
    String? title,
    List<PageMenuItem>? items,
    bool? largeMenu,
    IconData? icon,
    FloatingActionButtonLocation? fabLocation,
  }) {
    return PageMenuConfig(
      title: title ?? this.title,
      items: items ?? this.items,
      largeMenu: largeMenu ?? this.largeMenu,
      icon: icon ?? this.icon,
      fabLocation: fabLocation ?? this.fabLocation,
    );
  }

  /// Whether this menu has any items to display
  bool get hasItems => items.isNotEmpty;

  /// Get only the non-divider menu items
  List<PageMenuItem> get menuItems =>
      items.where((item) => !item.isDivider).toList();

  @override
  List<Object?> get props => [
        title,
        items,
        largeMenu,
        icon,
        fabLocation,
      ];

  @override
  bool get stringify => true;
}
