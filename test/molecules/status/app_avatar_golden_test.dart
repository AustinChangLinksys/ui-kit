import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppAvatar Golden Tests', () {
    goldenTest(
      'AppAvatar Matrix',
      fileName: 'app_avatar_matrix',
      builder: () => GoldenTestGroup(
        columns: 3,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 100, // Avatar 比較小
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                // 1. 標準 Initials (Standard)
                AppAvatar(
                  initials: 'JD',
                  size: 40,
                ),
                // 2. 大尺寸 (Large)
                AppAvatar(
                  initials: 'XY',
                  size: 56,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  });
}