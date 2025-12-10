import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'page_menu_item.dart';

/// Configuration class for responsive page menu display and behavior
///
/// This class follows UI Kit constitutional compliance by using Equatable
/// for value equality and providing immutable configuration options.
class PageMenuConfig extends Equatable {
  /// Optional title for the menu (typically shown on desktop)
  final String? title;

  /// List of menu items to display
  final List<PageMenuItem> items;

  /// Whether to show this menu on desktop layouts
  final bool showOnDesktop;

  /// Whether to show this menu on mobile layouts
  final bool showOnMobile;

  /// Whether to use large menu styling (desktop sidebar)
  final bool largeMenu;

  /// Icon to use for mobile menu trigger button
  final IconData? mobileMenuIcon;

  /// Creates a new PageMenuConfig instance
  const PageMenuConfig({
    this.title,
    this.items = const [],
    this.showOnDesktop = false,
    this.showOnMobile = false,
    this.largeMenu = false,
    this.mobileMenuIcon,
  });

  /// Creates a copy of this config with the given fields replaced
  PageMenuConfig copyWith({
    String? title,
    List<PageMenuItem>? items,
    bool? showOnDesktop,
    bool? showOnMobile,
    bool? largeMenu,
    IconData? mobileMenuIcon,
  }) {
    return PageMenuConfig(
      title: title ?? this.title,
      items: items ?? this.items,
      showOnDesktop: showOnDesktop ?? this.showOnDesktop,
      showOnMobile: showOnMobile ?? this.showOnMobile,
      largeMenu: largeMenu ?? this.largeMenu,
      mobileMenuIcon: mobileMenuIcon ?? this.mobileMenuIcon,
    );
  }

  /// Whether this menu should be shown based on responsive context
  bool shouldShowOnPlatform({required bool isDesktop}) {
    return isDesktop ? showOnDesktop : showOnMobile;
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
        showOnDesktop,
        showOnMobile,
        largeMenu,
        mobileMenuIcon,
      ];

  @override
  bool get stringify => true;
}