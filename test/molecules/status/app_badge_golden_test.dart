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

  group('AppBadge Golden Tests', () {
    goldenTest(
      'AppBadge Matrix',
      fileName: 'app_badge_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppBadge',
        width: 200,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Default style (Theme Highlight)
            const AppBadge(label: 'Beta Feature'),
            const SizedBox(height: 8),

            // 2. Custom color (Custom Tint)
            const AppBadge(
              label: 'Error',
              color: Colors.red,
            ),
            const SizedBox(height: 8),

            // 3. With delete icon (With Icon)
            AppBadge(
              label: 'Dismissible',
              onDeleted: () {},
            ),
          ],
        ),
      ),
    );
  });
}
