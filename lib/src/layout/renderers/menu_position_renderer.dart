import 'package:flutter/material.dart';
import '../models/page_menu_config.dart';
import '../models/page_menu_view.dart';
import '../models/page_menu_item.dart';

/// Context object containing all configuration needed for menu position rendering
///
/// Constitution Compliance:
/// - §3.2: Data-Driven Strategy - separates configuration from rendering
/// - §6.2: Dumb component pattern - pure data object
class MenuPositionContext {
  /// Menu configuration with items
  final PageMenuConfig? menuConfig;

  /// Custom menu view panel
  final PageMenuView? menuView;

  /// Current menu position
  final MenuPosition position;

  /// Whether the current layout is desktop
  final bool isDesktop;

  /// Callback to show bottom sheet (for mobile menu)
  final void Function(BuildContext context, Widget content)? showBottomSheet;

  const MenuPositionContext({
    this.menuConfig,
    this.menuView,
    required this.position,
    required this.isDesktop,
    this.showBottomSheet,
  });

  /// Whether menu items exist
  bool get hasItems => menuConfig != null && menuConfig!.hasItems;

  /// Whether a custom menu view exists
  bool get hasMenuView => menuView != null;

  /// Get menu items (non-divider only)
  List<PageMenuItem> get menuItems =>
      menuConfig?.items.where((item) => !item.isDivider).toList() ?? [];
}

/// Abstract renderer for menu position-specific behavior
///
/// Constitution Compliance:
/// - §3.2: Data-Driven Strategy with Renderer Pattern
/// - Eliminates runtime type checks in favor of polymorphism
abstract class MenuPositionRenderer {
  const MenuPositionRenderer();

  /// Factory method to get appropriate renderer for position
  factory MenuPositionRenderer.forPosition(MenuPosition position) {
    return switch (position) {
      MenuPosition.left => const LeftMenuRenderer(),
      MenuPosition.right => const RightMenuRenderer(),
      MenuPosition.top => const TopMenuRenderer(),
      MenuPosition.fab => const FabMenuRenderer(),
      MenuPosition.none => const NoneMenuRenderer(),
    };
  }

  /// Whether this renderer should show a sidebar on desktop
  bool shouldShowSidebar(MenuPositionContext context);

  /// Whether this renderer should show items in AppBar
  bool shouldShowAppBarItems(MenuPositionContext context);

  /// Whether this renderer should build a FAB
  bool shouldBuildFab(MenuPositionContext context);

  /// Build AppBar actions specific to this position
  List<Widget> buildAppBarActions(
    MenuPositionContext context,
    Widget Function(PageMenuItem item) buildIconAction,
    Widget Function(List<PageMenuItem> items) buildPopupMenu,
    Widget Function(PageMenuView view) buildMenuViewTrigger,
  );
}

/// Left sidebar menu renderer
/// - Desktop: Shows sidebar with menu items or menuView
/// - Mobile: Shows items in AppBar (as icons or popup)
class LeftMenuRenderer extends MenuPositionRenderer {
  const LeftMenuRenderer();

  @override
  bool shouldShowSidebar(MenuPositionContext context) {
    // Show sidebar on desktop when we have items or menuView
    return context.isDesktop && (context.hasItems || context.hasMenuView);
  }

  @override
  bool shouldShowAppBarItems(MenuPositionContext context) {
    // On mobile, show items in AppBar
    // On desktop with menuView, items go to AppBar (menuView is in sidebar)
    return !context.isDesktop ||
        (context.isDesktop && context.hasMenuView && context.hasItems);
  }

  @override
  bool shouldBuildFab(MenuPositionContext context) => false;

  @override
  List<Widget> buildAppBarActions(
    MenuPositionContext context,
    Widget Function(PageMenuItem item) buildIconAction,
    Widget Function(List<PageMenuItem> items) buildPopupMenu,
    Widget Function(PageMenuView view) buildMenuViewTrigger,
  ) {
    final actions = <Widget>[];

    // Scenario B Mobile: menuView only (no items)
    if (!context.isDesktop && context.hasMenuView && !context.hasItems) {
      actions.add(buildMenuViewTrigger(context.menuView!));
      return actions;
    }

    // Scenario C Desktop: menuView in sidebar, items in AppBar
    if (context.isDesktop && context.hasMenuView && context.hasItems) {
      final items = context.menuItems;
      if (items.length <= 2) {
        for (final item in items.where((i) => i.enabled)) {
          actions.add(buildIconAction(item));
        }
      } else {
        actions.add(buildPopupMenu(items));
      }
      return actions;
    }

    // Mobile with items
    if (!context.isDesktop && context.hasItems) {
      // Add menuView trigger first if present
      if (context.hasMenuView) {
        actions.add(buildMenuViewTrigger(context.menuView!));
      }

      final items = context.menuItems;
      if (items.length <= 2) {
        for (final item in items.where((i) => i.enabled)) {
          actions.add(buildIconAction(item));
        }
      } else {
        actions.add(buildPopupMenu(items));
      }
    }

    return actions;
  }
}

