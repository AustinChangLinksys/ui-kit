# Data Model & Entity Design: StyledPageView Migration to UI Kit

**Feature**: 023-styled-pageview-migration
**Phase**: Phase 1 Design
**Date**: 2025-12-10

## Overview

This document defines the data models, entities, and configuration structures for the enhanced UI Kit AppPageView system, designed to support the complete migration from PrivacyGUI's StyledAppPageView while maintaining full API compatibility.

## Core Configuration Models

### PageAppBarConfig

Primary configuration model for page header and AppBar behavior.

```dart
@freezed
class PageAppBarConfig with _$PageAppBarConfig {
  const factory PageAppBarConfig({
    String? title,
    List<Widget>? actions,
    VoidCallback? onBackTap,
    @Default(true) bool showBackButton,
    @Default(false) bool enableSliver,
    double? toolbarHeight,
    Widget? leading,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    @Default(true) bool centerTitle,
    double? elevation,
    Color? backgroundColor,
    Color? foregroundColor,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    bool? primary,
    bool? excludeHeaderSemantics,
    double? titleSpacing,
    double? toolbarOpacity,
    double? bottomOpacity,
  }) = _PageAppBarConfig;
}
```

**Key Properties**:
- `title`: Display text for the AppBar
- `actions`: List of action widgets (buttons, icons) for the trailing area
- `onBackTap`: Callback for back button interaction
- `showBackButton`: Controls back button visibility
- `enableSliver`: Enables SliverAppBar mode for collapsible behavior
- `toolbarHeight`: Custom height for the toolbar area

### PageBottomBarConfig

Configuration model for bottom action bar with primary/secondary actions.

```dart
@freezed
class PageBottomBarConfig with _$PageBottomBarConfig {
  const factory PageBottomBarConfig({
    String? positiveLabel,
    String? negativeLabel,
    VoidCallback? onPositiveTap,
    VoidCallback? onNegativeTap,
    @Default(true) bool isPositiveEnabled,
    bool? isNegativeEnabled,
    @Default(false) bool isDestructive,
    EdgeInsets? padding,
    double? height,
    MainAxisAlignment? alignment,
    CrossAxisAlignment? crossAlignment,
    Widget? leadingWidget,
    Widget? trailingWidget,
  }) = _PageBottomBarConfig;
}
```

**Key Properties**:
- `positiveLabel`/`negativeLabel`: Button text labels
- `onPositiveTap`/`onNegativeTap`: Action callbacks
- `isPositiveEnabled`/`isNegativeEnabled`: Button enabled states
- `isDestructive`: Applies destructive styling (red theme) when true
- `padding`: Custom spacing around the action bar
- `height`: Custom height for the bottom bar

### PageMenuConfig

Configuration model for responsive menu system supporting both desktop and mobile layouts.

```dart
@freezed
class PageMenuConfig with _$PageMenuConfig {
  const factory PageMenuConfig({
    String? title,
    @Default([]) List<PageMenuItem> items,
    @Default(true) bool showOnDesktop,
    @Default(true) bool showOnMobile,
    double? menuWidth,
    IconData? mobileMenuIcon,
    @Default(MenuPosition.left) MenuPosition position,
    @Default(false) bool largeMenu,
    Widget? header,
    Widget? footer,
    ScrollController? scrollController,
  }) = _PageMenuConfig;
}
```

**Key Properties**:
- `title`: Optional menu section title
- `items`: List of menu items with icons, labels, and actions
- `showOnDesktop`/`showOnMobile`: Platform-specific visibility controls
- `menuWidth`: Custom width for desktop sidebar menu
- `mobileMenuIcon`: Icon for mobile menu trigger button
- `position`: Menu placement (left/right for desktop)
- `largeMenu`: Enables expanded menu layout

### PageMenuItem

Individual menu item model supporting various interaction patterns.

```dart
@freezed
class PageMenuItem with _$PageMenuItem {
  const factory PageMenuItem({
    required String label,
    IconData? icon,
    Widget? iconWidget,
    VoidCallback? onTap,
    @Default(true) bool enabled,
    @Default(false) bool isSelected,
    String? subtitle,
    Widget? trailing,
    @Default(false) bool isDivider,
    @Default(false) bool isHeader,
  }) = _PageMenuItem;

  // Factory constructors for common patterns
  const factory PageMenuItem.divider() = _PageMenuItemDivider;

  const factory PageMenuItem.header({
    required String label,
  }) = _PageMenuItemHeader;
}
```

