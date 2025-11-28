import 'package:flutter/material.dart';
import '../../foundation/gen/assets.gen.dart'; // 引入 flutter_gen

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
    // 判斷當前是否為深色模式
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 根據模式選擇對應的 SVG 資產
    final targetSvg = isDark ? darkSvg : lightSvg;

    return targetSvg.svg(
      width: width,
      height: height,
      fit: fit,
      package: 'ui_kit_library',
    );
  }
}
