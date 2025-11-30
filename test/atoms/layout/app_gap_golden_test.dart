import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/atoms/layout/app_gap.dart';
import 'package:ui_kit_library/src/atoms/typography/app_text.dart';

import '../../test_utils/test_theme_matrix.dart';
import '../../test_utils/golden_test_scenarios.dart';

void main() {
  group('AppGap Golden Tests', () {
    goldenTest(
      'AppGap Matrix',
      fileName: 'app_gap_matrix',
      builder: () => GoldenTestGroup(
        columns: 2,
        children: kTestThemeMatrix.entries.map((entry) {
          return buildSafeScenario(
            name: entry.key,
            theme: entry.value,
            width: 300,
            height: 400, // 拉長以容納多個範例
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. 基礎間距測試
                _GapVisualizer(label: 'xxs (2px)', gap: AppGap.xxs()),
                _GapVisualizer(label: 'xs (4px)', gap: AppGap.xs()),
                _GapVisualizer(label: 'sm (8px)', gap: AppGap.sm()),
                _GapVisualizer(
                    label: 'md (12px)', gap: AppGap.md()), // Standard
                _GapVisualizer(label: 'lg (16px)', gap: AppGap.lg()),
                _GapVisualizer(label: 'xl (24px)', gap: AppGap.xl()),
                _GapVisualizer(label: 'xxl (32px)', gap: AppGap.xxl()),
                _GapVisualizer(label: 'xxxl (48px)', gap: AppGap.xxxl()),

                const Divider(height: 32),

                // 2. Gutter 測試 (響應式間距)
                // 這裡的寬度是 300 (Mobile)，所以應該讀取 gutterMobile
                _GapVisualizer(
                    label: 'Gutter (Responsive)', gap: AppGap.gutter()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  });
}

// 輔助元件：讓 Gap "看得見"
class _GapVisualizer extends StatelessWidget {
  final String label;
  final Widget gap;

  const _GapVisualizer({required this.label, required this.gap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // 左側標籤
          SizedBox(
            width: 120,
            child: AppText.caption(label, color: Colors.grey),
          ),
          // 視覺化區塊
          Container(
            width: 20,
            height: 20,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          // ✨ 被測試的主角：Gap ✨
          gap,
          // 右側對照區塊
          Container(
            width: 20,
            height: 20,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
