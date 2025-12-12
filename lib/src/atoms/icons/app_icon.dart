import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/icons/app_icon_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
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

    // Get current theme for adaptive style
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final style = theme?.iconStyle ?? AppIconStyle.vectorFilled;

    // Diversion rendering logic
    if (_fontIcon != null) {
      // Render Font Icon
      // Note: Font icons might need different font families for styles if desired, 
      // but typically SVG assets are swapped. 
      // For pixel style, we might want to enforce aliasing or specific font if available.
      return Icon(
        _fontIcon,
        size: size,
        color: iconColor, // Icon Widget natively supports color
      );
    } else {
      // Render SVG
      // Adaptive Logic:
      // In a real-world scenario, we would resolve asset path based on style.
      // E.g., 'assets/icons/home.svg' -> 'assets/icons/glass/home.svg'
      // Since we rely on static `SvgGenImage` which hardcodes path, fully dynamic asset swapping 
      // requires either a naming convention mapping or multiple asset classes.
      
      // For this implementation, we demonstrate the style usage by adjusting rendering properties.
      // Glass: Add glow/shadow. Pixel: Use point filtering (aliasing).
      
      Widget iconWidget = _svg!.svg(
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
      );

      switch (style) {
        case AppIconStyle.thinStroke:
          // Simulate thin stroke look or glow for Glass
          // Ideally, use a different asset `_svg_thin` if available.
          // Here we add a subtle outer glow wrapper as an effect
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: iconColor.withValues(alpha: 0.4),
                  blurRadius: 8,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: iconWidget,
          );
        
        case AppIconStyle.pixelated:
          // Ensure sharp edges for pixel art scaling
          // Note: SVG rendering is vector, so it's always smooth. 
          // True pixelation needs raster images or special shader.
          // We wrap in a pixel-snap alignment or similar if possible.
          // For now, standard render as placeholder for specific pixel-art SVG content.
          return iconWidget;

        case AppIconStyle.vectorFilled:
          return iconWidget;
      }
    }
  }
}

