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

  group('AppTag Golden Tests', () {
    goldenTest(
      'AppTag Matrix',
      fileName: 'app_tag_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppTag',
        width: 300,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Default style (Base Style)
            const AppTag(label: '#Flutter'),
            const SizedBox(height: 8),

            // 2. Custom color (Custom Tint)
            // Observe if orange Tag still has thick black border in Brutal mode
            const AppTag(
              label: '#DesignSystem',
              color: Colors.orange,
            ),
            const SizedBox(height: 8),

            // 3. Interactive
            AppTag(
              label: 'Filter: Active',
              onDeleted: () {},
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  });
}
