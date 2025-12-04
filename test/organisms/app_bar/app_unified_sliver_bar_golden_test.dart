import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/organisms/app_bar/app_unified_sliver_bar.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppUnifiedSliverBar Golden Tests', () {
    // Test 1: Expanded state with flexible space
    goldenTest(
      'AppUnifiedSliverBar - Expanded',
      fileName: 'app_unified_sliver_bar_expanded',
      builder: () => buildThemeMatrix(
        name: 'Expanded',
        width: 400,
        height: 250,
        child: CustomScrollView(
          slivers: [
            AppUnifiedSliverBar(
              title: 'Profile',
              expandedHeight: 200,
              flexibleSpace: Container(
                color: Colors.blue.withValues(alpha: 0.3),
                child: const Center(
                  child: Icon(Icons.person, size: 64, color: Colors.white),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 50),
            ),
          ],
        ),
      ),
    );

    // Test 2: Collapsed state (no flexible space)
    goldenTest(
      'AppUnifiedSliverBar - Collapsed',
      fileName: 'app_unified_sliver_bar_collapsed',
      builder: () => buildThemeMatrix(
        name: 'Collapsed',
        width: 400,
        height: 100,
        child: CustomScrollView(
          slivers: [
            const AppUnifiedSliverBar(
              title: 'Dashboard',
              pinned: true,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 50),
            ),
          ],
        ),
      ),
    );

    // Test 3: With actions
    goldenTest(
      'AppUnifiedSliverBar - With Actions',
      fileName: 'app_unified_sliver_bar_with_actions',
      builder: () => buildThemeMatrix(
        name: 'With Actions',
        width: 400,
        height: 100,
        child: CustomScrollView(
          slivers: [
            AppUnifiedSliverBar(
              title: 'Settings',
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 50),
            ),
          ],
        ),
      ),
    );
  });
}
