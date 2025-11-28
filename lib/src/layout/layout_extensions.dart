import 'dart:math';
import 'package:flutter/material.dart';
import '../foundation/theme/app_layout.dart';

extension LayoutContext on BuildContext {
  // 1. 基礎存取
  AppLayout get layout => Theme.of(this).extension<AppLayout>()!;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  // 2. 斷點判斷
  bool get isMobile => screenWidth < layout.breakpointMobile;
  bool get isTablet =>
      screenWidth >= layout.breakpointMobile &&
      screenWidth < layout.breakpointDesktop;
  bool get isDesktop => screenWidth >= layout.breakpointDesktop;

  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // 3. Grid 參數獲取 (統一入口，拒絕 magic number)

  /// 當前最大欄數
  int get currentMaxColumns =>
      responsive(mobile: 4, tablet: 8, desktop: layout.maxColumns // 12
          );

  /// 當前頁面邊距
  /// [修正] 直接使用 AppLayout 定義的 margin，確保與 DebugOverlay 一致
  double get pageMargin {
    // 如果需要針對不同裝置微調 Margin，建議在 AppLayout 中定義 marginMobile, marginTablet
    // 這裡暫時統一使用 layout.margin 以確保對齊
    return layout.margin;
  }

  /// 當前欄間距
  double get currentGutter => layout.gutter;

  // 4. 計算邏輯

  /// 從 Context 中獲取是否使用頁面邊距的設定
  /// 預設為 true (如果找不到 PageLayoutScope)
  bool get usePageMargins => PageLayoutScope.of(this);

  /// [Grid Span] 計算 N 條軌道的寬度
  /// [useMargins] 若為 null，則自動參考當前 [AppPageView] 的設定
  double colWidth(int columnSpan, {bool? useMargins}) {
    final effectiveUseMargins = useMargins ?? usePageMargins;
    final totalCols = currentMaxColumns;
    final marginTotal = effectiveUseMargins ? pageMargin * 2 : 0.0;
    final gutter = currentGutter;
    final gutterTotal = gutter * (totalCols - 1);

    // 計算可用總寬
    final availableContentWidth = screenWidth - marginTotal - gutterTotal;

    // 計算單欄寬
    final singleColWidth = availableContentWidth / totalCols;

    // 回傳跨度寬
    return (singleColWidth * columnSpan) + (gutter * max(0, columnSpan - 1));
  }

  /// [Fixed Split] 均分計算
  /// [useMargins] 若為 null，則自動參考當前 [AppPageView] 的設定
  double split(int count, {bool? useMargins}) {
    final effectiveUseMargins = useMargins ?? usePageMargins;
    final marginTotal = effectiveUseMargins ? pageMargin * 2 : 0.0;
    final availableWidth = screenWidth - marginTotal;
    final totalGutterWidth = currentGutter * (count - 1);
    return (availableWidth - totalGutterWidth) / count;
  }
}

/// 一個 InheritedWidget，用於將 AppPageView 的佈局設定向下傳遞
class PageLayoutScope extends InheritedWidget {
  final bool useContentPadding;

  const PageLayoutScope({
    super.key,
    required this.useContentPadding,
    required super.child,
  });

  static bool of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<PageLayoutScope>();
    return scope?.useContentPadding ?? true;
  }

  @override
  bool updateShouldNotify(PageLayoutScope oldWidget) {
    return useContentPadding != oldWidget.useContentPadding;
  }
}

