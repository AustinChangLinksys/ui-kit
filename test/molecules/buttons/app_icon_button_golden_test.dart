import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppIconButton Golden Tests', () {
    goldenTest(
      'AppIconButton Matrix',
      fileName: 'app_icon_button_matrix',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 80, // Icon Button 較小，縮小測試範圍
            height: 80,
            child: AppIconButton(
              icon: const Icon(Icons.settings),
              onTap: () {},
              variant: SurfaceVariant.base,
            ),
          );
        }).toList(),
      ),
    );
  });
}
