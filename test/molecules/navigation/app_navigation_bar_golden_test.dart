import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/navigation/app_navigation_bar.dart';
import 'package:ui_kit_library/src/molecules/navigation/app_navigation_item.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  // Prepare test data
  final navItems = [
    const AppNavigationItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home), // Test activeIcon replacement logic
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
    goldenTest(
      'AppNavigationBar Matrix',
      fileName: 'app_navigation_bar_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppNavigationBar',
        // The navigation bar is wider, we use 1 column for easier observation of details
        width: 375.0, // Simulate phone screen width (iPhone SE ~ 11)
        // Give enough height, because Floating Bar has margin
        height: 120.0,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.end, // Align to bottom, simulate real position
          children: [
            AppNavigationBar(
              items: navItems,
              currentIndex: 0, // Select the first one, verify Active state
              onTap: (_) {},
            ),
          ],
        ),
      ),
    );
  });
}