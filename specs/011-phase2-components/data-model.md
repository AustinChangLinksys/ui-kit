# Data Model: Phase 2 UI Kit Components

**Feature**: 011-phase2-components
**Date**: 2025-12-04
**Status**: Complete

## Overview

This document defines the data structures, style specs, and entity relationships for Phase 2 UI Kit components.

---

## 1. Style Specifications (Theme Layer)

### 1.1 AppBarStyle

**Purpose**: Defines visual properties for AppBar and SliverAppBar components.

| Field | Type | Description |
|-------|------|-------------|
| `containerStyle` | `SurfaceStyle` | Background, border, shadow for main AppBar container |
| `bottomContainerStyle` | `SurfaceStyle` | Style for bottom area (TabBar container) |
| `dividerStyle` | `DividerStyle` | Bottom divider (hairline for Flat, thick for Pixel) |
| `height` | `double` | Standard AppBar height (default: 56.0) |
| `collapsedHeight` | `double` | Minimum height when SliverAppBar collapsed |
| `expandedHeight` | `double` | Maximum height when SliverAppBar expanded |
| `flexibleSpaceBlur` | `double` | Blur sigma for Glass mode flexibleSpace overlay (0 for non-Glass) |

**Style Variants by Theme**:

| Theme | containerStyle | divider | blur |
|-------|---------------|---------|------|
| Flat | Solid bg, 8px radius, no blur | Hairline (1px) | 0 |
| Glass | Translucent bg, 24px radius, blur | None (border only) | 25.0 |
| Pixel | Opaque bg, 2px radius, block shadow | Thick (2px dashed) | 0 |

### 1.2 MenuStyle

**Purpose**: Defines visual properties for PopupMenu container and items.

| Field | Type | Description |
|-------|------|-------------|
| `containerStyle` | `SurfaceStyle` | Popup container background, border, shadow |
| `itemStyle` | `SurfaceStyle` | Default menu item appearance |
| `itemHoverStyle` | `SurfaceStyle` | Hovered/focused item appearance |
| `destructiveItemStyle` | `SurfaceStyle` | Destructive action item (error color) |
| `itemHeight` | `double` | Minimum item height (48.0 for a11y) |
| `itemHorizontalPadding` | `double` | Horizontal padding inside items |
| `iconSize` | `double` | Leading icon size |
| `iconLabelSpacing` | `double` | Gap between icon and label |

**Style Variants by Theme**:

| Theme | containerStyle | itemHover | destructive |
|-------|---------------|-----------|-------------|
| Flat | 8px radius, soft shadow | Subtle bg highlight | Error text/icon |
| Glass | 24px radius, blur, glow border | Glow effect | Error with glow |
| Pixel | 2px radius, thick border, block shadow | Inverted colors | Error with offset |

### 1.3 DialogStyle

**Purpose**: Defines visual properties for modal dialogs.

| Field | Type | Description |
|-------|------|-------------|
| `containerStyle` | `SurfaceStyle` | Dialog box background, border, shadow |
| `barrierColor` | `Color` | Semi-transparent backdrop color |
| `barrierBlur` | `double` | Backdrop blur for Glass mode (0 for others) |
| `maxWidth` | `double` | Maximum dialog width (default: 400.0) |
| `padding` | `EdgeInsets` | Internal content padding |
| `titleStyle` | `TextStyle?` | Title text style override |
| `buttonSpacing` | `double` | Gap between action buttons |
| `buttonAlignment` | `MainAxisAlignment` | Button row alignment |

**Style Variants by Theme**:

| Theme | container | barrierBlur | buttons |
|-------|-----------|-------------|---------|
| Flat | 8px radius, standard shadow | 0 | Standard AppButton |
| Glass | 24px radius, blur, glow | 10.0 | Glass-style buttons |
| Pixel | 2px radius, thick border, block shadow | 0 | Pixel-style buttons |

---

## 2. Component Data Models

### 2.1 AppPopupMenuItem<T>

**Purpose**: Data class representing a single menu item.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `value` | `T` | Yes | Return value when selected |
| `label` | `String` | Yes | Display text |
| `icon` | `IconData?` | No | Optional leading icon |
| `isDestructive` | `bool` | No | Destructive action flag (default: false) |
| `enabled` | `bool` | No | Item enabled state (default: true) |

**Validation Rules**:
- `label` must not be empty
- `value` type `T` must be consistent within a menu

### 2.2 DialogConfig (Internal)

**Purpose**: Configuration model for dialog display (internal use).

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | `String` | Yes | Dialog title |
| `content` | `String?` | No | Text content (exclusive with customContent) |
| `customContent` | `Widget?` | No | Widget content (exclusive with content) |
| `primaryButtonText` | `String` | Yes | Primary action label |
| `secondaryButtonText` | `String?` | No | Secondary action label |
| `isDestructive` | `bool` | No | Danger state for primary button |