**Key Properties**:
- `label`: Display text for the menu item
- `icon`/`iconWidget`: Visual indicator (either IconData or custom Widget)
- `onTap`: Callback for item selection
- `enabled`: Interaction state control
- `isSelected`: Visual selection state
- `subtitle`: Optional secondary text
- `trailing`: Optional trailing widget (badge, switch, etc.)

## Theme Integration Models

### PageLayoutStyle

Core theme specification for page layout styling across all visual languages.

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
}
```

### AppBarStyle

Dedicated theme specification for AppBar styling.

```dart
@TailorMixin()
class AppBarStyle extends ThemeExtension<AppBarStyle> {
  const AppBarStyle({
    required this.colors,
    required this.textStyle,
    required this.iconTheme,
    required this.elevation,
    required this.height,
    required this.borderRadius,
    required this.animation,
  });

  final StateColorSpec colors;
  final TextStyle textStyle;
  final IconThemeData iconTheme;
  final double elevation;
  final double height;
  final BorderRadius borderRadius;
  final AnimationSpec animation;
}
```

### BottomBarStyle

Dedicated theme specification for bottom action bar styling.

```dart
@TailorMixin()
class BottomBarStyle extends ThemeExtension<BottomBarStyle> {
  const BottomBarStyle({
    required this.colors,
    required this.destructiveColors,
    required this.textStyle,
    required this.buttonHeight,
    required this.borderRadius,
    required this.padding,
    required this.animation,
  });

  final StateColorSpec colors;
  final StateColorSpec destructiveColors;
  final TextStyle textStyle;
  final double buttonHeight;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final AnimationSpec animation;
}
```

## Enhanced AppPageView API

### Core Widget Interface

```dart
class AppPageView extends StatefulWidget {
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

  // Core content
  final Widget Function(BuildContext context, BoxConstraints constraints) child;

  // New enhanced configurations
  final PageAppBarConfig? appBarConfig;
  final PageBottomBarConfig? bottomBarConfig;
  final PageMenuConfig? menuConfig;

  // Tabbed navigation support
  final List<Widget>? tabs;
  final List<Widget>? tabViews;
  final TabController? tabController;
  final ValueChanged<int>? onTabChanged;

  // Layout and behavior
  final Color? backgroundColor;
  final bool useSlivers;
  final bool useContentPadding;
  final bool scrollable;
  final ScrollController? scrollController;
  final RefreshCallback? refreshCallback;
  final SafeAreaConfig? safeAreaConfig;
}
```

### Factory Constructors

```dart
extension AppPageViewFactories on AppPageView {
  // Basic page with content
  static AppPageView basic({
    required Widget Function(BuildContext, BoxConstraints) child,
    String? title,
    List<Widget>? actions,
    VoidCallback? onBackTap,
  }) => AppPageView(
    child: child,
    appBarConfig: title != null ? PageAppBarConfig(
      title: title,
      actions: actions,
      onBackTap: onBackTap,
    ) : null,
  );

  // Page with bottom actions
  static AppPageView withBottomBar({
    required Widget Function(BuildContext, BoxConstraints) child,
    String? title,
    required String positiveLabel,
    required VoidCallback onPositiveTap,
    String? negativeLabel,
    VoidCallback? onNegativeTap,
    bool isDestructive = false,
  }) => AppPageView(
    child: child,
    appBarConfig: PageAppBarConfig(title: title),
    bottomBarConfig: PageBottomBarConfig(
      positiveLabel: positiveLabel,
      onPositiveTap: onPositiveTap,
      negativeLabel: negativeLabel,
      onNegativeTap: onNegativeTap,
      isDestructive: isDestructive,
    ),
  );

  // Page with responsive menu
  static AppPageView withMenu({
    required Widget Function(BuildContext, BoxConstraints) child,
    String? title,
    required List<PageMenuItem> menuItems,
    String? menuTitle,
    bool largeMenu = false,
  }) => AppPageView(
    child: child,
    appBarConfig: PageAppBarConfig(title: title),
    menuConfig: PageMenuConfig(
      title: menuTitle,
      items: menuItems,
      largeMenu: largeMenu,
    ),
  );

  // Tabbed page layout
  static AppPageView withTabs({
    required List<Widget> tabs,
    required List<Widget> tabViews,
    String? title,
    TabController? controller,
    ValueChanged<int>? onTabChanged,
  }) => AppPageView(
    child: (context, constraints) => const SizedBox.shrink(), // Handled by tab system
    appBarConfig: PageAppBarConfig(title: title),
    tabs: tabs,
    tabViews: tabViews,
    tabController: controller,
    onTabChanged: onTabChanged,
  );
}
```

## PrivacyGUI Adapter Models

### ExperimentalUiKitPageView

API-compatible wrapper maintaining StyledAppPageView interface.

```dart
class ExperimentalUiKitPageView extends StatefulWidget {
  // Exact API match with StyledAppPageView
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

