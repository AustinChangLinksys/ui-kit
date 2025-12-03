// lib/src/foundation/theme/app_palette.dart
import 'dart:ui';

class AppPalette {
  AppPalette._(); // Private constructor to prevent instantiation

  // This is your Brand Color (Single Source of Truth)
  static const Color brandPrimary = Color(0xFF0870EA);

  // Other fixed colors (e.g., colors that do not change with Theme) can also be placed here
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Secondary container tokens (Material 3 inspired) - Light mode
  static const Color secondaryContainer = Color(0xFFDCE3F0);
  static const Color onSecondaryContainer = Color(0xFF1E2A3A);

  // Secondary container tokens - Dark mode
  static const Color secondaryContainerDark = Color(0xFF314561);
  static const Color onSecondaryContainerDark = Color(0xFFE0E8F8);

  // Tertiary container tokens (Material 3 inspired) - Light mode
  static const Color tertiaryContainer = Color(0xFFFFD8E4);
  static const Color onTertiaryContainer = Color(0xFF3E1F2F);

  // Neumorphic theme shadow colors
  static const Color neumorphicLightShadow = Color(0xFFA3B1C6);
  static const Color neumorphicDarkShadow = Color(0xFF14171A);
}
