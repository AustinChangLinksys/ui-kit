# Component API Contracts: Enhanced AppPageView System

**Feature**: 023-styled-pageview-migration
**Contract Type**: Component Interface Specifications
**Date**: 2025-12-10

## Overview

This document defines the formal API contracts for all components in the enhanced AppPageView system, ensuring consistent interfaces, type safety, and clear integration points.

## Core Component APIs

### AppPageView

Primary page layout component with enhanced configuration support.

```dart
class AppPageView extends StatefulWidget {
  /// Creates an enhanced page view with configurable AppBar, bottom actions, menus, and tabs
  const AppPageView({
    Key? key,
    required this.child,
    this.appBarConfig,
    this.bottomBarConfig,
    this.menuConfig,
    this.tabs,
    this.tabViews,
    this.tabController,
    this.onTabChanged,
    this.backgroundColor,
    this.useSlivers = false,
    this.useContentPadding = true,
    this.scrollable = true,
    this.scrollController,
    this.refreshCallback,
    this.safeAreaConfig,
  }) : super(key: key);

  /// Content builder function providing context and constraints
  /// REQUIRED - Must provide widget content for the page
  final Widget Function(BuildContext context, BoxConstraints constraints) child;

  /// Optional AppBar configuration
  /// When null, no AppBar is displayed
  final PageAppBarConfig? appBarConfig;

  /// Optional bottom action bar configuration
  /// When null, no bottom bar is displayed
  final PageBottomBarConfig? bottomBarConfig;

  /// Optional menu system configuration
  /// When null, no menu is displayed
  /// On desktop: displays as sidebar when showOnDesktop=true
  /// On mobile: displays as modal bottom sheet when showOnMobile=true
  final PageMenuConfig? menuConfig;

  /// Tab headers for tabbed navigation
  /// Must be provided with tabViews for tab functionality
  /// Length must match tabViews length
  final List<Widget>? tabs;

  /// Tab content views for tabbed navigation
  /// Must be provided with tabs for tab functionality
  /// Length must match tabs length
  final List<Widget>? tabViews;

  /// Optional tab controller for tab state management
  /// When null, internal controller is created automatically
  final TabController? tabController;

  /// Callback for tab selection changes
  /// Provides the newly selected tab index
  final ValueChanged<int>? onTabChanged;

  /// Optional background color override
  /// When null, uses theme backgroundColor
  final Color? backgroundColor;

  /// Enable Sliver-based scrolling layout
  /// Required for SliverAppBar and advanced scrolling behaviors
  /// Default: false (uses standard Box layout)
  final bool useSlivers;

  /// Enable automatic content padding from theme
  /// Applies pageMargin from responsive system
  /// Default: true
  final bool useContentPadding;

  /// Enable scrollable content
  /// When false, content is not scrollable
  /// Default: true
  final bool scrollable;

  /// Optional scroll controller for manual scroll management
  /// When null, internal controller is created automatically
  final ScrollController? scrollController;

  /// Optional pull-to-refresh callback
  /// When provided, enables pull-to-refresh functionality
  final RefreshCallback? refreshCallback;

  /// Optional safe area configuration
  /// Controls safe area behavior for different screen areas
  final SafeAreaConfig? safeAreaConfig;
}
```

**API Contracts**:
- `child` function MUST return a valid Widget
- `tabs` and `tabViews` MUST have matching lengths when both provided
- `appBarConfig.enableSliver` requires `useSlivers = true`
- Component MUST respond to theme changes automatically
- Component MUST handle responsive layout changes

### PageAppBarConfig

Configuration model for AppBar appearance and behavior.

```dart
@freezed
class PageAppBarConfig with _$PageAppBarConfig {
  /// Creates AppBar configuration with customizable properties
  const factory PageAppBarConfig({
    /// AppBar title text
    /// When null, no title is displayed
    String? title,

    /// Action widgets displayed in AppBar trailing area
    /// Displayed in order provided (left to right)
    List<Widget>? actions,

    /// Callback for back button interaction
    /// When null and showBackButton=true, uses Navigator.pop
    VoidCallback? onBackTap,

    /// Controls back button visibility
    /// Default: true (shows back button when Navigator.canPop)
    @Default(true) bool showBackButton,

    /// Enable SliverAppBar for collapsible behavior
    /// Requires AppPageView.useSlivers = true
    /// Default: false
    @Default(false) bool enableSliver,

    /// Custom AppBar height in logical pixels
    /// When null, uses theme default height
    double? toolbarHeight,

    /// Custom leading widget (overrides back button)
    /// When provided, replaces default back button
    Widget? leading,

    /// Flexible space widget for SliverAppBar
    /// Only used when enableSliver = true
    Widget? flexibleSpace,

    /// Bottom widget for AppBar (e.g., TabBar)
    /// Extends AppBar height to accommodate bottom widget
    PreferredSizeWidget? bottom,

    /// Center title text in AppBar
    /// Default: true
    @Default(true) bool centerTitle,
  }) = _PageAppBarConfig;
}
```

