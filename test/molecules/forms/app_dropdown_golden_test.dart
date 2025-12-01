import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/forms/app_dropdown.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppDropdown Golden Tests', () {
    goldenTest(
      'AppDropdown - Idle',
      fileName: 'app_dropdown_idle',
      builder: () => buildThemeMatrix(
        name: 'Idle',
        width: 300,
        height: 100,
        child: Portal(
          child: AppDropdown<String>(
            hint: 'Select an option',
            items: const ['Option 1', 'Option 2'],
            onChanged: (_) {},
          ),
        ),
      ),
    );

    goldenTest(
      'AppDropdown - Selected',
      fileName: 'app_dropdown_selected',
      builder: () => buildThemeMatrix(
        name: 'Selected',
        width: 300,
        height: 100,
        child: Portal(
          child: AppDropdown<String>(
            value: 'Option 1',
            items: const ['Option 1', 'Option 2'],
            onChanged: (_) {},
          ),
        ),
      ),
    );
  });
}
