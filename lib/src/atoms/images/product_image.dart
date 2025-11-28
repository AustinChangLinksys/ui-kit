import 'package:flutter/material.dart';
import '../../foundation/gen/assets.gen.dart'; // 引入生成的 Assets 類別

class ProductImage extends StatelessWidget {
  // 1. 強型別輸入：只接受 flutter_gen 產生的 AssetGenImage
  // 這樣使用者就不可能傳錯字串路徑
  final AssetGenImage image;

  final double? width;
  final double? height;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 2. 基礎渲染
    // flutter_gen 會自動處理 package 參數，不用擔心路徑問題
    Widget content = image.image(
      width: width,
      height: height,
      fit: fit,
      filterQuality: FilterQuality.medium, // 優化縮放畫質
      package: 'ui_kit_library',
    );

    // 3. 深色模式適配 (Dimming) - 憲章 5.2
    if (isDark) {
      return ColorFiltered(
        // 疊加一層 10% 的黑色，讓白色機殼在黑底上不那麼刺眼
        colorFilter: const ColorFilter.mode(
          Colors.black12,
          BlendMode.darken,
        ),
        child: content,
      );
    }

    return content;
  }
}
