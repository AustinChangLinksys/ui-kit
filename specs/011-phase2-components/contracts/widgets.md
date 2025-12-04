# Widget API Contracts: Phase 2 UI Kit Components

**Feature**: 011-phase2-components
**Date**: 2025-12-04
**Status**: Complete

## Overview

This document defines the public API contracts for Phase 2 UI Kit widgets. All components follow the Dumb Component pattern: constructor data in, callback events out.

---

## 1. AppUnifiedBar

**Location**: `lib/src/organisms/app_bar/app_unified_bar.dart`
**Type**: `StatelessWidget` implementing `PreferredSizeWidget`

### Constructor

```dart
const AppUnifiedBar({
  Key? key,
  required String title,
  Widget? titleWidget,
  Widget? leading,
  bool automaticallyImplyLeading = true,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
  double? elevation,
  bool centerTitle = true,
});
```

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `title` | `String` | Yes | - | Page title text |
| `titleWidget` | `Widget?` | No | null | Custom title widget (overrides `title`) |
| `leading` | `Widget?` | No | null | Leading widget (back button if auto-implied) |
| `automaticallyImplyLeading` | `bool` | No | true | Show back button when Navigator can pop |
| `actions` | `List<Widget>?` | No | null | Right-aligned action widgets |
| `bottom` | `PreferredSizeWidget?` | No | null | Bottom widget (TabBar, etc.) |
| `elevation` | `double?` | No | null | Override default elevation |
| `centerTitle` | `bool` | No | true | Center the title |

### Usage Example

```dart
AppUnifiedBar(
  title: 'Settings',
  actions: [
    AppIconButton(
      icon: Icons.search,
      onTap: () => _search(),
    ),
    AppPopupMenu(
      items: [...],
      onSelected: (value) => _handleAction(value),
    ),
  ],
  bottom: TabBar(
    tabs: [Tab(text: 'General'), Tab(text: 'Advanced')],
  ),
)
```

### Accessibility

- Wraps in `Semantics(header: true)`
- Title announced as heading
- Back button has label "Back" or custom semanticLabel

---

## 2. AppUnifiedSliverBar

**Location**: `lib/src/organisms/app_bar/app_unified_sliver_bar.dart`
**Type**: `StatelessWidget`

### Constructor

```dart
const AppUnifiedSliverBar({
  Key? key,
  required String title,
  Widget? titleWidget,
  List<Widget>? actions,
  bool pinned = true,
  bool floating = false,
  bool snap = false,
  double? expandedHeight,
  Widget? flexibleSpace,
  Widget? leading,
  bool automaticallyImplyLeading = true,
});
```

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `title` | `String` | Yes | - | Page title text |
| `titleWidget` | `Widget?` | No | null | Custom title widget |
| `actions` | `List<Widget>?` | No | null | Right-aligned action widgets |
| `pinned` | `bool` | No | true | Keep visible when scrolled |
| `floating` | `bool` | No | false | Appear on scroll up |
| `snap` | `bool` | No | false | Snap to full height |
| `expandedHeight` | `double?` | No | null | Maximum height when expanded |
| `flexibleSpace` | `Widget?` | No | null | Background content (hero image, etc.) |
| `leading` | `Widget?` | No | null | Leading widget |
| `automaticallyImplyLeading` | `bool` | No | true | Auto back button |

### Usage Example

```dart
CustomScrollView(
  slivers: [
    AppUnifiedSliverBar(
      title: 'Profile',
      expandedHeight: 200.0,
      flexibleSpace: Image.network(
        'https://example.com/hero.jpg',
        fit: BoxFit.cover,
      ),
      actions: [
        AppIconButton(icon: Icons.edit, onTap: _edit),
      ],
    ),
    SliverList(...),
  ],
)
```

### Glass Mode Behavior

When Glass theme is active and `flexibleSpace` is provided:
- Expanded state: Image visible with frosted glass overlay
- Collapsed state: Standard glass blur AppUnifiedBar

---

## 3. AppPopupMenu<T>

