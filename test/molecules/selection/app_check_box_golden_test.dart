import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// 引入共用工具
import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppCheckbox Golden Tests', () {
    goldenTest(
      'AppCheckbox Matrix',
      fileName: 'app_checkbox_matrix',
      builder: () => GoldenTestGroup(
        columns: 3, // 排列: 未選 | 已選 | 禁用
        children: kTestThemeMatrix.entries.map((entry) {
          final themeName = entry.key;
          final themeData = entry.value;

          return GoldenTestScenario(
            name: themeName,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Unchecked
                buildSafeScenario(
                  name: 'Unchecked',
                  theme: themeData,
                  width: 160, 
                  height: 60,
                  child: AppCheckbox(
                    value: false,
                    onChanged: (_) {},
                    label: 'Off',
                  ),
                ),
                // 2. Checked
                buildSafeScenario(
                  name: 'Checked',
                  theme: themeData,
                  width: 160, 
                  height: 60,
                  child: AppCheckbox(
                    value: true,
                    onChanged: (_) {},
                    label: 'On',
                  ),
                ),
                // 3. Disabled (Checked state)
                buildSafeScenario(
                  name: 'Disabled',
                  theme: themeData,
                  width: 160, 
                  height: 60,
                  child: const AppCheckbox(
                    value: true,
                    onChanged: null, // Disabled
                    label: 'Lock',
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