import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppExpansionPanel', () {
    const testPanel = ExpansionPanelItem(
      headerTitle: 'Test Panel',
      content: Text('Panel Content'),
    );

    testWidgets('renders without error', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppExpansionPanel(
              panels: [testPanel],
            ),
          ),
        ),
      );

      expect(find.byType(AppExpansionPanel), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('expands panel on tap', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppExpansionPanel(
              panels: [testPanel],
            ),
          ),
        ),
      );

      expect(find.text('Panel Content'), findsNothing);
      await tester.tap(find.byType(AppSurface).first);
      await tester.pumpAndSettle();
      expect(find.text('Panel Content'), findsOneWidget);
    });

    testWidgets('collapses expanded panel', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppExpansionPanel(
              panels: [testPanel],
              initialExpandedIndices: {0},
            ),
          ),
        ),
      );

      expect(find.text('Panel Content'), findsOneWidget);
      await tester.tap(find.byType(AppSurface).first);
      await tester.pumpAndSettle();
      expect(find.text('Panel Content'), findsNothing);
    });

    testWidgets('handles disabled state', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppExpansionPanel(
              panels: [
                const ExpansionPanelItem(
                  headerTitle: 'Disabled Panel',
                  content: Text('Disabled Content'),
                  enabled: false,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppSurface).first);
      await tester.pumpAndSettle();
      expect(find.text('Disabled Content'), findsNothing);
    });

    testWidgets('handles canExpand=false', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppExpansionPanel(
              panels: [
                const ExpansionPanelItem(
                  headerTitle: 'No Expand Panel',
                  content: Text('Cannot Expand'),
                  canExpand: false,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppSurface).first);
      await tester.pumpAndSettle();
      expect(find.text('Cannot Expand'), findsNothing);
    });

    testWidgets('renders empty list', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppExpansionPanel(panels: []),
          ),
        ),
      );

      expect(find.byType(AppExpansionPanel), findsOneWidget);
    });
  });
}