**API Contracts**:
- `enableSliver = true` requires parent `AppPageView.useSlivers = true`
- `onBackTap` when null falls back to `Navigator.pop(context)`
- `actions` widgets MUST be interactive (buttons, icons)
- `title` supports any string content including localized text
- All properties MUST be immutable and support equality comparison

### PageBottomBarConfig

Configuration model for bottom action bar with primary/secondary actions.

```dart
@freezed
class PageBottomBarConfig with _$PageBottomBarConfig {
  /// Creates bottom action bar configuration
  const factory PageBottomBarConfig({
    /// Primary action button label
    /// When null, primary button is not displayed
    String? positiveLabel,

    /// Secondary action button label
    /// When null, secondary button is not displayed
    String? negativeLabel,

    /// Primary action callback
    /// Required when positiveLabel is provided
    VoidCallback? onPositiveTap,

    /// Secondary action callback
    /// Required when negativeLabel is provided
    VoidCallback? onNegativeTap,

    /// Primary button enabled state
    /// Default: true
    @Default(true) bool isPositiveEnabled,

    /// Secondary button enabled state
    /// When null, button is enabled
    bool? isNegativeEnabled,

    /// Apply destructive styling (warning colors)
    /// When true, primary button uses destructive theme colors
    /// Default: false
    @Default(false) bool isDestructive,

    /// Custom padding around action bar
    /// When null, uses theme default padding
    EdgeInsets? padding,

    /// Custom action bar height
    /// When null, uses theme default height
    double? height,
  }) = _PageBottomBarConfig;
}
```

**API Contracts**:
- `positiveLabel` requires corresponding `onPositiveTap` callback
- `negativeLabel` requires corresponding `onNegativeTap` callback
- `isDestructive = true` applies warning/danger theme colors
- Button enabled state affects both visual appearance and interaction
- Component MUST handle safe area insets automatically

### PageMenuConfig

Configuration model for responsive menu system.

```dart
@freezed
class PageMenuConfig with _$PageMenuConfig {
  /// Creates responsive menu configuration
  const factory PageMenuConfig({
    /// Optional menu section title
    /// Displayed at top of menu when provided
    String? title,

    /// List of menu items
    /// Empty list results in no menu display
    @Default([]) List<PageMenuItem> items,

    /// Show menu on desktop platforms
    /// When true, displays as sidebar on desktop
    /// Default: true
    @Default(true) bool showOnDesktop,

    /// Show menu on mobile platforms
    /// When true, displays as modal bottom sheet on mobile
    /// Default: true
    @Default(true) bool showOnMobile,

    /// Custom menu width for desktop sidebar
    /// When null, uses responsive system default (context.colWidth(4))
    double? menuWidth,

    /// Icon for mobile menu trigger button
    /// When null, uses default menu icon (Icons.menu)
    IconData? mobileMenuIcon,

    /// Menu position for desktop sidebar
    /// Default: left side of screen
    @Default(MenuPosition.left) MenuPosition position,

    /// Enable large menu layout
    /// Provides more space for menu content
    /// Default: false
    @Default(false) bool largeMenu,

    /// Optional header widget for menu
    /// Displayed above menu items
    Widget? header,

    /// Optional footer widget for menu
    /// Displayed below menu items
    Widget? footer,
  }) = _PageMenuConfig;
}

enum MenuPosition { left, right }
```

**API Contracts**:
- `items` list MUST contain valid `PageMenuItem` instances
- `showOnDesktop = false` AND `showOnMobile = false` results in no menu
- Desktop menu width respects responsive grid system
- Mobile menu MUST handle safe area and keyboard interactions
- Menu MUST adapt to theme changes and platform conventions

### PageMenuItem

Individual menu item model supporting various interaction patterns.

```dart
@freezed
class PageMenuItem with _$PageMenuItem {
  /// Creates a standard menu item
  const factory PageMenuItem({
    /// Display text for menu item
    /// REQUIRED for standard items
    required String label,

    /// Optional icon displayed before label
    /// Either iconData or iconWidget can be provided, not both
    IconData? icon,

    /// Optional custom icon widget
    /// Either iconData or iconWidget can be provided, not both
    Widget? iconWidget,

    /// Callback for item selection
    /// When null, item is display-only
    VoidCallback? onTap,

    /// Item interaction enabled state
    /// Default: true
    @Default(true) bool enabled,

    /// Visual selection state
    /// When true, applies selected theme styling
    /// Default: false
    @Default(false) bool isSelected,

    /// Optional secondary text below label
    String? subtitle,

    /// Optional widget displayed at end of item
    /// Common uses: badge, switch, disclosure indicator
    Widget? trailing,
  }) = _PageMenuItem;

  /// Creates a visual divider between menu sections
  const factory PageMenuItem.divider() = _PageMenuItemDivider;

  /// Creates a menu section header
  const factory PageMenuItem.header({
    required String label,
  }) = _PageMenuItemHeader;
}
```

