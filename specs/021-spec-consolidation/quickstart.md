# Quickstart: Theme Spec Consolidation

**Feature**: 021-spec-consolidation
**Date**: 2025-12-08

## Overview

This guide covers how to use the consolidated theme specs:
- **Shared Specs**: AnimationSpec, StateColorSpec, OverlaySpec
- **Unified SheetStyle**: Replaces BottomSheetStyle + SideSheetStyle
- **StyleOverride**: Local spec overrides without theme changes

## Installation

No additional dependencies required. After code generation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Using Shared Specs

### AnimationSpec

```dart
import 'package:ui_kit_library/ui_kit.dart';

// Use presets
final animation = AnimationSpec.standard; // 300ms, easeInOut
final fast = AnimationSpec.fast;          // 150ms, easeOut
final instant = AnimationSpec.instant;    // 0ms (Pixel theme)

// Create custom
final custom = AnimationSpec(
  duration: Duration(milliseconds: 200),
  curve: Curves.bounceOut,
);

// Override single property
final modified = AnimationSpec.standard.withOverride(
  duration: Duration(milliseconds: 400),
);

// Access from theme
final carouselAnim = theme.carouselStyle.animation;
```

### StateColorSpec

```dart
// Create state colors (with optional hover/pressed)
final textColors = StateColorSpec(
  active: Colors.blue,
  inactive: Colors.grey,
  disabled: Colors.grey.withOpacity(0.5),
  error: Colors.red,
  hover: Colors.blue.shade700,    // Optional
  pressed: Colors.blue.shade900,  // Optional
);

// Resolve based on state
final color = textColors.resolve(isActive: isSelected);

// With disabled check
final color = textColors.resolve(
  isActive: isSelected,
  isDisabled: !isEnabled,
);

// With error state
final color = textColors.resolve(
  isActive: isSelected,
  hasError: hasValidationError,
);

// With hover/pressed (for interactive components)
final buttonColor = buttonColors.resolve(
  isActive: true,
  isHovered: _isHovered,
  isPressed: _isPressed,
);

// Resolution priority: error > disabled > pressed > hover > active/inactive
```

### OverlaySpec

```dart
// Use presets
final overlay = OverlaySpec.standard; // Flat/Brutal themes
final glass = OverlaySpec.glass;      // Glass theme with blur
final pixel = OverlaySpec.pixel;      // Pixel theme, instant

// Create custom
final custom = OverlaySpec(
  scrimColor: Colors.black54,
  blurStrength: 5.0,
  animation: AnimationSpec.fast,
);

// Access nested animation
final duration = overlay.animation.duration;
```

## Using SheetStyle

### Theme Definition

```dart
// In your theme file
sheetStyle: SheetStyle(
  overlay: OverlaySpec.glass,
  borderRadius: 24.0,
  width: 320.0,
  dragHandleHeight: 4.0,
),
```

### Component Usage

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context).extension<AppDesignTheme>()!;
  final style = theme.sheetStyle;

  return AnimatedContainer(
    duration: style.overlay.animation.duration,
    curve: style.overlay.animation.curve,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(style.borderRadius),
      ),
    ),
    child: child,
  );
}
```

### Migration from Old Styles (Breaking Change)

> **Note**: `BottomSheetStyle` and `SideSheetStyle` have been **removed** in Phase 10.
> See `specs/021-spec-consolidation/migration-guide.md` for full migration details.

```dart
// OLD (REMOVED - will not compile)
// final duration = theme.bottomSheetStyle.animationDuration;
// final width = theme.sideSheetStyle.width;

// NEW
final duration = theme.sheetStyle.overlay.animation.duration;
final width = theme.sheetStyle.width;

