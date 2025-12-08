import 'package:flutter_test/flutter_test.dart';
import 'package:alchemist/alchemist.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../../../test_utils/golden_test_matrix_factory.dart';
import '../../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppRangeInput Golden Tests', () {
    goldenTest(
      'AppRangeInput - Default State',
      fileName: 'app_range_input_default',
      builder: () => buildThemeMatrix(
        name: 'Default',
        width: 400.0,
        height: 100.0,
        child: const AppRangeInput(
          startLabel: 'Start',
          endLabel: 'End',
        ),
      ),
    );

    goldenTest(
      'AppRangeInput - Error State',
      fileName: 'app_range_input_error',
      builder: () => buildThemeMatrix(
        name: 'Error',
        width: 400.0,
        height: 120.0,
        child: const AppRangeInput(
          startLabel: 'Start',
          endLabel: 'End',
          errorText: 'Invalid range',
        ),
      ),
    );
  });
}