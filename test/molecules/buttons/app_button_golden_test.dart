import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppButton Golden Tests', () {
    // 1. Standard State (Highlight)
    goldenTest(
      'AppButton - Highlight',
      fileName: 'app_button_highlight',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300, // Sufficient width to prevent RenderFlex overflow
            height: 100,
            child: AppButton(
              label: 'Confirm',
              onTap: () {},
              variant: SurfaceVariant.highlight,
            ),
          );
        }).toList(),
      ),
    );

    // 2. Loading State (no more Timeout!)
    goldenTest(
      'AppButton - Loading',
      fileName: 'app_button_loading',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300,
            height: 100,
            // buildSafeScenario defaults to disableAnimation: true
            // So the Infinite Animation here will be frozen on the first frame, for safe screenshot
            child: AppButton(
              label: 'Loading',
              isLoading: true,
              onTap: () {},
            ),
          );
        }).toList(),
      ),
    );

    // 3. Disabled State
    goldenTest(
      'AppButton - Disabled',
      fileName: 'app_button_disabled',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300,
            height: 100,
            child: const AppButton(
              label: 'Disabled',
              onTap: null,
            ),
          );
        }).toList(),
      ),
    );
  });
}
