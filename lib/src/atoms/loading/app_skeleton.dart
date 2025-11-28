import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// import '../../foundation/theme/app_colors.dart'; // 假設你有 AppColors

class AppSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shape;
  final EdgeInsetsGeometry margin;

  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.shape = const RoundedRectangleBorder(), // 預設矩形
    this.margin = EdgeInsets.zero,
  });

  /// 圓形骨架 (常用於 Avatar)
  const AppSkeleton.circular({
    super.key,
    required double size,
    this.margin = EdgeInsets.zero,
  })  : width = size,
        height = size,
        shape = const CircleBorder();

  /// 文字骨架 (自動計算高度，模擬文字行)
  const AppSkeleton.text({
    super.key,
    this.width,
    double fontSize = 14,
    this.margin = const EdgeInsets.symmetric(vertical: 4),
  })  : height = fontSize,
        shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)));

  @override
  Widget build(BuildContext context) {
    // 從 ThemeExtension 獲取骨架顏色，確保深色模式適配
    // final appColors = Theme.of(context).extension<AppColors>()!;
    
    // 改用 ColorScheme 的 surfaceContainerHighest 和 surfaceContainer
    // 確保骨架是實心顏色，解決對比度不足的問題，並自動適應淺色/深色模式
    final colorScheme = Theme.of(context).colorScheme;
    final baseColor = colorScheme.surfaceContainerHighest; // 較深的背景色
    final highlightColor = colorScheme.surfaceContainer;   // 較淺的亮光色

    return Padding(
      padding: margin,
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: baseColor, // 這裡的顏色只是為了佔位，實際顏色由 Shimmer 控制
            shape: shape,
          ),
        ),
      ),
    );
  }
}