**API Contracts**:
- Standard items MUST provide `label`
- `icon` and `iconWidget` are mutually exclusive
- `onTap = null` creates display-only items
- Dividers ignore all properties except factory type
- Headers display `label` with header styling
- `enabled = false` disables interaction but maintains display

## Experimental Adapter APIs

### ExperimentalUiKitPageView

API-compatible wrapper maintaining StyledAppPageView interface.

```dart
class ExperimentalUiKitPageView extends StatefulWidget {
  /// Creates experimental wrapper with full StyledAppPageView API compatibility
  ///
  /// This component provides 100% API compatibility with StyledAppPageView
  /// while internally using enhanced UI Kit AppPageView system
  const ExperimentalUiKitPageView({
    Key? key,
    required this.child,
    this.title,
    this.toolbarHeight,
    this.onRefresh,
    this.onBackTap,
    this.backState = StyledBackState.enabled,
    this.actions,
    this.padding,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.scrollable = true,
    this.appBarStyle = StyledAppBarStyle.back,
    this.handleNoConnection = true,
    this.handleBanner = true,
    this.menuIcon,
    this.menu,
    this.menuWidget,
    this.controller,
    this.enableSafeArea = true,
    this.bottomBar,
    this.menuOnRight = false,
    this.largeMenu = false,
    this.topbar,
    this.useMainPadding = true,
    this.markLabel,
    this.tabs,
    this.tabContentViews,
    this.tabController,
    this.onTabTap,
    this.hideTopbar = false,
    this.pageContentType = PageContentType.flexible,
    this.enableSliverAppBar = false,
  }) : super(key: key);

  // Complete parameter list matching StyledAppPageView exactly
  // [All 25+ parameters preserved for 100% API compatibility]

  /// Factory constructor for inner page layout
  factory ExperimentalUiKitPageView.innerPage({
    Key? key,
    required Widget Function(BuildContext, BoxConstraints) child,
    String? title,
    double? toolbarHeight,
    RefreshCallback? onRefresh,
    VoidCallback? onBackTap,
    StyledBackState backState = StyledBackState.enabled,
    List<Widget>? actions,
    EdgeInsets? padding,
    Widget? bottomSheet,
    Widget? bottomNavigationBar,
    bool scrollable = true,
    StyledAppBarStyle appBarStyle = StyledAppBarStyle.back,
    bool handleNoConnection = true,
    bool handleBanner = true,
    IconData? menuIcon,
    PageMenu? menu,
    Widget? menuWidget,
    ScrollController? controller,
    bool enableSafeArea = true,
    PageBottomBar? bottomBar,
    bool menuOnRight = false,
    bool largeMenu = false,
    Widget? topbar,
    bool useMainPadding = true,
    String? markLabel,
  }) => ExperimentalUiKitPageView(/* parameters */);

  /// Factory constructor for Sliver layout
  factory ExperimentalUiKitPageView.withSliver({
    Key? key,
    required Widget Function(BuildContext, BoxConstraints) child,
    String? title,
    double? toolbarHeight,
    RefreshCallback? onRefresh,
    VoidCallback? onBackTap,
    StyledBackState backState = StyledBackState.enabled,
    List<Widget>? actions,
    bool handleNoConnection = true,
    bool handleBanner = true,
    PageBottomBar? bottomBar,
    bool enableSliverAppBar = false,
  }) => ExperimentalUiKitPageView(/* parameters with useSlivers: true */);
}
```

**API Contracts**:
- MUST maintain 100% parameter compatibility with StyledAppPageView
- MUST preserve all factory constructor signatures
- MUST handle all PrivacyGUI-specific parameters through internal adaptation
- Component behavior MUST be functionally identical to original
- Performance MUST be equivalent or better than original

### UiKitPageViewAdapter

Utility class for parameter conversion between StyledAppPageView and AppPageView APIs.

