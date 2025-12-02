import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppMacAddressTextField', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.create(brightness: Brightness.light),
          home: const Scaffold(
            body: AppMacAddressTextField(
              label: 'MAC Address',
              invalidFormatMessage: 'Invalid format',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(AppMacAddressTextField), findsOneWidget);
    });
  });
}