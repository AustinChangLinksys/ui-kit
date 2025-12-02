import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:editor/widgets/control_panel.dart';
import 'package:editor/controllers/theme_editor_controller.dart';

void main() {
  group('Control Panel Overflow', () {
    testWidgets('control panel is scrollable when content overflows', (tester) async {
      // Use small height to force overflow, but sufficient width to avoid horizontal overflow in toolbar
      tester.view.physicalSize = const Size(800, 400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final controller = ThemeEditorController();
      
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: controller,
          child: const MaterialApp(
            home: Scaffold(
              body: ControlPanel(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify scrollable
      final scrollable = find.byType(SingleChildScrollView);
      expect(scrollable, findsOneWidget);

      // Attempt to scroll
      await tester.drag(scrollable, const Offset(0, -200));
      await tester.pump();
      
      // No crash means success (RenderBox error would have failed test)
    });
  });
}
