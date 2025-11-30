import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppBadge Golden Tests', () {
    goldenTest(
      'AppBadge Matrix',
      fileName: 'app_badge_matrix',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 200,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. 預設樣式 (Theme Highlight)
                const AppBadge(label: 'Beta Feature'),
                const SizedBox(height: 8),
                
                // 2. 自定義顏色 (Custom Tint)
                const AppBadge(
                  label: 'Error',
                  color: Colors.red,
                ),
                const SizedBox(height: 8),
                
                // 3. 帶刪除圖示 (With Icon)
                AppBadge(
                  label: 'Dismissible',
                  onDeleted: () {},
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  });
}