import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_palette.dart';
import 'package:ui_kit_library/ui_kit.dart'; // Default fallback

// Defines the Builder type for external input (e.g., Widgetbook)
typedef DesignThemeBuilder = AppDesignTheme Function(ColorScheme scheme);

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // --- 1. Default Schemes (based on AppPalette Token) ---

  static final ColorScheme defaultLightScheme = ColorScheme.fromSeed(
    seedColor: AppPalette.brandPrimary,
    brightness: Brightness.light,
  );

  static final ColorScheme defaultDarkScheme = ColorScheme.fromSeed(
    seedColor: AppPalette.brandPrimary,
    brightness: Brightness.dark,
  );

  // --- 2. Helper: Get Design System from Context ---

  /// Returns the current [AppDesignTheme] from the context.
  static AppDesignTheme of(BuildContext context) {
    final theme = Theme.of(context);
    final extension = theme.extension<AppDesignTheme>();

    if (extension == null) {
      throw FlutterError(
          'AppDesignTheme extension not found in current Theme.\n'
          'Ensure that you have configured your MaterialApp to use AppTheme.create().');
    }

    return extension;
  }

  // --- 3. Factory: Create complete ThemeData ---

  static ThemeData create({
    required Brightness brightness,
    Color seedColor = AppPalette.brandPrimary, // Allow Widgetbook to override Seed
    DesignThemeBuilder? designThemeBuilder,
  }) {
    // A. Generate base ColorScheme
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    // B. Determine which design language to use (Glass, Brutal, Flat...)
    // Defaults to Glass, and injects the newly generated colorScheme
    final effectiveDesignSystem = designThemeBuilder?.call(colorScheme) ??
        GlassDesignTheme.light(colorScheme);

    // C. Assemble ThemeData
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,

      // Set background color, allowing Scaffold to automatically adapt to the Theme's base color (important for Glass/Neu)
      scaffoldBackgroundColor:
          effectiveDesignSystem.surfaceBase.backgroundColor,

      textTheme: appTextTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      // Key: Only inject this core Extension
      extensions: [
        effectiveDesignSystem,
      ],
    );
  }
}
