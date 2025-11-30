import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  final navItems = [
    const AppNavigationItem(icon: Icon(Icons.home), label: 'Home'),
    const AppNavigationItem(icon: Icon(Icons.folder), label: 'Files'),
    const AppNavigationItem(icon: Icon(Icons.settings), label: 'Config'),
  ];

  group('AppNavigationRail Golden Tests', () {
    goldenTest(
      'AppNavigationRail Matrix',
      fileName: 'app_navigation_rail_matrix',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 150, // 只截取左側 Rail 的部分
            height: 400, // 高度要夠長才能看到 Header/Footer
            child: Row( // 模擬 Scaffold body 的 Row 結構
              children: [
                AppNavigationRail(
                  items: navItems,
                  currentIndex: 0,
                  onTap: (_) {},
                  // 測試 Slot
                  leading: const FlutterLogo(size: 32),
                  trailing: const Icon(Icons.logout, size: 20),
                ),
                // 右側留白模擬內容區
                const Expanded(child: SizedBox()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  });
}