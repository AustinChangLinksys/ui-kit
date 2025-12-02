import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../../test_utils/font_loader.dart';
import '../../test_utils/golden_test_matrix_factory.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppDivider Golden Tests', () {
    goldenTest(
      'AppDivider - Horizontal',
      fileName: 'app_divider_horizontal',
      builder: () => buildThemeMatrix(
        name: 'Horizontal',
        width: 300.0,
        height: 50.0,
        child: const Center(child: AppDivider()),
      ),
    );

    goldenTest(
      'AppDivider - Vertical',
      fileName: 'app_divider_vertical',
      builder: () => buildThemeMatrix(
        name: 'Vertical',
        width: 100.0,
        height: 200.0,
        child: const Center(child: AppDivider(axis: Axis.vertical)),
      ),
    );
  });
}
