import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_item.dart';
import 'layout_extensions.dart';
import 'grid_debug_overlay.dart';
import 'models/page_app_bar_config.dart';
import 'models/page_bottom_bar_config.dart';
import 'models/page_menu_config.dart';
import 'models/page_menu_view.dart';
import 'widgets/page_sidebar.dart';
import 'renderers/menu_position_renderer.dart';
import '../atoms/typography/app_text.dart';
import '../atoms/surfaces/app_surface.dart';
import '../atoms/icons/app_icon.dart';
import '../molecules/buttons/app_button.dart';
import '../molecules/buttons/app_icon_button.dart';
import '../organisms/app_bar/app_unified_bar.dart';
import '../atoms/layout/app_gap.dart';
import '../foundation/theme/design_system/app_design_theme.dart';
import '../foundation/theme/tokens/app_spacing.dart';
import '../organisms/expandable_fab/app_expandable_fab.dart';
import '../molecules/menu/app_popup_menu.dart';
import '../molecules/menu/app_popup_menu_item.dart';

/// Type definition for constraint-aware child builder
typedef PageChildBuilder = Widget Function(BuildContext context, BoxConstraints constraints);

/// A standardized page container integrating a responsive Grid System,
/// Desktop Side Menu, and dual Sliver/Box layout modes.
class AppPageView extends StatelessWidget {
  /// The main content of the page (static widget).
  /// Use this for simple content that doesn't need layout constraints.
  final Widget? child;

  /// Builder for constraint-aware content.
  /// Use this when content needs to adapt to available space.
  /// Takes priority over [child] when both are provided.
  final PageChildBuilder? childBuilder;

  /// Page Header.
  final Widget? header;

  /// Configuration for the app bar
  final PageAppBarConfig? appBarConfig;

  /// Configuration for the bottom action bar
  final PageBottomBarConfig? bottomBarConfig;

  /// Custom bottom bar widget (takes priority over bottomBarConfig)
  final Widget? customBottomBar;

  /// Configuration for the responsive menu system
  final PageMenuConfig? menuConfig;

  /// Position of the menu for responsive layout
  final MenuPosition menuPosition;

  /// Optional custom menu view panel configuration
  /// Displayed in sidebar (Desktop) or via BottomSheet trigger (Mobile)
  final PageMenuView? menuView;

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

  // --- Tab navigation properties ---
  /// List of tabs for tabbed navigation
  final List<Tab>? tabs;

  /// List of tab content widgets corresponding to the tabs
  final List<Widget>? tabViews;

  /// Controller for the tab navigation
  final TabController? tabController;

  /// Whether to show tab bar indicator
  final bool showTabIndicator;

  /// Tab bar indicator color
  final Color? tabIndicatorColor;

  /// Tab bar text style
  final TextStyle? tabTextStyle;

  /// Tab bar selected text style
  final TextStyle? selectedTabTextStyle;

  // --- Scaffold related properties ---
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;

  // --- Custom slivers ---
  /// Custom slivers for advanced sliver-based layouts.
  /// When provided, these replace the default content wrapping.
  final List<Widget>? slivers;

  const AppPageView({
    super.key,
    this.child,
    this.childBuilder,
    this.header,
    this.appBarConfig,
    this.bottomBarConfig,
    this.customBottomBar,
    this.menuConfig,
    this.menuPosition = MenuPosition.left,
    this.menuView,
    this.useSlivers = true,
    this.backgroundColor,
    this.scrollable = true,
    this.scrollController,
    this.onRefresh,
    this.padding,
    this.useContentPadding = true,
    this.showGridOverlay = false,
    this.enableSafeArea = (left: true, top: true, right: true, bottom: true),
    this.tabs,
    this.tabViews,
    this.tabController,
    this.showTabIndicator = true,
    this.tabIndicatorColor,
    this.tabTextStyle,
    this.selectedTabTextStyle,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.slivers,
  }) : assert(
         child != null || childBuilder != null || (tabs != null && tabViews != null) || slivers != null,
         'Either child, childBuilder, tabs with tabViews, or slivers must be provided',
       );

