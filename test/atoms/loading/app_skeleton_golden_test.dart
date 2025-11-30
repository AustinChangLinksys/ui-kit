import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// 引入矩陣與新的場景建構器
import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart'; // ✨ 新增引用

void main() {
  group('AppSkeleton Golden Tests', () {
    kTestThemeMatrix.forEach((themeName, themeData) {
      goldenTest(
        'AppSkeleton - $themeName',
        fileName: 'app_skeleton_${themeName.toLowerCase()}',
        builder: () => GoldenTestGroup(
          columns: 2,
          children: [
            // 1. 基礎區塊
            buildSafeScenario(
              name: 'Standard Box',
              theme: themeData,
              child: const AppSkeleton(
                width: 100,
                height: 60,
              ),
            ),

            // 2. 文字佔位符
            buildSafeScenario(
              name: 'Text Line',
              theme: themeData,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeleton.text(width: 120, height: 20),
                  const SizedBox(height: 8),
                  AppSkeleton.text(width: 80, height: 14),
                ],
              ),
            ),

            // 3. 頭像佔位符
            buildSafeScenario(
              name: 'Circular (Avatar)',
              theme: themeData,
              child: AppSkeleton.circular(size: 48),
            ),

            // 4. 膠囊/按鈕佔位符
            buildSafeScenario(
              name: 'Capsule (Chip)',
              theme: themeData,
              child: AppSkeleton.capsule(width: 80, height: 32),
            ),
          ],
        ),
      );
    });
  });
}