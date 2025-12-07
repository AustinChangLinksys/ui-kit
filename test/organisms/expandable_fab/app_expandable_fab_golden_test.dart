import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:alchemist/alchemist.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import test utilities
import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  // Setup: Load fonts
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppExpandableFab Golden Tests', () {
    goldenTest(
      'AppExpandableFab - Closed State',
      fileName: 'app_expandable_fab_closed',
      builder: () => buildThemeMatrix(
        name: 'Closed',
        width: 100.0,
        height: 100.0,
        child: const Portal(
          child: Align(
            alignment: Alignment.bottomRight,
            child: AppExpandableFab(
              icon: Icon(Icons.add),
              children: [
                Icon(Icons.image),
                Icon(Icons.camera),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'AppExpandableFab - Expanded State',
      fileName: 'app_expandable_fab_expanded',
      builder: () => buildThemeMatrix(
        name: 'Expanded',
        width: 120.0,
        height: 350.0, // Increased to fit 3 mini FABs + main FAB + spacing
        child: const Portal(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 8, bottom: 8),
              child: AppExpandableFab(
                initiallyOpen: true,
                icon: Icon(Icons.add),
                activeIcon: Icon(Icons.close),
                children: [
                  Icon(Icons.image),
                  Icon(Icons.camera),
                  Icon(Icons.video_call),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'AppExpandableFab - Custom Icons',
      fileName: 'app_expandable_fab_custom_icon',
      builder: () => buildThemeMatrix(
        name: 'Custom',
        width: 120.0,
        height: 280.0, // Increased to fit 2 mini FABs + main FAB + spacing
        child: const Portal(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 8, bottom: 8),
              child: AppExpandableFab(
                initiallyOpen: true,
                icon: Icon(Icons.menu),
                activeIcon: Icon(Icons.close),
                children: [
                  Icon(Icons.share),
                  Icon(Icons.edit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
}
