import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../domain/entities/design_language.dart';

/// Factory functions for creating AppDesignTheme based on DesignLanguage.
///
/// Maps each design language enum value to its corresponding theme factory.
class ThemeFactories {
  ThemeFactories._();

  /// Creates an AppDesignTheme for the given design language and brightness.
  static AppDesignTheme createAppDesignTheme({
    required DesignLanguage language,
    required Brightness brightness,
    Color? seedColor,
  }) {
    final colorScheme = seedColor != null
        ? ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
          )
        : null;

    switch (language) {
      case DesignLanguage.glass:
        return brightness == Brightness.light
            ? GlassDesignTheme.light(colorScheme)
            : GlassDesignTheme.dark(colorScheme);
      case DesignLanguage.brutal:
        return brightness == Brightness.light
            ? BrutalDesignTheme.light(colorScheme)
            : BrutalDesignTheme.dark(colorScheme);
      case DesignLanguage.flat:
        return brightness == Brightness.light
            ? FlatDesignTheme.light(colorScheme)
            : FlatDesignTheme.dark(colorScheme);
      case DesignLanguage.neumorphic:
        return brightness == Brightness.light
            ? NeumorphicDesignTheme.light(colorScheme)
            : NeumorphicDesignTheme.dark(colorScheme);
      case DesignLanguage.pixel:
        return brightness == Brightness.light
            ? PixelDesignTheme.light(colorScheme)
            : PixelDesignTheme.dark(colorScheme);
    }
  }

  /// Creates a Material ThemeData with the appropriate design theme extension.
  static ThemeData createThemeData({
    required DesignLanguage language,
    required Brightness brightness,
    Color? seedColor,
  }) {
    final appDesignTheme = createAppDesignTheme(
      language: language,
      brightness: brightness,
      seedColor: seedColor,
    );

    final colorScheme = seedColor != null
        ? ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: brightness,
          )
        : ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: brightness,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      extensions: [appDesignTheme],
    );
  }
}
