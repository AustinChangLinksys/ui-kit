import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/navigation/app_navigation_bar.dart';
import 'package:ui_kit_library/src/molecules/navigation/app_navigation_item.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  // 準備測試數據
  final navItems = [
    const AppNavigationItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home), // 測試 activeIcon 替換邏輯
      label: 'Home',
    ),
    const AppNavigationItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    const AppNavigationItem(
      icon: Icon(Icons.person_outline),
      label: 'Profile',
    ),
  ];

  group('AppNavigationBar Golden Tests', () {
    goldenTest(
      'AppNavigationBar Theme Matrix',
      fileName: 'app_navigation_bar_matrix',
      builder: () => GoldenTestGroup(
        // 導航列比較寬，我們用 1 欄排列，方便觀察細節
        columns: 1,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            // 模擬手機螢幕寬度 (iPhone SE ~ 11 左右)
            width: 375.0,
            // 高度給足一點，因為 Floating Bar 有 margin
            height: 120.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // 靠下對齊，模擬真實位置
              children: [
                AppNavigationBar(
                  items: navItems,
                  currentIndex: 0, // 固定選中第一個，驗證 Active 狀態
                  onTap: (_) {},
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  });
}
