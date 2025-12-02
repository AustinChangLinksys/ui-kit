import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppIpv4TextField', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.create(brightness: Brightness.light),
          home: Scaffold(
            body: AppIpv4TextField(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(AppIpv4TextField), findsOneWidget);
    });
  });
}