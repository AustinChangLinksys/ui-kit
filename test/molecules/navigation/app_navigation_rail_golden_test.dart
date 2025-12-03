import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  final navItems = [
    const AppNavigationItem(icon: Icon(Icons.home), label: 'Home'),
    const AppNavigationItem(icon: Icon(Icons.folder), label: 'Files'),
    const AppNavigationItem(icon: Icon(Icons.settings), label: 'Config'),
  ];

  group('AppNavigationRail Golden Tests', () {
    // Test 1: Selected item (index 0) shows Tonal pill indicator
    goldenTest(
      'AppNavigationRail - Selected Item 0 (Tonal Pill)',
      fileName: 'app_navigation_rail_selected_0',
      builder: () => buildThemeMatrix(
        name: 'Selected 0',
        width: 150, // Only capture the left part of the Rail
        height: 400, // Height must be long enough to see Header/Footer
        child: Row(
          children: [
            AppNavigationRail(
              items: navItems,
              currentIndex: 0, // ✨ First item selected with Tonal pill
              onTap: (_) {},
              leading: const FlutterLogo(size: 32),
              trailing: const Icon(Icons.logout, size: 20),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );

    // Test 2: Different selected item (index 1) shows Tonal pill moves
    goldenTest(
      'AppNavigationRail - Selected Item 1 (Tonal Pill)',
      fileName: 'app_navigation_rail_selected_1',
      builder: () => buildThemeMatrix(
        name: 'Selected 1',
        width: 150,
        height: 400,
        child: Row(
          children: [
            AppNavigationRail(
              items: navItems,
              currentIndex: 1, // ✨ Second item selected with Tonal pill
              onTap: (_) {},
              leading: const FlutterLogo(size: 32),
              trailing: const Icon(Icons.logout, size: 20),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  });
}
