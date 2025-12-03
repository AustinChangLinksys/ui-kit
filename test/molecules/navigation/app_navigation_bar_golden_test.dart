import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import test utilities
import '../../test_utils/golden_test_matrix_factory.dart'; // ✨ Matrix factory
import '../../test_utils/font_loader.dart'; // ✨ Font loader

void main() {
  // 1. Setup: Load fonts
  setUpAll(() async {
    await loadAppFonts();
  });

  // Prepare test data: Navigation items list
  final navItems = [
    const AppNavigationItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    const AppNavigationItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    const AppNavigationItem(
      icon: Icon(Icons.person_outline),
      label: 'Profile',
    ),
  ];

  group('AppNavigationBar Golden Tests', () {

    // Test 1: Item 0 Selected - Verify Tonal pill indicator
    goldenTest(
      'AppNavigationBar - Item 0 Selected (Tonal Pill)',
      fileName: 'app_navigation_bar_selected_0',
      builder: () => buildThemeMatrix(
        name: 'Item 0 Selected',
        width: 375.0, // iPhone SE width
        height: 140.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppNavigationBar(
              items: navItems,
              currentIndex: 0, // First item selected with Tonal pill
              onTap: (_) {},
            ),
          ],
        ),
      ),
    );

    // Test 2: Item 1 Selected - Verify pill transitions
    goldenTest(
      'AppNavigationBar - Item 1 Selected (Tonal Pill)',
      fileName: 'app_navigation_bar_selected_1',
      builder: () => buildThemeMatrix(
        name: 'Item 1 Selected',
        width: 375.0,
        height: 140.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppNavigationBar(
              items: navItems,
              currentIndex: 1, // Middle item selected
              onTap: (_) {},
            ),
          ],
        ),
      ),
    );
  });
}