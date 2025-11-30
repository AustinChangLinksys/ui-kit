import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/app_palette.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/styles/glass_design_theme.dart'; // Default fallback

// 定義 Builder 類型，方便外部傳入 (例如 Widgetbook)
typedef DesignThemeBuilder = AppDesignTheme Function(ColorScheme scheme);

class AppTheme {
  // 私有建構子，防止實例化
  AppTheme._();

  // --- 1. Default Schemes (基於 AppPalette Token) ---

  static final ColorScheme defaultLightScheme = ColorScheme.fromSeed(
    seedColor: AppPalette.brandPrimary,
    brightness: Brightness.light,
  );

  static final ColorScheme defaultDarkScheme = ColorScheme.fromSeed(
    seedColor: AppPalette.brandPrimary,
    brightness: Brightness.dark,
  );

  // --- 2. Helper: 從 Context 獲取 Design System ---

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

  // --- 3. Factory: 建立完整的 ThemeData ---

  static ThemeData create({
    required Brightness brightness,
    Color seedColor = AppPalette.brandPrimary, // 允許 Widgetbook 覆蓋 Seed
    DesignThemeBuilder? designThemeBuilder,
  }) {
    // A. 生成基礎 ColorScheme
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    // B. 決定要用哪套設計語言 (Glass, Brutal, Flat...)
    // 預設退回使用 Glass，並注入剛剛生成的 colorScheme
    final effectiveDesignSystem = designThemeBuilder?.call(colorScheme) ??
        GlassDesignTheme.light(colorScheme);

    // C. 組裝 ThemeData
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,

      // 設定背景色，讓 Scaffold 自動適配 Theme 的基底色 (對 Glass/Neu 很重要)
      scaffoldBackgroundColor:
          effectiveDesignSystem.surfaceBase.backgroundColor,

      // 設定全域字體 (Optional: 如果你有定義 appTextTheme 可保留，否則用預設)
      // textTheme: GoogleFonts.interTextTheme().apply(...),

      // ✨ 關鍵：只注入這一個核心 Extension
      extensions: [
        effectiveDesignSystem,
      ],
    );
  }
}
