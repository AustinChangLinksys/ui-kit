import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:editor/pages/live_editor_page.dart';
import 'package:editor/controllers/theme_editor_controller.dart';
import 'package:editor/widgets/preview_area.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('Theme Update Integration', () {
    testWidgets('adjusting spacing factor updates the theme in controller and preview', (tester) async {
      // Set size to desktop to ensure we test the side-by-side layout and avoid ListView infinite height issues
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

      // 1. Verify initial state (default spacing is usually 1.0)
      expect(controller.currentTheme.spacingFactor, 1.0);

      // 2. Find the slider for Spacing Factor
      final sliderFinder = find.byWidgetPredicate(
        (widget) => widget is Slider && widget.max == 2.0 && widget.min == 0.5, 
        description: 'Spacing Factor Slider'
      );
      expect(sliderFinder, findsOneWidget);

      // 3. Drag the slider to change value (e.g., to 1.5)
      // Ensure it's visible first (ControlPanel is scrollable)
      await tester.ensureVisible(sliderFinder);
      await tester.pumpAndSettle();
      
      await tester.drag(sliderFinder, const Offset(100, 0)); // Drag right
      await tester.pump();

      // 4. Verify controller updated
      expect(controller.currentTheme.spacingFactor, greaterThan(1.0));
      final newSpacing = controller.currentTheme.spacingFactor;

      // 5. Verify PreviewArea reflects the change
      // We need to find a widget inside PreviewArea and check the theme in its context.
      // _DashboardHeroDemo is private, but we can find AppText inside it.
      final appTextFinder = find.descendant(
        of: find.byType(PreviewArea),
        matching: find.text('Theme Preview'),
      );
      
      expect(appTextFinder, findsOneWidget);
      
      final previewContext = tester.element(appTextFinder);
      final previewTheme = AppTheme.of(previewContext);
      
      expect(previewTheme.spacingFactor, equals(newSpacing), 
        reason: 'Preview theme spacing factor should match controller state');
    });
  });
}
