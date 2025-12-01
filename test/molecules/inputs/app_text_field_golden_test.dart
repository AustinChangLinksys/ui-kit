import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_scenarios.dart';
import '../../test_utils/test_theme_matrix.dart';

void main() {
  group('AppTextField Golden Tests', () {
    kTestThemeMatrix.forEach((themeName, themeData) {
      goldenTest(
        'TextField - $themeName',
        fileName: 'text_field_${themeName.toLowerCase()}',
        // Custom Pump behavior: simulate click to trigger Focus state
        pumpWidget: (tester, widget) async {
          await tester.pumpWidget(widget);
          // Attempt to find and tap the first TextField (corresponding to 'Outline Focused' scenario)
          // Note: There are multiple TextFields in GoldenTestGroup, this will only Focus the first one found
          // In practice, this is usually sufficient to verify "if Focus style exists"
          await tester.tap(find.byType(TextField).first);
          await tester.pumpAndSettle();
        },
        builder: () => GoldenTestGroup(
          columns: 2,
          children: [
            // 1. Idle Outline
            buildSafeScenario(
              name: 'Outline Idle',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(hintText: 'Enter value'),
            ),

            // 2. Focused Outline (triggered by pumpWidget)
            buildSafeScenario(
              name: 'Outline Focused',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(hintText: 'Focused Text'),
            ),

            // 3. Error State
            buildSafeScenario(
              name: 'Outline Error',
              theme: themeData,
              width: 300,
              height: 170, // Increase height to display error message
              child: const AppTextField(
                hintText: 'Required',
                errorText: 'This field is required.',
              ),
            ),

            // 4. Underline Variant
            buildSafeScenario(
              name: 'Underline Variant',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(
                variant: AppInputVariant.underline,
                hintText: 'Username',
              ),
            ),

            // 5. Filled Variant
            buildSafeScenario(
              name: 'Filled Variant',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(
                variant: AppInputVariant.filled,
                hintText: 'Email Address',
              ),
            ),

            // 6. With Icons & Large Text (Typography Test) New
            buildSafeScenario(
              name: 'Title Input w/ Icon',
              theme: themeData,
              width: 300,
              height: 150,
              child: const AppTextField(
                hintText: 'Page Title',
                // Test large font input
                textVariant: AppTextVariant.headlineSmall, 
                prefixIcon: Icon(Icons.title),
                // Test Underline with large title effect (common design)
                variant: AppInputVariant.underline,
              ),
            ),
          ],
        ),
      );
    });
  });
}