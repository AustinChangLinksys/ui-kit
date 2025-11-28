import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_typography.tailor.dart';

// 1. 定義基礎樣式與設定 (DRY)
const _packageName = 'ui_kit_library'; // 確保指向本 Package
const _fontFamily = 'NeueHaasGrotTextRound';
const _fontFamilyFallback = [
  'NoToSans',
  'NoToSansKR',
  'NoToSansSC',
  'NoToSansAR',
  'NoToSansTh'
];

const _baseTextStyle = TextStyle(
  fontFamily: _fontFamily,
  package: _packageName,
  fontFamilyFallback: _fontFamilyFallback,
  decoration: TextDecoration.none,
  leadingDistribution: TextLeadingDistribution.even, // 建議加入，優化垂直置中
);

// 2. 定義標準 TextTheme (供 ThemeData.textTheme 使用)
final appTextTheme = TextTheme(
  displayLarge: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 57,
    height: 64 / 57,
    letterSpacing: -0.25,
  ),
  displayMedium: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 45,
    height: 52 / 45,
    letterSpacing: 0,
  ),
  displaySmall: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 36,
    height: 44 / 36,
    letterSpacing: 0,
  ),
  headlineLarge: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: 0,
  ),
  headlineMedium: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 36 / 28,
    letterSpacing: 0,
  ),
  headlineSmall: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: 0,
  ),
  titleLarge: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 28 / 22,
    letterSpacing: 0,
  ),
  titleMedium: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.15,
  ),
  titleSmall: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
  ),
  labelLarge: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
  ),
  labelMedium: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.5,
  ),
  labelSmall: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: 0.5,
  ),
  bodyLarge: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0,
  ),
  bodyMedium: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
  ),
  bodySmall: _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0,
  ),
);

// 3. 定義擴充樣式 (ThemeExtension)
@TailorMixin()
class AppTypography extends ThemeExtension<AppTypography>
    with _$AppTypographyTailorMixin {
  
  @override
  final TextStyle bodyExtraSmall;

  const AppTypography({
    required this.bodyExtraSmall,
  });

  static final regular = AppTypography(
    bodyExtraSmall: _baseTextStyle.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      height: 14 / 10,
      letterSpacing: 0,
    ),
  );
}