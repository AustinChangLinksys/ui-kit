// lib/src/foundation/theme/design_system/specs/toggle_style.dart

import 'package:flutter/material.dart';

enum ToggleContentType {
  none,   // 空白
  text,   // 顯示文字 (I/O)
  icon,   // 顯示圖示 (Check/Close)
  grip,   // 顯示止滑紋 (Glass 風格)
  dot,    // 顯示凹點 (Neumorphic 風格)
}

class ToggleStyle {
  final ToggleContentType activeType;
  final ToggleContentType inactiveType;
  final String? activeText;   // e.g. "I", "ON"
  final String? inactiveText; // e.g. "O", "OFF"
  final IconData? activeIcon; // e.g. Icons.check
  final IconData? inactiveIcon;

  const ToggleStyle({
    this.activeType = ToggleContentType.none,
    this.inactiveType = ToggleContentType.none,
    this.activeText,
    this.inactiveText,
    this.activeIcon,
    this.inactiveIcon,
  });
}