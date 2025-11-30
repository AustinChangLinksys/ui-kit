import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppButton Golden Tests', () {
    // 1. 標準狀態 (Highlight)
    goldenTest(
      'AppButton - Highlight',
      fileName: 'app_button_highlight',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300, // 寬度給足，防止 RenderFlex overflow
            height: 100,
            child: AppButton(
              label: 'Confirm',
              onTap: () {},
              variant: SurfaceVariant.highlight,
            ),
          );
        }).toList(),
      ),
    );

    // 2. Loading 狀態 (再也不會 Timeout 了!)
    goldenTest(
      'AppButton - Loading',
      fileName: 'app_button_loading',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300,
            height: 100,
            // buildSafeScenario 預設 disableAnimation: true
            // 所以這裡的 Infinite Animation 會被凍結在第一幀，安全截圖
            child: AppButton(
              label: 'Loading',
              isLoading: true,
              onTap: () {},
            ),
          );
        }).toList(),
      ),
    );

    // 3. Disabled 狀態
    goldenTest(
      'AppButton - Disabled',
      fileName: 'app_button_disabled',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300,
            height: 100,
            child: const AppButton(
              label: 'Disabled',
              onTap: null,
            ),
          );
        }).toList(),
      ),
    );
  });
}
