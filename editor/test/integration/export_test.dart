import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:editor/pages/live_editor_page.dart';
import 'package:editor/controllers/theme_editor_controller.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('Export Integration', () {
    testWidgets('adjusting property and exporting generates correct code', (tester) async {
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

      // 2. Tap Export button
      final exportBtn = find.byTooltip('Export theme code');
      await tester.ensureVisible(exportBtn);
      await tester.tap(exportBtn);
      await tester.pumpAndSettle();

      // 3. Verify Dialog appears
      expect(find.text('Export Theme Code'), findsOneWidget);

      // 4. Verify code content
      // Since code generator skeleton only outputs global metrics for now (T011 implementation):
      // buffer.writeln('  spacingFactor: ${theme.spacingFactor},');
      // We expect to see the modified spacing factor.
      // Default 1.0. Dragged right -> > 1.0.
      final newSpacing = controller.currentTheme.spacingFactor;
      expect(find.textContaining('spacingFactor: $newSpacing'), findsOneWidget);
    });
  });
}
