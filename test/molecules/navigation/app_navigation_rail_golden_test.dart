import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  final navItems = [
    const AppNavigationItem(icon: Icon(Icons.home), label: 'Home'),
    const AppNavigationItem(icon: Icon(Icons.folder), label: 'Files'),
    const AppNavigationItem(icon: Icon(Icons.settings), label: 'Config'),
  ];

  group('AppNavigationRail Golden Tests', () {
    goldenTest(
      'AppNavigationRail Matrix',
      fileName: 'app_navigation_rail_matrix',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 150, // Only capture the left part of the Rail
            height: 400, // Height must be long enough to see Header/Footer
            child: Row( // Simulate the Row structure of Scaffold body
              children: [
                AppNavigationRail(
                  items: navItems,
                  currentIndex: 0,
                  onTap: (_) {},
                  // Test Slot
                  leading: const FlutterLogo(size: 32),
                  trailing: const Icon(Icons.logout, size: 20),
                ),
                // Right blank space simulates content area
                const Expanded(child: SizedBox()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  });
}