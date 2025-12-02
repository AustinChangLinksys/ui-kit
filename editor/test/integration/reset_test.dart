import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:editor/pages/live_editor_page.dart';
import 'package:editor/controllers/theme_editor_controller.dart';

void main() {
  group('Reset Integration', () {
    testWidgets('reset button reverts theme to defaults', (tester) async {
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

      // 1. Change a property (Spacing Factor)
      final sliderFinder = find.byWidgetPredicate(
        (widget) => widget is Slider && widget.max == 2.0 && widget.min == 0.5,
      );
      await tester.ensureVisible(sliderFinder);
      await tester.pumpAndSettle();
      await tester.drag(sliderFinder, const Offset(100, 0));
      await tester.pump();

      expect(controller.currentTheme.spacingFactor, greaterThan(1.0));

      // 2. Tap Reset button
      final resetBtn = find.byTooltip('Reset to default');
      await tester.ensureVisible(resetBtn);
      await tester.tap(resetBtn);
      await tester.pumpAndSettle();

      // 3. Confirm dialog
      await tester.tap(find.widgetWithText(FilledButton, 'Reset'));
      await tester.pumpAndSettle();

      // 4. Verify Reset
      expect(controller.currentTheme.spacingFactor, 1.0);
      expect(controller.hasUnsavedChanges, false);
    });
  });
}
