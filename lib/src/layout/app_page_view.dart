import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_item.dart';
import 'layout_extensions.dart'; // Ensure correct path
import 'grid_debug_overlay.dart'; // Ensure correct path
import 'models/page_app_bar_config.dart';
import 'models/page_bottom_bar_config.dart';
import 'models/page_menu_config.dart';
import 'models/page_fab_config.dart';
import '../atoms/typography/app_text.dart';
import '../molecules/layout/app_list_tile.dart';
import '../molecules/buttons/app_button.dart';
import '../atoms/surfaces/app_surface.dart';
import '../molecules/cards/app_card.dart';
import '../atoms/icons/app_icon.dart';
import '../molecules/buttons/app_icon_button.dart';
import '../atoms/layout/app_divider.dart';
import '../organisms/app_bar/app_unified_bar.dart';
import '../atoms/layout/app_gap.dart';
import '../organisms/expandable_fab/app_expandable_fab.dart';

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

  /// Custom bottom bar widget (takes priority over bottomBarConfig)
  final Widget? customBottomBar;

  /// Configuration for the responsive menu system
  final PageMenuConfig? menuConfig;

  /// Position of the menu for responsive layout
  final MenuPosition menuPosition;

  /// Configuration for the floating action button
  final PageFabConfig? fabConfig;

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
    this.customBottomBar,
    this.menuConfig,
    this.menuPosition = MenuPosition.left,
    this.fabConfig,
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
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
  });

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
    required dynamic child,
    bool scrollable = true,
    bool showBackButton = false,
    List<Widget>? actions,
  }) {
    return AppPageView(
      key: key,
      child: child,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
        actions: actions,
      ),
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
    required dynamic child,
    bool scrollable = true,
    bool showBackButton = true,
    List<Widget>? actions,
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
      child: child,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
        actions: actions,
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
    required dynamic child,
    bool scrollable = true,
    bool showBackButton = false,
    List<Widget>? actions,
    required String menuTitle,
    required List<PageMenuItem> menuItems,
    bool largeMenu = false,
    bool showOnDesktop = true,
    bool showOnMobile = true,
    IconData? mobileMenuIcon,
    MenuPosition menuPosition = MenuPosition.left,
  }) {
    return AppPageView(
      key: key,
      child: child,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
        actions: actions,
      ),
      menuConfig: PageMenuConfig(
        title: menuTitle,
        items: menuItems,
        largeMenu: largeMenu,
        showOnDesktop: showOnDesktop,
        showOnMobile: showOnMobile,
        mobileMenuIcon: mobileMenuIcon,
      ),
      menuPosition: menuPosition,
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
    List<Widget>? actions,
    bool showTabIndicator = true,
    Color? tabIndicatorColor,
    TextStyle? tabTextStyle,
    TextStyle? selectedTabTextStyle,
  }) {
    // Create a dummy child since tabs will override the content
    const dummyChild = SizedBox.shrink();

    return AppPageView(
      key: key,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
        actions: actions,
      ),
      tabs: tabs,
      tabViews: tabViews,
      tabController: tabController,
      showTabIndicator: showTabIndicator,
      tabIndicatorColor: tabIndicatorColor,
      tabTextStyle: tabTextStyle,
      selectedTabTextStyle: selectedTabTextStyle,
      child: dummyChild,
    );
  }

  /// T048: Page with expandable FAB factory constructor
  ///
  /// Creates a page with an expandable floating action button that reveals satellite actions.
  ///
  /// Example:
  /// ```dart
  /// AppPageView.withExpandableFAB(
  ///   title: 'Actions',
  ///   child: MyContent(),
  ///   fabActions: [
  ///     FloatingActionButton(
  ///       heroTag: "edit",
  ///       onPressed: () => _editItem(),
  ///       child: const Icon(Icons.edit),
  ///     ),
  ///     FloatingActionButton(
  ///       heroTag: "delete",
  ///       onPressed: () => _deleteItem(),
  ///       child: const Icon(Icons.delete),
  ///     ),
  ///   ],
  /// )
  /// ```
  factory AppPageView.withExpandableFAB({
    Key? key,
    required String title,
    required dynamic child,
    required List<Widget> fabActions,
    bool scrollable = true,
    bool showBackButton = false,
    List<Widget>? actions,
    IconData? fabIcon,
    IconData? fabActiveIcon,
    bool fabInitiallyOpen = false,
    VoidCallback? onFABToggle,
    FloatingActionButtonLocation? fabLocation,
  }) {
    return AppPageView(
      key: key,
      child: child,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
        actions: actions,
      ),
      fabConfig: PageFabConfig.expandable(
        children: fabActions,
        icon: fabIcon,
        activeIcon: fabActiveIcon,
        initiallyOpen: fabInitiallyOpen,
        onToggle: onFABToggle,
        location: fabLocation,
      ),
    );
  }

  /// T049: Page with standard FAB factory constructor
  ///
  /// Creates a page with a standard floating action button for a single primary action.
  ///
  /// Example:
  /// ```dart
  /// AppPageView.withFAB(
  ///   title: 'Add Item',
  ///   child: MyContent(),
  ///   fabIcon: Icons.add,
  ///   onFABPressed: () => _addItem(),
  /// )
  /// ```
  factory AppPageView.withFAB({
    Key? key,
    required String title,
    required dynamic child,
    required IconData fabIcon,
    required VoidCallback onFABPressed,
    bool scrollable = true,
    bool showBackButton = false,
    List<Widget>? actions,
    String? fabTooltip,
    FloatingActionButtonLocation? fabLocation,
    bool mini = false,
  }) {
    return AppPageView(
      key: key,
      child: child,
      scrollable: scrollable,
      appBarConfig: PageAppBarConfig(
        title: title,
        showBackButton: showBackButton,
        actions: actions,
      ),
      fabConfig: mini
          ? PageFabConfig.mini(
              icon: fabIcon,
              onPressed: onFABPressed,
              tooltip: fabTooltip,
              location: fabLocation,
            )
          : PageFabConfig.standard(
              icon: fabIcon,
              onPressed: onFABPressed,
              tooltip: fabTooltip,
              location: fabLocation,
            ),
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

          final scaffold = Scaffold(
            backgroundColor: backgroundColor,
            appBar: useSlivers ? null : _buildAppBar(context), // Only use AppBar in Box mode
            body: contentLayer,
            bottomNavigationBar:
                _buildBottomBar(context) ?? bottomNavigationBar,
            bottomSheet: bottomSheet,
            floatingActionButton: _buildFAB(context),
            floatingActionButtonLocation: _getFABLocation(),
            floatingActionButtonAnimator: _getFABAnimator(),
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
    // Check if we have tabs configured
    if (tabs != null && tabs!.isNotEmpty) {
      return _buildTabbedContent(context);
    }

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

  /// Build tabbed content with tab bar and tab views
  Widget _buildTabbedContent(BuildContext context) {
    if (tabs == null || tabs!.isEmpty) {
      return child as Widget;
    }

    final theme = Theme.of(context);
    final tabLength = tabs!.length;

    // Use provided controller or create a default one
    // Note: For proper state management, the controller should be provided from parent
    Widget tabBarWidget = TabBar(
      controller: tabController,
      tabs: tabs!,
      indicatorColor: tabIndicatorColor ?? theme.colorScheme.primary,
      labelColor: theme.colorScheme.onSurface,
      unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      labelStyle: selectedTabTextStyle ?? theme.textTheme.labelLarge,
      unselectedLabelStyle: tabTextStyle ?? theme.textTheme.labelMedium,
      indicatorWeight: showTabIndicator ? 2.0 : 0.0,
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
      // Fallback to using the main child for all tabs
      tabBarViewWidget = TabBarView(
        controller: tabController,
        children: List.generate(
          tabLength,
          (index) => child is Function
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return (child as Widget Function(
                        BuildContext, BoxConstraints))(
                      context,
                      constraints,
                    );
                  },
                )
              : child as Widget,
        ),
      );
    }

    // Return tab structure
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tab bar
        Material(
          color: theme.colorScheme.surface,
          elevation: 1.0,
          child: tabBarWidget,
        ),
        // Tab content - Use fixed height instead of Expanded
        SizedBox(
          height: 400, // Fixed height for tab content
          child: tabBarViewWidget,
        ),
      ],
    );
  }

  /// Build app bar from configuration (based on PrivacyGUI pattern)
  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (appBarConfig == null && menuConfig == null) return null;

    final bool isDesktop = context.isDesktop;
    final bool hasMobileMenu = menuConfig != null &&
        menuConfig!.shouldShowOnPlatform(isDesktop: false) &&
        menuConfig!.hasItems;
    final bool hasDesktopAppBarMenu = menuConfig != null &&
        menuConfig!.shouldShowOnPlatform(isDesktop: true) &&
        menuConfig!.hasItems &&
        (menuPosition == MenuPosition.right || menuPosition == MenuPosition.top);

    // Build actions list
    List<Widget> actions = [];

    // Add original actions from appBarConfig
    if (appBarConfig?.actions != null) {
      actions.addAll(appBarConfig!.actions!);
    }

    // Add menu action if needed (mobile menu OR desktop app bar menu)
    if ((!isDesktop && hasMobileMenu) || (isDesktop && hasDesktopAppBarMenu)) {
      final menuItems = menuConfig!.items.where((item) => !item.isDivider).toList();

      if (menuItems.length <= 2) {
        // 2 items or fewer: show directly in actions
        for (final item in menuItems) {
          if (item.enabled) {
            actions.add(
              AppIconButton.secondary(
                icon: AppIcon.font(item.icon ?? Icons.circle),
                tooltip: item.label,
                onTap: item.onTap,
              ),
            );
          }
        }
      } else {
        // 3+ items: show as popup menu
        actions.add(
          PopupMenuButton<String>(
            icon: Icon(menuConfig!.mobileMenuIcon ?? Icons.more_vert),
            itemBuilder: (context) => menuItems
                .map((item) => PopupMenuItem<String>(
                      value: item.label,
                      enabled: item.enabled,
                      child: Row(
                        children: [
                          if (item.icon != null) ...[
                            Icon(item.icon!, size: 20),
                            const SizedBox(width: 12),
                          ],
                          Text(item.label),
                        ],
                      ),
                    ))
                .toList(),
            onSelected: (value) {
              // Find the selected item and execute its callback
              final selectedItem = menuItems
                  .firstWhere((item) => item.label == value);
              if (selectedItem.enabled && selectedItem.onTap != null) {
                selectedItem.onTap!();
              }
            },
          ),
        );
      }
    }

    // Build app bar
    if (appBarConfig != null) {
      final config = appBarConfig!;
      return AppUnifiedBar(
        title: config.title ?? '',
        titleWidget: config.title != null ? AppText(config.title!) : null,
        automaticallyImplyLeading: config.showBackButton,
        actions: actions.isNotEmpty ? actions : null,
        centerTitle: false, // Default to left alignment
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
        centerTitle: false, // Default to left alignment
      );
    }

    return null;
  }


  /// Build bottom action bar from configuration with priority logic
  /// Priority: customBottomBar > bottomBarConfig
  Widget? _buildBottomBar(BuildContext context) {
    // Priority 1: Custom bottom bar widget
    if (customBottomBar != null) return customBottomBar;

    // Priority 2: Structured configuration
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
    // Only show sidebar menu if position is left
    if (isDesktop &&
        menuConfig != null &&
        menuConfig!.shouldShowOnPlatform(isDesktop: true) &&
        menuConfig!.hasItems &&
        menuPosition == MenuPosition.left) {
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
    // Only show sidebar menu if position is left
    if (isDesktop &&
        menuConfig != null &&
        menuConfig!.shouldShowOnPlatform(isDesktop: true) &&
        menuConfig!.hasItems &&
        menuPosition == MenuPosition.left) {
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
    final double menuWidth = context.colWidth(menuColumn,
        useMargins: false); // Standard menu: 3 columns

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

  // ===========================================================================
  // FAB Configuration Helpers
  // ===========================================================================

  /// Build the floating action button from configuration
  Widget? _buildFAB(BuildContext context) {
    // Use fabConfig if provided, otherwise fall back to legacy FAB properties
    if (fabConfig != null) {
      final config = fabConfig!;

      if (!config.enabled) return null;

      switch (config.type) {
        case PageFabType.standard:
          return FloatingActionButton(
            onPressed: config.onPressed,
            tooltip: config.tooltip,
            heroTag: config.heroTag,
            child: Icon(config.icon),
          );

        case PageFabType.mini:
          return FloatingActionButton.small(
            onPressed: config.onPressed,
            tooltip: config.tooltip,
            heroTag: config.heroTag,
            child: Icon(config.icon),
          );

        case PageFabType.expandable:
          return AppExpandableFab(
            icon: config.icon != null ? Icon(config.icon) : null,
            activeIcon: config.activeIcon != null ? Icon(config.activeIcon) : null,
            initiallyOpen: config.initiallyOpen,
            onToggle: config.onToggle,
            children: config.children ?? [],
          );

        case PageFabType.custom:
          // For custom type, we would need to pass the widget somehow
          // This is a placeholder - custom widgets would need to be handled differently
          return null;
      }
    }

    // Fall back to legacy floatingActionButton property
    return floatingActionButton;
  }

  /// Get the FAB location from configuration
  FloatingActionButtonLocation? _getFABLocation() {
    return fabConfig?.location ?? floatingActionButtonLocation;
  }

  /// Get the FAB animator from configuration
  FloatingActionButtonAnimator? _getFABAnimator() {
    return fabConfig?.animator ?? floatingActionButtonAnimator;
  }
}
