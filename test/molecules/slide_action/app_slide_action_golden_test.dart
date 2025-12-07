import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  group('AppSlideAction Golden Tests', () {
    goldenTest(
      'AppSlideAction - Open State',
      fileName: 'app_slide_action_open',
      builder: () => buildThemeMatrix(
        name: 'Open',
        width: 375.0,
        height: 80.0,
        child: AppSlideAction(
          initiallyOpen: true,
          actions: [
            SlideActionItem(
              label: 'Delete',
              icon: const Icon(Icons.delete),
              onTap: () {},
              variant: SlideActionVariant.destructive,
            ),
          ],
          child: Container(
            color: Colors.grey[300],
            height: 72,
            child: const Center(
              child: Text('Swipe Item', style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'AppSlideAction - Multiple Actions',
      fileName: 'app_slide_action_multiple',
      builder: () => buildThemeMatrix(
        name: 'Multiple Actions',
        width: 375.0,
        height: 80.0,
        child: AppSlideAction(
          initiallyOpen: true,
          actions: [
            SlideActionItem(
              label: 'Edit',
              icon: const Icon(Icons.edit),
              onTap: () {},
              variant: SlideActionVariant.standard,
            ),
            SlideActionItem(
              label: 'Delete',
              icon: const Icon(Icons.delete),
              onTap: () {},
              variant: SlideActionVariant.destructive,
            ),
          ],
          child: Container(
            color: Colors.white,
            height: 72,
            child: const Center(child: Text('Swipeable List Item')),
          ),
        ),
      ),
    );
  });
}
