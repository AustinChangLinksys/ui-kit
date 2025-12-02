import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.axis = Axis.horizontal,
    this.height,
    this.width,
    this.indent,
    this.endIndent,
    this.color,
  });

  final Axis axis;
  final double? height;
  final double? width;
  final double? indent;
  final double? endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final style = theme.dividerStyle;

    final double thickness = style.thickness;
    // 縮放 Indent
    final double indentVal = (indent ?? style.indent) * theme.spacingFactor;
    final double endIndentVal = (endIndent ?? style.endIndent) * theme.spacingFactor;

    // 計算佔用空間 (Jagged 線通常需要比直線更多的垂直空間)
    final double defaultSize = style.pattern == DividerPattern.jagged 
        ? 12.0 * theme.spacingFactor // 鋸齒需要高度
        : thickness;

    final double effectiveHeight = axis == Axis.horizontal 
        ? (height ?? (defaultSize + 16 * theme.spacingFactor)) 
        : (height ?? double.infinity);
        
    final double effectiveWidth = axis == Axis.vertical 
        ? (width ?? (defaultSize + 16 * theme.spacingFactor)) 
        : (width ?? double.infinity);

    return SizedBox(
      height: effectiveHeight,
      width: effectiveWidth,
      child: CustomPaint(
        painter: _DividerPainter(
          color: color ?? style.color,
          secondaryColor: style.secondaryColor,
          thickness: thickness,
          indent: indentVal,
          endIndent: endIndentVal,
          glowStrength: style.glowStrength,
          pattern: style.pattern,
          axis: axis,
        ),
      ),
    );
  }
}

class _DividerPainter extends CustomPainter {
  final Color color;
  final Color? secondaryColor;
  final double thickness;
  final double indent;
  final double endIndent;
  final double glowStrength;
  final DividerPattern pattern;
  final Axis axis;

  _DividerPainter({
    required this.color,
    this.secondaryColor,
    required this.thickness,
    required this.indent,
    required this.endIndent,
    required this.glowStrength,
    required this.pattern,
    required this.axis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (glowStrength > 0) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, glowStrength);
    }

    // 定義起點與終點
    Offset p1, p2;
    if (axis == Axis.horizontal) {
      double y = size.height / 2;
      p1 = Offset(indent, y);
      p2 = Offset(size.width - endIndent, y);
    } else {
      double x = size.width / 2;
      p1 = Offset(x, indent);
      p2 = Offset(x, size.height - endIndent);
    }

    // 根據 Pattern 選擇繪圖策略
    switch (pattern) {
      case DividerPattern.solid:
        canvas.drawLine(p1, p2, paint);
        break;
      case DividerPattern.dashed:
        _drawDashedLine(canvas, p1, p2, paint);
        break;
      case DividerPattern.jagged:
        _drawJaggedLine(canvas, p1, p2, paint);
        break;
    }

    // 處理 Neumorphic 的 secondary color (只支援 Solid)
    if (secondaryColor != null && pattern == DividerPattern.solid) {
      final lightPaint = Paint()
        ..color = secondaryColor!
        ..strokeWidth = thickness
        ..style = PaintingStyle.stroke;
      
      final offset = axis == Axis.horizontal ? const Offset(0, 1) : const Offset(1, 0);
      canvas.drawLine(p1 + offset, p2 + offset, lightPaint);
    }
  }

  // --- 繪製虛線 ---
  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    final double dashWidth = 8.0;
    final double dashSpace = 4.0;
    
    double distance = (p2 - p1).distance;
    double dx = (p2.dx - p1.dx) / distance;
    double dy = (p2.dy - p1.dy) / distance;
    
    double currentDist = 0.0;
    while (currentDist < distance) {
      double drawLen = dashWidth;
      if (currentDist + drawLen > distance) drawLen = distance - currentDist;
      
      final start = Offset(p1.dx + dx * currentDist, p1.dy + dy * currentDist);
      final end = Offset(p1.dx + dx * (currentDist + drawLen), p1.dy + dy * (currentDist + drawLen));
      
      canvas.drawLine(start, end, paint);
      currentDist += dashWidth + dashSpace;
    }
  }

  // --- ✨ 繪製鋸齒線 (Zig-Zag) ---
  void _drawJaggedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    final Path path = Path();
    path.moveTo(p1.dx, p1.dy);

    const double toothWidth = 6.0; // 每個鋸齒的寬度
    const double toothHeight = 4.0; // 鋸齒的高度 (波峰到波谷)

    if (axis == Axis.horizontal) {
      double x = p1.dx;
      double y = p1.dy;
      bool up = true;

      while (x < p2.dx) {
        x += toothWidth;
        // 確保不超出終點
        if (x > p2.dx) x = p2.dx;
        
        // 上下交替
        final nextY = up ? y - toothHeight : y + toothHeight;
        path.lineTo(x, nextY);
        up = !up;
      }
    } else {
      // 垂直方向鋸齒
      double y = p1.dy;
      double x = p1.dx;
      bool right = true;

      while (y < p2.dy) {
        y += toothWidth;
        if (y > p2.dy) y = p2.dy;

        final nextX = right ? x + toothHeight : x - toothHeight;
        path.lineTo(nextX, y);
        right = !right;
      }
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DividerPainter oldDelegate) => true;
}