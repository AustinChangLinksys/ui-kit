import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/presentation/widgets/error_display.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(brightness: Brightness.light),
      home: Scaffold(body: child),
    );
  }

  testWidgets('ErrorDisplay renders message and retry button', (tester) async {
    bool retried = false;
    await tester.pumpWidget(wrapWithTheme(ErrorDisplay(
      message: 'Something bad happened',
      onRetry: () => retried = true,
    )));

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Something bad happened'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });
}
