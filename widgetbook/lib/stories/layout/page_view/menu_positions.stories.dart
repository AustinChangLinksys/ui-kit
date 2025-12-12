import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

/// Menu Position Variations for AppPageView
/// Demonstrates all MenuPosition options and coexistence scenarios

// ===========================================================================
// Sidebar Positions
// ===========================================================================

@widgetbook.UseCase(
  name: 'Left Sidebar',
  type: AppPageView,
)
Widget buildLeftSidebar(BuildContext context) {
  return AppPageView.withMenu(
    title: 'Left Sidebar Demo',
    menuTitle: 'Navigation',
    menuPosition: MenuPosition.left,
    menuItems: [
      PageMenuItem.navigation(
        label: 'Overview',
        icon: Icons.dashboard,
        isSelected: true,
        onTap: () {},
      ),
      PageMenuItem.navigation(
        label: 'Analytics',
        icon: Icons.analytics,
        onTap: () {},
      ),
      PageMenuItem.navigation(
        label: 'Reports',
        icon: Icons.assessment,
        onTap: () {},
      ),
      const PageMenuItem.divider(),
      PageMenuItem.settings(label: 'Settings', onTap: () {}),
    ],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.view_sidebar, size: 64),
          AppGap.md(),
          AppText.titleLarge('Left Sidebar'),
          AppGap.sm(),
          AppText.bodyMedium('Desktop: Sidebar on left'),
          AppText.bodyMedium('Mobile: Menu in AppBar'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Right Sidebar',
  type: AppPageView,
)
Widget buildRightSidebar(BuildContext context) {
  return AppPageView.withMenu(
    title: 'Right Sidebar Demo',
    menuTitle: 'Filters',
    menuPosition: MenuPosition.right,
    menuItems: [
      PageMenuItem.navigation(
        label: 'All Items',
        icon: Icons.list,
        isSelected: true,
        onTap: () {},
      ),
      PageMenuItem.navigation(
        label: 'Active',
        icon: Icons.check_circle,
        onTap: () {},
      ),
      PageMenuItem.navigation(
        label: 'Archived',
        icon: Icons.archive,
        onTap: () {},
      ),
    ],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.view_sidebar, size: 64),
          AppGap.md(),
          AppText.titleLarge('Right Sidebar'),
          AppGap.sm(),
          AppText.bodyMedium('Desktop: Sidebar on right'),
          AppText.bodyMedium('Mobile: Menu in AppBar'),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Top Position
// ===========================================================================

@widgetbook.UseCase(
  name: 'Top Actions (AppBar)',
  type: AppPageView,
)
Widget buildTopActions(BuildContext context) {
  return AppPageView.withMenu(
    title: 'Top Actions Demo',
    menuTitle: 'Actions',
    menuPosition: MenuPosition.top,
    menuItems: [
      PageMenuItem.action(label: 'Search', icon: Icons.search, onTap: () {}),
      PageMenuItem.action(
          label: 'Filter', icon: Icons.filter_list, onTap: () {}),
      PageMenuItem.action(label: 'More', icon: Icons.more_vert, onTap: () {}),
    ],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.menu, size: 64),
          AppGap.md(),
          AppText.titleLarge('Top Actions'),
          AppGap.sm(),
          AppText.bodyMedium('Actions appear in AppBar'),
          AppText.bodyMedium('1-2 items: icons | 3+ items: popup'),
        ],
      ),
    ),
  );
}

// ===========================================================================
// FAB Positions
// ===========================================================================

