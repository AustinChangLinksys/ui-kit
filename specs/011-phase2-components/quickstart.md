# Quickstart Guide: Phase 2 UI Kit Components

**Feature**: 011-phase2-components
**Date**: 2025-12-04

## Overview

This guide provides quick examples for integrating Phase 2 UI Kit components into your application. All components automatically adapt to the active design style (Flat, Glass, Pixel).

---

## Prerequisites

Ensure your app is wrapped with the UI Kit theme:

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      // Choose your design style:
      FlatDesignTheme.light(),    // or .dark()
      // GlassDesignTheme.light(),
      // PixelDesignTheme.light(),
    ],
  ),
  // ...
);
```

---

## 1. AppUnifiedBar

### Basic Usage

```dart
Scaffold(
  appBar: AppUnifiedBar(
    title: 'Dashboard',
  ),
  body: // ...
);
```

### With Actions

```dart
AppUnifiedBar(
  title: 'Settings',
  actions: [
    AppIconButton(
      icon: Icons.search,
      onTap: () => _openSearch(),
    ),
    AppPopupMenu<String>(
      items: [
        AppPopupMenuItem(value: 'help', label: 'Help'),
        AppPopupMenuItem(value: 'about', label: 'About'),
      ],
      onSelected: _handleMenuAction,
    ),
  ],
)
```

### With TabBar

```dart
AppUnifiedBar(
  title: 'Products',
  bottom: TabBar(
    controller: _tabController,
    tabs: [
      Tab(text: 'All'),
      Tab(text: 'Featured'),
      Tab(text: 'Sale'),
    ],
  ),
)
```

---

## 2. AppUnifiedSliverBar

### Collapsible Header with Image

```dart
CustomScrollView(
  slivers: [
    AppUnifiedSliverBar(
      title: 'User Profile',
      expandedHeight: 200.0,
      flexibleSpace: Image.network(
        profileImageUrl,
        fit: BoxFit.cover,
      ),
      actions: [
        AppIconButton(icon: Icons.edit, onTap: _editProfile),
      ],
    ),
    SliverList(
      delegate: SliverChildListDelegate([
        // Profile content...
      ]),
    ),
  ],
)
```

### Floating AppBar

```dart
AppUnifiedSliverBar(
  title: 'Feed',
  pinned: false,
  floating: true,
  snap: true, // Snaps to full height on scroll up
)
```

---

## 3. AppPopupMenu

### Basic Menu

```dart
AppPopupMenu<String>(
  items: [
    AppPopupMenuItem(value: 'edit', label: 'Edit'),
    AppPopupMenuItem(value: 'duplicate', label: 'Duplicate'),
    AppPopupMenuItem(value: 'delete', label: 'Delete', isDestructive: true),
  ],
  onSelected: (action) {
    switch (action) {
      case 'edit': _edit();
      case 'duplicate': _duplicate();
      case 'delete': _confirmDelete();
    }
  },
)
```

### With Icons

```dart
AppPopupMenu<String>(
  items: [
    AppPopupMenuItem(
      value: 'share',
      label: 'Share',
      icon: Icons.share,
    ),
    AppPopupMenuItem(
      value: 'download',
      label: 'Download',
      icon: Icons.download,
    ),
    AppPopupMenuItem(
      value: 'report',
      label: 'Report Issue',
      icon: Icons.flag,
      isDestructive: true,
    ),
  ],
  onSelected: _handleAction,
)
```

### Custom Trigger

```dart
AppPopupMenu<String>(
  items: menuItems,
  onSelected: _onSelected,
  child: Container(
    padding: EdgeInsets.all(8),
    child: Row(
      children: [
        Text('Options'),
        Icon(Icons.arrow_drop_down),
      ],
    ),
  ),
)
```

---

## 4. AppDialog

### Confirmation Dialog

```dart
void _showDeleteConfirmation() {
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
}
```

### Information Dialog

```dart
AppDialog(
  title: 'Update Available',
  content: 'A new version of the app is available. Update now to get the latest features and improvements.',
  primaryButtonText: 'Update',
  onPrimaryPressed: _launchUpdate,
  secondaryButtonText: 'Later',
  onSecondaryPressed: () => Navigator.of(context).pop(),
)
```

### Custom Content Dialog

```dart
AppDialog(
  title: 'Choose Avatar',
  customContent: GridView.builder(
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),
    itemCount: avatars.length,
    itemBuilder: (_, index) => AvatarOption(
      avatar: avatars[index],
      onTap: () => _selectAvatar(avatars[index]),
    ),
  ),
  primaryButtonText: 'Done',
  onPrimaryPressed: () => Navigator.of(context).pop(),
)
```

### Using Helper Function

```dart
// Simpler API for common use cases
await showAppDialog(
  context: context,
  title: 'Logout',
  content: 'Are you sure you want to logout?',
  primaryButtonText: 'Logout',
  onPrimaryPressed: _logout,
  secondaryButtonText: 'Cancel',
  onSecondaryPressed: () => Navigator.of(context).pop(),
);
```

---

## 5. Style Adaptation Examples

All components automatically adapt to the active theme. Here's what to expect:

### Flat Style
- Solid backgrounds with 8px border radius
- Minimal or no shadows
- Hairline dividers
- Clean, material-like appearance

### Glass Style
- Translucent backgrounds with blur effect
- 24px border radius with subtle glow
- Light borders for edge definition
- Modern, glassmorphism appearance

### Pixel Style
- Opaque backgrounds with 2px border radius
- Thick borders (2px)
- Hard-edge block shadows (no blur)
- Retro, 8-bit inspired appearance

---

## 6. Accessibility Notes

### Touch Targets
All interactive elements maintain minimum 48x48dp touch targets.

### Screen Readers
Components include proper semantics:
- AppBar: Announced as header/navigation
- Menu items: Announced as buttons with labels
- Dialog: Modal announcement with title

### Contrast
All themes maintain WCAG AA contrast ratios in both light and dark modes.

---

## 7. Common Patterns

### AppBar with Search

```dart
AppUnifiedBar(
  title: 'Products',
  actions: [
    AppIconButton(
      icon: Icons.search,
      onTap: () {
        showSearch(
          context: context,
          delegate: ProductSearchDelegate(),
        );
      },
    ),
  ],
)
```

### Contextual Menu in List

```dart
AppListTile(
  title: item.name,
  subtitle: item.description,
  trailing: AppPopupMenu<String>(
    items: [
      AppPopupMenuItem(value: 'edit', label: 'Edit', icon: Icons.edit),
      AppPopupMenuItem(value: 'delete', label: 'Delete', icon: Icons.delete, isDestructive: true),
    ],
    onSelected: (action) => _handleItemAction(item, action),
  ),
)
```

### Unsaved Changes Dialog

```dart
Future<bool> _onWillPop() async {
  if (!_hasChanges) return true;

  final shouldLeave = await showDialog<bool>(
    context: context,
    builder: (_) => AppDialog(
      title: 'Unsaved Changes',
      content: 'You have unsaved changes. Are you sure you want to leave?',
      primaryButtonText: 'Leave',
      onPrimaryPressed: () => Navigator.of(context).pop(true),
      secondaryButtonText: 'Stay',
      onSecondaryPressed: () => Navigator.of(context).pop(false),
      isDestructive: true,
    ),
  );

  return shouldLeave ?? false;
}
```

---

## Next Steps

- Browse Widgetbook for interactive examples
- Review [contracts/widgets.md](./contracts/widgets.md) for complete API reference
- Check golden test files for visual expectations across all themes
