import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/atoms/typography/app_text.dart';

// 引入共用工具
import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppText Golden Tests', () {
    goldenTest(
      'AppText Matrix',
      fileName: 'app_text_matrix',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 350, // 文字測試需要較寬的空間
            height: 600, // 高度拉長以容納所有層級
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Semantic Factories (語義化捷徑 - 最常用)
                _SectionHeader('Semantic Aliases'),
                AppText.headline('Headline (H3)'),
                AppText.subhead('Subhead (Subtitle2)'),
                AppText.body(
                    'Body text: The quick brown fox jumps over the lazy dog.'),
                AppText.caption('Caption (Helper text)'),
                AppText.tiny('Tiny (Tags/Timestamp)'),

                const Divider(height: 24),

                // 2. Material 3 Standard Levels (標準層級 - 精確控制)
                _SectionHeader('Material 3 Scale'),
                AppText.displaySmall('Display Small'),
                AppText.headlineSmall('Headline Small'),
                AppText.titleMedium('Title Medium'),
                AppText.labelLarge('Label Large (Button)'),
                AppText.bodySmall('Body Small'),

                const Divider(height: 24),

                // 3. Custom Extensions (自定義擴充)
                _SectionHeader('Custom / Overrides'),
                AppText.bodyExtraSmall('Body Extra Small (10sp)'),
                // 測試顏色覆寫
                AppText.body('Colored Text (Primary)',
                    color: entry.value.colorScheme.primary),
                // 測試粗細覆寫
                const AppText('Bold Body Text', fontWeight: FontWeight.w900),
              ],
            ),
          );
        }).toList(),
      ),
    );
  });
}

// 測試用的小標題 Helper
class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.withOpacity(0.5),
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
