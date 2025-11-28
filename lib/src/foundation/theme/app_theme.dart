import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'app_layout.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'design_system/app_design_theme.dart';
import 'design_system/styles/glass_design_theme.dart';

class AppTheme {
  static ThemeData create({
    required Brightness brightness,
    Color seedColor = const Color(0xFF0870EA),
    AppDesignTheme? designSystem,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

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
        // 注入設計系統 (預設為 Glass)
        designSystem ?? const GlassDesignTheme(),

        // 保留舊的 GlassTheme 以相容 (直到完全遷移)
        brightness == Brightness.light ? GlassTheme.light : GlassTheme.dark,
        
        AppLayout.regular,

        // 2. 注入自定義文字擴充 (bodyExtraSmall)
        AppTypography.regular,

        // 注入顏色擴充
        brightness == Brightness.light ? AppColors.light : AppColors.dark,
      ],
    );
  }
}