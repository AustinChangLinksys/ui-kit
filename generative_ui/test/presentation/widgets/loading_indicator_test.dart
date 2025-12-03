import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/presentation/widgets/loading_indicator.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(brightness: Brightness.light),
      home: Scaffold(body: child),
    );
  }

  testWidgets('LoadingIndicator renders correctly', (tester) async {
    await tester.pumpWidget(wrapWithTheme(const LoadingIndicator()));

    expect(find.byType(AppLoader), findsOneWidget);
    expect(find.text('Thinking...'), findsOneWidget);
  });
  
  testWidgets('LoadingIndicator renders custom message', (tester) async {
    await tester.pumpWidget(wrapWithTheme(const LoadingIndicator(message: 'Processing...')));
    
    expect(find.text('Processing...'), findsOneWidget);
  });
}
