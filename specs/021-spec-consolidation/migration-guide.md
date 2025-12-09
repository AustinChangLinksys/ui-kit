# Migration Guide: BottomSheetStyle & SideSheetStyle → SheetStyle

## Overview

This document describes the breaking changes introduced in Phase 10 of the Theme Spec Consolidation project. The deprecated `BottomSheetStyle` and `SideSheetStyle` classes have been removed in favor of the unified `SheetStyle`.

## Why This Change?

1. **Reduced Duplication**: Both sheet styles shared ~80% of their properties
2. **Consistent API**: Single style class with composable `OverlaySpec`
3. **Better Override Support**: Uses `AnimationSpec` for animation customization
4. **Simplified Theme Files**: One definition instead of two per theme

## Breaking Changes Summary

| Removed | Replacement |
|---------|-------------|
| `BottomSheetStyle` | `SheetStyle` |
| `SideSheetStyle` | `SheetStyle` |
| `AppDesignTheme.bottomSheetStyle` | `AppDesignTheme.sheetStyle` |
| `AppDesignTheme.sideSheetStyle` | `AppDesignTheme.sheetStyle` |
| `AppBottomSheet(style: ...)` | `AppBottomSheet(animationOverride: ...)` |
| `AppSideSheet(style: ...)` | `AppSideSheet(animationOverride: ...)` |

## Property Mapping

### BottomSheetStyle → SheetStyle

| Old Property | New Property |
|--------------|--------------|
| `overlayColor` | `overlay.scrimColor` |
| `animationDuration` | `overlay.animation.duration` |
| `animationCurve` | `overlay.animation.curve` |
| `topBorderRadius` | `borderRadius` |
| `dragHandleHeight` | `dragHandleHeight` |

### SideSheetStyle → SheetStyle

| Old Property | New Property |
|--------------|--------------|
| `overlayColor` | `overlay.scrimColor` |
| `animationDuration` | `overlay.animation.duration` |
| `animationCurve` | `overlay.animation.curve` |
| `width` | `width` |
| `blurStrength` | `overlay.blurStrength` |
| `enableDithering` | `enableDithering` |

## Migration Examples

### Before (Deprecated)

```dart
// Accessing styles from theme
final bottomStyle = theme.bottomSheetStyle;
final sideStyle = theme.sideSheetStyle;

// Using overlay color
Container(color: bottomStyle.overlayColor)

// Using animation
AnimationController(duration: sideStyle.animationDuration)

// Custom style override (deprecated parameter)
AppBottomSheet(
  style: BottomSheetStyle(
    overlayColor: Colors.black54,
    animationDuration: Duration(milliseconds: 300),
    animationCurve: Curves.easeOut,
    topBorderRadius: 16.0,
    dragHandleHeight: 4.0,
  ),
  child: content,
)
```

### After (New API)

```dart
// Accessing unified style from theme
final sheetStyle = theme.sheetStyle;

// Using overlay color (via OverlaySpec)
Container(color: sheetStyle.overlay.scrimColor)

// Using animation (via OverlaySpec.animation)
AnimationController(duration: sheetStyle.overlay.animation.duration)

// Custom animation override (new parameter)
AppBottomSheet(
  animationOverride: AnimationSpec(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeOut,
  ),
  child: content,
)

// Or use StyleOverride for subtree-wide override
StyleOverride(
  animationSpec: AnimationSpec.fast,
  child: AppBottomSheet(child: content),
)
```

## Theme Definition Migration

### Before

```dart
// In theme file (e.g., glass_design_theme.dart)
PixelDesignTheme._(
  bottomSheetStyle: BottomSheetStyle(
    overlayColor: overlayColor,
    animationDuration: const Duration(milliseconds: 100),
    animationCurve: Curves.linear,
    topBorderRadius: 0.0,
    dragHandleHeight: 16.0,
  ),
  sideSheetStyle: SideSheetStyle(
    width: 256.0,
    overlayColor: overlayColor,
    animationDuration: const Duration(milliseconds: 100),
    animationCurve: Curves.linear,
    blurStrength: 0.0,
    enableDithering: true,
  ),
  sheetStyle: SheetStyle(...), // Also had this
  // ...
)
```

### After

```dart
// In theme file - only SheetStyle needed
PixelDesignTheme._(
  sheetStyle: SheetStyle(
    overlay: OverlaySpec(
      scrimColor: overlayColor,
      blurStrength: 0.0,
      animation: AnimationSpec(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      ),
    ),
    borderRadius: 0.0,
    width: 256.0,
    dragHandleHeight: 4.0,
    enableDithering: true,
  ),
  // bottomSheetStyle: REMOVED
  // sideSheetStyle: REMOVED
  // ...
)
```

## Files Removed

The following files have been deleted:

- `lib/src/foundation/theme/design_system/specs/bottom_sheet_style.dart`
- `lib/src/foundation/theme/design_system/specs/bottom_sheet_style.tailor.dart`
- `lib/src/foundation/theme/design_system/specs/side_sheet_style.dart`
- `lib/src/foundation/theme/design_system/specs/side_sheet_style.tailor.dart`

## Exports Updated

The following exports have been removed from `lib/ui_kit.dart`:

```dart
// REMOVED
export 'src/foundation/theme/design_system/specs/bottom_sheet_style.dart';
export 'src/foundation/theme/design_system/specs/side_sheet_style.dart';
```

## Component API Changes

### AppBottomSheet

```dart
// Before
const AppBottomSheet({
  required Widget child,
  @Deprecated('Use the theme sheetStyle or animationOverride instead')
  BottomSheetStyle? style,  // REMOVED
  AnimationSpec? animationOverride,
});

// After
const AppBottomSheet({
  required Widget child,
  AnimationSpec? animationOverride,  // Use this for custom animations
});
```

### AppSideSheet

```dart
// Before
const AppSideSheet({
  required Widget child,
  @Deprecated('Use the theme sheetStyle or animationOverride instead')
  SideSheetStyle? style,  // REMOVED
  AnimationSpec? animationOverride,
});

// After
const AppSideSheet({
  required Widget child,
  AnimationSpec? animationOverride,  // Use this for custom animations
});
```

### AppDrawer

```dart
// Before
const AppDrawer({
  required Widget child,
  @Deprecated('Use the theme sheetStyle or animationOverride instead')
  SideSheetStyle? style,  // REMOVED
  AnimationSpec? animationOverride,
});

// After
const AppDrawer({
  required Widget child,
  AnimationSpec? animationOverride,  // Use this for custom animations
});
```

## Animation Override Priority

The new `animationOverride` parameter follows a resolution priority:

1. **Component parameter** (`animationOverride`) - highest priority
2. **StyleOverride ancestor** - `StyleOverride.resolveSpec<AnimationSpec>(context)`
3. **Theme default** - `theme.sheetStyle.overlay.animation`

## Checklist for Migration

- [ ] Replace `theme.bottomSheetStyle` with `theme.sheetStyle`
- [ ] Replace `theme.sideSheetStyle` with `theme.sheetStyle`
- [ ] Update property access to use `overlay.*` prefix for scrim/blur/animation
- [ ] Replace deprecated `style:` parameter with `animationOverride:` if custom animation needed
- [ ] Update custom theme definitions to remove `bottomSheetStyle` and `sideSheetStyle`
- [ ] Run `dart run build_runner build` to regenerate theme files
- [ ] Run `flutter analyze` to verify no deprecated warnings

## Questions?

See the full specification in `specs/021-spec-consolidation/spec.md` and task breakdown in `tasks.md`.
