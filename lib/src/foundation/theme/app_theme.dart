import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/app_palette.dart';
import 'package:ui_kit_library/ui_kit.dart';

typedef DesignThemeBuilder = AppDesignTheme Function(ColorScheme scheme);

class AppTheme {
  // Light Mode 預設方案
  static final ColorScheme defaultLightScheme = ColorScheme.fromSeed(
    seedColor: AppPalette.brandPrimary,
    brightness: Brightness.light,
  );

  // Dark Mode 預設方案
  static final ColorScheme defaultDarkScheme = ColorScheme.fromSeed(
    seedColor: AppPalette.brandPrimary, // 使用同一個 Seed
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

    // 決定最終的 Design System
    final effectiveDesignSystem = designThemeBuilder?.call(colorScheme) ??
        GlassDesignTheme.light(colorScheme); // 預設使用 Glass Dynamic

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,

      // 1. 注入標準文字主題 (讓 AppBar, ListTile 等預設元件字型正確)
      textTheme: appTextTheme.apply(
        // 確保文字顏色正確對比
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),

      extensions: [
        // 注入設計系統
        effectiveDesignSystem,

        // 移除舊的 GlassTheme 注入，避免混淆
        // brightness == Brightness.light ? GlassTheme.light : GlassTheme.dark,
        
        AppLayout.regular,

        // 2. 注入自定義文字擴充 (bodyExtraSmall)
        AppTypography.regular,

        // 注入顏色擴充
        brightness == Brightness.light ? AppColors.light : AppColors.dark,
      ],
    );
  }
}