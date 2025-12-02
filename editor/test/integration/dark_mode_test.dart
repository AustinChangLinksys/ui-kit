import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:editor/pages/live_editor_page.dart';
import 'package:editor/controllers/theme_editor_controller.dart';
import 'package:editor/widgets/preview_area.dart';

void main() {
  group('Dark Mode Integration', () {
    testWidgets('toggling dark mode updates preview theme', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final controller = ThemeEditorController();
      
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: controller,
          child: const MaterialApp(
            home: LiveEditorPage(),
          ),
        ),
      );

      // 1. Verify initial state (Light)
      expect(controller.brightness, Brightness.light);
      
      // Verify Preview is Light (check background color or similar)
      // We can check AppTheme.of(previewContext).brightness or just scaffold background
      // AppTheme.create uses defaultLightScheme seed color (primary) if not overridden.
      
      // 2. Find and tap Dark Mode toggle
      final toggleBtn = find.byTooltip('Toggle brightness');
      await tester.tap(toggleBtn);
      await tester.pumpAndSettle();

      // 3. Verify controller updated
      expect(controller.brightness, Brightness.dark);

      // 4. Verify Preview updated
      final appTextFinder = find.descendant(
        of: find.byType(PreviewArea),
        matching: find.text('Theme Preview'),
      );
      final previewContext = tester.element(appTextFinder);
      final previewTheme = Theme.of(previewContext);
      
      expect(previewTheme.brightness, Brightness.dark);
    });
  });
}
