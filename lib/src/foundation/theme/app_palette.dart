// lib/src/foundation/theme/app_palette.dart
import 'dart:ui';

class AppPalette {
  AppPalette._(); // Private constructor to prevent instantiation

  // This is your Brand Color (Single Source of Truth)
  static const Color brandPrimary = Color(0xFF0870EA);

  // Other fixed colors (e.g., colors that do not change with Theme) can also be placed here
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color neumorphicLightShadow = Color(0xFFA3B1C6);
  static const Color neumorphicDarkShadow = Color(0xFF14171A);
}