**Location**: `lib/src/molecules/menu/app_popup_menu.dart`
**Type**: `StatefulWidget` (manages overlay state)

### Constructor

```dart
const AppPopupMenu<T>({
  Key? key,
  required List<AppPopupMenuItem<T>> items,
  required ValueChanged<T> onSelected,
  Widget? icon,
  Widget? child,
  Offset offset = Offset.zero,
  bool enabled = true,
});
```

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `items` | `List<AppPopupMenuItem<T>>` | Yes | - | Menu items |
| `onSelected` | `ValueChanged<T>` | Yes | - | Selection callback |
| `icon` | `Widget?` | No | `Icons.more_vert` | Trigger icon |
| `child` | `Widget?` | No | null | Custom trigger widget (overrides icon) |
| `offset` | `Offset` | No | `Offset.zero` | Popup position offset |
| `enabled` | `bool` | No | true | Enable/disable menu |

### Usage Example

```dart
AppPopupMenu<String>(
  items: [
    AppPopupMenuItem(value: 'edit', label: 'Edit', icon: Icons.edit),
    AppPopupMenuItem(value: 'share', label: 'Share', icon: Icons.share),
    AppPopupMenuItem(
      value: 'delete',
      label: 'Delete',
      icon: Icons.delete,
      isDestructive: true,
    ),
  ],
  onSelected: (action) {
    switch (action) {
      case 'edit': _edit();
      case 'delete': _confirmDelete();
    }
  },
)
```

---

## 4. AppPopupMenuItem<T>

**Location**: `lib/src/molecules/menu/app_popup_menu_item.dart`
**Type**: Immutable data class

### Constructor

```dart
const AppPopupMenuItem({
  required T value,
  required String label,
  IconData? icon,
  bool isDestructive = false,
  bool enabled = true,
});
```

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `value` | `T` | Yes | - | Return value on selection |
| `label` | `String` | Yes | - | Display text |
| `icon` | `IconData?` | No | null | Leading icon |
| `isDestructive` | `bool` | No | false | Danger action styling |
| `enabled` | `bool` | No | true | Item enabled state |

### Assertions

```dart
assert(label.isNotEmpty, 'Menu item label cannot be empty');
```

---

## 5. AppDialog

**Location**: `lib/src/organisms/dialog/app_dialog.dart` (enhanced)
**Type**: `StatelessWidget`

### Constructor

```dart
const AppDialog({
  Key? key,
  required String title,
  String? content,
  Widget? customContent,
  Widget? titleWidget,
  required String primaryButtonText,
  required VoidCallback onPrimaryPressed,
  String? secondaryButtonText,
  VoidCallback? onSecondaryPressed,
  bool isDestructive = false,
  bool scrollable = true,
});
```

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `title` | `String` | Yes | - | Dialog title |
| `content` | `String?` | No | null | Text content (XOR customContent) |
| `customContent` | `Widget?` | No | null | Widget content (XOR content) |
| `titleWidget` | `Widget?` | No | null | Custom title widget |
| `primaryButtonText` | `String` | Yes | - | Primary button label |
| `onPrimaryPressed` | `VoidCallback` | Yes | - | Primary button action |
| `secondaryButtonText` | `String?` | No | null | Secondary button label |
| `onSecondaryPressed` | `VoidCallback?` | No | null | Secondary button action |
| `isDestructive` | `bool` | No | false | Danger styling for primary button |
| `scrollable` | `bool` | No | true | Enable content scrolling |

### Assertions

```dart
assert(
  content != null || customContent != null,
  'Either content or customContent must be provided',
);
assert(
  content == null || customContent == null,
  'content and customContent are mutually exclusive',
);
```

### Usage Example

```dart
showDialog(
  context: context,
  builder: (_) => AppDialog(
    title: 'Delete Item',
    content: 'Are you sure you want to delete this item? This action cannot be undone.',
    primaryButtonText: 'Delete',
    onPrimaryPressed: () {
      _deleteItem();
      Navigator.of(context).pop();
    },
    secondaryButtonText: 'Cancel',
    onSecondaryPressed: () => Navigator.of(context).pop(),
    isDestructive: true,
  ),
);
```