  /// T044: Basic page factory constructor with minimal configuration
  ///
  /// Creates a simple page with just a title and content, perfect for quickstart examples.
  ///
  /// Example:
  /// ```dart
  /// AppPageView.basic(
  ///   title: 'Settings',
  ///   child: SettingsForm(),
  /// )
  /// ```
  factory AppPageView.basic({
    Key? key,
    required String title,
    required Widget child,
    bool scrollable = true,
    bool showBackButton = false,
  }) {
    return AppPageView(
      key: key,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
      ),
      child: child,
    );
  }

  /// T045: Page with bottom bar factory constructor
  ///
  /// Creates a page with action buttons at the bottom, ideal for forms and confirmations.
  ///
  /// Example:
  /// ```dart
  /// AppPageView.withBottomBar(
  ///   title: 'Edit Profile',
  ///   child: ProfileForm(),
  ///   positiveLabel: 'Save',
  ///   onPositiveTap: () => _saveProfile(),
  ///   negativeLabel: 'Cancel',
  ///   onNegativeTap: () => Navigator.pop(context),
  /// )
  /// ```
  factory AppPageView.withBottomBar({
    Key? key,
    required String title,
    required Widget child,
    bool scrollable = true,
    bool showBackButton = true,
    required String positiveLabel,
    required VoidCallback onPositiveTap,
    String? negativeLabel,
    VoidCallback? onNegativeTap,
    bool isPositiveEnabled = true,
    bool isNegativeEnabled = true,
    bool isDestructive = false,
  }) {
    return AppPageView(
      key: key,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
      ),
      bottomBarConfig: PageBottomBarConfig(
        positiveLabel: positiveLabel,
        negativeLabel: negativeLabel,
        onPositiveTap: onPositiveTap,
        onNegativeTap: onNegativeTap,
        isPositiveEnabled: isPositiveEnabled,
        isNegativeEnabled: isNegativeEnabled,
        isDestructive: isDestructive,
      ),
      child: child,
    );
  }

  /// T046: Page with responsive menu factory constructor
  ///
  /// Creates a page with a responsive navigation menu that adapts to desktop/mobile.
  ///
  /// Example:
  /// ```dart
  /// AppPageView.withMenu(
  ///   title: 'Dashboard',
  ///   child: DashboardContent(),
  ///   menuTitle: 'Navigation',
  ///   menuItems: [
  ///     PageMenuItem.navigation(
  ///       label: 'Overview',
  ///       icon: Icons.dashboard,
  ///       onTap: () => _navigateToOverview(),
  ///     ),
  ///     PageMenuItem.navigation(
  ///       label: 'Settings',
  ///       icon: Icons.settings,
  ///       onTap: () => _navigateToSettings(),
  ///     ),
  ///   ],
  /// )
  /// ```
  factory AppPageView.withMenu({
    Key? key,
    required String title,
    required Widget child,
    bool scrollable = true,
    bool showBackButton = false,
    required String menuTitle,
    required List<PageMenuItem> menuItems,
    bool largeMenu = false,
    IconData? menuIcon,
    PageMenuView? menuView,
    MenuPosition menuPosition = MenuPosition.left,
  }) {
    return AppPageView(
      key: key,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
      ),
      menuView: menuView,
      menuConfig: PageMenuConfig(
        title: menuTitle,
        items: menuItems,
        largeMenu: largeMenu,
        icon: menuIcon,
      ),
      menuPosition: menuPosition,
      child: child,
    );
  }

  /// T047: Page with tabs factory constructor
  ///
  /// Creates a page with tabbed navigation for organizing related content.
  ///
  /// Example:
  /// ```dart
  /// AppPageView.withTabs(
  ///   title: 'Settings',
  ///   tabs: [
  ///     Tab(text: 'General'),
  ///     Tab(text: 'Privacy'),
  ///     Tab(text: 'Advanced'),
  ///   ],
  ///   tabViews: [
  ///     GeneralSettings(),
  ///     PrivacySettings(),
  ///     AdvancedSettings(),
  ///   ],
  /// )
  /// ```
  factory AppPageView.withTabs({
    Key? key,
    required String title,
    required List<Tab> tabs,
    required List<Widget> tabViews,
    TabController? tabController,
    bool scrollable = true,
    bool showBackButton = false,
    bool showTabIndicator = true,
    Color? tabIndicatorColor,
    TextStyle? tabTextStyle,
    TextStyle? selectedTabTextStyle,
  }) {
    // No dummy child needed - tabs with tabViews satisfies the assert
    return AppPageView(
      key: key,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
      ),
      tabs: tabs,
      tabViews: tabViews,
      tabController: tabController,
      showTabIndicator: showTabIndicator,
      tabIndicatorColor: tabIndicatorColor,
      tabTextStyle: tabTextStyle,
      selectedTabTextStyle: selectedTabTextStyle,
    );
  }

  /// T050: Page with custom slivers factory constructor
  ///
  /// Creates a page optimized for sliver-based layouts with custom scrolling behavior.
  /// Use this when you need fine-grained control over scroll physics or want to
  /// combine multiple slivers (SliverList, SliverGrid, SliverAppBar, etc.)
  ///
  /// Example:
  /// ```dart
  /// AppPageView.withSlivers(
  ///   title: 'Product List',
  ///   slivers: [
  ///     SliverToBoxAdapter(child: HeaderWidget()),
  ///     SliverList(delegate: SliverChildListDelegate(products)),
  ///     SliverGrid(delegate: ..., gridDelegate: ...),
  ///   ],
  /// )
  /// ```
  factory AppPageView.withSlivers({
    Key? key,
    required String title,
    required List<Widget> slivers,
    bool showBackButton = false,
    PageMenuConfig? menuConfig,
    MenuPosition menuPosition = MenuPosition.none,
    PageMenuView? menuView,
    PageBottomBarConfig? bottomBarConfig,
  }) {
    return AppPageView(
      key: key,
      useSlivers: true,
      scrollable: true,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
      ),
      menuConfig: menuConfig,
      menuPosition: menuPosition,
      menuView: menuView,
      bottomBarConfig: bottomBarConfig,
      slivers: slivers,
      child: const SizedBox.shrink(), // Placeholder - slivers override content
    );
  }

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

          // In Box mode with header, AppBar should be below header
          // So we don't use Scaffold.appBar when header is present
          final bool useScaffoldAppBar = !useSlivers && header == null;

          final scaffold = Scaffold(
            backgroundColor: backgroundColor,
            appBar: useScaffoldAppBar
                ? _buildAppBar(context)
                : null, // Only use Scaffold.appBar when no header in Box mode
            body: contentLayer,
            bottomNavigationBar:
                _buildBottomBar(context) ?? bottomNavigationBar,
            bottomSheet: bottomSheet,
            floatingActionButton: _buildFAB(context),
            floatingActionButtonLocation: menuConfig?.fabLocation,
          );

          if (!showGridOverlay) return AppExpandableFabScope(child: scaffold);

          return AppExpandableFabScope(
            child: Stack(
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
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // Enhanced Configuration Helpers
  // ===========================================================================

  /// Build the main content widget using typed parameters
  /// Priority: tabs > childBuilder > child
  Widget _buildContentWidget(BuildContext context) {
    // Priority 1: Check if we have custom slivers
    // Note: slivers are handled separately in _buildSliverBody
    if (slivers != null && slivers!.isNotEmpty) {
      // When using custom slivers, return empty - slivers handled in body builder
      return const SizedBox.shrink();
    }

    // Priority 2: Check if we have tabs configured
    if (tabs != null && tabs!.isNotEmpty) {
      return _buildTabbedContent(context);
    }

    // Priority 3: Use childBuilder if provided (constraint-aware)
    if (childBuilder != null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return childBuilder!(context, constraints);
        },
      );
    }

    // Priority 4: Use static child widget
    if (child != null) {
      return child!;
    }

    // Fallback (should not reach here due to assert in constructor)
    return const SizedBox.shrink();
  }

  /// Build tabbed content with tab bar and tab views
  /// Uses TabsStyle from AppDesignTheme for Constitution compliance (§4.1, §6.1)
  Widget _buildTabbedContent(BuildContext context) {
    if (tabs == null || tabs!.isEmpty) {
      // Fallback to child content if no tabs
      return child ?? const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final designTheme = AppDesignTheme.of(context);
    final tabsStyle = designTheme.tabsStyle;
    final tabLength = tabs!.length;

    // Build TabBar using TabsStyle for theme-driven styling
    Widget tabBarWidget = TabBar(
      controller: tabController,
      tabs: tabs!,
      // Use TabsStyle for Constitution compliance (§4.1 - no hardcoded colors)
      indicatorColor: tabIndicatorColor ?? tabsStyle.indicatorColor,
      labelColor: tabsStyle.textColors.active,
      unselectedLabelColor: tabsStyle.textColors.inactive,
      labelStyle: selectedTabTextStyle ?? theme.textTheme.labelLarge,
      unselectedLabelStyle: tabTextStyle ?? theme.textTheme.labelMedium,
      indicatorWeight: showTabIndicator ? tabsStyle.indicatorThickness : 0.0,
    );

    Widget tabBarViewWidget;
    if (tabViews != null && tabViews!.isNotEmpty) {
      // Use provided tab views
      final validTabViews = tabViews!.take(tabLength).toList();
      // Fill any missing tab views with empty containers
      while (validTabViews.length < tabLength) {
        validTabViews.add(const SizedBox.shrink());
      }

      tabBarViewWidget = TabBarView(
        controller: tabController,
        children: validTabViews,
      );
    } else {
      // Fallback: Generate tab views from child/childBuilder
      tabBarViewWidget = TabBarView(
        controller: tabController,
        children: List.generate(
          tabLength,
          (index) {
            if (childBuilder != null) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return childBuilder!(context, constraints);
                },
              );
            }
            return child ?? const SizedBox.shrink();
          },
        ),
      );
    }

    // Return tab structure using AppSurface for Constitution compliance (§6.1)
    // Use LayoutBuilder to get bounded height for TabBarView compatibility
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate available height for tab content
        // Subtract estimated tab bar height (48) from total constraints
        const double tabBarHeight = 48.0;
        final double tabContentHeight = constraints.maxHeight.isFinite
            ? (constraints.maxHeight - tabBarHeight).clamp(200.0, double.infinity)
            : 400.0; // Fallback for unbounded (sliver) contexts

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tab bar - Use AppSurface instead of Material (§6.1)
            AppSurface(
              variant: SurfaceVariant.elevated,
              child: tabBarWidget,
            ),
            // Tab content - Use calculated height for sliver compatibility
            SizedBox(
              height: tabContentHeight,
              child: tabBarViewWidget,
            ),
          ],
        );
      },
    );
  }

  /// Build app bar from configuration using Renderer Pattern
  /// Constitution Compliance: §3.2 (Data-Driven Strategy with Renderer Pattern)
  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (appBarConfig == null && menuConfig == null) return null;

    final bool isDesktop = context.isDesktop;
    final renderer = MenuPositionRenderer.forPosition(menuPosition);

    // Create context for renderer
    final menuContext = MenuPositionContext(
      menuConfig: menuConfig,
      menuView: menuView,
      position: menuPosition,
      isDesktop: isDesktop,
    );

    // Check if sidebar mode - on desktop with sidebar, only show AppBar if appBarConfig exists
    final bool isSidebarMode =
        menuPosition == MenuPosition.left || menuPosition == MenuPosition.right;
    if (isDesktop && isSidebarMode && appBarConfig == null) {
      return null; // No AppBar needed - items are in sidebar
    }

    // Build actions using renderer
    final actions = renderer.buildAppBarActions(
      menuContext,
      // Icon action builder
      (item) => AppIconButton.icon(
        icon: AppIcon.font(item.icon ?? Icons.circle),
        tooltip: item.label,
        onTap: item.onTap,
      ),
      // Popup menu builder
      (items) => AppPopupMenu<String>(
        icon: menuConfig?.icon ?? Icons.more_vert,
        items: items
            .map((item) => AppPopupMenuItem<String>(
                  value: item.label,
                  label: item.label,
                  icon: item.icon,
                  enabled: item.enabled,
                ))
            .toList(),
        onSelected: (value) {
          final selectedItem = items.firstWhere((item) => item.label == value);
          if (selectedItem.enabled && selectedItem.onTap != null) {
            selectedItem.onTap!();
          }
        },
      ),
      // MenuView trigger builder
      (view) => AppIconButton.icon(
        icon: AppIcon.font(view.icon),
        tooltip: view.label,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (c) => view.content,
          );
        },
      ),
    );

    // Build app bar
    if (appBarConfig != null) {
      final config = appBarConfig!;
      return AppUnifiedBar(
        title: config.title ?? '',
        titleWidget: config.title != null ? AppText(config.title!) : null,
        automaticallyImplyLeading: config.showBackButton,
        actions: actions.isNotEmpty ? actions : null,
        centerTitle: false,
      );
    } else if (menuContext.hasItems && !isDesktop) {
      // Simple app bar with just menu action (mobile)
      return AppUnifiedBar(
        title: menuConfig!.title ?? '',
        titleWidget:
            menuConfig!.title != null ? AppText(menuConfig!.title!) : null,
        actions: actions,
        centerTitle: false,
      );
    }

    return null;
  }

  /// Build bottom action bar from configuration with priority logic
  /// Priority: customBottomBar > bottomBarConfig
  /// Uses AppSpacing tokens for Constitution compliance (§3.3)
  Widget? _buildBottomBar(BuildContext context) {
    // Priority 1: Custom bottom bar widget
    if (customBottomBar != null) return customBottomBar;

    // Priority 2: Structured configuration
    if (bottomBarConfig == null) return null;

    final config = bottomBarConfig!;

    return AppSurface(
      variant: SurfaceVariant.base,
      // Use AppSpacing.lg (16) instead of hardcoded value (§3.3)
      padding: const EdgeInsets.all(AppSpacing.lg),
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

    // 1. Add header first (appears above AppBar)
    if (header != null) {
      slivers.add(header!);
    }

    // 2. Add AppBar as SliverAppBar if present
    final appBar = _buildAppBar(context);
    if (appBar != null) {
      slivers.add(SliverAppBar(
        toolbarHeight: appBar.preferredSize.height,
        pinned: false,
        floating: false,
        flexibleSpace: appBar,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 0,
      ));
    }

    // 3. Start with the provided content widget (No padding yet)
    Widget contentBlock = contentWidget;

    // 4. Combine with Menu if Desktop (Structure first)
    // Structure: [Menu] [Gutter] [Content]
    // Show sidebar when:
    // - Scenario A: position left/right with items
    // - Scenario B: position left/right with menuView (no items)
    // - Scenario C+fab: position fab with menuView
    final bool shouldShowSidebar = isDesktop &&
        ((menuConfig != null &&
                menuConfig!.hasItems &&
                (menuPosition == MenuPosition.left ||
                    menuPosition == MenuPosition.right)) ||
            (menuView != null &&
                (menuPosition == MenuPosition.left ||
                    menuPosition == MenuPosition.right ||
                    menuPosition == MenuPosition.fab)));
    if (shouldShowSidebar) {
      contentBlock = _buildDesktopMenuLayout(context, contentBlock);
    }

    // 5. Apply Padding to the WHOLE structure
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

    // Check if using custom slivers (from withSlivers factory)
    if (this.slivers != null && this.slivers!.isNotEmpty) {
      // Use custom slivers directly instead of wrapping contentBlock
      slivers.addAll(this.slivers!);
    } else {
      slivers.add(SliverToBoxAdapter(child: contentBlock));
    }

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
    // Show sidebar when:
    // - Scenario A: position left/right with items
    // - Scenario B: position left/right with menuView (no items)
    // - Scenario C+fab: position fab with menuView
    final bool shouldShowSidebar = isDesktop &&
        ((menuConfig != null &&
                menuConfig!.hasItems &&
                (menuPosition == MenuPosition.left ||
                    menuPosition == MenuPosition.right)) ||
            (menuView != null &&
                (menuPosition == MenuPosition.left ||
                    menuPosition == MenuPosition.right ||
                    menuPosition == MenuPosition.fab)));
    if (shouldShowSidebar) {
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

    // 4. Add Header and AppBar (when header is present)
    // Structure: Header → AppBar → Content
    if (header != null) {
      final appBar = _buildAppBar(context);
      return Column(
        children: [
          header!,
          if (appBar != null)
            SizedBox(
              height: appBar.preferredSize.height,
              child: appBar,
            ),
          Expanded(child: finalBody),
        ],
      );
    }

    return finalBody;
  }

  /// Helper: Desktop Menu Layout using extracted PageSidebar widget
  /// Constitution Compliance: §6.3 (Composition over Inheritance)
  Widget _buildDesktopMenuLayout(BuildContext context, Widget contentWidget) {
    return PageSidebar(
      menuConfig: menuConfig,
      menuView: menuView,
      content: contentWidget,
      position: menuPosition,
    );
  }

  // ===========================================================================
  // FAB Configuration Helpers
  // ===========================================================================

  /// Build the floating action button from configuration
  Widget? _buildFAB(BuildContext context) {
    // Unified FAB Logic: Derived from MenuConfig
    // 1. Check if we should render FAB based on position
    if (menuPosition == MenuPosition.fab) {
      if (menuConfig == null && menuView == null) return null;

      final bool isDesktop = context.isDesktop;
      // On Desktop with menuView: menuView is in sidebar, items go to FAB
      // On Mobile with menuView: show items + menuView as expandable FAB items
      final bool menuViewInSidebar = isDesktop && menuView != null;

      // Default icon for FAB (don't use menuView.icon on Mobile)
      final triggerIcon = menuConfig?.icon ?? Icons.menu;

      final theme = Theme.of(context).extension<AppDesignTheme>();

      // Build FAB children list
      List<Widget> fabChildren = [];

      // Add menu items as FAB children
      if (menuConfig != null && menuConfig!.hasItems) {
        final items = menuConfig!.menuItems;
        for (final item in items) {
          fabChildren.add(
            FloatingActionButton.small(
              heroTag: null,
              onPressed: item.enabled ? item.onTap : null,
              tooltip: item.label,
              backgroundColor: theme?.surfaceSecondary.backgroundColor,
              foregroundColor: theme?.surfaceSecondary.contentColor,
              child: item.icon != null ? Icon(item.icon) : null,
            ),
          );
        }
      }

      // Add menuView as a FAB child (on mobile only, desktop has sidebar)
      if (menuView != null && !menuViewInSidebar) {
        fabChildren.add(
          FloatingActionButton.small(
            heroTag: null,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (c) => menuView!.content,
              );
            },
            tooltip: menuView!.label,
            backgroundColor: theme?.surfaceSecondary.backgroundColor,
            foregroundColor: theme?.surfaceSecondary.contentColor,
            child: Icon(menuView!.icon),
          ),
        );
      }

      // Render based on children count
      if (fabChildren.length > 1) {
        // Multiple items → AppExpandableFab
        return AppExpandableFab(
          icon: Icon(triggerIcon),
          activeIcon: const Icon(Icons.close),
          children: fabChildren,
        );
      } else if (fabChildren.length == 1) {
        // Single item → Standard FAB (execute first item's action)
        final singleChild = fabChildren.first as FloatingActionButton;
        return FloatingActionButton(
          elevation: 0,
          backgroundColor: theme?.surfaceHighlight.backgroundColor,
          foregroundColor: theme?.surfaceHighlight.contentColor,
          shape: const CircleBorder(),
          onPressed: singleChild.onPressed,
          child: singleChild.child,
        );
      }

      return null;
    }

    return null;
  }
}
