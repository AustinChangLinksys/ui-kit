import 'package:flutter/material.dart';
import 'layout_extensions.dart'; // Ensure correct path
import 'grid_debug_overlay.dart'; // Ensure correct path
import 'models/page_app_bar_config.dart';
import 'models/page_bottom_bar_config.dart';
import 'models/page_menu_config.dart';
import '../atoms/typography/app_text.dart';
import '../molecules/layout/app_list_tile.dart';
import '../molecules/buttons/app_button.dart';
import '../atoms/surfaces/app_surface.dart';
import '../molecules/bottom_sheet/app_bottom_sheet.dart';
import '../molecules/cards/app_card.dart';
import '../atoms/icons/app_icon.dart';
import '../molecules/buttons/app_icon_button.dart';
import '../atoms/layout/app_divider.dart';
import '../organisms/app_bar/app_unified_bar.dart';
import '../atoms/layout/app_gap.dart';

/// A standardized page container integrating a responsive Grid System,
/// Desktop Side Menu, and dual Sliver/Box layout modes.
class AppPageView extends StatelessWidget {
  /// The main content of the page.
  /// Can be either a Widget or a function that takes (BuildContext, BoxConstraints).
  final dynamic child;

  /// Page Header.
  final Widget? header;

  /// Side Menu (Desktop Only) - legacy support.
  final Widget? sideMenu;

  /// Configuration for the app bar
  final PageAppBarConfig? appBarConfig;

  /// Configuration for the bottom action bar
  final PageBottomBarConfig? bottomBarConfig;

  /// Configuration for the responsive menu system
  final PageMenuConfig? menuConfig;

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
    this.appBarConfig,
    this.bottomBarConfig,
    this.menuConfig,
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

          // Build the main content widget
          Widget contentWidget = _buildContentWidget(innerContext);

          Widget contentLayer;

          if (useSlivers) {
            contentLayer =
                _buildSliverLayout(innerContext, isDesktop, contentWidget);
          } else {
            contentLayer =
                _buildBoxLayout(innerContext, isDesktop, contentWidget);
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
            appBar: _buildAppBar(context),
            body: contentLayer,
            bottomNavigationBar:
                _buildBottomBar(context) ?? bottomNavigationBar,
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
  // Enhanced Configuration Helpers
  // ===========================================================================

  /// Build the main content widget, handling both Widget and function types
  Widget _buildContentWidget(BuildContext context) {
    if (child is Function) {
      // If child is a function, call it with context and constraints
      return LayoutBuilder(
        builder: (context, constraints) {
          return (child as Widget Function(BuildContext, BoxConstraints))(
            context,
            constraints,
          );
        },
      );
    } else {
      // If child is a Widget, return it directly
      return child as Widget;
    }
  }

  /// Build app bar from configuration (based on PrivacyGUI pattern)
  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (appBarConfig == null && menuConfig == null) return null;

    final bool isDesktop = context.isDesktop;
    final bool hasMobileMenu = menuConfig != null &&
        menuConfig!.shouldShowOnPlatform(isDesktop: false) &&
        menuConfig!.hasItems;

    // Build actions list
    List<Widget> actions = [];

    // Add original actions from appBarConfig
    if (appBarConfig?.actions != null) {
      actions.addAll(appBarConfig!.actions!);
    }

    // Add mobile menu action if needed (not on desktop and has mobile menu)
    if (!isDesktop && hasMobileMenu) {
      actions.add(
        AppIconButton.secondary(
          icon: AppIcon.font(menuConfig!.mobileMenuIcon ?? Icons.more_vert),
          onTap: () => _showMobileMenu(context),
        ),
      );
    }

    // Build app bar
    if (appBarConfig != null) {
      final config = appBarConfig!;
      return AppUnifiedBar(
        title: config.title ?? '',
        titleWidget: config.title != null ? AppText(config.title!) : null,
        automaticallyImplyLeading: config.showBackButton,
        actions: actions.isNotEmpty ? actions : null,
        // Note: AppUnifiedBar doesn't support toolbarHeight and sliver mode directly
        // This is a limitation that may need future enhancement
      );
    } else if (hasMobileMenu && !isDesktop) {
      // Simple app bar with just menu action
      return AppUnifiedBar(
        title: menuConfig!.title ?? '',
        titleWidget:
            menuConfig!.title != null ? AppText(menuConfig!.title!) : null,
        actions: actions,
      );
    }

    return null;
  }