// Animation override (replaces style parameter)
AppBottomSheet(
  animationOverride: AnimationSpec.fast,
  child: content,
);
```

## Using StyleOverride

### Page-Level Override

```dart
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StyleOverride(
      animationSpec: AnimationSpec.fast, // Snappier animations
      child: Scaffold(
        body: ListView(
          children: [
            AppExpansionPanel(...),
            AppTabs(...),
            AppBottomSheet(...),
          ],
        ),
      ),
    );
  }
}
```

### Section Override

```dart
Column(
  children: [
    // Normal speed
    AppCarousel(...),

    // Slow animations for hero section
    StyleOverride(
      animationSpec: AnimationSpec.slow,
      child: HeroImageCarousel(...),
    ),

    // Back to normal
    AppStepper(...),
  ],
)
```

### Component with Override Parameter

```dart
// Direct override takes highest priority
AppBottomSheet(
  animationOverride: AnimationSpec(
    duration: Duration(milliseconds: 500),
    curve: Curves.elasticOut,
  ),
  child: content,
)
```

## Resolution Priority

Components resolve specs in this order:

1. **Component parameter** (e.g., `animationOverride`)
2. **StyleOverride ancestor** (nearest in widget tree)
3. **Theme default** (from AppDesignTheme)

```dart
AnimationSpec _resolveAnimation(BuildContext context) {
  // 1. Direct override
  if (animationOverride != null) return animationOverride!;

  // 2. StyleOverride
  final override = StyleOverride.resolveSpec<AnimationSpec>(context);
  if (override != null) return override;

  // 3. Theme default
  return theme.carouselStyle.animation;
}
```

## Creating New Component Styles

When creating a new component style, compose shared specs instead of duplicating properties:

```dart
// BAD: Duplicating animation properties
@TailorMixin()
class MyComponentStyle extends ThemeExtension<MyComponentStyle> {
  final Duration animationDuration; // Duplicated!
  final Curve animationCurve;       // Duplicated!
  final Color activeColor;          // Duplicated!
  final Color inactiveColor;        // Duplicated!
}

// GOOD: Compose shared specs
@TailorMixin()
class MyComponentStyle extends ThemeExtension<MyComponentStyle> {
  final AnimationSpec animation;     // Composed
  final StateColorSpec colors;       // Composed
  final double customProperty;       // Component-specific only
}
```

## Testing

### Unit Tests for Specs

```dart
test('AnimationSpec.withOverride preserves unmodified values', () {
  final original = AnimationSpec.standard;
  final modified = original.withOverride(duration: Duration(milliseconds: 100));

  expect(modified.duration, Duration(milliseconds: 100));
  expect(modified.curve, original.curve); // Unchanged
});

test('StateColorSpec.resolve returns correct color', () {
  final spec = StateColorSpec(
    active: Colors.blue,
    inactive: Colors.grey,
    error: Colors.red,
  );

  expect(spec.resolve(isActive: true), Colors.blue);
  expect(spec.resolve(isActive: false), Colors.grey);
  expect(spec.resolve(isActive: true, hasError: true), Colors.red);
});
```

### Widget Tests with StyleOverride

```dart
testWidgets('component respects StyleOverride', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: StyleOverride(
        animationSpec: AnimationSpec.instant,
        child: AppCarousel(items: [...]),
      ),
    ),
  );

  // Verify instant animation behavior
});
```

## Common Patterns

### Theme-Aware Defaults

```dart
// In Glass theme
sheetStyle: SheetStyle(
  overlay: OverlaySpec.glass,      // Blur + slow animation
  borderRadius: 24.0,              // Rounded
),

// In Pixel theme
sheetStyle: SheetStyle(
  overlay: OverlaySpec.pixel,      // No blur + instant
  borderRadius: 0.0,               // Sharp
  enableDithering: true,
),
```

### Conditional Override

```dart
StyleOverride(
  animationSpec: isReducedMotion
      ? AnimationSpec.instant
      : AnimationSpec.standard,
  child: content,
)
```

## Integrated Component Styles

All component styles now use shared specs. Here's the complete integration matrix:

| Style | AnimationSpec | StateColorSpec | OverlaySpec |
|-------|:-------------:|:--------------:|:-----------:|
| SheetStyle | ✓ (via overlay) | - | ✓ |
| DialogStyle | ✓ (via overlay) | - | ✓ |
| TabsStyle | - | ✓ (textColors) | - |
| BreadcrumbStyle | - | ✓ (linkColors) | - |
| ChipGroupStyle | - | ✓ (textColors, backgroundColors) | - |
| CarouselStyle | ✓ | ✓ (indicatorColors) | - |
| ExpansionPanelStyle | ✓ | - | - |
| SlideActionStyle | ✓ | - | - |
| TableStyle | ✓ (modeTransition) | - | - |
| GaugeStyle | ✓ | - | - |
| ExpandableFabStyle | ✓ (via overlay) | - | ✓ |
| TopologySpec | ✓ (linkAnimation) | - | - |
| NavigationStyle | ✓ | ✓ (itemColors) | - |
| StepperStyle | ✓ | - | - |
| SkeletonStyle | ✓ | - | - |

### Component Usage Examples

#### TabsStyle with StateColorSpec

```dart
// In component
Widget _buildTab(TabItem tab, bool isSelected) {
  return AppText(
    tab.label,
    color: _style.textColors.resolve(isActive: isSelected),
  );
}

