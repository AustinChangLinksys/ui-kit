import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:editor/utils/code_generator.dart';

void main() {
  group('Full Code Generator', () {
    test('generates valid constructor with all specs', () {
      final theme = FlatDesignTheme.light().copyWith(
        spacingFactor: 1.5,
      );

      final code = generateDartCode(theme);

      print(code);

      expect(code, contains('AppDesignTheme('));
      expect(code, contains('spacingFactor: 1.5,'));
      expect(code, contains('surfaceBase: SurfaceStyle('));
      expect(code, contains('inputStyle: InputStyle('));
      expect(code, contains('toggleStyle: ToggleStyle('));
      expect(code, contains('loaderStyle: LoaderStyle('));
      expect(code, contains('navigationStyle: NavigationStyle('));
      expect(code, contains('skeletonStyle: SkeletonStyle('));
      expect(code, contains('toastStyle: ToastStyle('));
      expect(code, contains('dividerStyle: DividerStyle('));
      expect(code, contains('networkInputStyle: NetworkInputStyle('));
      expect(code, contains('typography: TypographySpec('));
      expect(code, contains('layoutSpec: LayoutSpec('));
      expect(code, contains(')'));
    });
  });
}