```dart
class UiKitPageViewAdapter {
  /// Converts StyledAppPageView AppBar parameters to PageAppBarConfig
  static PageAppBarConfig? convertAppBarConfig({
    String? title,
    String? markLabel,
    StyledBackState backState = StyledBackState.enabled,
    VoidCallback? onBackTap,
    List<Widget>? actions,
    double? toolbarHeight,
    StyledAppBarStyle appBarStyle = StyledAppBarStyle.back,
    bool enableSliverAppBar = false,
  });

  /// Converts StyledAppPageView bottom bar to PageBottomBarConfig
  static PageBottomBarConfig? convertBottomBarConfig(
    PageBottomBar? bottomBar,
    BuildContext context, // For localization
  );

  /// Converts StyledAppPageView menu parameters to PageMenuConfig
  static PageMenuConfig? convertMenuConfig({
    PageMenu? menu,
    Widget? menuWidget,
    IconData? menuIcon,
    bool menuOnRight = false,
    bool largeMenu = false,
  });

  /// Converts StyledAppPageView tab parameters to AppPageView tab system
  static ({List<Widget>? tabs, List<Widget>? tabViews}) convertTabConfig({
    List<Widget>? tabs,
    List<Widget>? tabContentViews,
    TabController? tabController,
  });
}
```

**API Contracts**:
- All conversion methods MUST be static and pure (no side effects)
- MUST handle null parameters gracefully
- MUST preserve all functional behaviors from original parameters
- MUST maintain type safety throughout conversion process
- Conversion MUST be bidirectional where applicable

## Theme Integration Contracts

### PageLayoutStyle

Theme extension for page layout styling across visual languages.

```dart
@TailorMixin()
class PageLayoutStyle extends ThemeExtension<PageLayoutStyle> {
  const PageLayoutStyle({
    required this.animation,
    required this.appBarColors,
    required this.bottomBarColors,
    required this.menuColors,
    required this.backgroundColor,
    required this.contentPadding,
    required this.borderRadius,
    required this.elevation,
    required this.overlaySpec,
  });

  final AnimationSpec animation;
  final StateColorSpec appBarColors;
  final StateColorSpec bottomBarColors;
  final StateColorSpec menuColors;
  final Color backgroundColor;
  final EdgeInsets contentPadding;
  final BorderRadius borderRadius;
  final double elevation;
  final OverlaySpec overlaySpec;

  // Auto-generated by @TailorMixin
  // copyWith, lerp, ==, hashCode methods
}
```

**Theme Integration Contracts**:
- MUST support all 5 visual languages (Flat, Glass, Brutal, Pixel, Neumorphic)
- MUST compose shared specs (AnimationSpec, StateColorSpec, OverlaySpec)
- MUST NOT duplicate properties available in shared specs
- Color resolution MUST use semantic AppColorScheme properties
- Animation specifications MUST respect theme-specific motion requirements

## Testing Contracts

### Migration Test Interface

API for migration validation and compatibility testing.

```dart
abstract class MigrationTestInterface {
  /// Compare visual output between original and experimental implementations
  Future<bool> validateVisualCompatibility(Widget original, Widget experimental);

  /// Compare functional behavior between implementations
  Future<bool> validateFunctionalCompatibility(
    Widget original,
    Widget experimental,
    List<TestAction> actions,
  );

  /// Generate complexity analysis for migration assessment
  ComplexityAnalysisResult analyzeComplexity(Map<String, dynamic> configuration);

  /// Validate performance parity between implementations
  Future<PerformanceComparisonResult> comparePerformance(
    Widget original,
    Widget experimental,
    PerformanceTestConfig config,
  );
}
```

**Testing Contracts**:
- Visual validation MUST compare rendered pixels across theme matrix
- Functional validation MUST verify identical behavior for user interactions
- Complexity analysis MUST provide quantified migration effort assessment
- Performance comparison MUST measure render time and memory usage
- All test methods MUST be deterministic and repeatable

## Error Handling Contracts

### Component Error Handling

All components MUST implement consistent error handling:

```dart
abstract class ComponentErrorContract {
  /// Handle configuration errors gracefully
  /// MUST provide meaningful error messages
  /// MUST not crash the application
  void handleConfigurationError(String component, String error);

  /// Handle theme integration errors
  /// MUST fall back to default theme values
  /// MUST log error for debugging
  void handleThemeError(String component, ThemeExtension? theme);

  /// Handle interaction errors
  /// MUST prevent error propagation to parent widgets
  /// MUST provide user-visible error indication when appropriate
  void handleInteractionError(String component, String interaction, Exception error);
}
```

**Error Handling Requirements**:
- Configuration errors MUST be caught and handled gracefully
- Theme missing errors MUST use safe fallback values
- User interaction errors MUST not crash the component
- All errors MUST be logged for debugging purposes
- Error messages MUST be actionable for developers

This API contract specification ensures consistent, reliable, and maintainable component interfaces throughout the enhanced AppPageView system.