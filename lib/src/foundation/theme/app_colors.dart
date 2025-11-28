import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_colors.tailor.dart';

@TailorMixin()
class AppColors extends ThemeExtension<AppColors> with _$AppColorsTailorMixin {
  // 1. 定義語意化欄位
  @override
  final Color success;
  @override
  final Color onSuccess;
  @override
  final Color successContainer;
  @override
  final Color onSuccessContainer;

  @override
  final Color warning;
  @override
  final Color onWarning;
  @override
  final Color warningContainer;
  @override
  final Color onWarningContainer;

  // 2. 標準建構子
  const AppColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
  });

  // 3. 定義 Light Theme 數值 (參考你的 TonalPalette 邏輯，這裡直接取最終值)
  static const light = AppColors(
    // Green Tonal Palette 映射
    success: Color(0xFF2E6C00), // Green 40 (範例)
    onSuccess: Colors.white,
    successContainer: Color(0xFFB8F397), // Green 90
    onSuccessContainer: Color(0xFF0A2100), // Green 10
    
    // Orange Tonal Palette 映射
    warning: Color(0xFF8B5000), // Orange 40
    onWarning: Colors.white,
    warningContainer: Color(0xFFFFDCC1), // Orange 90
    onWarningContainer: Color(0xFF2B1700), // Orange 10
  );

  // 4. 定義 Dark Theme 數值
  static const dark = AppColors(
    // Green Tonal Palette 映射 (Dark Mode 通常用 lighter token)
    success: Color(0xFF9CD67D), // Green 80
    onSuccess: Color(0xFF0A2100), // Green 20
    successContainer: Color(0xFF165200), // Green 30
    onSuccessContainer: Color(0xFFB8F397), // Green 90

    // Orange Tonal Palette 映射
    warning: Color(0xFFFFB878), // Orange 80
    onWarning: Color(0xFF4B2800), // Orange 20
    warningContainer: Color(0xFF6B3D00), // Orange 30
    onWarningContainer: Color(0xFFFFDCC1), // Orange 90
  );
}