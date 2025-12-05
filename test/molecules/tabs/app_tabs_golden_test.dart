import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../../test_utils/font_loader.dart';
import '../../test_utils/golden_test_matrix_factory.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppTabs Golden Tests', () {
    final tabs = [
      const TabItem(label: 'All'),
      const TabItem(label: 'Favorites'),
      const TabItem(label: 'Recent'),
    ];

    final tabsWithIcons = [
      const TabItem(label: 'Home', icon: Icons.home),
      const TabItem(label: 'Search', icon: Icons.search),
      const TabItem(label: 'Settings', icon: Icons.settings),
    ];

    goldenTest(
      'AppTabs - Underline Mode (Tab 1)',
      fileName: 'tabs_underline_tab1',
      builder: () => buildThemeMatrix(
        name: 'Underline - Tab 1 Selected',
        width: 400.0,
        height: 100.0,
        child: AppTabs(
          tabs: tabs,
          initialIndex: 0,
          displayMode: TabDisplayMode.underline,
        ),
      ),
    );

    goldenTest(
      'AppTabs - Underline Mode (Tab 2)',
      fileName: 'tabs_underline_tab2',
      builder: () => buildThemeMatrix(
        name: 'Underline - Tab 2 Selected',
        width: 400.0,
        height: 100.0,
        child: AppTabs(
          tabs: tabs,
          initialIndex: 1,
          displayMode: TabDisplayMode.underline,
        ),
      ),
    );

    goldenTest(
      'AppTabs - Filled Mode',
      fileName: 'tabs_filled',
      builder: () => buildThemeMatrix(
        name: 'Filled - Tab 1 Selected',
        width: 400.0,
        height: 100.0,
        child: AppTabs(
          tabs: tabs,
          initialIndex: 0,
          displayMode: TabDisplayMode.filled,
        ),
      ),
    );

    goldenTest(
      'AppTabs - Segmented Mode',
      fileName: 'tabs_segmented',
      builder: () => buildThemeMatrix(
        name: 'Segmented - Tab 2 Selected',
        width: 400.0,
        height: 100.0,
        child: AppTabs(
          tabs: tabs,
          initialIndex: 1,
          displayMode: TabDisplayMode.segmented,
        ),
      ),
    );

    goldenTest(
      'AppTabs - With Icons',
      fileName: 'tabs_with_icons',
      builder: () => buildThemeMatrix(
        name: 'With Icons - Tab 1 Selected',
        width: 400.0,
        height: 100.0,
        child: AppTabs(
          tabs: tabsWithIcons,
          initialIndex: 0,
          displayMode: TabDisplayMode.underline,
        ),
      ),
    );

    goldenTest(
      'AppTabs - Disabled Tab',
      fileName: 'tabs_disabled',
      builder: () => buildThemeMatrix(
        name: 'With Disabled Tab',
        width: 400.0,
        height: 100.0,
        child: AppTabs(
          tabs: [
            const TabItem(label: 'Active'),
            const TabItem(label: 'Disabled', enabled: false),
            const TabItem(label: 'Active'),
          ],
          initialIndex: 0,
          displayMode: TabDisplayMode.underline,
        ),
      ),
    );
  });
}
