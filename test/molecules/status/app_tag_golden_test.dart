import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import test utilities
import '../../test_utils/golden_test_matrix_factory.dart'; // ✨ Matrix factory
import '../../test_utils/font_loader.dart'; // ✨ Font loader

void main() {
  // 1. Setup: Load fonts
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppTag Golden Tests', () {

    // Test 1: Unselected State - Base Surface
    goldenTest(
      'AppTag - Unselected (Base Surface)',
      fileName: 'app_tag_base_unselected',
      builder: () => buildThemeMatrix(
        name: 'Unselected',
        width: 300,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Default style with base surface
            const AppTag(label: '#Flutter', isSelected: false),
            const SizedBox(height: 8),

            // Custom color tint - verify border behavior in different themes
            const AppTag(
              label: '#DesignSystem',
              color: Colors.orange,
              isSelected: false,
            ),
            const SizedBox(height: 8),

            // Interactive with delete action
            AppTag(
              label: 'Filter: Inactive',
              onDeleted: () {},
              color: Colors.blue,
              isSelected: false,
            ),
          ],
        ),
      ),
    );

    // Test 2: Selected State - Tonal Surface
    goldenTest(
      'AppTag - Selected (Tonal Surface)',
      fileName: 'app_tag_tonal_selected',
      builder: () => buildThemeMatrix(
        name: 'Selected',
        width: 300,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Selected style with tonal/secondary surface
            const AppTag(label: '#Flutter', isSelected: true),
            const SizedBox(height: 8),

            // Custom color selected - tonal surface applied
            const AppTag(
              label: '#DesignSystem',
              color: Colors.orange,
              isSelected: true,
            ),
            const SizedBox(height: 8),

            // Interactive selected with delete action
            AppTag(
              label: 'Filter: Active',
              onDeleted: () {},
              color: Colors.blue,
              isSelected: true,
            ),
          ],
        ),
      ),
    );
  });
}
