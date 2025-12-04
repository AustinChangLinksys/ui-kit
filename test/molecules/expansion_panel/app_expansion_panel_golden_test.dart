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

  group('AppExpansionPanel Golden Tests', () {
    goldenTest(
      'AppExpansionPanel - Collapsed',
      fileName: 'expansion_panel_collapsed',
      builder: () => buildThemeMatrix(
        name: 'Collapsed',
        width: 300.0,
        height: 400.0,
        child: const AppExpansionPanel(
          panels: [
            ExpansionPanelItem(
              headerTitle: 'Panel 1',
              content: Text('Content 1'),
            ),
            ExpansionPanelItem(
              headerTitle: 'Panel 2',
              content: Text('Content 2'),
            ),
          ],
        ),
      ),
    );

    goldenTest(
      'AppExpansionPanel - Expanded',
      fileName: 'expansion_panel_expanded',
      builder: () => buildThemeMatrix(
        name: 'Expanded',
        width: 300.0,
        height: 400.0,
        child: const AppExpansionPanel(
          panels: [
            ExpansionPanelItem(
              headerTitle: 'Panel 1',
              content: Text('Content 1'),
            ),
            ExpansionPanelItem(
              headerTitle: 'Panel 2',
              content: Text('Content 2'),
            ),
          ],
          initialExpandedIndices: {0},
        ),
      ),
    );

    goldenTest(
      'AppExpansionPanel - Multiple Expanded',
      fileName: 'expansion_panel_multiple_expanded',
      builder: () => buildThemeMatrix(
        name: 'Multiple Expanded',
        width: 300.0,
        height: 400.0,
        child: const AppExpansionPanel(
          panels: [
            ExpansionPanelItem(
              headerTitle: 'Panel 1',
              content: Text('Content 1'),
            ),
            ExpansionPanelItem(
              headerTitle: 'Panel 2',
              content: Text('Content 2'),
            ),
          ],
          allowMultipleOpen: true,
          initialExpandedIndices: {0, 1},
        ),
      ),
    );
  });
}