/// Right sidebar menu renderer (mirrors left behavior)
class RightMenuRenderer extends MenuPositionRenderer {
  const RightMenuRenderer();

  @override
  bool shouldShowSidebar(MenuPositionContext context) {
    return context.isDesktop && (context.hasItems || context.hasMenuView);
  }

  @override
  bool shouldShowAppBarItems(MenuPositionContext context) {
    return !context.isDesktop ||
        (context.isDesktop && context.hasMenuView && context.hasItems);
  }

  @override
  bool shouldBuildFab(MenuPositionContext context) => false;

  @override
  List<Widget> buildAppBarActions(
    MenuPositionContext context,
    Widget Function(PageMenuItem item) buildIconAction,
    Widget Function(List<PageMenuItem> items) buildPopupMenu,
    Widget Function(PageMenuView view) buildMenuViewTrigger,
  ) {
    // Same logic as LeftMenuRenderer
    return const LeftMenuRenderer().buildAppBarActions(
      context,
      buildIconAction,
      buildPopupMenu,
      buildMenuViewTrigger,
    );
  }
}

/// Top menu renderer - items always in AppBar
class TopMenuRenderer extends MenuPositionRenderer {
  const TopMenuRenderer();

  @override
  bool shouldShowSidebar(MenuPositionContext context) => false;

  @override
  bool shouldShowAppBarItems(MenuPositionContext context) => context.hasItems;

  @override
  bool shouldBuildFab(MenuPositionContext context) => false;

  @override
  List<Widget> buildAppBarActions(
    MenuPositionContext context,
    Widget Function(PageMenuItem item) buildIconAction,
    Widget Function(List<PageMenuItem> items) buildPopupMenu,
    Widget Function(PageMenuView view) buildMenuViewTrigger,
  ) {
    final actions = <Widget>[];

    // MenuView trigger if present
    if (context.hasMenuView) {
      actions.add(buildMenuViewTrigger(context.menuView!));
    }

    // Menu items
    if (context.hasItems) {
      final items = context.menuItems;
      if (items.length <= 2) {
        for (final item in items.where((i) => i.enabled)) {
          actions.add(buildIconAction(item));
        }
      } else {
        actions.add(buildPopupMenu(items));
      }
    }

    return actions;
  }
}

/// FAB menu renderer - items go to FAB, not AppBar
class FabMenuRenderer extends MenuPositionRenderer {
  const FabMenuRenderer();

  @override
  bool shouldShowSidebar(MenuPositionContext context) {
    // Show sidebar on desktop only for menuView
    return context.isDesktop && context.hasMenuView;
  }

  @override
  bool shouldShowAppBarItems(MenuPositionContext context) => false;

  @override
  bool shouldBuildFab(MenuPositionContext context) {
    return context.hasItems || context.hasMenuView;
  }

  @override
  List<Widget> buildAppBarActions(
    MenuPositionContext context,
    Widget Function(PageMenuItem item) buildIconAction,
    Widget Function(List<PageMenuItem> items) buildPopupMenu,
    Widget Function(PageMenuView view) buildMenuViewTrigger,
  ) {
    // FAB mode doesn't show items in AppBar
    return [];
  }
}

/// None menu renderer - menu is hidden, no actions
class NoneMenuRenderer extends MenuPositionRenderer {
  const NoneMenuRenderer();

  @override
  bool shouldShowSidebar(MenuPositionContext context) => false;

  @override
  bool shouldShowAppBarItems(MenuPositionContext context) => false;

  @override
  bool shouldBuildFab(MenuPositionContext context) => false;

  @override
  List<Widget> buildAppBarActions(
    MenuPositionContext context,
    Widget Function(PageMenuItem item) buildIconAction,
    Widget Function(List<PageMenuItem> items) buildPopupMenu,
    Widget Function(PageMenuView view) buildMenuViewTrigger,
  ) {
    return [];
  }
}