// In theme definition
tabsStyle: TabsStyle(
  textColors: StateColorSpec(
    active: Colors.blue,
    inactive: Colors.grey,
  ),
  indicatorColor: Colors.blue,
  indicatorThickness: 2.0,
),
```

#### BreadcrumbStyle with StateColorSpec

```dart
// In component - isLast means current location (inactive)
Widget _buildItem(BreadcrumbItem item, bool isLast) {
  final color = _style.linkColors.resolve(isActive: !isLast);
  return Text(item.label, style: TextStyle(color: color));
}

// In theme definition
breadcrumbStyle: BreadcrumbStyle(
  linkColors: StateColorSpec(
    active: Colors.blue,      // Clickable links
    inactive: Colors.black87, // Current location
  ),
  separatorText: ' / ',
),
```

#### ChipGroupStyle with StateColorSpec

```dart
// In component
Widget _buildChip(ChipItem chip, bool isSelected) {
  return Container(
    color: _style.backgroundColors.resolve(isActive: isSelected),
    child: Text(
      chip.label,
      style: TextStyle(
        color: _style.textColors.resolve(isActive: isSelected),
      ),
    ),
  );
}

// In theme definition
chipGroupStyle: ChipGroupStyle(
  textColors: StateColorSpec(
    active: Colors.white,
    inactive: Colors.black87,
  ),
  backgroundColors: StateColorSpec(
    active: Colors.blue,
    inactive: Colors.grey.shade200,
  ),
),
```

#### CarouselStyle with AnimationSpec

```dart
// In component
AnimatedPositioned(
  duration: _style.animation.duration,
  curve: _style.animation.curve,
  child: child,
);

// In theme definition
carouselStyle: CarouselStyle(
  animation: AnimationSpec.standard,
  indicatorColors: StateColorSpec(
    active: Colors.blue,
    inactive: Colors.grey,
  ),
),
```

#### NavigationStyle with Both Specs

```dart
// In component
Icon(
  icon,
  color: _style.itemColors.resolve(isActive: isSelected),
);

// Animated transitions
AnimatedContainer(
  duration: _style.animation.duration,
  curve: _style.animation.curve,
);

// In theme definition
navigationStyle: NavigationStyle(
  animation: AnimationSpec.fast,
  itemColors: StateColorSpec(
    active: colorScheme.primary,
    inactive: colorScheme.onSurface.withOpacity(0.6),
  ),
),
```

## Backward Compatibility

All migrated styles provide backward-compatible getters:

```dart
// These still work (but prefer the new API)
final duration = carouselStyle.animationDuration; // → animation.duration
final curve = carouselStyle.animationCurve;       // → animation.curve
final active = tabsStyle.activeTextColor;         // → textColors.active
final inactive = tabsStyle.inactiveTextColor;     // → textColors.inactive

// Recommended new API
final duration = carouselStyle.animation.duration;
final color = tabsStyle.textColors.resolve(isActive: isSelected);
```

## Quick Reference

### AnimationSpec Presets

| Preset | Duration | Curve | Use Case |
|--------|----------|-------|----------|
| `instant` | 0ms | linear | Pixel theme, reduced motion |
| `fast` | 150ms | easeOut | Micro-interactions, hover states |
| `standard` | 300ms | easeInOut | Default transitions |
| `slow` | 500ms | easeInOut | Hero animations, emphasis |

### StateColorSpec Resolution Priority

```
error → disabled → pressed → hover → active/inactive
```

### OverlaySpec Presets

| Preset | Scrim | Blur | Animation | Use Case |
|--------|-------|------|-----------|----------|
| `standard` | black54 | 0.0 | standard | Flat, Neumorphic |
| `glass` | black26 | 10.0 | slow | Glassmorphism |
| `pixel` | black87 | 0.0 | instant | Pixel art theme |
