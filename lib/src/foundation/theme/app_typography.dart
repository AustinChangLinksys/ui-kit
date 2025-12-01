import 'package:flutter/material.dart';

// 1. Base settings (retaining original font settings)
const _packageName = 'ui_kit_library';
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
  leadingDistribution: TextLeadingDistribution.even,
  // Define base color here, typically black or white, but will be overridden when Theme is created
  color: Colors.black,
);

// 2. Standard TextTheme (for AppTheme)
// All standard font sizes of the Design System are defined here
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

// 3. Define custom styles added in v2.0 (as static constants)
// This is to allow AppText to read precise values, rather than calculated ones
class AppTypographyExtra {
  static final TextStyle bodyExtraSmall = _baseTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 14 / 10,
    letterSpacing: 0,
  );
}
