import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:editor/pages/live_editor_page.dart';
import 'package:editor/controllers/theme_editor_controller.dart';
import 'package:editor/widgets/preview_area.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('Responsive Preview Integration', () {
    testWidgets('toggling mobile/desktop width updates navigation component', (tester) async {
      // Use 1600 width to ensure PreviewArea (half width - padding) > 600 breakpoint
      tester.view.physicalSize = const Size(1600, 800);
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

      // 1. Initial State: Desktop width
      // Verify AppNavigationRail is present
      expect(find.byType(AppNavigationRail), findsOneWidget);
      expect(find.byType(AppNavigationBar), findsNothing);

      // 2. Toggle Mobile Width
      final widthToggleBtn = find.byTooltip('Switch to mobile width');
      await tester.tap(widthToggleBtn);
      await tester.pumpAndSettle();

      // 3. Verify Preview width is constrained (implied by finding AppNavigationBar)
      // The PreviewArea sets width to 375.
      // Verify AppNavigationBar is present
      expect(find.byType(AppNavigationBar), findsOneWidget);
      expect(find.byType(AppNavigationRail), findsNothing);

      // 4. Toggle back to Desktop
      final desktopBtn = find.byTooltip('Switch to desktop width');
      await tester.tap(desktopBtn);
      await tester.pumpAndSettle();

      // 5. Verify Desktop again
      expect(find.byType(AppNavigationRail), findsOneWidget);
      expect(find.byType(AppNavigationBar), findsNothing);
    });
  });
}
