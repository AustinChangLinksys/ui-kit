import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:editor/utils/code_generator.dart';

void main() {
  group('generateDartCode', () {
    test('generates valid constructor with global metrics', () {
      final theme = FlatDesignTheme.light().copyWith(
        spacingFactor: 1.5,
      );
      // Note: copyWith for animation might be complex if AnimationSpec isn't easily constructible 
      // without importing it. For this test, we rely on default animation or just check spacingFactor
      // and the existence of animationDuration field in output.

      final code = generateDartCode(theme);

      expect(code, contains('AppDesignTheme('));
      expect(code, contains('spacingFactor: 1.5,'));
      // Check that animation duration is present (FlatDesignTheme default is 250ms)
      expect(code, contains('animationDuration: Duration(milliseconds: 250),'));
      expect(code, contains(')'));
    });
  });
}
