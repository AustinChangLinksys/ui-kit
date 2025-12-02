import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/layout_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';

extension LayoutContext on BuildContext {
  // 1. Basic access
  LayoutSpec get layout {
    // ✨ 修正點：先取得 AppDesignTheme，再拿裡面的 layout
    final theme = Theme.of(this).extension<AppDesignTheme>();
    if (theme == null) {
      // 防呆：清楚的錯誤訊息
      throw FlutterError('AppDesignTheme not found in context.\n'
          'Ensure that your app is wrapped with a Theme that includes AppDesignTheme (via AppTheme.create).');
    }
    return theme.layoutSpec;
  }

  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  // 2. Breakpoint judgment
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

  // 3. Grid parameter acquisition (unified entry, reject magic numbers)

  /// Current maximum number of columns
  int get currentMaxColumns =>
      responsive(mobile: 4, tablet: 8, desktop: layout.maxColumns // 12
          );

  /// Current page margins
  /// Directly use the margin defined by AppLayout to ensure consistency with DebugOverlay
  double get pageMargin {
    // If you need to fine-tune margins for different devices, it is recommended to define marginMobile, marginTablet in AppLayout
    // Here, layout.margin is temporarily used uniformly to ensure alignment
    return layout.margin(screenWidth);
  }

  /// Current gutter width
  double get currentGutter => layout.gutter(screenWidth);

  // 4. Calculation logic

  /// Get the setting for whether to use page margins from the Context
  /// Defaults to true (if PageLayoutScope is not found)
  bool get usePageMargins => PageLayoutScope.of(this);

  /// If null, automatically refers to the current [AppPageView] settings
  double colWidth(int columnSpan, {bool? useMargins}) {
    final effectiveUseMargins = useMargins ?? usePageMargins;
    final totalCols = currentMaxColumns;
    final marginTotal = effectiveUseMargins ? pageMargin * 2 : 0.0;
    final gutter = currentGutter;
    final gutterTotal = gutter * (totalCols - 1);

    // Calculate available total width
    final availableContentWidth = screenWidth - marginTotal - gutterTotal;

    // Calculate single column width
    final singleColWidth = availableContentWidth / totalCols;

    // Return span width
    return (singleColWidth * columnSpan) + (gutter * max(0, columnSpan - 1));
  }

  /// Even distribution calculation
  /// If null, automatically refers to the current [AppPageView] settings
  double split(int count, {bool? useMargins}) {
    final effectiveUseMargins = useMargins ?? usePageMargins;
    final marginTotal = effectiveUseMargins ? pageMargin * 2 : 0.0;
    final availableWidth = screenWidth - marginTotal;
    final totalGutterWidth = currentGutter * (count - 1);
    return (availableWidth - totalGutterWidth) / count;
  }
}

/// An InheritedWidget used to pass AppPageView's layout settings down the widget tree
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
