import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppIpv6TextField', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.create(brightness: Brightness.light),
          home: const Scaffold(
            body: AppIPv6TextField(
              label: '',
              invalidFormatMessage: '',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(AppIPv6TextField), findsOneWidget);
    });
  });
}
