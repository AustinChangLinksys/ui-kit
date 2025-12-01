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

  group('AppAvatar Golden Tests', () {
    goldenTest(
      'AppAvatar Matrix',
      fileName: 'app_avatar_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppAvatar',
        width: 200, // Adjusted width to accommodate all elements in a row
        height: 100,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 1. Standard Initials (Standard)
            AppAvatar(
              initials: 'JD',
              size: 40,
            ),
            // 2. Large size (Large)
            AppAvatar(
              initials: 'XY',
              size: 56,
            ),
          ],
        ),
      ),
    );
  });
}