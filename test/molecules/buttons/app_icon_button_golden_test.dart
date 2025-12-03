import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppIconButton Golden Tests', () {
    // Test 1: Base variant (default action button)
    goldenTest(
      'AppIconButton - Base Variant',
      fileName: 'app_icon_button_base',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 80,
            height: 80,
            child: AppIconButton(
              icon: const Icon(Icons.home),
              onTap: () {},
              variant: SurfaceVariant.base,
            ),
          );
        }).toList(),
      ),
    );

    // Test 2: Tonal variant (toggle/selected states)
    goldenTest(
      'AppIconButton - Tonal Variant (Toggle)',
      fileName: 'app_icon_button_tonal',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 80,
            height: 80,
            child: AppIconButton(
              // ✨ Tonal for secondary/toggle states
              icon: const Icon(Icons.favorite),
              onTap: () {},
              variant: SurfaceVariant.tonal,
            ),
          );
        }).toList(),
      ),
    );

    // Test 3: Highlight variant (critical actions)
    goldenTest(
      'AppIconButton - Highlight Variant',
      fileName: 'app_icon_button_highlight',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 80,
            height: 80,
            child: AppIconButton(
              icon: const Icon(Icons.add),
              onTap: () {},
              variant: SurfaceVariant.highlight,
            ),
          );
        }).toList(),
      ),
    );
  });
}
