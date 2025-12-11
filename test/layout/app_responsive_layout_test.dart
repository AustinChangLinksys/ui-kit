import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppResponsiveLayout', () {
    Widget buildTestWidget(Widget child, {double width = 800}) {
      return MaterialApp(
        theme: AppTheme.create(
          brightness: Brightness.light,
          designThemeBuilder: (scheme) => FlatDesignTheme.light(scheme),
        ),
        home: MediaQuery(
          data: MediaQueryData(size: Size(width, 600)),
          child: Scaffold(body: child),
        ),
      );
    }

    testWidgets('should show mobile widget on small screens', (tester) async {
      const mobileWidget = Text('Mobile');
      const desktopWidget = Text('Desktop');

      await tester.pumpWidget(
        buildTestWidget(
          const AppResponsiveLayout(
            mobile: mobileWidget,
            desktop: desktopWidget,
          ),
          width: 400, // Mobile width
        ),
      );

      expect(find.text('Mobile'), findsOneWidget);
      expect(find.text('Desktop'), findsNothing);
    });

    testWidgets('should show desktop widget on large screens', (tester) async {
      const mobileWidget = Text('Mobile');
      const desktopWidget = Text('Desktop');

      await tester.pumpWidget(
        buildTestWidget(
          const AppResponsiveLayout(
            mobile: mobileWidget,
            desktop: desktopWidget,
          ),
          width: 1200, // Desktop width
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Desktop'), findsOneWidget);
    });

    testWidgets('should show tablet widget on tablet screens when provided', (tester) async {
      const mobileWidget = Text('Mobile');
      const tabletWidget = Text('Tablet');
      const desktopWidget = Text('Desktop');

      await tester.pumpWidget(
        buildTestWidget(
          const AppResponsiveLayout(
            mobile: mobileWidget,
            tablet: tabletWidget,
            desktop: desktopWidget,
          ),
          width: 800, // Tablet width
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Tablet'), findsOneWidget);
      expect(find.text('Desktop'), findsNothing);
    });

    testWidgets('should fall back to desktop widget on tablet screens when tablet not provided', (tester) async {
      const mobileWidget = Text('Mobile');
      const desktopWidget = Text('Desktop');

      await tester.pumpWidget(
        buildTestWidget(
          const AppResponsiveLayout(
            mobile: mobileWidget,
            desktop: desktopWidget,
            // No tablet widget provided
          ),
          width: 800, // Tablet width
        ),
      );

      expect(find.text('Mobile'), findsNothing);
      expect(find.text('Desktop'), findsOneWidget); // Should use desktop as fallback
    });
  });
}