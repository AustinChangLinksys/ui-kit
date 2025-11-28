import 'package:flutter/material.dart';
import 'layout_extensions.dart';

class GridDebugOverlay extends StatelessWidget {
  final Widget child;
  final bool visible;

  /// 是否顯示左右邊距 (通常跟隨 AppPageView 的設定)
  final bool useMargins;

  const GridDebugOverlay({
    super.key,
    required this.child,
    this.visible = false,
    this.useMargins = true, // 預設為 true (標準 Grid)
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return child;

    final cols = context.currentMaxColumns;
    final gutter = context.layout.gutter;

    // 關鍵邏輯：如果不使用 Margin，則將視覺上的 Margin 寬度歸零
    // 這樣紅色的 Column 就會自動 Expanded 填滿兩側
    final margin = useMargins ? context.pageMargin : 0.0;

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // A. 左側 Margin
                if (margin > 0)
                  Container(
                    width: margin,
                    color: Colors.green.withValues(alpha: 0.2),
                  ),

                // B. Grid 區域
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(cols * 2 - 1, (index) {
                      final isColumn = index % 2 == 0;
                      if (isColumn) {
                        return Expanded(
                          child: Container(color: Colors.red.withValues(alpha: 0.1)),
                        );
                      } else {
                        return SizedBox(
                          width: gutter,
                          child: Container(color: Colors.cyan.withValues(alpha: 0.2)),
                        );
                      }
                    }),
                  ),
                ),

                // C. 右側 Margin
                if (margin > 0)
                  Container(
                    width: margin,
                    color: Colors.green.withValues(alpha: 0.2),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