@widgetbook.UseCase(
  name: 'FAB - Single Action',
  type: AppPageView,
)
Widget buildFABSingle(BuildContext context) {
  return AppPageView.withMenu(
    title: 'Single FAB',
    menuTitle: 'Actions',
    menuPosition: MenuPosition.fab,
    menuItems: [
      PageMenuItem.action(
        label: 'Create New',
        icon: Icons.add,
        onTap: () {},
      ),
    ],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.list, size: 64),
          AppGap.md(),
          AppText.titleLarge('Single FAB'),
          AppGap.sm(),
          AppText.bodyMedium('Tap FAB to execute directly'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'FAB - Expandable',
  type: AppPageView,
)
Widget buildFABExpandable(BuildContext context) {
  return AppPageView.withMenu(
    title: 'Expandable FAB',
    menuTitle: 'Actions',
    menuPosition: MenuPosition.fab,
    menuItems: [
      PageMenuItem.action(label: 'Edit', icon: Icons.edit, onTap: () {}),
      PageMenuItem.action(label: 'Delete', icon: Icons.delete, onTap: () {}),
      PageMenuItem.action(label: 'Share', icon: Icons.share, onTap: () {}),
    ],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.auto_awesome, size: 64),
          AppGap.md(),
          AppText.titleLarge('Expandable FAB'),
          AppGap.sm(),
          AppText.bodyMedium('Tap FAB to expand actions'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'FAB + Custom MenuView',
  type: AppPageView,
)
Widget buildFABMenuView(BuildContext context) {
  return AppPageView(
    appBarConfig: const PageAppBarConfig(title: 'FAB with MenuView'),
    menuConfig: const PageMenuConfig(title: 'User', items: []),
    menuPosition: MenuPosition.fab,
    menuView: PageMenuView(
      icon: Icons.person,
      label: 'User Profile',
      content: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            AppGap.lg(),
            AppText.titleLarge('John Doe'),
            AppText.bodyMedium('john@example.com'),
            AppGap.xl(),
            AppButton.primary(label: 'Edit Profile', onTap: () {}),
            AppGap.sm(),
            AppButton.secondary(label: 'Logout', onTap: () {}),
          ],
        ),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.account_box, size: 64),
          AppGap.md(),
          AppText.titleLarge('FAB + MenuView'),
          AppGap.sm(),
          AppText.bodyMedium('Tap FAB to open custom sheet'),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Coexistence Scenarios
// ===========================================================================

@widgetbook.UseCase(
  name: 'Coexistence - Desktop',
  type: AppPageView,
)
Widget buildCoexistenceDesktop(BuildContext context) {
  return AppPageView(
    appBarConfig: const PageAppBarConfig(title: 'Dashboard'),
    menuConfig: PageMenuConfig(
      title: 'Quick Actions',
      items: [
        PageMenuItem.action(label: 'Add Item', icon: Icons.add, onTap: () {}),
        PageMenuItem.action(label: 'Edit', icon: Icons.edit, onTap: () {}),
        PageMenuItem.action(label: 'Share', icon: Icons.share, onTap: () {}),
      ],
    ),
    menuPosition: MenuPosition.fab,
    menuView: PageMenuView(
      icon: Icons.person,
      label: 'User Profile',
      content: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 32)),
            AppGap.md(),
            AppText.titleMedium('John Doe'),
            AppText.bodySmall('john@example.com'),
          ],
        ),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.dashboard_customize, size: 64),
          AppGap.md(),
          AppText.titleMedium('Coexistence Mode'),
          AppGap.sm(),
          AppText.bodySmall('Desktop: menuView→Sidebar, items→FAB'),
          AppText.bodySmall('Mobile: Combined in Sheet'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Coexistence - Sidebar + Items',
  type: AppPageView,
)
Widget buildCoexistenceSidebar(BuildContext context) {
  return AppPageView(
    appBarConfig: const PageAppBarConfig(title: 'Dashboard'),
    menuConfig: PageMenuConfig(
      title: 'Navigation',
      items: [
        PageMenuItem.navigation(
          label: 'Overview',
          icon: Icons.dashboard,
          isSelected: true,
          onTap: () {},
        ),
        PageMenuItem.navigation(
          label: 'Analytics',
          icon: Icons.analytics,
          onTap: () {},
        ),
        const PageMenuItem.divider(),
        PageMenuItem.settings(label: 'Settings', onTap: () {}),
      ],
    ),
    menuPosition: MenuPosition.left,
    menuView: PageMenuView(
      icon: Icons.person,
      label: 'Profile',
      content: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 32)),
            AppGap.md(),
            AppText.titleMedium('John Doe'),
            AppText.bodySmall('john@example.com'),
          ],
        ),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.grid_view, size: 64),
          AppGap.md(),
          AppText.titleMedium('Sidebar + Items'),
          AppGap.sm(),
          AppText.bodySmall('Desktop: items + menuView → Sidebar'),
          AppText.bodySmall('Mobile: items (popup) + menuView → AppBar'),
        ],
      ),
    ),
  );
}
