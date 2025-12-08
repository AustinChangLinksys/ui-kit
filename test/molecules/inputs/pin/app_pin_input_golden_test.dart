import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alchemist/alchemist.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../../../test_utils/golden_test_matrix_factory.dart';
import '../../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppPinInput Golden Tests', () {
    goldenTest(
      'AppPinInput - Empty State',
      fileName: 'app_pin_input_empty',
      builder: () => buildThemeMatrix(
        name: 'Empty',
        width: 400.0,
        height: 100.0,
        child: const AppPinInput(length: 4),
      ),
    );

    goldenTest(
      'AppPinInput - Filled State',
      fileName: 'app_pin_input_filled',
      pumpWidget: (tester, widget) async {
        await tester.pumpWidget(widget);
        // Enter text into all PIN inputs
        final textFields = find.byType(TextField);
        for (final textField in textFields.evaluate()) {
          await tester.enterText(find.byWidget(textField.widget), '1234');
        }
        await tester.pump();
      },
      builder: () => buildThemeMatrix(
        name: 'Filled',
        width: 400.0,
        height: 100.0,
        child: const AppPinInput(length: 4),
      ),
    );

    goldenTest(
      'AppPinInput - Obscured State',
      fileName: 'app_pin_input_obscured',
      pumpWidget: (tester, widget) async {
        await tester.pumpWidget(widget);
        final textFields = find.byType(TextField);
        for (final textField in textFields.evaluate()) {
          await tester.enterText(find.byWidget(textField.widget), '1234');
        }
        await tester.pump();
      },
      builder: () => buildThemeMatrix(
        name: 'Obscured',
        width: 400.0,
        height: 100.0,
        child: const AppPinInput(length: 4, obscureText: true),
      ),
    );

    goldenTest(
      'AppPinInput - Error State',
      fileName: 'app_pin_input_error',
      builder: () => buildThemeMatrix(
        name: 'Error',
        width: 400.0,
        height: 100.0,
        child: const AppPinInput(
          length: 4,
          errorText: 'Invalid PIN',
        ),
      ),
    );
  });
}
