import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/styles/glass_design_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/styles/brutal_design_theme.dart';

void main() {
  testWidgets('AppSurface renders with Glass theme', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [GlassDesignTheme()],
        ),
        home: const Scaffold(
          body: AppSurface(child: Text('Glass')),
        ),
      ),
    );

    expect(find.text('Glass'), findsOneWidget);
    final container = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, const Color(0x1AFFFFFF)); // Glass base color
  });

  testWidgets('AppSurface renders with Brutal theme', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [BrutalDesignTheme()],
        ),
        home: const Scaffold(
          body: AppSurface(child: Text('Brutal')),
        ),
      ),
    );

    expect(find.text('Brutal'), findsOneWidget);
    final container = tester.widget<AnimatedContainer>(find.byType(AnimatedContainer));
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.white); // Brutal base color
    expect(decoration.border?.top.width, 3.0); // Brutal border width
  });
}
