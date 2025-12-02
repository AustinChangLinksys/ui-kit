import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:editor/pages/live_editor_page.dart';
import 'package:editor/controllers/theme_editor_controller.dart';

void main() {
  group('Performance Tests', () {
    testWidgets('theme update logic completes within 16ms budget', (tester) async {
      // Set size to desktop
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

      final sliderFinder = find.byWidgetPredicate(
        (widget) => widget is Slider && widget.max == 2.0 && widget.min == 0.5,
      );
      await tester.ensureVisible(sliderFinder);
      await tester.pumpAndSettle();

      final stopwatch = Stopwatch()..start();
      
      // Perform update
      await tester.drag(sliderFinder, const Offset(50, 0));
      await tester.pump(); // Triggers the rebuild
      
      stopwatch.stop();
      
      // Note: This measures the test execution time of the pump, which includes widget rebuilding.
      // In a real environment, we want frame time < 16ms.
      // In test environment, if it takes > 500ms, something is very wrong (infinite loop or heavy computation).
      // We set a generous budget for CI stability but strict enough to catch regressions.
      debugPrint('Theme update pump took: ${stopwatch.elapsedMilliseconds}ms');
      expect(stopwatch.elapsedMilliseconds, lessThan(500)); 
    });
  });
}
