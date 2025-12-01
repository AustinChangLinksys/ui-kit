import 'package:flutter/material.dart';
import '../../foundation/gen/assets.gen.dart'; // SVG generated file

class AppIcon extends StatelessWidget {
  // Internal variables (only one will have a value)
  final SvgGenImage? _svg;
  final IconData? _fontIcon;

  final double size;
  final Color? color;

  // 1. Constructor A: for SVG
  const AppIcon(
    SvgGenImage icon, {
    super.key,
    this.size = 24.0,
    this.color,
  })  : _svg = icon,
        _fontIcon = null;

  // 2. Constructor B: for Icon Font
  const AppIcon.font(
    IconData icon, {
    super.key,
    this.size = 24.0,
    this.color,
  })  : _fontIcon = icon,
        _svg = null;

  @override
  Widget build(BuildContext context) {
    // Unified color determination (Charter 5.2: controlled by external or Theme)
    final iconColor = color ?? IconTheme.of(context).color ?? Colors.black;

    // Diversion rendering logic
    if (_fontIcon != null) {
      // Render Font Icon
      return Icon(
        _fontIcon,
        size: size,
        color: iconColor, // Icon Widget natively supports color
      );
    } else {
      // Render SVG (using previous logic)
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
