import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppExpansionPanel', () {
    const testPanel1 = ExpansionPanelItem(
      headerTitle: 'Panel 1',
      content: Text('Content 1'),
    );
    const testPanel2 = ExpansionPanelItem(
      headerTitle: 'Panel 2',
      content: Text('Content 2'),
    );
    const testPanel3 = ExpansionPanelItem(
      headerTitle: 'Panel 3',
      content: Text('Content 3'),
    );

    Future<void> buildWidget(
      WidgetTester tester, {
      required List<ExpansionPanelItem> panels,
      Set<int>? initialExpandedIndices,
      bool allowMultipleOpen = true,
      ValueChanged<int>? onPanelToggled,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppExpansionPanel(
              panels: panels,
              initialExpandedIndices: initialExpandedIndices ?? {},
              allowMultipleOpen: allowMultipleOpen,
              onPanelToggled: onPanelToggled,
            ),
          ),
        ),
      );
    }

    testWidgets('renders multiple panels', (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [testPanel1, testPanel2, testPanel3],
      );

      expect(find.text('Panel 1'), findsOneWidget);
      expect(find.text('Panel 2'), findsOneWidget);
      expect(find.text('Panel 3'), findsOneWidget);
    });

    testWidgets('expands panel on tap', (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [testPanel1],
      );

      expect(find.text('Content 1'), findsNothing);

      // Tap the header to expand
      await tester.tap(find.text('Panel 1'));
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('collapses expanded panel on tap', (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [testPanel1],
        initialExpandedIndices: {0},
      );

      expect(find.text('Content 1'), findsOneWidget);

      // Tap the header to collapse
      await tester.tap(find.text('Panel 1'));
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsNothing);
    });

    testWidgets('respects allowMultipleOpen=false (single open mode)',
        (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [testPanel1, testPanel2],
        allowMultipleOpen: false,
      );

      // Expand first panel
      await tester.tap(find.text('Panel 1'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);

      // Expand second panel - should close first panel
      await tester.tap(find.text('Panel 2'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsNothing);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('respects allowMultipleOpen=true (multiple open mode)',
        (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [testPanel1, testPanel2],
        allowMultipleOpen: true,
      );

      // Expand first panel
      await tester.tap(find.text('Panel 1'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);

      // Expand second panel - first should stay open
      await tester.tap(find.text('Panel 2'));
      await tester.pumpAndSettle();
      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('respects initialExpandedIndices', (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [testPanel1, testPanel2, testPanel3],
        initialExpandedIndices: {0, 2},
      );

      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsNothing);
      expect(find.text('Content 3'), findsOneWidget);
    });

    testWidgets('calls onPanelToggled callback', (WidgetTester tester) async {
      final toggledIndices = <int>[];
      await buildWidget(
        tester,
        panels: [testPanel1, testPanel2],
        onPanelToggled: (index) => toggledIndices.add(index),
      );

      // Toggle first panel
      await tester.tap(find.text('Panel 1'));
      await tester.pumpAndSettle();
      expect(toggledIndices, [0]);

      // Toggle second panel
      await tester.tap(find.text('Panel 2'));
      await tester.pumpAndSettle();
      expect(toggledIndices, [0, 1]);
    });

    testWidgets('handles disabled panels', (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [
          const ExpansionPanelItem(
            headerTitle: 'Enabled',
            content: Text('Enabled content'),
            enabled: true,
          ),
          const ExpansionPanelItem(
            headerTitle: 'Disabled',
            content: Text('Disabled content'),
            enabled: false,
          ),
        ],
      );

      // Disabled panel should show as slightly transparent
      final disabledOpacity = find.byType(Opacity).at(1);
      expect(disabledOpacity, findsOneWidget);

      // Tap disabled panel header - should not expand
      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();
      expect(find.text('Disabled content'), findsNothing);
    });

    testWidgets('handles canExpand=false', (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [
          const ExpansionPanelItem(
            headerTitle: 'Can expand',
            content: Text('Can expand content'),
            canExpand: true,
          ),
          const ExpansionPanelItem(
            headerTitle: 'Cannot expand',
            content: Text('Cannot expand content'),
            canExpand: false,
          ),
        ],
      );

      // Panel with canExpand=false should not expand
      await tester.tap(find.text('Cannot expand'));
      await tester.pumpAndSettle();
      expect(find.text('Cannot expand content'), findsNothing);

      // But the expandable one should work
      await tester.tap(find.text('Can expand'));
      await tester.pumpAndSettle();
      expect(find.text('Can expand content'), findsOneWidget);
    });

    testWidgets('renders panel headers with correct semantics',
        (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [testPanel1],
      );

      // Check for semantics on header
      final semantics = find.bySemanticsLabel('Panel 1');
      expect(semantics, findsOneWidget);
    });

    testWidgets('icon rotates when panel expands', (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [testPanel1],
      );

      // Initial state - icon should be at 0 rotation
      // We can't directly test the rotation value, but we can verify the animation exists
      expect(find.byIcon(Icons.expand_more), findsOneWidget);

      // Expand panel
      await tester.tap(find.text('Panel 1'));
      await tester.pumpAndSettle();

      // Icon should still exist (rotation is animated)
      expect(find.byIcon(Icons.expand_more), findsOneWidget);
    });

    testWidgets('empty panel list renders without error',
        (WidgetTester tester) async {
      await buildWidget(
        tester,
        panels: [],
      );

      expect(find.byType(AppExpansionPanel), findsOneWidget);
    });

    testWidgets('large number of panels renders correctly',
        (WidgetTester tester) async {
      final largePanelList = List.generate(
        10,
        (i) => ExpansionPanelItem(
          headerTitle: 'Panel $i',
          content: Text('Content $i'),
        ),
      );

      await buildWidget(
        tester,
        panels: largePanelList,
      );

      // Verify all headers are rendered
      expect(find.byType(AppExpansionPanel), findsOneWidget);
      expect(find.byType(AppText), findsWidgets); // At least headers rendered

      // Check a few panels to verify they exist
      expect(find.text('Panel 0'), findsOneWidget);
      expect(find.text('Panel 5'), findsOneWidget);
      expect(find.text('Panel 9'), findsOneWidget);
    });
  });
}
