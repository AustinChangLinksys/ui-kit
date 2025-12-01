import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// 引入測試工具組
import '../../test_utils/golden_test_matrix_factory.dart'; // ✨ 矩陣工廠
import '../../test_utils/font_loader.dart'; // ✨ 字體載入

void main() {
  // 1. 測試前置準備：載入字體
  setUpAll(() async {
    await loadAppFonts(); 
  });

  group('AppButton Golden Tests', () {
    
    // 測試 1: Highlight Variant (Primary)
    goldenTest(
      'AppButton - Highlight',
      fileName: 'app_button_highlight',
      // 使用矩陣工廠自動生成 8 種風格 (4x2)
      builder: () => buildThemeMatrix(
        name: 'Highlight',
        width: 300, // 給予充足寬度防止 Overflow
        height: 100,
        child: AppButton(
          label: 'Confirm',
          onTap: () {},
          variant: SurfaceVariant.highlight,
        ),
      ),
    );

    // 測試 2: Base Variant (Secondary)
    goldenTest(
      'AppButton - Base',
      fileName: 'app_button_base',
      builder: () => buildThemeMatrix(
        name: 'Base',
        width: 300,
        height: 100,
        child: AppButton(
          label: 'Cancel',
          onTap: () {},
          variant: SurfaceVariant.base,
        ),
      ),
    );

    // 測試 3: Loading State
    goldenTest(
      'AppButton - Loading',
      fileName: 'app_button_loading',
      builder: () => buildThemeMatrix(
        name: 'Loading',
        width: 300,
        height: 100,
        // Matrix Factory 內部呼叫 buildSafeScenario，預設 disableAnimation: true
        // 這裡會自動凍結動畫，不會 Timeout
        child: AppButton(
          label: 'Loading',
          isLoading: true,
          onTap: () {},
        ),
      ),
    );

    // 測試 4: Disabled State
    goldenTest(
      'AppButton - Disabled',
      fileName: 'app_button_disabled',
      builder: () => buildThemeMatrix(
        name: 'Disabled',
        width: 300,
        height: 100,
        child: const AppButton(
          label: 'Disabled',
          onTap: null,
        ),
      ),
    );
  });
}