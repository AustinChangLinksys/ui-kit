import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/organisms/app_bar/app_unified_bar.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppUnifiedBar Golden Tests', () {
    // Test 1: Default AppBar with title
    goldenTest(
      'AppUnifiedBar - Default',
      fileName: 'app_unified_bar_default',
      builder: () => buildThemeMatrix(
        name: 'Default',
        width: 400,
        height: 80,
        child: const AppUnifiedBar(
          title: 'Dashboard',
        ),
      ),
    );

    // Test 2: AppBar with actions
    goldenTest(
      'AppUnifiedBar - With Actions',
      fileName: 'app_unified_bar_with_actions',
      builder: () => buildThemeMatrix(
        name: 'With Actions',
        width: 400,
        height: 80,
        child: AppUnifiedBar(
          title: 'Settings',
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );

    // Test 3: AppBar with bottom (TabBar placeholder)
    goldenTest(
      'AppUnifiedBar - With Bottom',
      fileName: 'app_unified_bar_with_bottom',
      builder: () => buildThemeMatrix(
        name: 'With Bottom',
        width: 400,
        height: 130,
        child: AppUnifiedBar(
          title: 'Products',
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              height: 48,
              alignment: Alignment.center,
              child: const Text('Tab Bar Placeholder'),
            ),
          ),
        ),
      ),
    );

    // Test 4: AppBar left-aligned title
    goldenTest(
      'AppUnifiedBar - Left Aligned',
      fileName: 'app_unified_bar_left_aligned',
      builder: () => buildThemeMatrix(
        name: 'Left Aligned',
        width: 400,
        height: 80,
        child: const AppUnifiedBar(
          title: 'Profile',
          centerTitle: false,
        ),
      ),
    );
  });
}
