import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppSkeleton Golden Tests', () {
    goldenTest(
      'AppSkeleton Matrix',
      fileName: 'app_skeleton_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppSkeleton',
        width: 200,
        height: 400, // Adjusted height for multiple scenarios
        child: Column(
          children: [
            // 1. Basic block
            AppSkeleton(
              width: 100,
              height: 60,
            ),
            const SizedBox(height: 16),

            // 2. Text placeholder
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSkeleton.text(width: 120, height: 20),
                const SizedBox(height: 8),
                AppSkeleton.text(width: 80, height: 14),
              ],
            ),
            const SizedBox(height: 16),

            // 3. Avatar placeholder
            AppSkeleton.circular(size: 48),
            const SizedBox(height: 16),

            // 4. Capsule/button placeholder
            AppSkeleton.capsule(width: 80, height: 32),
          ],
        ),
      ),
    );
  });
}