**Validation Rules**:
- `content` XOR `customContent` must be provided (mutual exclusivity)
- `title` must not be empty
- `primaryButtonText` must not be empty

---

## 3. Entity Relationships

```
┌─────────────────────────────────────────────────────────────────┐
│                        AppDesignTheme                           │
│  (ThemeExtension - Single Source of Truth)                      │
├─────────────────────────────────────────────────────────────────┤
│  + appBarStyle: AppBarStyle      ◄─── NEW                       │
│  + menuStyle: MenuStyle          ◄─── NEW                       │
│  + dialogStyle: DialogStyle      ◄─── NEW                       │
│  + surfaceBase: SurfaceStyle                                    │
│  + surfaceElevated: SurfaceStyle                                │
│  + ...existing specs...                                         │
└─────────────────────────────────────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
  ┌───────────────┐   ┌───────────────┐   ┌───────────────┐
  │  AppBarStyle  │   │   MenuStyle   │   │  DialogStyle  │
  ├───────────────┤   ├───────────────┤   ├───────────────┤
  │ containerStyle│   │ containerStyle│   │ containerStyle│
  │ bottomStyle   │   │ itemStyle     │   │ barrierColor  │
  │ dividerStyle  │   │ hoverStyle    │   │ barrierBlur   │
  │ height        │   │ destructive   │   │ maxWidth      │
  │ ...           │   │ ...           │   │ ...           │
  └───────┬───────┘   └───────┬───────┘   └───────┬───────┘
          │                   │                   │
          ▼                   ▼                   ▼
  ┌───────────────┐   ┌───────────────┐   ┌───────────────┐
  │  SurfaceStyle │   │  SurfaceStyle │   │  SurfaceStyle │
  │ (from specs/) │   │ (from specs/) │   │ (from specs/) │
  └───────────────┘   └───────────────┘   └───────────────┘
```

---

## 4. Component-Spec Mapping

| Component | Tier | Primary Spec | Additional Specs |
|-----------|------|--------------|------------------|
| `AppUnifiedBar` | Organism | `appBarStyle.containerStyle` | `dividerStyle` |
| `AppUnifiedSliverBar` | Organism | `appBarStyle.*` | `flexibleSpaceBlur` |
| `AppPopupMenu<T>` | Molecule | `menuStyle.containerStyle` | `itemStyle`, `destructiveItemStyle` |
| `AppDialog` | Organism | `dialogStyle.containerStyle` | `barrierColor`, button styles |

---

## 5. State Transitions

### 5.1 AppBar States

```
[Default] ──scroll──▶ [ScrolledUnder] ──scroll──▶ [Collapsed]
    │                       │                          │
    └── Glass: normal blur  └── Glass: increased blur  └── Full opacity
    └── Flat: normal        └── Flat: shadow appears   └── Flat: max shadow
    └── Pixel: normal       └── Pixel: unchanged       └── Pixel: unchanged
```

### 5.2 Menu Item States

```
[Default] ──hover/focus──▶ [Hovered] ──tap──▶ [Selected]
    │                           │                  │
    └── itemStyle              └── itemHoverStyle  └── triggers onSelected

[Destructive Default] ──hover──▶ [Destructive Hovered]
    │                                   │
    └── destructiveItemStyle           └── destructive + hover effects
```

### 5.3 Dialog Button States

```
[Primary] ◄─── isDestructive: false ───▶ [Danger Primary]
    │                                          │
    └── surfaceHighlight style                └── error color variant

[Secondary] ◄─── always neutral ───▶ (no danger variant)
    │
    └── surfaceBase or tonal style
```

---

## 6. Validation Summary

| Entity | Validation Rule | Error Behavior |
|--------|-----------------|----------------|
| `AppPopupMenuItem` | `label.isNotEmpty` | Assert in debug |
| `AppDialog` | `content` XOR `customContent` | Assert in debug |
| `AppDialog` | `title.isNotEmpty` | Assert in debug |
| Menu items | Touch target >= 48dp | Enforced via BoxConstraints |

---

## 7. Migration Notes

### Existing AppDialog

The current `AppDialog` implementation will be enhanced, not replaced:

**Current API**:
```dart
AppDialog({
  Widget? title,
  required Widget content,
  List<Widget>? actions,
})
```

**Enhanced API**:
```dart
AppDialog({
  required String title,           // CHANGED: String instead of Widget
  String? content,                 // NEW: Simple text content
  Widget? customContent,           // RENAMED: from content
  Widget? titleWidget,             // NEW: Optional widget override
  required String primaryButtonText,
  required VoidCallback onPrimaryPressed,
  String? secondaryButtonText,
  VoidCallback? onSecondaryPressed,
  bool isDestructive = false,
})
```

**Breaking Changes**:
- `title` type changed from `Widget?` to `String`
- `content` renamed to `customContent`
- `actions` replaced with structured button parameters

**Migration Path**: Deprecated API support for one version cycle if needed.
