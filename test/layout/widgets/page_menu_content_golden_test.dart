import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/layout/widgets/page_menu_content.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Golden tests for extracted PageMenuContent widget
void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('PageMenuContent Golden Tests', () {
    goldenTest(
      'PageMenuContent - Basic Items',
      fileName: 'page_menu_content_basic',
      builder: () => buildThemeMatrix(
        name: 'Basic Menu',
        width: 300,
        height: 300,
        child: PageMenuContent(
          config: PageMenuConfig(
            title: 'Menu',
            items: [
              PageMenuItem(
                label: 'Home',
                icon: Icons.home,
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
      'PageMenuContent - With Dividers',
      fileName: 'page_menu_content_dividers',
      builder: () => buildThemeMatrix(
        name: 'Menu with Dividers',
        width: 300,
        height: 350,
        child: PageMenuContent(
          config: PageMenuConfig(
            title: 'Navigation',
            items: [
              PageMenuItem(
                label: 'Dashboard',
                icon: Icons.dashboard,
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
          ),
        ),
      ),
    );

    goldenTest(
      'PageMenuContent - Selected State',
      fileName: 'page_menu_content_selected',
      builder: () => buildThemeMatrix(
        name: 'Selected Item',
        width: 300,
        height: 300,
        child: PageMenuContent(
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
                label: 'Settings',
                icon: Icons.settings,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'PageMenuContent - No Title',
      fileName: 'page_menu_content_no_title',
      builder: () => buildThemeMatrix(
        name: 'No Title',
        width: 300,
        height: 250,
        child: PageMenuContent(
          config: PageMenuConfig(
            items: [
              PageMenuItem(
                label: 'Option A',
                icon: Icons.check_box,
                onTap: () {},
              ),
              PageMenuItem(
                label: 'Option B',
                icon: Icons.check_box_outline_blank,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'PageMenuContent - Disabled Items',
      fileName: 'page_menu_content_disabled',
      builder: () => buildThemeMatrix(
        name: 'Disabled Items',
        width: 300,
        height: 300,
        child: PageMenuContent(
          config: PageMenuConfig(
            title: 'Actions',
            items: [
              PageMenuItem(
                label: 'Active',
                icon: Icons.play_arrow,
                onTap: () {},
              ),
              PageMenuItem(
                label: 'Disabled',
                icon: Icons.block,
                enabled: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  });
}
