import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppTextField Golden Tests', () {
    goldenTest(
      'AppTextField Matrix',
      fileName: 'app_text_field_matrix',
      // Custom Pump behavior: simulate click to trigger Focus state
      pumpWidget: (tester, widget) async {
        await tester.pumpWidget(widget);
        // Attempt to find and tap the first TextField (corresponding to 'Outline Focused' scenario)
        // In practice, this is usually sufficient to verify "if Focus style exists"
        await tester.tap(find.byType(TextField).first);
        await tester.pumpAndSettle();
      },
      builder: () => buildThemeMatrix(
        name: 'AppTextField',
        width: 300,
        height: 500, // Adjusted height to accommodate all scenarios
        child: const Column(
          children: [
            // 1. Idle Outline
            AppTextField(hintText: 'Enter value'),
            SizedBox(height: 10),

            // 2. Focused Outline (triggered by pumpWidget)
            AppTextField(hintText: 'Focused Text'),
            SizedBox(height: 10),

            // 3. Error State
            AppTextField(
              hintText: 'Required',
              errorText: 'This field is required.',
            ),
            SizedBox(height: 10),

            // 4. Underline Variant
            AppTextField(
              variant: AppInputVariant.underline,
              hintText: 'Username',
            ),
            SizedBox(height: 10),

            // 5. Filled Variant
            AppTextField(
              variant: AppInputVariant.filled,
              hintText: 'Email Address',
            ),
            SizedBox(height: 10),

            // 6. With Icons & Large Text (Typography Test)
            AppTextField(
              hintText: 'Page Title',
              textVariant: AppTextVariant.headlineSmall,
              prefixIcon: Icon(Icons.title),
              variant: AppInputVariant.underline,
            ),
          ],
        ),
      ),
    );
  });
}
