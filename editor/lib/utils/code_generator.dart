import 'package:ui_kit_library/ui_kit.dart';

/// Generates Dart code for the current theme
class CodeGenerator {
  static String generateDartCode(AppDesignTheme theme) {
    final buffer = StringBuffer();

    buffer.writeln('AppDesignTheme(');

    // TODO: Add spacing factor if available
    // buffer.writeln('  spacingFactor: ${theme.spacingFactor},');

    // TODO: Serialize surface specs
    // buffer.writeln('  surfaceBase: SurfaceStyle(');
    // buffer.writeln('    backgroundColor: Color(${colorToHex(theme.surfaceBase.backgroundColor)}),');
    // buffer.writeln('    borderRadius: ${theme.surfaceBase.borderRadius},');
    // buffer.writeln('  ),');

    buffer.writeln(')');

    return buffer.toString();
  }

}