  // All original StyledAppPageView parameters preserved
  final Widget Function(BuildContext context, BoxConstraints constraints) child;
  final String? title;
  final double? toolbarHeight;
  final RefreshCallback? onRefresh;
  final VoidCallback? onBackTap;
  final StyledBackState backState;
  final List<Widget>? actions;
  // ... (complete parameter list matching original)

  // Factory constructors matching original
  factory ExperimentalUiKitPageView.innerPage({...}) => ...;
  factory ExperimentalUiKitPageView.withSliver({...}) => ...;
}
```

### Parameter Conversion Logic

```dart
class UiKitPageViewAdapter {
  static PageAppBarConfig convertAppBarConfig({
    String? title,
    String? markLabel,
    StyledBackState backState,
    VoidCallback? onBackTap,
    List<Widget>? actions,
    double? toolbarHeight,
    bool enableSliverAppBar,
  }) {
    return PageAppBarConfig(
      title: _buildTitleWithMarkLabel(title, markLabel),
      showBackButton: backState != StyledBackState.none,
      onBackTap: backState == StyledBackState.enabled ? onBackTap : null,
      actions: actions,
      toolbarHeight: toolbarHeight,
      enableSliver: enableSliverAppBar,
    );
  }

  static PageBottomBarConfig? convertBottomBarConfig(PageBottomBar? bottomBar) {
    if (bottomBar == null) return null;

    return PageBottomBarConfig(
      positiveLabel: bottomBar.positiveLabel,
      negativeLabel: bottomBar.negitiveLable, // Preserve original typo for compatibility
      onPositiveTap: bottomBar.onPositiveTap,
      onNegativeTap: bottomBar.onNegitiveTap,
      isPositiveEnabled: bottomBar.isPositiveEnabled ?? true,
      isNegativeEnabled: bottomBar.isNegitiveEnabled,
      isDestructive: bottomBar is InversePageBottomBar,
    );
  }

  static PageMenuConfig? convertMenuConfig({
    PageMenu? menu,
    Widget? menuWidget,
    IconData? menuIcon,
    bool menuOnRight,
    bool largeMenu,
  }) {
    if (menu == null && menuWidget == null) return null;

    return PageMenuConfig(
      title: menu?.title,
      items: menu?.items.map((item) => PageMenuItem(
        label: item.label,
        icon: item.icon,
        onTap: item.onTap,
        enabled: item.enabled,
      )).toList() ?? [],
      mobileMenuIcon: menuIcon,
      position: menuOnRight ? MenuPosition.right : MenuPosition.left,
      largeMenu: largeMenu,
    );
  }
}
```

## Testing & Validation Models

### MigrationTestCase

Model for test scenario definition and validation.

```dart
@freezed
class MigrationTestCase with _$MigrationTestCase {
  const factory MigrationTestCase({
    required String name,
    required String description,
    required Widget Function() buildOriginal,
    required Widget Function() buildExperimental,
    @Default([]) List<String> testActions,
    Map<String, dynamic>? metadata,
  }) = _MigrationTestCase;
}
```

### ComplexityAnalysisResult

Model for migration complexity assessment results.

```dart
@freezed
class ComplexityAnalysisResult with _$ComplexityAnalysisResult {
  const factory ComplexityAnalysisResult({
    required int complexityScore,
    required List<String> challenges,
    required List<String> warnings,
    required String recommendation,
    required Map<String, int> featureScores,
  }) = _ComplexityAnalysisResult;
}
```

## Integration Points

### Theme System Integration

All new models integrate seamlessly with the existing UI Kit theme system:

1. **AppDesignTheme Extension**: New styles added to main theme container
2. **Color System**: Uses AppColorScheme semantic properties
3. **Motion System**: Integrates with AppMotion for consistent animations
4. **Typography**: Leverages appTextTheme for consistent text styling

### Responsive System Integration

Models support the UI Kit responsive system:

1. **Breakpoint Awareness**: `context.isDesktop` integration
2. **Grid System**: `context.colWidth()` for layout sizing
3. **Safe Area**: Automatic safe area handling
4. **Adaptive Behavior**: Menu system adapts to platform capabilities

### Testing Integration

Models support comprehensive testing requirements:

1. **Golden Tests**: All models support theme matrix testing
2. **Unit Tests**: Equatable enables efficient comparison testing
3. **Integration Tests**: Models support end-to-end validation
4. **Migration Tests**: Specialized validation for compatibility

This data model design ensures complete API compatibility while enabling enhanced functionality, maintaining UI Kit architectural principles, and supporting safe migration validation.