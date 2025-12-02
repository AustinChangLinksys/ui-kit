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

  group('AppRadio Golden Tests', () {
    goldenTest(
      'AppRadio Matrix',
      fileName: 'app_radio_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppRadio',
        // Arrangement: Unselected | Selected | Disabled
        width: 480, // 3 * 160
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Unselected
            SizedBox(
              width: 160,
              height: 60,
              child: AppRadio<int>(
                value: 1,
                groupValue: 2, // Mismatch = Unselected
                onChanged: (_) {},
                label: 'Opt A',
              ),
            ),
            // 2. Selected
            SizedBox(
              width: 160,
              height: 60,
              child: AppRadio<int>(
                value: 1,
                groupValue: 1, // Match = Selected
                onChanged: (_) {},
                label: 'Opt B',
              ),
            ),
            // 3. Disabled
            const SizedBox(
              width: 160,
              height: 60,
              child: AppRadio<int>(
                value: 1,
                groupValue: 1,
                onChanged: null, // Disabled
                label: 'Opt C',
              ),
            ),
          ],
        ),
      ),
    );
  });
}