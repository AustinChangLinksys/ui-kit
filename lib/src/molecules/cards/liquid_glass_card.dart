import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/glass_theme.dart';


class LiquidGlassStyle {
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? blurStrength;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final Gradient? sheenGradient;

  const LiquidGlassStyle({
    this.width,
    this.height,
    this.borderRadius,
    this.blurStrength,
    this.backgroundColor,
    this.borderColor,
    this.boxShadow,
    this.sheenGradient,
  });
}

class LiquidGlassCard extends StatelessWidget {
  final Widget child;
  final LiquidGlassStyle? style; // 改為可選

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 從 Context 獲取 Token (憲章 3.1)
    // 若 Context 中沒有 GlassTheme，則退回預設樣式 (Fallback)，避免紅屏
    final theme = Theme.of(context).extension<GlassTheme>() ?? GlassTheme.light;
    
    // 2. 計算最終值 (優先權: Style > Theme)
    final radius = style?.borderRadius ?? 24.0; // 圓角也可以放 Theme，這裡暫時寫死通用值
    final blur = style?.blurStrength ?? theme.blurStrength;
    final bgColor = style?.backgroundColor ?? theme.baseColor;
    final borderCol = style?.borderColor ?? theme.borderColor;
    final shadowCol = theme.shadowColor;

    return Container(
      width: style?.width, // 如果是 null，讓 layout 自適應
      height: style?.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: style?.boxShadow ?? [
          BoxShadow(
            color: shadowCol, // ✅ 使用 Token 顏色
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 模糊層
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              decoration: BoxDecoration(
                color: bgColor, // ✅ 自動適配 Dark Mode
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: borderCol, width: 1.5),
              ),
            ),
          ),
          // 光澤層
          if (style?.sheenGradient != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: style!.sheenGradient!,
              ),
            ),
          // 內容
          Center(child: child),
        ],
      ),
    );
  }
}