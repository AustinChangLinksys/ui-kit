import 'package:flutter/material.dart';
import 'layout_extensions.dart'; // Import our math logic
import 'grid_debug_overlay.dart'; // Import debug grid

/// A standardized page container that integrates a responsive grid system.
///
/// Features:
/// - Automatically handles responsive page margins
/// - Integrates pull-to-refresh
/// - Integrates scroll view
/// - Provides debug overlay
/// - Full Scaffold support (AppBar, FAB, BottomNav)
class AppPageView extends StatelessWidget {
  /// Page main content
  final Widget child;

  /// AppBar (optional)
  final PreferredSizeWidget? appBar;

  /// Background color (defaults to Theme.colorScheme.surface)
  final Color? backgroundColor;

  /// Whether it is scrollable (defaults to false)
  /// If true, content will be wrapped in a SingleChildScrollView
  final bool scrollable;

  /// Scroll controller (only effective when scrollable=true)
  final ScrollController? scrollController;

  /// Pull-to-refresh callback (optional)
  /// If this callback is provided, RefreshIndicator will be automatically enabled
  final Future<void> Function()? onRefresh;

  /// Additional Padding
  /// This is layered on top of the Grid Margin. For example: you need Grid Margin + an additional 16px
  final EdgeInsets? padding;

  /// Whether to apply responsive Grid Margin (defaults to true)
  /// - true: Content will be inset and aligned with the grid system.
  /// - false: Content will align with the screen edges (suitable for full-width maps, images, or custom layouts).
  final bool useContentPadding;

  /// Whether to show the debug grid (usually controlled by external variables, such as Environment.isDebug)
  final bool showGridOverlay;

  /// SafeArea settings (all enabled by default)
  final ({bool left, bool top, bool right, bool bottom}) enableSafeArea;

  // --- Scaffold related properties ---
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
    // 1. Create content layer
    Widget content = child;

    // A. Apply Grid Margin (responsive margins)
    // This is the core of the Grid System: (total width - margin) = content area
    if (useContentPadding) {
      content = Padding(
        padding: EdgeInsets.symmetric(horizontal: context.pageMargin),
        child: content,
      );
    }

    // B. Apply additional Padding
    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    // C. Handle scrolling behavior
    if (scrollable) {
      content = SingleChildScrollView(
        controller: scrollController,
        // AlwaysScrollable ensures that pull-to-refresh can be triggered even with less content, and conforms to physical properties
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          // Ensure that the content area at least fills the "visible height"
          // This is very important for UI like "Footer" that needs to be at the bottom
          constraints: BoxConstraints(
            minHeight: _calculateMinHeight(context),
          ),
          child: content,
        ),
      );
    }

    // D. Handle pull-to-refresh
    if (onRefresh != null) {
      content = RefreshIndicator(
        onRefresh: onRefresh!,
        child: content,
      );
    }

    // E. Overlay debug grid
    // We wrap it in the outermost layer (but inside SafeArea) to ensure the grid correctly covers the content
    content = GridDebugOverlay(
      visible: showGridOverlay,
      // Key: Pass the padding status to the Overlay so it knows whether to draw the green Margin
      useMargins: useContentPadding,
      child: content,
    );

    // 2. Construct SafeArea
    // Decide whether to wrap SafeArea based on settings
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

    // 3. Final assembly (Scaffold)
    return PageLayoutScope(
      useContentPadding: useContentPadding,
      child: Scaffold(
        backgroundColor: backgroundColor, // If null, Scaffold automatically takes Theme.colorScheme.surface
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

  /// Calculate the minimum height of the content area
  /// (Screen height - AppBar height - StatusBar height)
  double _calculateMinHeight(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double appBarHeight = appBar?.preferredSize.height ?? 0;
    final double topPadding = MediaQuery.paddingOf(context).top;

    // If there is a BottomNavBar, it should also be deducted. Here, a simple calculation is temporarily performed.
    return screenHeight - appBarHeight - topPadding;
  }
}
