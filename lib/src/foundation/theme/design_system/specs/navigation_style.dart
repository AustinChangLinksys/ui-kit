import 'dart:ui' as ui;

class NavigationStyle {
  final double height;
  final bool isFloating;
  final double floatingMargin;
  final double itemSpacing;

  const NavigationStyle({
    this.height = 80.0,
    this.isFloating = false,
    this.floatingMargin = 16.0,
    this.itemSpacing = 8.0,
  });

  // 選項：如果你堅持要讓高度有動畫過渡，可以手寫一個 lerp
  // 但通常對於這種結構性變更，我們接受它瞬間切換
  static NavigationStyle lerp(NavigationStyle a, NavigationStyle b, double t) {
    return NavigationStyle(
      // 數值型別可以過渡
      height: ui.lerpDouble(a.height, b.height, t)!,
      floatingMargin: ui.lerpDouble(a.floatingMargin, b.floatingMargin, t)!,
      itemSpacing: ui.lerpDouble(a.itemSpacing, b.itemSpacing, t)!,
      
      // 布林值無法過渡，t < 0.5 保持原樣，t >= 0.5 切換
      isFloating: t < 0.5 ? a.isFloating : b.isFloating,
    );
  }
}