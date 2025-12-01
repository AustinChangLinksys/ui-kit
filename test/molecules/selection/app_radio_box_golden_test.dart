import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppRadio Golden Tests', () {
    goldenTest(
      'AppRadio Matrix',
      fileName: 'app_radio_matrix',
      builder: () => GoldenTestGroup(
        columns: 3, // Arrangement: Unselected | Selected | Disabled
        children: kTestThemeMatrix.entries.map((entry) {
          final themeName = entry.key;
          final themeData = entry.value;

          return GoldenTestScenario(
            name: themeName,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Unselected
                buildSafeScenario(
                  name: 'Unselected',
                  theme: themeData,
                  width: 160,
                  height: 60,
                  child: AppRadio<int>(
                    value: 1,
                    groupValue: 2, // Mismatch = Unselected
                    onChanged: (_) {},
                    label: 'Opt A',
                  ),
                ),
                // 2. Selected
                buildSafeScenario(
                  name: 'Selected',
                  theme: themeData,
                  width: 160,
                  height: 60,
                  child: AppRadio<int>(
                    value: 1,
                    groupValue: 1, // Match = Selected
                    onChanged: (_) {},
                    label: 'Opt B',
                  ),
                ),
                // 3. Disabled
                buildSafeScenario(
                  name: 'Disabled',
                  theme: themeData,
                  width: 160,
                  height: 60,
                  child: const AppRadio<int>(
                    value: 1,
                    groupValue: 1,
                    onChanged: null, // Disabled
                    label: 'Opt C',
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  });
}
