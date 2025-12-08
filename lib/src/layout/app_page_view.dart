import 'package:flutter/material.dart';
import 'layout_extensions.dart'; // Ensure correct path
import 'grid_debug_overlay.dart'; // Ensure correct path

/// A standardized page container integrating a responsive Grid System,
/// Desktop Side Menu, and dual Sliver/Box layout modes.
class AppPageView extends StatelessWidget {
  /// The main content of the page.
  final Widget child;

  /// Page Header.
  final Widget? header;

  /// Side Menu (Desktop Only).
  final Widget? sideMenu;

  /// Whether to use CustomScrollView (Sliver) layout logic.
  final bool useSlivers;

  /// Background color.
  final Color? backgroundColor;

  /// Whether the content is scrollable.
  final bool scrollable;

  /// Scroll controller.
  final ScrollController? scrollController;

  /// Pull-to-refresh callback.
  final Future<void> Function()? onRefresh;

  /// Additional Padding (layered on top of Grid Margins).
  final EdgeInsets? padding;

  /// Whether to apply responsive Grid Margins.
  final bool useContentPadding;

  /// Whether to show the Grid Debug Overlay.
  final bool showGridOverlay;

  /// SafeArea settings.
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
    this.header,
    this.sideMenu,
    this.useSlivers = true,
    this.backgroundColor,
    this.scrollable = true,
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
    return PageLayoutScope(
      useContentPadding: useContentPadding,
      child: Builder(
        builder: (innerContext) {
          final bool isDesktop = innerContext.currentMaxColumns >= 12;

          Widget contentLayer;

          if (useSlivers) {
            contentLayer = _buildSliverLayout(innerContext, isDesktop);
          } else {
            contentLayer = _buildBoxLayout(innerContext, isDesktop);
          }

          if (enableSafeArea.left ||
              enableSafeArea.top ||
              enableSafeArea.right ||
              enableSafeArea.bottom) {
            contentLayer = SafeArea(
              left: enableSafeArea.left,
              top: enableSafeArea.top,
              right: enableSafeArea.right,
              bottom: enableSafeArea.bottom,
              child: contentLayer,
            );
          }

          final scaffold = Scaffold(
            backgroundColor: backgroundColor,
            body: contentLayer,
            bottomNavigationBar: bottomNavigationBar,
            bottomSheet: bottomSheet,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
          );

          if (!showGridOverlay) return scaffold;

          return Stack(
            children: [
              scaffold,
              Positioned.fill(
                child: IgnorePointer(
                  child: SafeArea(
                    left: enableSafeArea.left,
                    top: enableSafeArea.top,
                    right: enableSafeArea.right,
                    bottom: enableSafeArea.bottom,
                    child: Padding(
                      // Ensure Overlay padding matches the content padding
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            useContentPadding ? innerContext.pageMargin : 0.0,
                      ),
                      child: GridDebugOverlay(
                        visible: true,
                        useMargins: false,
                        child: Container(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // Layout Strategy A: Sliver Mode
  // ===========================================================================
  Widget _buildSliverLayout(BuildContext context, bool isDesktop) {
    List<Widget> slivers = [];

    if (header != null) {
      slivers.add(header!);
    }

    // 1. Start with the raw child (No padding yet)
    Widget contentBlock = child;

    // 2. Combine with Menu if Desktop (Structure first)
    // Structure: [Menu] [Gutter] [Content]
    if (isDesktop && sideMenu != null) {
      contentBlock = _buildDesktopRow(context, contentBlock);
    }

    // 3. Apply Padding to the WHOLE structure
    // This ensures Menu is also pushed by the page margin
    if (useContentPadding) {
      contentBlock = Padding(
        padding: EdgeInsets.symmetric(horizontal: context.pageMargin),
        child: contentBlock,
      );
    }

    if (padding != null) {
      contentBlock = Padding(padding: padding!, child: contentBlock);
    }

    slivers.add(SliverToBoxAdapter(child: contentBlock));

    Widget scrollView = CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: slivers,
    );

    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh!, child: scrollView);
    }

    return scrollView;
  }

  // ===========================================================================
  // Layout Strategy B: Box Mode
  // ===========================================================================
  Widget _buildBoxLayout(BuildContext context, bool isDesktop) {
    // 1. Prepare Scrollable Content (Right Side)
    Widget mainContent = child;

    // Note: In Box Mode, we do NOT apply padding to 'mainContent' immediately
    // because we want the padding to wrap the Menu+Content group later.

    if (scrollable) {
      mainContent = SingleChildScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height,
          ),
          child: mainContent,
        ),
      );
    }

    if (onRefresh != null) {
      mainContent = RefreshIndicator(onRefresh: onRefresh!, child: mainContent);
    }

    // 2. Compose Menu + Content
    Widget finalBody;
    if (isDesktop && sideMenu != null) {
      finalBody = _buildDesktopRow(context, mainContent);
    } else {
      finalBody = mainContent;
    }

    // 3. Apply Padding to the Final Body (Menu + Content)
    // This moves the Menu inwards, respecting the Grid Margin
    if (useContentPadding) {
      finalBody = Padding(
        padding: EdgeInsets.symmetric(horizontal: context.pageMargin),
        child: finalBody,
      );
    }

    // Apply additional padding
    if (padding != null) {
      finalBody = Padding(padding: padding!, child: finalBody);
    }

    // 4. Add Header
    if (header != null) {
      return Column(
        children: [
          header!,
          Expanded(child: finalBody),
        ],
      );
    }

    return finalBody;
  }

  //Helper: Desktop Row Builder
  Widget _buildDesktopRow(BuildContext context, Widget contentWidget) {
    final double menuWidth = context.colWidth(4);
    final double gutter = context.currentGutter;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: menuWidth,
          child: sideMenu,
        ),
        SizedBox(width: gutter),
        Expanded(
          child: contentWidget,
        ),
      ],
    );
  }
}
