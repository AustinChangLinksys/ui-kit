import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppIconButton Golden Tests', () {
    // Test 1: Tertiary variant (base action button)
    goldenTest(
      'AppIconButton - Tertiary Variant',
      fileName: 'app_icon_button_tertiary',
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

    // Test 2: Secondary variant (tonal toggle/selected states)
    goldenTest(
      'AppIconButton - Secondary Variant (Toggle)',
      fileName: 'app_icon_button_secondary',
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

    // Test 3: Primary variant (highlight critical actions)
    goldenTest(
      'AppIconButton - Primary Variant',
      fileName: 'app_icon_button_primary',
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
