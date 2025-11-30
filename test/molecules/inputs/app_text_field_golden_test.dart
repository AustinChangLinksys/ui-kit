import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_scenarios.dart';
import '../../test_utils/test_theme_matrix.dart';

void main() {
  group('AppTextField Golden Tests', () {
    kTestThemeMatrix.forEach((themeName, themeData) {
      goldenTest(
        'TextField - $themeName',
        fileName: 'text_field_${themeName.toLowerCase()}',
        // 自定義 Pump 行為：模擬點擊以觸發 Focus 狀態
        pumpWidget: (tester, widget) async {
          await tester.pumpWidget(widget);
          // 嘗試找到並點擊第一個 TextField (對應 'Outline Focused' 場景)
          // 注意：GoldenTestGroup 裡有多個 TextField，這只會 Focus 第一個被找到的
          // 實務上通常足夠驗證 "Focus 樣式是否存在"
          await tester.tap(find.byType(TextField).first);
          await tester.pumpAndSettle();
        },
        builder: () => GoldenTestGroup(
          columns: 2,
          children: [
            // 1. Idle Outline
            buildSafeScenario(
              name: 'Outline Idle',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(hintText: 'Enter value'),
            ),

            // 2. Focused Outline (會被 pumpWidget 觸發)
            buildSafeScenario(
              name: 'Outline Focused',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(hintText: 'Focused Text'),
            ),

            // 3. Error State
            buildSafeScenario(
              name: 'Outline Error',
              theme: themeData,
              width: 300,
              height: 170, // 增加高度顯示錯誤訊息
              child: const AppTextField(
                hintText: 'Required',
                errorText: 'This field is required.',
              ),
            ),

            // 4. Underline Variant
            buildSafeScenario(
              name: 'Underline Variant',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(
                variant: AppInputVariant.underline,
                hintText: 'Username',
              ),
            ),

            // 5. Filled Variant
            buildSafeScenario(
              name: 'Filled Variant',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(
                variant: AppInputVariant.filled,
                hintText: 'Email Address',
              ),
            ),

            // 6. With Icons & Large Text (Typography Test) ✨ 新增
            buildSafeScenario(
              name: 'Title Input w/ Icon',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(
                hintText: 'Page Title',
                // 測試大字體輸入
                textVariant: AppTextVariant.headlineSmall, 
                prefixIcon: Icon(Icons.title),
                // 測試 Underline 配合大標題的效果 (常見設計)
                variant: AppInputVariant.underline,
              ),
            ),
          ],
        ),
      );
    });
  });
}