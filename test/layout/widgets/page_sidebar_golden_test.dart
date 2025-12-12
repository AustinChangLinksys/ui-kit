import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/layout/widgets/page_sidebar.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Golden tests for extracted PageSidebar widget
void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('PageSidebar Golden Tests', () {
    goldenTest(
      'PageSidebar - Left Position with Menu Items',
      fileName: 'page_sidebar_left_items',
      builder: () => buildThemeMatrix(
        name: 'Left Sidebar',
        width: 800,
        height: 400,
        child: PageSidebar(
          menuConfig: PageMenuConfig(
            title: 'Navigation',
            items: [
              PageMenuItem(
                label: 'Dashboard',
                icon: Icons.dashboard,
                isSelected: true,
                onTap: () {},
              ),
              PageMenuItem(
                label: 'Settings',
                icon: Icons.settings,
                onTap: () {},
              ),
            ],
          ),
          position: MenuPosition.left,
          content: const Center(child: Text('Main Content')),
        ),
      ),
    );

    goldenTest(
      'PageSidebar - Right Position',
      fileName: 'page_sidebar_right',
      builder: () => buildThemeMatrix(
        name: 'Right Sidebar',
        width: 800,
        height: 400,
        child: PageSidebar(
          menuConfig: PageMenuConfig(
            title: 'Details',
            items: [
              PageMenuItem(
                label: 'Info',
                icon: Icons.info,
                onTap: () {},
              ),
              PageMenuItem(
                label: 'Help',
                icon: Icons.help,
                onTap: () {},
              ),
            ],
          ),
          position: MenuPosition.right,
          content: const Center(child: Text('Main Content')),
        ),
      ),
    );

    goldenTest(
      'PageSidebar - With MenuView Content',
      fileName: 'page_sidebar_menu_view',
      builder: () => buildThemeMatrix(
        name: 'MenuView Sidebar',
        width: 800,
        height: 400,
        child: PageSidebar(
          menuView: PageMenuView(
            icon: Icons.person,
            label: 'User Panel',
            content: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.account_circle, size: 48),
                  AppGap.md(),
                  AppText.titleMedium('User Profile'),
                  AppGap.sm(),
                  AppText.body('user@example.com'),
                ],
              ),
            ),
          ),
          position: MenuPosition.left,
          content: const Center(child: Text('Main Content')),
        ),
      ),
    );

    goldenTest(
      'PageSidebar - Large Menu (4 columns)',
      fileName: 'page_sidebar_large',
      builder: () => buildThemeMatrix(
        name: 'Large Sidebar',
        width: 1000,
        height: 400,
        child: PageSidebar(
          menuConfig: PageMenuConfig(
            title: 'Extended Navigation',
            items: [
              PageMenuItem(
                label: 'Dashboard',
                icon: Icons.dashboard,
                isSelected: true,
                onTap: () {},
              ),
              PageMenuItem(
                label: 'Analytics',
                icon: Icons.analytics,
                onTap: () {},
              ),
              const PageMenuItem.divider(),
              PageMenuItem(
                label: 'Settings',
                icon: Icons.settings,
                onTap: () {},
              ),
            ],
            largeMenu: true,
          ),
          position: MenuPosition.left,
          content: const Center(child: Text('Main Content')),
        ),
      ),
    );
  });
}
