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

  group('AppIcon Golden Tests', () {
    goldenTest(
      'AppIcon - Adaptive Styles',
      fileName: 'app_icon_adaptive',
      builder: () => GoldenTestGroup(
        children: [
          buildThemeMatrix(
            name: 'Icon Variants',
            width: 150.0,
            height: 100.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SVG Icon
                  AppIcon(
                    Assets.icons.search,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  // Font Icon
                  const AppIcon.font(
                    Icons.home,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  });
}
