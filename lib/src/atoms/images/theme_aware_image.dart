import 'package:flutter/material.dart';
import '../../foundation/gen/assets.gen.dart'; // Import flutter_gen

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
    // Determine brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Select image
    final targetImage = isDark ? darkImage : lightImage;

    // Render
    // flutter_gen's image() method returns an Image Widget
    return targetImage.image(
      width: width,
      height: height,
      fit: fit,
      filterQuality: FilterQuality.medium,
      package: 'ui_kit_library',
    );
  }
}
