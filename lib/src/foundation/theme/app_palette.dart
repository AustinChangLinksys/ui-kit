// lib/src/foundation/theme/app_palette.dart
import 'dart:ui';

class AppPalette {
  AppPalette._(); // 私有建構子，防止實例化

  // 這是你的 Brand Color (Single Source of Truth)
  static const Color brandPrimary = Color(0xFF0870EA);
  
  // 如果有其他固定顏色（例如不隨 Theme 變化的顏色）也可以放這
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}