import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/app_palette.dart';
import 'package:ui_kit_library/ui_kit.dart';

typedef DesignThemeBuilder = AppDesignTheme Function(ColorScheme scheme);

class AppTheme {
  // Light Mode default scheme
  static final ColorScheme defaultLightScheme = ColorScheme.fromSeed(
    seedColor: AppPalette.brandPrimary,
    brightness: Brightness.light,
  );

  // Dark Mode default scheme
  static final ColorScheme defaultDarkScheme = ColorScheme.fromSeed(
    seedColor: AppPalette.brandPrimary, // Use the same Seed
    brightness: Brightness.dark,
  );
  
  static ThemeData create({
    required Brightness brightness,
    Color seedColor = const Color(0xFF0870EA),
    DesignThemeBuilder? designThemeBuilder, // 只保留這個參數
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    // Determine the final Design System
    final effectiveDesignSystem = designThemeBuilder?.call(colorScheme) ??
        GlassDesignTheme.light(colorScheme); // Default to Glass Dynamic

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,

      // 1. Inject standard text theme (to ensure correct font for default widgets like AppBar, ListTile)
      textTheme: appTextTheme.apply(
        // Ensure correct text color contrast
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),

      extensions: [
        // 注入設計系統
        effectiveDesignSystem,

        // Remove old GlassTheme injection to avoid confusion
        // brightness == Brightness.light ? GlassTheme.light : GlassTheme.dark,
        
        AppLayout.regular,

        // 2. Inject custom text extension (bodyExtraSmall)
        AppTypography.regular,

        // Inject color extension
        brightness == Brightness.light ? AppColors.light : AppColors.dark,
      ],
    );
  }
}