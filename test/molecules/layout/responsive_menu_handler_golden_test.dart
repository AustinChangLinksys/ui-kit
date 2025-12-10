import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/layout/responsive_menu_handler.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_config.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_item.dart';
import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Golden tests for ResponsiveMenuHandler component
/// This test ensures responsive menu behavior across desktop and mobile
void main() {
  setUpAll(() async {
    // Load real fonts for proper golden test rendering
    await loadAppFonts();
  });

  group('ResponsiveMenuHandler Golden Tests', () {
    // Note: These tests will initially FAIL as ResponsiveMenuHandler doesn't exist yet
    // This is expected behavior following TDD approach

    goldenTest(
      'ResponsiveMenuHandler - Desktop Sidebar',
      fileName: 'responsive_menu_handler_desktop',
      builder: () => buildThemeMatrix(
          name: 'ResponsiveMenuHandler - Desktop',
          width: 1400, // Desktop breakpoint is 1200px
          height: 600,
          child: ResponsiveMenuHandler(
            config: PageMenuConfig(
              title: 'Navigation',
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
                PageMenuItem.divider(),
                PageMenuItem(
                  label: 'Settings',
                  icon: Icons.settings,
                  onTap: () {},
                ),
                PageMenuItem(
                  label: 'Logout',
                  icon: Icons.logout,
                  onTap: () {},
                ),
              ],
              showOnDesktop: true,
              largeMenu: true,
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main Content Area',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text('This is the main content area next to the sidebar menu.'),
                ],
              ),
            ),
          ),
      ),
    );

    goldenTest(
      'ResponsiveMenuHandler - Mobile Trigger',
      fileName: 'responsive_menu_handler_mobile',
      builder: () => buildThemeMatrix(
          name: 'ResponsiveMenuHandler - Mobile',
          width: 400,
          height: 600,
          child: ResponsiveMenuHandler(
            config: PageMenuConfig(
              title: 'Menu',
              items: [
                PageMenuItem(
                  label: 'Home',
                  icon: Icons.home,
                  onTap: () {},
                ),
                PageMenuItem(
                  label: 'Search',
                  icon: Icons.search,
                  onTap: () {},
                ),
                PageMenuItem(
                  label: 'Profile',
                  icon: Icons.person,
                  onTap: () {},
                ),
              ],
              showOnMobile: true,
              mobileMenuIcon: Icons.menu,
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mobile Layout',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Menu trigger should be visible in mobile layout.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );

    goldenTest(
      'ResponsiveMenuHandler - Empty Menu',
      fileName: 'responsive_menu_handler_empty',
      builder: () => buildThemeMatrix(
          name: 'ResponsiveMenuHandler - Empty',
          width: 400,
          height: 300,
          child: ResponsiveMenuHandler(
            config: PageMenuConfig(
              items: [], // Empty menu
              showOnDesktop: true,
              showOnMobile: true,
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text('Content with empty menu config'),
              ),
            ),
          ),
      ),
    );
  });
}