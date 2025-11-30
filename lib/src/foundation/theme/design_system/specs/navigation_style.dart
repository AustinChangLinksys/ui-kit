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

  // Option: if you insist on animating height transitions, you can write a lerp manually
  // But for this kind of structural change, we usually accept instantaneous switching
  static NavigationStyle lerp(NavigationStyle a, NavigationStyle b, double t) {
    return NavigationStyle(
      // Numeric types can transition
      height: ui.lerpDouble(a.height, b.height, t)!,
      floatingMargin: ui.lerpDouble(a.floatingMargin, b.floatingMargin, t)!,
      itemSpacing: ui.lerpDouble(a.itemSpacing, b.itemSpacing, t)!,
      
      // Boolean values cannot transition, t < 0.5 remains unchanged, t >= 0.5 switches
      isFloating: t < 0.5 ? a.isFloating : b.isFloating,
    );
  }
}