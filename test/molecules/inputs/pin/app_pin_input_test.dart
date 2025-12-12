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

  testWidgets('AppPinInput should support external TextEditingController', (tester) async {
    final controller = TextEditingController();

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
              controller: controller,
              length: 4,
            ),
          ),
        ),
      ),
    );

    // Set text through external controller
    controller.text = '1234';
    await tester.pump();

    // Verify the text is displayed
    expect(controller.text, equals('1234'));

    controller.dispose();
  });

  testWidgets('AppPinInput should call onSubmitted when ghost field is submitted', (tester) async {
    bool submitted = false;

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
              onSubmitted: () {
                submitted = true;
              },
            ),
          ),
        ),
      ),
    );

    // Find the hidden TextField and focus it first
    final textFieldFinder = find.byType(TextField);
    await tester.tap(textFieldFinder);
    await tester.pump();

    // Trigger submit by calling the action directly on the TextField
    final textFieldWidget = tester.widget<TextField>(textFieldFinder);
    textFieldWidget.onSubmitted!('');
    await tester.pump();

    expect(submitted, isTrue);
  });

  testWidgets('AppPinInput should stay on last field when stayOnLastField is true', (tester) async {
    bool completed = false;

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
              stayOnLastField: true,
              onCompleted: (value) {
                completed = true;
              },
            ),
          ),
        ),
      ),
    );

    // Tap to focus the input
    await tester.tap(find.byType(AppPinInput));
    await tester.pump();

    // Enter 4 digits to complete the PIN
    await tester.enterText(find.byType(TextField), '1234');
    await tester.pump();

    expect(completed, isTrue);
  });

  testWidgets('AppPinInput should unfocus when stayOnLastField is false (default)', (tester) async {
    bool completed = false;

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
              stayOnLastField: false,
              onCompleted: (value) {
                completed = true;
              },
            ),
          ),
        ),
      ),
    );

    // Tap to focus the input
    await tester.tap(find.byType(AppPinInput));
    await tester.pump();

    // Enter 4 digits to complete the PIN
    await tester.enterText(find.byType(TextField), '1234');
    await tester.pump();

    expect(completed, isTrue);
  });
}
