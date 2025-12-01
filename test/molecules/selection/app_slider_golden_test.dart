import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppSlider Golden Tests', () {
    
    // 1. Continuous sliding - test 50% position
    goldenTest(
      'AppSlider - Continuous',
      fileName: 'app_slider_continuous',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300,
            height: 80,
            child: AppSlider(
              value: 0.5,
              onChanged: (_) {},
            ),
          );
        }).toList(),
      ),
    );

    // 2. Discrete stepping (Discrete) - test tick display (Ticks)
    goldenTest(
      'AppSlider - Discrete',
      fileName: 'app_slider_discrete',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300,
            height: 80,
            child: AppSlider(
              value: 3,
              min: 0,
              max: 5,
              divisions: 5, // Should display 6 tick marks (0,1,2,3,4,5)
              onChanged: (_) {},
            ),
          );
        }).toList(),
      ),
    );

    // 3. Disabled state
    goldenTest(
      'AppSlider - Disabled',
      fileName: 'app_slider_disabled',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300,
            height: 80,
            child: const AppSlider(
              value: 0.3,
              onChanged: null, // Disabled
            ),
          );
        }).toList(),
      ),
    );
  });
}