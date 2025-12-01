import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import shared matrix
import '../../test_utils/test_theme_matrix.dart';

void main() {
  group('AppSurface Logic Tests', () {
    // 1. Matrix verification: ensure AppSurface correctly reads all defined Themes
    kTestThemeMatrix.forEach((themeName, themeData) {
      testWidgets('AppSurface correctly maps properties from $themeName',
          (tester) async {
        // Extract Extension from ThemeData
        final appTheme = themeData.extension<AppDesignTheme>()!;
        final expectedStyle = appTheme.surfaceBase;

        // Render Widget
        await tester.pumpWidget(
            _buildTestApp(themeData, const AppSurface(child: Text('A'))));

        // Find the underlying Container
        final container =
            tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
        final decoration = container.decoration as BoxDecoration;

        // --- Verify core property mapping ---

        // 1. Color consistency
        expect(decoration.color, expectedStyle.backgroundColor,
            reason: '$themeName: Background color mismatch');

        // 2. Border consistency (if Theme defines border)
        if (expectedStyle.borderWidth > 0) {
          expect(decoration.border?.top.width, expectedStyle.borderWidth,
              reason: '$themeName: Border width mismatch');
          expect(decoration.border?.top.color, expectedStyle.borderColor,
              reason: '$themeName: Border color mismatch');
        }

        // 3. Corner radius consistency (default rectangle mode)
        // Note: Some themes (Brutal) may have a corner radius of 0
        if (expectedStyle.borderRadius > 0) {
          expect(decoration.borderRadius,
              BorderRadius.circular(expectedStyle.borderRadius),
              reason: '$themeName: Border radius mismatch');
        } else {
          // If 0, it could be BorderRadius.zero or null (depending on implementation), usually check radius.x
          expect(
              (decoration.borderRadius as BorderRadius?)?.topLeft.x ?? 0, 0.0);
        }

        // 4. Shadow consistency (especially important for Neumorphic)
        // listEquals cannot directly compare BoxShadow, here simply check the length or the first element
        expect(decoration.boxShadow?.length ?? 0, expectedStyle.shadows.length,
            reason: '$themeName: Shadow count mismatch');
      });
    });

    // 2. Variant switching test (Variant Logic)
    // Just pick a representative theme to test the logic (e.g., the first one)
    testWidgets('AppSurface switches to Highlight variant correctly',
        (tester) async {
      final themeData = kTestThemeMatrix.values.first;
      final appTheme = themeData.extension<AppDesignTheme>()!;

      await tester.pumpWidget(_buildTestApp(
        themeData,
        const AppSurface(variant: SurfaceVariant.highlight, child: Text('A')),
      ));

      final container =
          tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      final decoration = container.decoration as BoxDecoration;

      // Verify that it reads Highlight and not Base
      expect(decoration.color, appTheme.surfaceHighlight.backgroundColor);
      expect(decoration.color, isNot(appTheme.surfaceBase.backgroundColor));
    });

    // 3. Priority override test (Style Override Logic)
    testWidgets('AppSurface style parameter overrides theme variant',
        (tester) async {
      final themeData = kTestThemeMatrix.values.first; // Pick any theme

      // Define a "red style" different from any theme
      const customStyle = SurfaceStyle(
        backgroundColor: Colors.red,
        borderColor: Colors.green,
        borderWidth: 10.0,
        borderRadius: 0,
        shadows: [],
        blurStrength: 0,
        contentColor: Colors.white,
      );

      await tester.pumpWidget(_buildTestApp(
        themeData,
        const AppSurface(
          variant: SurfaceVariant.base, // Should be ignored
          style: customStyle, // Should be effective
          child: Text('A'),
        ),
      ));

      final container =
          tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
      final decoration = container.decoration as BoxDecoration;

      // Verify that the properties are entirely from customStyle
      expect(decoration.color, Colors.red);
      expect(decoration.border?.top.color, Colors.green);
      expect(decoration.border?.top.width, 10.0);
    });
  });
}

// Helper function: inject Theme
Widget _buildTestApp(ThemeData themeData, Widget child) {
  return MaterialApp(
    theme: themeData,
    home: Scaffold(
      body: child,
    ),
  );
}
