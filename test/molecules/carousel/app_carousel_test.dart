import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppCarousel', () {
    const testItems = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    testWidgets('renders without error', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      expect(find.byType(AppCarousel), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('displays current item', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      expect(find.text(testItems[0]), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('navigates to next item on button tap',
        (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              showNavigationButtons: true,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      // Tap next button
      await tester.tap(find.byIcon(Icons.arrow_forward).first);
      await tester.pumpAndSettle();

      // Item should change
      expect(find.text(testItems[1]), findsOneWidget);
    });

    testWidgets('navigates to previous item on button tap',
        (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              showNavigationButtons: true,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      // Navigate to item 3
      await tester.tap(find.byIcon(Icons.arrow_forward).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_forward).first);
      await tester.pumpAndSettle();

      expect(find.text(testItems[2]), findsOneWidget);

      // Go back
      await tester.tap(find.byIcon(Icons.arrow_back).first);
      await tester.pumpAndSettle();

      expect(find.text(testItems[1]), findsOneWidget);
    });

    testWidgets('disables previous button at first item',
        (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              showNavigationButtons: true,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      // Previous button should be disabled at first item
      // (Try to tap it, should stay on same item)
      await tester.tap(find.byIcon(Icons.arrow_back).first);
      await tester.pumpAndSettle();

      expect(find.text(testItems[0]), findsOneWidget);
    });

    testWidgets('disables next button at last item',
        (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              showNavigationButtons: true,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      // Navigate to last item
      for (int i = 0; i < testItems.length - 1; i++) {
        await tester.tap(find.byIcon(Icons.arrow_forward).first);
        await tester.pumpAndSettle();
      }

      expect(find.text(testItems[testItems.length - 1]), findsOneWidget);

      // Try to go next, should stay
      await tester.tap(find.byIcon(Icons.arrow_forward).first);
      await tester.pumpAndSettle();

      expect(find.text(testItems[testItems.length - 1]), findsOneWidget);
    });

    testWidgets('supports loop behavior', (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              scrollBehavior: CarouselScrollBehavior.loop,
              showNavigationButtons: true,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      // Navigate to last item
      for (int i = 0; i < testItems.length - 1; i++) {
        await tester.tap(find.byIcon(Icons.arrow_forward).first);
        await tester.pumpAndSettle();
      }

      expect(find.text(testItems[testItems.length - 1]), findsOneWidget);

      // Next should loop back to first
      await tester.tap(find.byIcon(Icons.arrow_forward).first);
      await tester.pumpAndSettle();

      expect(find.text(testItems[0]), findsOneWidget);
    });

    testWidgets('calls onIndexChanged callback',
        (WidgetTester tester) async {
      int? changedIndex;
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              showNavigationButtons: true,
              onIndexChanged: (index) => changedIndex = index,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_forward).first);
      await tester.pumpAndSettle();

      expect(changedIndex, equals(1));
    });

    testWidgets('renders correct number of items',
        (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      // PageView shows only current item initially
      expect(find.text(testItems[0]), findsOneWidget);

      // But can navigate through all items
      for (int i = 1; i < testItems.length; i++) {
        await tester.drag(
          find.byType(PageView),
          Offset(-500, 0),
        );
        await tester.pumpAndSettle();
        expect(find.text(testItems[i]), findsOneWidget);
      }
    });

    testWidgets('respects padding parameter',
        (WidgetTester tester) async {
      final theme = GlassDesignTheme.light();
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            extensions: [theme],
          ),
          home: Scaffold(
            body: AppCarousel(
              itemCount: testItems.length,
              itemHeight: 300,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return Center(child: Text(testItems[index]));
              },
            ),
          ),
        ),
      );

      expect(find.byType(AppCarousel), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
