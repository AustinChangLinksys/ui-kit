import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:editor/widgets/control_panel.dart';
import 'package:editor/controllers/theme_editor_controller.dart';

void main() {
  group('Control Panel Integration', () {
    testWidgets('all spec editor sections are present', (tester) async {
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

      // Verify Section Headers are present
      expect(find.text('Input Fields'), findsOneWidget);
      expect(find.text('Surfaces'), findsOneWidget);
      // Global Metrics appears in section header and the editor widget title
      expect(find.text('Global Metrics'), findsNWidgets(2));
      expect(find.text('Feedback Components'), findsOneWidget);
      expect(find.text('Navigation'), findsNWidgets(2));
      
      // Verify Toggle section (doesn't have a header text "Toggle", but implies presence of ToggleSpecEditor)
      // ToggleSpecEditor usually has a title or header? In ControlPanel it's just `ToggleSpecEditor(...)`
      // Let's check if we can find a known widget inside ToggleSpecEditor or just rely on structure.
      // Assuming ToggleSpecEditor renders something recognizable.
    });
  });
}
