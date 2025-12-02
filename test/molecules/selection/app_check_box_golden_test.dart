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

  group('AppCheckbox Golden Tests', () {
    goldenTest(
      'AppCheckbox Matrix',
      fileName: 'app_checkbox_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppCheckbox',
        // Arrangement: Unchecked | Checked | Disabled
        width: 480, // 3 * 160
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Unchecked
            SizedBox(
              width: 160,
              height: 60,
              child: AppCheckbox(
                value: false,
                onChanged: (_) {},
                label: 'Off',
              ),
            ),
            // 2. Checked
            SizedBox(
              width: 160,
              height: 60,
              child: AppCheckbox(
                value: true,
                onChanged: (_) {},
                label: 'On',
              ),
            ),
            // 3. Disabled (Checked state)
            const SizedBox(
              width: 160,
              height: 60,
              child: AppCheckbox(
                value: true,
                onChanged: null, // Disabled
                label: 'Lock',
              ),
            ),
          ],
        ),
      ),
    );
  });
}
