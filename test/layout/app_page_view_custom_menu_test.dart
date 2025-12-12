import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../test_utils/font_loader.dart';

// ============================================================
// AppPageView Menu & FAB Golden Tests (Unified Action Hub v3.3)
// ============================================================
// Tests cover all MenuPosition configurations and layout behaviors
// per implementation plan scenarios A/B/C.
//
// IMPORTANT: Uses 1-column layout for consistent golden rendering.
// ============================================================

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  // Helper: Custom Menu View using PageMenuView model
  PageMenuView buildCustomMenuView() {
    return PageMenuView(
      icon: Icons.account_circle,
      label: 'User Panel',
      content: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.account_circle, size: 48, color: Colors.white),
            AppGap.md(),
            AppText.titleMedium('Custom Menu', color: Colors.white),
            AppGap.sm(),
            const AppDivider(),
            AppGap.sm(),
            const AppListTile(
              title: AppText('Settings', color: Colors.white),
              leading: Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Group 1: Scenario A - Only menuConfig (no menuView)
  // ============================================================
  group('Scenario A: Only menuConfig', () {
    goldenTest(
      'Desktop - Left Sidebar with items',
      fileName: 'app_page_view_a_left_desktop',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'Left Sidebar',
            width: 1200,
            height: 400,
            child: AppPageView.withMenu(
              title: 'Dashboard',
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
              child: const Center(child: Text('Main Content')),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'Desktop - Top Actions in AppBar',
      fileName: 'app_page_view_a_top_desktop',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'Top Actions',
            width: 1200,
            height: 300,
            child: AppPageView.withMenu(
              title: 'Top Menu Page',
              menuTitle: 'Actions',
              menuPosition: MenuPosition.top,
              menuItems: [
                PageMenuItem.action(
                  label: 'Search',
                  icon: Icons.search,
                  onTap: () {},
                ),
                PageMenuItem.action(
                  label: 'Notifications',
                  icon: Icons.notifications,
                  onTap: () {},
                ),
              ],
              child: const Center(child: Text('Content')),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'FAB - Single Action',
      fileName: 'app_page_view_a_fab_single',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'Single FAB',
            width: 400,
            height: 600,
            child: AppPageView.withMenu(
              title: 'Add Item',
              menuTitle: 'Actions',
              menuPosition: MenuPosition.fab,
              menuItems: [
                PageMenuItem.action(
                  label: 'Create New',
                  icon: Icons.add,
                  onTap: () {},
                ),
              ],
              child: const Center(child: Text('Tap FAB to add')),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'FAB - Multiple Actions (Expandable)',
      fileName: 'app_page_view_a_fab_multiple',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'Expandable FAB',
            width: 400,
            height: 600,
            child: AppPageView.withMenu(
              title: 'Quick Actions',
              menuTitle: 'Actions',
              menuPosition: MenuPosition.fab,
              menuItems: [
                PageMenuItem.action(
                    label: 'Edit', icon: Icons.edit, onTap: () {}),
                PageMenuItem.action(
                    label: 'Delete', icon: Icons.delete, onTap: () {}),
                PageMenuItem.action(
                    label: 'Share', icon: Icons.share, onTap: () {}),
              ],
              child: const Center(child: Text('Tap FAB to expand')),
            ),
          ),
        ],
      ),
    );
  });

  // ============================================================
  // Group 2: Scenario B - Only menuView (no items)
  // ============================================================
  group('Scenario B: Only menuView', () {
    goldenTest(
      'Desktop - Left Sidebar with menuView',
      fileName: 'app_page_view_b_left_desktop',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'menuView Sidebar',
            width: 1200,
            height: 400,
            child: AppPageView(
              appBarConfig: const PageAppBarConfig(title: 'Profile'),
              menuConfig: const PageMenuConfig(title: 'User', items: []),
              menuPosition: MenuPosition.left,
              menuView: buildCustomMenuView(),
              child: const Center(child: Text('Profile Content')),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'Mobile - menuView via AppBar trigger',
      fileName: 'app_page_view_b_mobile',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'Mobile menuView',
            width: 375,
            height: 667,
            child: AppPageView(
              appBarConfig: const PageAppBarConfig(title: 'Mobile Profile'),
              menuConfig: const PageMenuConfig(title: 'User', items: []),
              menuPosition: MenuPosition.left,
              menuView: buildCustomMenuView(),
              child: const Center(child: Text('Mobile Content')),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'FAB - menuView sheet trigger',
      fileName: 'app_page_view_b_fab',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'FAB menuView',
            width: 400,
            height: 600,
            child: AppPageView(
              appBarConfig: const PageAppBarConfig(title: 'FAB Sheet'),
              menuConfig: const PageMenuConfig(title: 'User', items: []),
              menuPosition: MenuPosition.fab,
              menuView: buildCustomMenuView(),
              child: const Center(child: Text('Tap FAB for sheet')),
            ),
          ),
        ],
      ),
    );
  });

  // ============================================================
  // Group 3: Scenario C - menuConfig + menuView (Coexistence)
  // ============================================================
  group('Scenario C: Coexistence', () {
    goldenTest(
      'Desktop - menuView in sidebar, items in AppBar',
      fileName: 'app_page_view_c_desktop',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'Coexistence Desktop',
            width: 1200,
            height: 400,
            child: AppPageView(
              appBarConfig: const PageAppBarConfig(title: 'Dashboard'),
              menuConfig: PageMenuConfig(
                title: 'Nav',
                items: [
                  PageMenuItem.action(
                      label: 'Search', icon: Icons.search, onTap: () {}),
                  PageMenuItem.action(
                      label: 'Filter', icon: Icons.filter_list, onTap: () {}),
                ],
              ),
              menuPosition: MenuPosition.left,
              menuView: buildCustomMenuView(),
              child: const Center(child: Text('Content')),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'Mobile - menuView wrapped as item',
      fileName: 'app_page_view_c_mobile',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'Coexistence Mobile',
            width: 375,
            height: 667,
            child: AppPageView(
              appBarConfig: const PageAppBarConfig(title: 'Mobile Dashboard'),
              menuConfig: PageMenuConfig(
                title: 'Nav',
                items: [
                  PageMenuItem.action(
                      label: 'Home', icon: Icons.home, onTap: () {}),
                ],
              ),
              menuPosition: MenuPosition.left,
              menuView: buildCustomMenuView(),
              child: const Center(child: Text('Mobile Content')),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'FAB - menuView in sidebar, items in FAB',
      fileName: 'app_page_view_c_fab',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          buildSafeScenarioWithMediaQuery(
            name: 'Coexistence FAB',
            width: 1200,
            height: 400,
            child: AppPageView(
              appBarConfig: const PageAppBarConfig(title: 'FAB + Sidebar'),
              menuConfig: PageMenuConfig(
                title: 'Actions',
                items: [
                  PageMenuItem.action(
                      label: 'Edit', icon: Icons.edit, onTap: () {}),
                  PageMenuItem.action(
                      label: 'Share', icon: Icons.share, onTap: () {}),
                ],
              ),
              menuPosition: MenuPosition.fab,
              menuView: buildCustomMenuView(),
              child: const Center(child: Text('Content')),
            ),
          ),
        ],
      ),
    );
  });
}

// ============================================================
// Helper: buildSafeScenarioWithMediaQuery
// ============================================================

GoldenTestScenario buildSafeScenarioWithMediaQuery({
  required String name,
  required double width,
  required double height,
  required Widget child,
}) {
  final theme = AppTheme.create(
    brightness: Brightness.light,
    designThemeBuilder: (s) => GlassDesignTheme.light(s),
  );

  return GoldenTestScenario(
    name: name,
    child: SizedBox(
      width: width,
      height: height,
      child: MediaQuery(
        data: MediaQueryData(size: Size(width, height)),
        child: Theme(
          data: theme,
          child: ColoredBox(
            color: theme.scaffoldBackgroundColor,
            child: child,
          ),
        ),
      ),
    ),
  );
}
