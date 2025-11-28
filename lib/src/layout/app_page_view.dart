import 'package:flutter/material.dart';
import 'layout_extensions.dart'; // 引入我們寫好的數學邏輯
import 'grid_debug_overlay.dart'; // 引入除錯網格

/// 一個標準化的頁面容器，整合了響應式網格系統 (Grid System)。
///
/// 功能特色：
/// - 自動處理響應式邊距 (Page Margins)
/// - 整合下拉刷新 (Pull-to-Refresh)
/// - 整合捲動視圖 (Scroll View)
/// - 提供除錯網格 (Debug Overlay)
/// - 完整的 Scaffold 支援 (AppBar, FAB, BottomNav)
class AppPageView extends StatelessWidget {
  /// 頁面主要內容
  final Widget child;

  /// AppBar (選填)
  final PreferredSizeWidget? appBar;

  /// 背景色 (預設使用 Theme.colorScheme.surface)
  final Color? backgroundColor;

  /// 是否可捲動 (預設 false)
  /// 若為 true，內容會被 SingleChildScrollView 包裹
  final bool scrollable;

  /// 捲動控制器 (僅在 scrollable=true 時有效)
  final ScrollController? scrollController;

  /// 下拉刷新 callback (選填)
  /// 若提供此 callback，會自動啟用 RefreshIndicator
  final Future<void> Function()? onRefresh;

  /// 額外的 Padding
  /// 這是疊加在 Grid Margin 之上的。例如：你需要 Grid Margin + 額外 16px
  final EdgeInsets? padding;

  /// 是否套用響應式 Grid Margin (預設 true)
  /// - true: 內容會被內縮，對齊網格系統。
  /// - false: 內容會貼齊螢幕邊緣 (適合全版地圖、圖片或自定義佈局)。
  final bool useContentPadding;

  /// 是否顯示除錯網格 (通常由外部變數控制，如 Environment.isDebug)
  final bool showGridOverlay;

  /// SafeArea 設定 (預設全開)
  final ({bool left, bool top, bool right, bool bottom}) enableSafeArea;

  // --- Scaffold 相關屬性 ---
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  const AppPageView({
    super.key,
    required this.child,
    this.appBar,
    this.backgroundColor,
    this.scrollable = false,
    this.scrollController,
    this.onRefresh,
    this.padding,
    this.useContentPadding = true,
    this.showGridOverlay = false,
    this.enableSafeArea = (left: true, top: true, right: true, bottom: true),
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 建立內容層 (Content Layer)
    Widget content = child;

    // A. 套用 Grid Margin (響應式邊距)
    // 這是 Grid System 的核心：(總寬 - Margin) = 內容區
    if (useContentPadding) {
      content = Padding(
        padding: EdgeInsets.symmetric(horizontal: context.pageMargin),
        child: content,
      );
    }

    // B. 套用額外 Padding
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    // C. 處理捲動行為 (Scrolling)
    if (scrollable) {
      content = SingleChildScrollView(
        controller: scrollController,
        // AlwaysScrollable 確保內容少時也能觸發下拉刷新，且符合物理特性
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          // 確保內容區域至少撐滿「可視高度」
          // 這對於像 "Footer" 這種需要置底的 UI 來說非常重要
          constraints: BoxConstraints(
            minHeight: _calculateMinHeight(context),
          ),
          child: content,
        ),
      );
    }

    // D. 處理下拉刷新 (Pull-to-Refresh)
    if (onRefresh != null) {
      content = RefreshIndicator(
        onRefresh: onRefresh!,
        child: content,
      );
    }

    // E. 疊加除錯網格 (Debug Overlay)
    // 我們將它包在最外層 (但在 SafeArea 內)，確保網格正確覆蓋在內容上
    content = GridDebugOverlay(
      visible: showGridOverlay,
      // 關鍵：將 padding 狀態傳遞給 Overlay，讓它知道是否要繪製綠色 Margin
      useMargins: useContentPadding,
      child: content,
    );

    // 2. 構建 SafeArea
    // 根據設定決定是否包裹 SafeArea
    if (enableSafeArea.left ||
        enableSafeArea.top ||
        enableSafeArea.right ||
        enableSafeArea.bottom) {
      content = SafeArea(
        left: enableSafeArea.left,
        top: enableSafeArea.top,
        right: enableSafeArea.right,
        bottom: enableSafeArea.bottom,
        child: content,
      );
    }

    // 3. 最終組裝 (Scaffold)
    return PageLayoutScope(
      useContentPadding: useContentPadding,
      child: Scaffold(
        backgroundColor: backgroundColor, // 若為 null，Scaffold 會自動取 Theme.colorScheme.surface
        appBar: appBar,
        body: content,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
      ),
    );
  }

  /// 計算內容區域的最小高度
  /// (螢幕高 - AppBar高 - StatusBar高)
  double _calculateMinHeight(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double appBarHeight = appBar?.preferredSize.height ?? 0;
    final double topPadding = MediaQuery.paddingOf(context).top;

    // 如果有 BottomNavBar 也要扣掉，這裡暫時做簡單計算
    return screenHeight - appBarHeight - topPadding;
  }
}
