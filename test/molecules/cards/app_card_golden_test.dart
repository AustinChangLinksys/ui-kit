import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// 引入共用工具
import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppCard Golden Tests', () {
    goldenTest(
      'AppCard Theme Matrix',
      fileName: 'app_card_matrix',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 160,
            height: 160,
            child: const AppCard(
              width: 100,
              height: 100,
              child: Center(child: Text('Card Content')),
            ),
          );
        }).toList(),
      ),
    );
  });
}
