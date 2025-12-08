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

  group('AppPasswordInput Golden Tests', () {
    final rules = [
      AppPasswordRule(label: 'At least 8 characters', validate: (v) => v.length >= 8),
      AppPasswordRule(label: 'Contains a number', validate: (v) => RegExp(r'[0-9]').hasMatch(v)),
      AppPasswordRule(label: 'Contains uppercase', validate: (v) => RegExp(r'[A-Z]').hasMatch(v)),
    ];

    goldenTest(
      'AppPasswordInput - Empty State',
      fileName: 'app_password_input_empty',
      builder: () => buildThemeMatrix(
        name: 'Empty',
        width: 400.0,
        height: 200.0,
        child: AppPasswordInput(
          label: 'Password',
          hint: 'Enter password',
          rules: rules,
        ),
      ),
    );

    goldenTest(
      'AppPasswordInput - Partial Valid',
      fileName: 'app_password_input_partial',
      pumpWidget: (tester, widget) async {
        await tester.pumpWidget(widget);
        // Enter text that passes some rules (8 chars but no number/uppercase)
        final textFields = find.byType(TextField);
        for (final textField in textFields.evaluate()) {
          await tester.enterText(find.byWidget(textField.widget), 'abcdefgh');
        }
        await tester.pump();
      },
      builder: () => buildThemeMatrix(
        name: 'Partial',
        width: 400.0,
        height: 200.0,
        child: AppPasswordInput(
          label: 'Password',
          hint: 'Enter password',
          rules: rules,
        ),
      ),
    );

    goldenTest(
      'AppPasswordInput - All Valid',
      fileName: 'app_password_input_valid',
      pumpWidget: (tester, widget) async {
        await tester.pumpWidget(widget);
        // Enter text that passes all rules
        final textFields = find.byType(TextField);
        for (final textField in textFields.evaluate()) {
          await tester.enterText(find.byWidget(textField.widget), 'Password1');
        }
        await tester.pump();
      },
      builder: () => buildThemeMatrix(
        name: 'Valid',
        width: 400.0,
        height: 200.0,
        child: AppPasswordInput(
          label: 'Password',
          hint: 'Enter password',
          rules: rules,
        ),
      ),
    );

    goldenTest(
      'AppPasswordInput - Visibility Toggle',
      fileName: 'app_password_input_visible',
      builder: () => buildThemeMatrix(
        name: 'Visible',
        width: 400.0,
        height: 200.0,
        child: AppPasswordInput(
          label: 'Password',
          hint: 'Enter password',
          initiallyObscured: false,
          rules: rules,
        ),
      ),
    );
  });
}
