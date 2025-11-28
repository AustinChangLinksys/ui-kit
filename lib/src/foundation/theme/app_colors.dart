import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_colors.tailor.dart';

@TailorMixin()
class AppColors extends ThemeExtension<AppColors> with _$AppColorsTailorMixin {
  // 1. Define semantic fields
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

  // 2. Standard constructor
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

  // 3. Define Light Theme values (referencing your TonalPalette logic, directly using the final values here)
  static const light = AppColors(
    // Green Tonal Palette mapping
    success: Color(0xFF2E6C00), // Green 40 (example)
    onSuccess: Colors.white,
    successContainer: Color(0xFFB8F397), // Green 90
    onSuccessContainer: Color(0xFF0A2100), // Green 10
    
    // Orange Tonal Palette mapping
    warning: Color(0xFF8B5000), // Orange 40
    onWarning: Colors.white,
    warningContainer: Color(0xFFFFDCC1), // Orange 90
    onWarningContainer: Color(0xFF2B1700), // Orange 10
  );

  // 4. Define Dark Theme values
  static const dark = AppColors(
    // Green Tonal Palette mapping (Dark Mode usually uses lighter tokens)
    success: Color(0xFF9CD67D), // Green 80
    onSuccess: Color(0xFF0A2100), // Green 20
    successContainer: Color(0xFF165200), // Green 30
    onSuccessContainer: Color(0xFFB8F397), // Green 90

    // Orange Tonal Palette mapping
    warning: Color(0xFFFFB878), // Orange 80
    onWarning: Color(0xFF4B2800), // Orange 20
    warningContainer: Color(0xFF6B3D00), // Orange 30
    onWarningContainer: Color(0xFFFFDCC1), // Orange 90
  );
}