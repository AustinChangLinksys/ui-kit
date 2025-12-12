import 'package:flutter/material.dart';
import '../../molecules/cards/app_card.dart';
import '../../atoms/layout/app_gap.dart';
import '../models/page_menu_config.dart';
import '../models/page_menu_view.dart';
import '../models/page_menu_item.dart'; // For MenuPosition
import 'page_menu_content.dart';

/// A Constitution-compliant sidebar widget for AppPageView.
///
/// This widget handles the desktop sidebar layout, supporting both
/// menu items (rendered via PageMenuContent) and custom menu views.
///
/// Constitution Compliance:
/// - §6.2: Dumb component - receives data via constructor, passes events via callback
/// - §6.3: Uses Slots Pattern with composable content
/// - §3.3: Uses AppGap for spacing (gutter between sidebar and content)
class PageSidebar extends StatelessWidget {
  /// Configuration for menu items (displayed when menuView is null)
  final PageMenuConfig? menuConfig;

  /// Custom menu view panel (takes priority over menuConfig for sidebar content)
  final PageMenuView? menuView;

  /// The main content widget to display alongside the sidebar
  final Widget content;

  /// Position of the sidebar (left or right)
  final MenuPosition position;

  const PageSidebar({
    super.key,
    this.menuConfig,
    this.menuView,
    required this.content,
    this.position = MenuPosition.left,
  }) : assert(
         menuConfig != null || menuView != null,
         'Either menuConfig or menuView must be provided',
       );

  @override
  Widget build(BuildContext context) {
    // Determine column span based on menu size
    final int menuColumn = menuConfig?.largeMenu == true ? 4 : 3;
    final int contentColumn = 12 - menuColumn;

    // Build sidebar widget based on available configuration
    // Priority: menuView > menuConfig
    Widget sidebarWidget;
    if (menuView != null) {
      // menuView goes to sidebar, items will be in AppBar
      sidebarWidget = menuView!.content;
    } else if (menuConfig != null && menuConfig!.hasItems) {
      // Only items, show in sidebar wrapped in AppCard
      sidebarWidget = AppCard(
        child: PageMenuContent(config: menuConfig!),
      );
    } else {
      // Fallback (should not happen due to assert)
      sidebarWidget = const SizedBox.shrink();
    }

    // Determine order based on position
    final bool isRightSidebar = position == MenuPosition.right;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isRightSidebar
          ? [
              // Content first for right sidebar
              Expanded(
                flex: contentColumn,
                child: content,
              ),
              AppGap.gutter(),
              // Sidebar on right
              Expanded(
                flex: menuColumn,
                child: sidebarWidget,
              ),
            ]
          : [
              // Sidebar first for left position (default)
              Expanded(
                flex: menuColumn,
                child: sidebarWidget,
              ),
              AppGap.gutter(),
              // Content on right
              Expanded(
                flex: contentColumn,
                child: content,
              ),
            ],
    );
  }
}
