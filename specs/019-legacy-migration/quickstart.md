# Quickstart: Legacy Components Migration

## Overview
This migration introduces three new theme-aware components: `AppSlideAction`, `AppExpandableFab`, and `AppGauge`. The legacy versions (`AppSlideActionContainer`, `ExpandableFab`, `AnimatedMeter`) are now **deprecated**.

## Migration Guide

### 1. Slide Action
**Old:** `AppSlideActionContainer`
**New:** `AppSlideAction`

```dart
// Before
AppSlideActionContainer(
  actions: [
    IconAction(icon: Icons.delete, onTap: delete),
  ],
  child: MyItem(),
)

// After
AppSlideAction(
  actions: [
    SlideActionItem(
      label: 'Delete',
      icon: Icon(Icons.delete),
      onTap: delete,
      variant: SlideActionVariant.destructive, // Semantic styling
    ),
  ],
  child: MyItem(),
)
```

### 2. Expandable FAB
**Old:** `ExpandableFab`
**New:** `AppExpandableFab`

```dart
// Before
ExpandableFab(
  distance: 100,
  children: [...],
)

// After
AppExpandableFab(
  children: [...],
  // distance is now handled by the Theme!
)
```

### 3. Gauge
**Old:** `AnimatedMeter`
**New:** `AppGauge`

```dart
// Before
AnimatedMeter(
  value: 0.75,
  color: Colors.blue, // Hardcoded
)

// After
AppGauge(
  value: 0.75,
  // Color derived from AppTheme.signalStrong automatically.
  // Note: For specific overrides, `AppThemeConfig.customSignalStrong` can still be used.
)
```