  /// Show mobile menu as bottom sheet (based on PrivacyGUI pattern)
  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AppBottomSheet(
        padding: const EdgeInsets.all(24),
        displayMode: BottomSheetDisplayMode.intrinsic,
        child: _buildMenuContent(context),
      ),
    );
  }

  /// Build bottom action bar from configuration
  Widget? _buildBottomBar(BuildContext context) {
    if (bottomBarConfig == null) return null;

    final config = bottomBarConfig!;

    return AppSurface(
      variant: SurfaceVariant.base,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (config.negativeLabel != null)
            Expanded(
              child: AppButton.secondary(
                onTap: (config.isNegativeEnabled ?? true)
                    ? config.onNegativeTap
                    : null,
                label: config.negativeLabel!,
              ),
            ),
          if (config.negativeLabel != null && config.positiveLabel != null)
            AppGap.lg(),
          if (config.positiveLabel != null)
            Expanded(
              child: AppButton.primary(
                onTap: config.isPositiveEnabled ? config.onPositiveTap : null,
                label: config.positiveLabel!,
              ),
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // Layout Strategy A: Sliver Mode
  // ===========================================================================
  Widget _buildSliverLayout(
      BuildContext context, bool isDesktop, Widget contentWidget) {
    List<Widget> slivers = [];

    if (header != null) {
      slivers.add(header!);
    }

    // 1. Start with the provided content widget (No padding yet)
    Widget contentBlock = contentWidget;

    // 2. Combine with Menu if Desktop (Structure first)
    // Structure: [Menu] [Gutter] [Content]
    if (isDesktop &&
        menuConfig != null &&
        menuConfig!.shouldShowOnPlatform(isDesktop: true) &&
        menuConfig!.hasItems) {
      contentBlock = _buildDesktopMenuLayout(context, contentBlock);
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
  Widget _buildBoxLayout(
      BuildContext context, bool isDesktop, Widget contentWidget) {
    // 1. Prepare Scrollable Content (Right Side)
    Widget mainContent = contentWidget;

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
    if (isDesktop &&
        menuConfig != null &&
        menuConfig!.shouldShowOnPlatform(isDesktop: true) &&
        menuConfig!.hasItems) {
      finalBody = _buildDesktopMenuLayout(context, mainContent);
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

  // Helper: Desktop Menu Layout (based on PrivacyGUI StyledPageView)
  Widget _buildDesktopMenuLayout(BuildContext context, Widget contentWidget) {
    // Calculate menu width without page margins since they're applied at the parent level
    final int menuColumn = menuConfig!.largeMenu ? 4 : 3;
    final double menuWidth =
        context.colWidth(menuColumn, useMargins: false); // Standard menu: 3 columns
    final double gutter = context.currentGutter;


    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Menu Card Container
        SizedBox(
          width: menuWidth,
          child: AppCard(
            child: _buildMenuContent(context),
          ),
        ),
        AppGap.gutter(),
        // Main Content (remaining columns)
        Expanded(
          child: contentWidget,
        ),
      ],
    );
  }

  // Helper: Build Menu Content (shared between Desktop and Mobile)
  Widget _buildMenuContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Menu Title (if provided)
        if (menuConfig!.title != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppText.titleLarge(menuConfig!.title!),
          ),

        // Menu Items
        ...menuConfig!.items.map((item) {
          if (item.isDivider) {
            return const AppDivider();
          }

          return AppListTile(
            leading: item.icon != null ? AppIcon.font(item.icon!) : null,
            title: AppText(item.label),
            selected: item.isSelected,
            onTap: item.enabled ? item.onTap : null,
          );
        }),
      ],
    );
  }
}
