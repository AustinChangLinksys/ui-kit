import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

// ============================================================
// AppPageView Menu Position & FAB Stories
// ============================================================
// Demonstrates unified menu system with various positions
// and FAB behaviors per implementation plan v3.3.
// ============================================================

// ===========================================================================
// Group 1: Sidebar Position (Left/Right)
// ===========================================================================

@widgetbook.UseCase(
  name: 'Sidebar - Left Position',
  type: AppPageView,
)
Widget buildSidebarLeft(BuildContext context) {
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
      const PageMenuItem.divider(),
      PageMenuItem.settings(label: 'Settings', onTap: () {}),
    ],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.view_sidebar, size: 64),
          AppGap.md(),
          const Text('Sidebar Position: Left'),
          AppGap.sm(),
          const Text('Desktop: Sidebar on left'),
          const Text('Mobile: Menu in AppBar'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Sidebar - Right Position',
  type: AppPageView,
)
Widget buildSidebarRight(BuildContext context) {
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
          const Icon(Icons.view_sidebar, size: 64),
          AppGap.md(),
          const Text('Sidebar Position: Right'),
          AppGap.sm(),
          const Text('Desktop: Sidebar on right'),
          const Text('Mobile: Menu in AppBar'),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Group 2: Top Position (AppBar Actions)
// ===========================================================================

@widgetbook.UseCase(
  name: 'Top Position - AppBar Actions',
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
          const Icon(Icons.menu, size: 64),
          AppGap.md(),
          const Text('Menu Position: Top'),
          AppGap.sm(),
          const Text('Actions appear in AppBar'),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Group 3: FAB Position
// ===========================================================================

@widgetbook.UseCase(
  name: 'FAB - Single Action',
  type: AppPageView,
)
Widget buildFabSingle(BuildContext context) {
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
          const Icon(Icons.list, size: 64),
          AppGap.md(),
          const Text('FAB - Single Action'),
          AppGap.sm(),
          const Text('Tap FAB to directly execute'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'FAB - Expandable (Multiple Actions)',
  type: AppPageView,
)
Widget buildFabExpandable(BuildContext context) {
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
          const Icon(Icons.auto_awesome, size: 64),
          AppGap.md(),
          const Text('FAB - Expandable'),
          AppGap.sm(),
          const Text('Tap FAB to expand actions'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'FAB - Custom MenuView',
  type: AppPageView,
)
Widget buildFabMenuView(BuildContext context) {
  return AppPageView(
    appBarConfig: const PageAppBarConfig(title: 'Custom MenuView'),
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
          const Icon(Icons.account_box, size: 64),
          AppGap.md(),
          const Text('FAB - Custom MenuView'),
          AppGap.sm(),
          const Text('Tap FAB to open custom sheet'),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Group 4: Coexistence Scenarios (Scenario C)
// ===========================================================================

@widgetbook.UseCase(
  name: 'Coexistence - Desktop (Sidebar + FAB)',
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
          const Icon(Icons.dashboard_customize, size: 64),
          AppGap.md(),
          const Text('Scenario C: Coexistence'),
          AppGap.sm(),
          const Text('Desktop: menuView→Sidebar, items→FAB'),
          const Text('Mobile: Combined items+menuView in Sheet'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Coexistence - Sidebar + Items',
  type: AppPageView,
)
Widget buildCoexistenceSidebarAppbar(BuildContext context) {
  return AppPageView(
    appBarConfig: const PageAppBarConfig(
      title: 'Dashboard',
    ),
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
            label: 'Analytics', icon: Icons.analytics, onTap: () {}),
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
          const Icon(Icons.grid_view, size: 64),
          AppGap.md(),
          const Text('Scenario C: Sidebar + Items'),
          AppGap.sm(),
          const Text('Desktop: items + menuView → Sidebar'),
          const Text('Mobile: items (popup) + menuView (trigger) → AppBar'),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Group 5: Only MenuView (Scenario B)
// ===========================================================================

@widgetbook.UseCase(
  name: 'Only MenuView - Custom Sidebar',
  type: AppPageView,
)
Widget buildOnlyMenuView(BuildContext context) {
  return AppPageView(
    appBarConfig: const PageAppBarConfig(title: 'Profile Page'),
    menuConfig: const PageMenuConfig(title: 'User', items: []),
    menuPosition: MenuPosition.left,
    menuView: PageMenuView(
      icon: Icons.person,
      label: 'User Profile',
      content: AppCard(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                  radius: 48, child: Icon(Icons.person, size: 48)),
              AppGap.lg(),
              AppText.titleLarge('John Doe'),
              AppText.bodyMedium('john@example.com'),
              AppGap.lg(),
              const AppDivider(),
              AppGap.md(),
              AppListTile(
                leading: const Icon(Icons.settings),
                title: const AppText('Settings'),
                onTap: () {},
              ),
              AppListTile(
                leading: const Icon(Icons.help),
                title: const AppText('Help'),
                onTap: () {},
              ),
              AppListTile(
                leading: const Icon(Icons.logout),
                title: const AppText('Logout'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_pin, size: 64),
          AppGap.md(),
          const Text('Scenario B: Only MenuView'),
          AppGap.sm(),
          const Text('Desktop: menuView directly in sidebar'),
          const Text('Mobile: menuView via AppBar trigger'),
        ],
      ),
    ),
  );
}

// ===========================================================================
// Group 6: Interactive Playground
// ===========================================================================

@widgetbook.UseCase(
  name: 'Playground - Interactive Testing',
  type: AppPageView,
)
Widget buildPlayground(BuildContext context) {
  // Knobs for interactive testing
  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    initialValue: 3,
    min: 1,
    max: 6,
    description: '1-2: icons, 3+: popup menu',
  );

  final menuPositionIndex = context.knobs.list<int>(
    label: 'Menu Position',
    options: [0, 1, 2, 3],
    labelBuilder: (value) => switch (value) {
      0 => 'Left Sidebar',
      1 => 'Right Sidebar',
      2 => 'Top (AppBar)',
      3 => 'FAB',
      _ => 'Unknown',
    },
    initialOption: 0,
    description: 'Where to display menu items',
  );

  final hasMenuView = context.knobs.boolean(
    label: 'Has MenuView',
    initialValue: true,
    description: 'Include custom menuView (profile)',
  );

  // Map index to MenuPosition
  final menuPosition = switch (menuPositionIndex) {
    0 => MenuPosition.left,
    1 => MenuPosition.right,
    2 => MenuPosition.top,
    3 => MenuPosition.fab,
    _ => MenuPosition.left,
  };

  // Generate items based on count
  final allItems = [
    PageMenuItem.navigation(
        label: 'Home', icon: Icons.home, onTap: () {}, isSelected: true),
    PageMenuItem.navigation(label: 'Search', icon: Icons.search, onTap: () {}),
    PageMenuItem.navigation(
        label: 'Favorites', icon: Icons.favorite, onTap: () {}),
    PageMenuItem.navigation(
        label: 'Settings', icon: Icons.settings, onTap: () {}),
    PageMenuItem.navigation(label: 'Help', icon: Icons.help, onTap: () {}),
    PageMenuItem.navigation(label: 'About', icon: Icons.info, onTap: () {}),
  ];

  final items = allItems.take(itemCount).toList();

  return AppPageView(
    appBarConfig: const PageAppBarConfig(title: 'Playground'),
    menuConfig: PageMenuConfig(
      title: 'Menu',
      items: items,
    ),
    menuPosition: menuPosition,
    menuView: hasMenuView
        ? PageMenuView(
            icon: Icons.person,
            label: 'Profile',
            content: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                      radius: 32, child: Icon(Icons.person, size: 32)),
                  AppGap.md(),
                  AppText.titleMedium('John Doe'),
                  AppText.bodySmall('john@example.com'),
                  AppGap.lg(),
                  AppText.bodySmall('Custom menuView content'),
                ],
              ),
            ),
          )
        : null,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.science, size: 64),
          AppGap.md(),
          AppText.titleMedium('Interactive Playground'),
          AppGap.sm(),
          AppText('Items: $itemCount (${itemCount <= 2 ? "icons" : "popup"})'),
          AppText('Position: ${menuPosition.name}'),
          AppText('MenuView: ${hasMenuView ? "Yes" : "No"}'),
          AppGap.lg(),
          const AppCard(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('🖥️ Desktop:'),
                  Text('• left/right + menuView → Sidebar + AppBar items'),
                  Text('• left/right (no menuView) → Sidebar items'),
                  Text('• top → AppBar items'),
                  Text('• fab → FAB menu'),
                  SizedBox(height: 8),
                  Text('📱 Mobile:'),
                  Text('• All positions → AppBar icons/popup'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
