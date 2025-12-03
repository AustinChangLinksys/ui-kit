import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import shared utilities
import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppCard Golden Tests', () {
    // Test 1: Unselected state (Base surface)
    goldenTest(
      'AppCard - Unselected (Base Surface)',
      fileName: 'app_card_base_unselected',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 160,
            height: 160,
            child: const AppCard(
              isSelected: false, // ✨ Base surface (default)
              width: 100,
              height: 100,
              child: Center(child: Text('Unselected')),
            ),
          );
        }).toList(),
      ),
    );

    // Test 2: Selected state (Tonal surface)
    goldenTest(
      'AppCard - Selected (Tonal Surface)',
      fileName: 'app_card_tonal_selected',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 160,
            height: 160,
            child: const AppCard(
              isSelected: true, // ✨ Tonal surface when selected
              width: 100,
              height: 100,
              child: Center(child: Text('Selected')),
            ),
          );
        }).toList(),
      ),
    );
  });
}
