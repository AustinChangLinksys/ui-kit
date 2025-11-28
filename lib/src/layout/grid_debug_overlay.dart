import 'package:flutter/material.dart';
import 'layout_extensions.dart';

class GridDebugOverlay extends StatelessWidget {
  final Widget child;
  final bool visible;

  /// Whether to show left and right margins (usually follows AppPageView's settings)
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

    // Key logic: If margins are not used, the visual margin width is set to zero
    // This way, the red Column will automatically expand to fill both sides
    final margin = useMargins ? context.pageMargin : 0.0;

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // A. Left Margin
                if (margin > 0)
                  Container(
                    width: margin,
                    color: Colors.green.withValues(alpha: 0.2),
                  ),

                // B. Grid Area
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

                // C. Right Margin
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
