import 'package:flutter/material.dart';
import '../../foundation/gen/assets.gen.dart'; // SVG 生成檔

class AppIcon extends StatelessWidget {
  // 內部變數 (只有其中一個會有值)
  final SvgGenImage? _svg;
  final IconData? _fontIcon;

  final double size;
  final Color? color;

  // 1. 建構子 A：給 SVG 用的 (維持原樣)
  const AppIcon(
    SvgGenImage icon, {
    super.key,
    this.size = 24.0,
    this.color,
  })  : _svg = icon,
        _fontIcon = null;

  // 2. 建構子 B：給 Icon Font 用的 (新增)
  const AppIcon.font(
    IconData icon, {
    super.key,
    this.size = 24.0,
    this.color,
  })  : _fontIcon = icon,
        _svg = null;

  @override
  Widget build(BuildContext context) {
    // 統一決定顏色 (憲章 5.2：由外部或 Theme 控制)
    final iconColor = color ?? IconTheme.of(context).color ?? Colors.black;

    // 分流渲染邏輯
    if (_fontIcon != null) {
      // 渲染 Font Icon
      return Icon(
        _fontIcon,
        size: size,
        color: iconColor, // Icon Widget 原生就支援 color
      );
    } else {
      // 渲染 SVG (使用之前的邏輯)
      return _svg!.svg(
        width: size,
        height: size,
        package: 'ui_kit_library',
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
      );
    }
  }
}
