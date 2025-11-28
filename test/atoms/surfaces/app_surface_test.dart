import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/styles/glass_design_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/styles/brutal_design_theme.dart';

void main() {
  testWidgets('AppSurface renders with Glass theme', (tester) async {
    final glassTheme = GlassDesignTheme.light(); // Get GlassDesignTheme instance
    final expectedColor = glassTheme.surfaceBase.backgroundColor; // Get expected color from instance

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [glassTheme],
        ),
        home: const Scaffold(
          body: AppSurface(child: Text('Glass')),
        ),
      ),
    );

    expect(find.text('Glass'), findsOneWidget);
    final container = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, expectedColor); // Compare with color obtained from theme instance // Glass base color
  });

  testWidgets('AppSurface renders with Brutal theme', (tester) async {
    final brutalTheme = BrutalDesignTheme.light(); // Get BrutalDesignTheme instance
    final expectedColor = brutalTheme.surfaceBase.backgroundColor; // Get expected color from instance
    final expectedBorderWidth = brutalTheme.surfaceBase.borderWidth; // Get expected border width from instance

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [brutalTheme],
        ),
        home: const Scaffold(
          body: AppSurface(child: Text('Brutal')),
        ),
      ),
    );

    expect(find.text('Brutal'), findsOneWidget);
    final container = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, expectedColor); // Compare with color obtained from theme instance
    expect(decoration.border?.top.width, expectedBorderWidth); // Compare with border width obtained from theme instance
  });
}