### Helper Functions

```dart
/// Show dialog utility
Future<T?> showAppDialog<T>({
  required BuildContext context,
  required String title,
  String? content,
  Widget? customContent,
  required String primaryButtonText,
  required VoidCallback onPrimaryPressed,
  String? secondaryButtonText,
  VoidCallback? onSecondaryPressed,
  bool isDestructive = false,
  bool barrierDismissible = true,
});
```

---

## 6. Style Spec Contracts

### AppBarStyle

```dart
class AppBarStyle extends Equatable {
  final SurfaceStyle containerStyle;
  final SurfaceStyle? bottomContainerStyle;
  final DividerStyle dividerStyle;
  final double height;
  final double collapsedHeight;
  final double expandedHeight;
  final double flexibleSpaceBlur;

  const AppBarStyle({
    required this.containerStyle,
    this.bottomContainerStyle,
    required this.dividerStyle,
    this.height = 56.0,
    this.collapsedHeight = 56.0,
    this.expandedHeight = 200.0,
    this.flexibleSpaceBlur = 0.0,
  });

  AppBarStyle copyWith({...});
  static AppBarStyle lerp(AppBarStyle a, AppBarStyle b, double t);
}
```

### MenuStyle

```dart
class MenuStyle extends Equatable {
  final SurfaceStyle containerStyle;
  final SurfaceStyle itemStyle;
  final SurfaceStyle itemHoverStyle;
  final SurfaceStyle destructiveItemStyle;
  final double itemHeight;
  final double itemHorizontalPadding;
  final double iconSize;
  final double iconLabelSpacing;

  const MenuStyle({
    required this.containerStyle,
    required this.itemStyle,
    required this.itemHoverStyle,
    required this.destructiveItemStyle,
    this.itemHeight = 48.0,
    this.itemHorizontalPadding = 16.0,
    this.iconSize = 24.0,
    this.iconLabelSpacing = 12.0,
  });

  MenuStyle copyWith({...});
  static MenuStyle lerp(MenuStyle a, MenuStyle b, double t);
}
```

### DialogStyle

```dart
class DialogStyle extends Equatable {
  final SurfaceStyle containerStyle;
  final Color barrierColor;
  final double barrierBlur;
  final double maxWidth;
  final EdgeInsets padding;
  final double buttonSpacing;
  final MainAxisAlignment buttonAlignment;

  const DialogStyle({
    required this.containerStyle,
    this.barrierColor = const Color(0x80000000),
    this.barrierBlur = 0.0,
    this.maxWidth = 400.0,
    this.padding = const EdgeInsets.all(24.0),
    this.buttonSpacing = 8.0,
    this.buttonAlignment = MainAxisAlignment.end,
  });

  DialogStyle copyWith({...});
  static DialogStyle lerp(DialogStyle a, DialogStyle b, double t);
}
```

---

## 7. AppDesignTheme Extension

```dart
@TailorMixin()
class AppDesignTheme extends ThemeExtension<AppDesignTheme>
    with _$AppDesignThemeTailorMixin {
  // Existing fields...

  // NEW: Phase 2 specs
  @override
  final AppBarStyle appBarStyle;

  @override
  final MenuStyle menuStyle;

  @override
  final DialogStyle dialogStyle;

  const AppDesignTheme({
    // ...existing parameters...
    required this.appBarStyle,
    required this.menuStyle,
    required this.dialogStyle,
  });
}
```

---

## 8. Backward Compatibility

### Deprecated API (AppDialog)

```dart
@Deprecated('Use the new AppDialog API with structured parameters. '
    'This constructor will be removed in v2.0')
factory AppDialog.legacy({
  Widget? title,
  required Widget content,
  List<Widget>? actions,
});
```

The legacy factory maintains backward compatibility for existing usage while encouraging migration to the new API.
