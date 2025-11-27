import 'dart:ui';
import 'package:flutter/material.dart';

/// 封裝 LiquidGlassCard 的樣式設定
/// 符合憲章規範：當參數超過 3 個時，使用 Style Object。
class LiquidGlassStyle {
  final double width;
  final double height;
  final double borderRadius;
  final double blurStrength;
  final Color backgroundColor;
  final Color borderColor;
  final List<BoxShadow>? boxShadow;
  final Gradient? sheenGradient;

  const LiquidGlassStyle({
    this.width = 300,
    this.height = 200,
    this.borderRadius = 25.0,
    this.blurStrength = 15.0,
    this.backgroundColor = const Color(0x1AFFFFFF), // 10% 白色不透明度
    this.borderColor = const Color(0x4DFFFFFF), // 30% 白色不透明度
    this.boxShadow,
    this.sheenGradient,
  });
}

/// 呈現毛玻璃效果的卡片元件
/// 符合憲章規範：
/// - Dumb Component: 純粹 UI，無業務邏輯。
/// - Composition: 接受 Widget child。
/// - Style Object: 使用 LiquidGlassStyle 管理參數。
class LiquidGlassCard extends StatelessWidget {
  final Widget child;
  final LiquidGlassStyle style;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.style = const LiquidGlassStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: style.width,
      height: style.height,
      // clipBehavior 確保子部件（包括模糊效果）被正確地裁剪成圓角
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(style.borderRadius),
        boxShadow: style.boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
      ),
      child: Stack(
        children: [
          // 1. BackdropFilter 應用模糊效果到它下面的所有內容
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: style.blurStrength,
              sigmaY: style.blurStrength,
            ),
            child: Container(
              // 這個 Container 負責定義模糊的區域和提供基礎的半透明背景色
              decoration: BoxDecoration(
                color: style.backgroundColor,
                borderRadius: BorderRadius.circular(
                  style.borderRadius,
                ), // 確保這個也圓角
                border: Border.all(color: style.borderColor, width: 1.5),
              ),
            ),
          ),
          // 2. (Optional) 疊加一個漸層來模擬光澤感
          if (style.sheenGradient != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(style.borderRadius),
                gradient: style.sheenGradient,
              ),
            ),
          // 3. 卡片的實際內容
          Center(child: child),
        ],
      ),
    );
  }
}
