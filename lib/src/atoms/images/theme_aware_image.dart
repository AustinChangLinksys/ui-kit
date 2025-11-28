import 'package:flutter/material.dart';
import '../../foundation/gen/assets.gen.dart'; // 引入 flutter_gen

class ThemeAwareImage extends StatelessWidget {
  final AssetGenImage lightImage;
  final AssetGenImage darkImage;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ThemeAwareImage({
    super.key,
    required this.lightImage,
    required this.darkImage,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    // 判斷亮度
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 選擇圖片
    final targetImage = isDark ? darkImage : lightImage;

    // 渲染
    // flutter_gen 的 image() 方法回傳的是 Image Widget
    return targetImage.image(
      width: width,
      height: height,
      fit: fit,
      filterQuality: FilterQuality.medium,
      package: 'ui_kit_library',
    );
  }
}
