import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/styles/glass_design_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/styles/brutal_design_theme.dart';

void main() {
  testWidgets('AppSurface renders with Glass theme', (tester) async {
    final glassTheme = GlassDesignTheme.light(); // 取得 GlassDesignTheme 實例
    final expectedColor = glassTheme.surfaceBase.backgroundColor; // 從實例中取得預期的顏色

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
    expect(decoration.color, expectedColor); // 使用從主題實例中取得的顏色來進行比較 // Glass base color
  });

  testWidgets('AppSurface renders with Brutal theme', (tester) async {
    final brutalTheme = BrutalDesignTheme.light(); // 取得 BrutalDesignTheme 實例
    final expectedColor = brutalTheme.surfaceBase.backgroundColor; // 從實例中取得預期的顏色
    final expectedBorderWidth = brutalTheme.surfaceBase.borderWidth; // 從實例中取得預期的邊框寬度

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
    expect(decoration.color, expectedColor); // 使用從主題實例中取得的顏色來進行比較
    expect(decoration.border?.top.width, expectedBorderWidth); // 使用從主題實例中取得的邊框寬度來進行比較
  });
}
