import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_config.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_item.dart';
import 'package:ui_kit_library/src/atoms/typography/app_text.dart';
import 'package:ui_kit_library/src/molecules/layout/app_list_tile.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Golden tests for PageMenuConfig model variations
/// This test ensures the configuration model behaves consistently across all themes
void main() {
  setUpAll(() async {
    // Load real fonts for proper golden test rendering
    await loadAppFonts();
  });

  group('PageMenuConfig Golden Tests', () {
    // Note: This test will initially FAIL as PageMenuConfig doesn't exist yet
    // This is expected behavior following TDD approach

    goldenTest(
      'PageMenuConfig - Basic Menu',
      fileName: 'page_menu_config_basic',
      builder: () => buildThemeMatrix(
        name: 'Basic Menu',
        width: 400,
        height: 350, // Increase height for UI Kit components
        child: TestWidget(
          config: PageMenuConfig(
            title: 'Menu Options',
            items: [
              PageMenuItem(
                label: 'Settings',
                icon: Icons.settings,
                onTap: () {},
              ),
              PageMenuItem(
                label: 'Profile',
                icon: Icons.person,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'PageMenuConfig - Desktop Menu',
      fileName: 'page_menu_config_desktop',
      builder: () => buildThemeMatrix(
        name: 'Desktop Menu',
        width: 400, // Config model test, not responsive layout test
        height: 450,
        child: TestWidget(
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
            ],
            showOnDesktop: true,
            largeMenu: true,
          ),
        ),
      ),
    );

    goldenTest(
      'PageMenuConfig - Mobile Menu',
      fileName: 'page_menu_config_mobile',
      builder: () => buildThemeMatrix(
        name: 'Mobile Menu',
        width: 400,
        height: 350, // Increase height for UI Kit components
        child: TestWidget(
          config: PageMenuConfig(
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
            ],
            showOnMobile: true,
            mobileMenuIcon: Icons.menu,
          ),
        ),
      ),
    );
  });
}

/// Test widget to display configuration model behavior
class TestWidget extends StatelessWidget {
  final PageMenuConfig config;

  const TestWidget({
    Key? key,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText('Title: ${config.title ?? "No Title"}'),
            AppText('Items Count: ${config.items.length}'),
            AppText('Show on Desktop: ${config.showOnDesktop}'),
            AppText('Show on Mobile: ${config.showOnMobile}'),
            AppText('Large Menu: ${config.largeMenu}'),
            SizedBox(height: 20),
            AppSurface(
              variant: SurfaceVariant.elevated,
              width: 250,
              child: Column(
                children: [
                  if (config.title != null)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: AppText.titleMedium(config.title!),
                    ),
                  ...config.items.map((item) => AppListTile(
                    leading: item.icon != null ? Icon(item.icon) : null,
                    title: AppText(item.label),
                    selected: item.isSelected,
                    onTap: item.enabled ? item.onTap : null,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}