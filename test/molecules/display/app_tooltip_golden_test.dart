import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart'; // 必須引入
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/display/app_tooltip.dart';
import 'package:ui_kit_library/ui_kit.dart';

// 引入共用矩陣與安全場景建構器
import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppTooltip Golden Tests', () {
    kTestThemeMatrix.forEach((themeName, themeData) {
      goldenTest(
        'Tooltip - $themeName',
        fileName: 'app_tooltip_${themeName.toLowerCase()}',
        // 移除了 pumpWidget，因為我們使用 initiallyVisible: true
        builder: () => GoldenTestGroup(
          columns: 2,
          children: [
            // 場景 1: 純文字 (Standard Text)
            buildSafeScenario(
              name: 'Text Message',
              theme: themeData,
              width: 260, // 寬度給足，避免 Brutal 模式溢出
              height: 150,
              // ✨ 關鍵：手動包裹 Portal，因為 buildSafeScenario 裡沒有
              child: Portal(
                child: Center(
                  child: AppTooltip(
                    message: 'Edit Profile',
                    position: AxisDirection.up,
                    initiallyVisible: true, // 強制顯示
                    child: AppIconButton(
                        icon: const Icon(Icons.edit), onTap: () {}),
                  ),
                ),
              ),
            ),

            // 場景 2: 放入元件 (Components inside Tooltip)
            // 測試：Tooltip 內放入 Avatar + Text + Button
            buildSafeScenario(
              name: 'Rich Components',
              theme: themeData,
              width: 260,
              height: 200, // 高度拉大，因為內容較多
              child: Portal(
                child: Center(
                  child: AppTooltip(
                    position: AxisDirection.right,
                    initiallyVisible: true,
                    // ✨ 測試點：放入複雜元件
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const AppAvatar(initials: 'AU', size: 32),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.labelMedium('Austin'),
                                AppText.caption('Online', color: Colors.green),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // 在 Tooltip 裡放按鈕
                        AppButton(
                          label: 'Message',
                          size: AppButtonSize.small,
                          onTap: () {},
                        ),
                      ],
                    ),
                    child: AppIconButton(
                        icon: const Icon(Icons.person), onTap: () {}),
                  ),
                ),
              ),
            ),

            // 場景 3: 放入圖片 (Image inside Tooltip)
            // 測試：Tooltip 顯示預覽圖
            buildSafeScenario(
              name: 'Image Preview',
              theme: themeData,
              width: 260,
              height: 200,
              child: Portal(
                child: Center(
                  child: AppTooltip(
                    position: AxisDirection.down,
                    initiallyVisible: true,
                    // ✨ 測試點：放入圖片 (使用 Icon 模擬圖片，避免網路圖在測試中掛掉)
                    // 實務上可以用 Image.asset 或 Image.memory
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 120,
                          height: 80,
                          color: Colors.grey.withValues(alpha: 0.3),
                          child: const Icon(Icons.image,
                              size: 40, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        AppText.caption('Preview.jpg'),
                      ],
                    ),
                    child: AppIconButton(
                        icon: const Icon(Icons.image_search), onTap: () {}),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  });
}
