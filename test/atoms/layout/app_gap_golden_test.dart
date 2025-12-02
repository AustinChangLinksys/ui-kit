import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/atoms/layout/app_gap.dart';
import 'package:ui_kit_library/src/atoms/typography/app_text.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppGap Golden Tests', () {
    goldenTest(
      'AppGap Matrix',
      fileName: 'app_gap_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppGap',
        width: 300,
        height: 400, // Lengthened to accommodate multiple examples
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Basic spacing test
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

            // 2. Gutter test (responsive spacing)
            // The width here is 300 (Mobile), so gutterMobile should be read
            _GapVisualizer(label: 'Gutter (Responsive)', gap: AppGap.gutter()),
          ],
        ),
      ),
    );
  });
}

// Helper widget: makes Gap "visible"
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
          // Left label
          SizedBox(
            width: 120,
            child: AppText.caption(label, color: Colors.grey),
          ),
          // Visualization block
          Container(
            width: 20,
            height: 20,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          // The main subject under test: Gap
          gap,
          // Right comparison block
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