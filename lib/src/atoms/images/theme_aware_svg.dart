import 'package:flutter/material.dart';
import '../../foundation/gen/assets.gen.dart'; // Import flutter_gen

class ThemeAwareSvg extends StatelessWidget {
  final SvgGenImage lightSvg;
  final SvgGenImage darkSvg;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ThemeAwareSvg({
    super.key,
    required this.lightSvg,
    required this.darkSvg,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if current mode is dark mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Select the corresponding SVG asset based on the mode
    final targetSvg = isDark ? darkSvg : lightSvg;

    return targetSvg.svg(
      width: width,
      height: height,
      fit: fit,
      package: 'ui_kit_library',
    );
  }
}
