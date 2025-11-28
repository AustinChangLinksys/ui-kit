import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'glass_theme.tailor.dart';

@TailorMixin()
class GlassTheme extends ThemeExtension<GlassTheme> with _$GlassThemeTailorMixin {
  @override
  final Color baseColor;
  @override
  final Color borderColor;
  @override
  final double blurStrength;
  @override
  final Color shadowColor;

  const GlassTheme({
    required this.baseColor,
    required this.borderColor,
    required this.blurStrength,
    required this.shadowColor,
  });

  // 淺色模式：白霧玻璃
  static const light = GlassTheme(
    baseColor: Color(0x1AFFFFFF), // 10% White
    borderColor: Color(0x4DFFFFFF), // 30% White
    blurStrength: 15.0,
    shadowColor: Color(0x1A000000), // 10% Black Shadow
  );

  // 深色模式：黑霧玻璃 (這就是 Charter 的價值，自動適配深色)
  static const dark = GlassTheme(
    baseColor: Color(0x80000000), // 50% Black
    borderColor: Color(0x1AFFFFFF), // 10% White border
    blurStrength: 15.0,
    shadowColor: Colors.black,
  );
}