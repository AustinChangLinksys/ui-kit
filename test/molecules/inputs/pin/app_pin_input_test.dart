import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  testWidgets('AppPinInput handles paste interaction', (tester) async {
    String? completedPin;

    // Create theme with AppDesignTheme
    final theme = AppTheme.create(
      brightness: Brightness.light,
      designThemeBuilder: (s) => FlatDesignTheme.light(s),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Center(
            child: AppPinInput(
              length: 6,
              onCompleted: (pin) => completedPin = pin,
            ),
          ),
        ),
      ),
    );

    // Find the hidden TextField inside AppPinInput
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    // Tap to focus the text field
    await tester.tap(textFieldFinder);
    await tester.pump();

    // Enter text through the TextField
    await tester.enterText(textFieldFinder, '123456');
    await tester.pump();

    expect(completedPin, '123456');
  });

  testWidgets('AppPinInput truncates input exceeding length', (tester) async {
    String? lastChangedValue;

    final theme = AppTheme.create(
      brightness: Brightness.light,
      designThemeBuilder: (s) => FlatDesignTheme.light(s),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Center(
            child: AppPinInput(
              length: 4,
              onChanged: (value) => lastChangedValue = value,
            ),
          ),
        ),
      ),
    );

    final textFieldFinder = find.byType(TextField);
    await tester.tap(textFieldFinder);
    await tester.pump();

    // Enter more than 4 characters
    await tester.enterText(textFieldFinder, '123456789');
    await tester.pump();

    // Should be truncated to 4 characters
    expect(lastChangedValue, '1234');
  });
}
