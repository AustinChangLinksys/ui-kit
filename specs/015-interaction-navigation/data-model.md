# Phase 1 Design: Data Model & Component Entities

**Date**: 2025-12-04
**Related**: [plan.md](plan.md) | [research.md](research.md)

## Overview

This document defines the data structures, state models, and component APIs for all 8 interaction and navigation components. Follows Dart/Flutter conventions and Constitution principles.

---

## 1. Bottom Sheet Component

### Entity: `BottomSheetState`

```dart
class BottomSheetState {
  final bool isOpen;
  final double scrollOffset;
  final double containerHeight;
  final Duration animationDuration;

  BottomSheetState({
    required this.isOpen,
    required this.scrollOffset,
    required this.containerHeight,
    required this.animationDuration,
  });
}
```

### Component Props: `AppBottomSheet`

```dart
class AppBottomSheet extends StatefulWidget {
  // Display properties
  final Widget child;
  final double maxHeight;
  final double minHeight;
  final EdgeInsets padding;

  // Interaction
  final VoidCallback? onDismiss;
  final bool isDismissible; // Tap outside to close
  final bool enableDrag; // Swipe down to close

  // Theming
  final BottomSheetStyle? style;
}
```

### Theme Spec: `BottomSheetStyle`

```dart
@TailorMixin()
class BottomSheetStyle extends ThemeExtension<BottomSheetStyle> {
  final Color overlayColor; // Scrim color
  final Duration animationDuration;
  final Curve animationCurve;
  final double topBorderRadius;
  final double dragHandleHeight;

  // Theme-specific
  // Glass: smooth animation, subtle overlay
  // Brutal: fast animation, dark overlay
  // Pixel: snap animation, thick handle indicator
}
```

### Validation Rules

- `maxHeight` must be > 0 and ≤ screen height
- `minHeight` must be < `maxHeight`
- `animationDuration` must be positive (typical: 300-500ms)

---

## 2. Side Sheet / Drawer Component

### Entity: `SideSheetState`

```dart
class SideSheetState {
  final bool isOpen;
  final double scrollOffset;
  final SheetPosition position; // left or right

  enum SheetPosition { left, right }
}
```

### Component Props: `AppSideSheet`

```dart
class AppSideSheet extends StatefulWidget {
  // Display
  final Widget child;
  final double width;
  final SheetPosition position;
  final bool isPersistent; // Always visible vs overlay

  // Interaction
  final VoidCallback? onDismiss;
  final bool isDismissible;

  // Theming
  final SideSheetStyle? style;
}

class AppDrawer extends AppSideSheet {
  // Convenience wrapper for left-side drawer pattern
}
```

### Theme Spec: `SideSheetStyle`

```dart
@TailorMixin()
class SideSheetStyle extends ThemeExtension<SideSheetStyle> {
  final double width;
  final Color overlayColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final double blurStrength; // Glass theme specific
  final bool enableDithering; // Pixel theme specific

  // Theme variations:
  // Glass: high blur (20+), rim light edges, smooth animation
  // Brutal: dark overlay, fast snap animation
  // Pixel: dithering texture, no animation (snap)
  // Flat: minimal shadow
  // Neumorphic: inset shadow for recessed appearance
}
```

---

## 3. Tabs Component

### Entity: `TabState`

```dart
class TabState {
  final int selectedIndex;
  final List<TabItem> tabs;
  final double scrollOffset; // For scrollable tabs

  TabState({
    required this.selectedIndex,
    required this.tabs,
    this.scrollOffset = 0.0,
  });
}

class TabItem {
  final String label;
  final Widget content;
  final bool enabled;

  TabItem({
    required this.label,
    required this.content,
    this.enabled = true,
  });
}
```

### Component Props: `AppTabs`

```dart
class AppTabs extends StatefulWidget {
  // Content
  final List<TabItem> tabs;
  final int initialIndex;

  // Behavior
  final ValueChanged<int>? onTabChanged;
  final TabsStyle? style;
  final TabDisplayMode displayMode; // segmented, underline, etc.
}

enum TabDisplayMode { segmented, underline, scrollable }
```

### Theme Spec: `TabsStyle`

```dart
@TailorMixin()
class TabsStyle extends ThemeExtension<TabsStyle> {
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color indicatorColor;
  final Color tabBackgroundColor;
  final Duration animationDuration;
  final double indicatorThickness;

  // Theme-specific rendering
  // Glass: smooth indicator animation, glow on active
  // Brutal: bold text on active, thick indicator
  // Pixel: inverted colors or connected block style
  // Neumorphic: subtle shadow on active tab
  // Flat: minimal styling, underline only
}
```

### Validation Rules

- `tabs.length` must be ≥ 2
- `initialIndex` must be in range [0, tabs.length-1]
- All tab labels must be non-empty strings

---

## 4. Stepper Component

### Entity: `StepperState`

```dart
class StepperState {
  final int currentStep;
  final Set<int> completedSteps;
  final List<StepItem> steps;

  bool isStepCompleted(int step) => completedSteps.contains(step);
  bool isStepActive(int step) => step == currentStep;

  StepperState({
    required this.currentStep,
    required this.completedSteps,
    required this.steps,
  });
}

class StepItem {
  final String title;
  final String? description;
  final bool enabled;

  StepItem({
    required this.title,
    this.description,
    this.enabled = true,
  });
}
```

### Component Props: `AppStepper`

```dart
class AppStepper extends StatefulWidget {
  // Content
  final List<StepItem> steps;
  final int currentStep;
  final Set<int> completedSteps;

  // Behavior
  final ValueChanged<int>? onStepTapped;
  final StepperStyle? style;
  final StepperType type; // linear, non-linear
}

enum StepperType { linear, nonLinear }
```

### Theme Spec: `StepperStyle`

```dart
@TailorMixin()
class StepperStyle extends ThemeExtension<StepperStyle> {
  final Color activeStepColor;
  final Color completedStepColor;
  final Color pendingStepColor;
  final Color disabledStepColor;
  final Color connectorColor;
  final double stepSize;
  final bool useDashedConnector; // Pixel theme

  // State indicators
  final Widget Function()? completedIconBuilder; // null = uses default checkmark

  // Theme-specific variations:
  // Glass: glowing active step, smooth connector animation
  // Brutal: bold filled circles, thick connector
  // Pixel: uses pixel checkmark, dashed connector
  // Neumorphic: recessed pending, raised completed
  // Flat: flat styling, minimal shadows
}
```

### Validation Rules

- `steps.length` must be ≥ 2
- `currentStep` must be in range [0, steps.length-1]
- `completedSteps` must not include `currentStep`

---

## 5. Breadcrumb Component

### Entity: `BreadcrumbItem`

```dart
class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;
  final bool isCurrentLocation;

  BreadcrumbItem({
    required this.label,
    this.onTap,
    this.isCurrentLocation = false,
  });
}
```

### Component Props: `AppBreadcrumb`

```dart
class AppBreadcrumb extends StatelessWidget {
  // Content
  final List<BreadcrumbItem> items;

  // Behavior
  final BreadcrumbStyle? style;
  final BreadcrumbOverflowBehavior overflowBehavior;
}

enum BreadcrumbOverflowBehavior {
  ellipsis,    // Show ... for hidden items
  scroll,      // Horizontally scrollable
  wrap         // Wrap to multiple lines
}
```

### Theme Spec: `BreadcrumbStyle`

```dart
@TailorMixin()
class BreadcrumbStyle extends ThemeExtension<BreadcrumbStyle> {
  final Color activeLinkColor;
  final Color inactiveLinkColor;
  final Color separatorColor;
  final String separatorText; // " / ", " > ", etc.
  final TextStyle itemTextStyle;

  // Pixel theme specific
  final bool useAsciiSeparators; // true = ">" instead of "/"
}
```

### Validation Rules

- `items.length` must be ≥ 2
- Exactly one item must have `isCurrentLocation == true`
- All labels must be non-empty strings

---

## 6. Expansion Panel Component

### Entity: `ExpansionPanelState`

```dart
class ExpansionPanelState {
  final Set<int> expandedPanels;
  final bool allowMultipleOpen;

  bool isPanelExpanded(int index) => expandedPanels.contains(index);

  ExpansionPanelState({
    required this.expandedPanels,
    required this.allowMultipleOpen,
  });
}

class ExpansionPanel {
  final String headerTitle;
  final Widget content;
  final bool enabled;
  final bool canExpand;

  ExpansionPanel({
    required this.headerTitle,
    required this.content,
    this.enabled = true,
    this.canExpand = true,
  });
}
```

### Component Props: `AppExpansionPanel`

```dart
class AppExpansionPanel extends StatefulWidget {
  // Content
  final List<ExpansionPanel> panels;

  // Behavior
  final Set<int> initialExpandedIndices;
  final bool allowMultipleOpen;
  final ValueChanged<int>? onPanelToggled;

  // Theming
  final ExpansionPanelStyle? style;
}
```

### Theme Spec: `ExpansionPanelStyle`

```dart
@TailorMixin()
class ExpansionPanelStyle extends ThemeExtension<ExpansionPanelStyle> {
  final Color headerColor;
  final Color expandedBackgroundColor;
  final Color headerTextColor;
  final IconData expandIcon;
  final Duration animationDuration;
  final double headerPadding;

  // Theme-specific
  // Glass: expanded area shows deepened background (recessed look)
  // Brutal: bold border between header/content
  // Pixel: rough expand/collapse indicator
  // Neumorphic: inset shadow on expanded content
  // Flat: minimal styling
}
```

### Validation Rules

- `panels.length` must be ≥ 1
- `initialExpandedIndices` indices must be valid (< panels.length)
- If `allowMultipleOpen == false`, only 0 or 1 panel can be open

---

## 7. Carousel Component

### Entity: `CarouselState`

```dart
class CarouselState {
  final int currentItemIndex;
  final int totalItems;
  final CarouselScrollBehavior scrollBehavior;

  bool canGoNext() => currentItemIndex < totalItems - 1;
  bool canGoPrevious() => currentItemIndex > 0;

  CarouselState({
    required this.currentItemIndex,
    required this.totalItems,
    required this.scrollBehavior,
  });
}

enum CarouselScrollBehavior {
  smooth,    // Smooth animation between items
  snap,      // Instant snap to next item (Pixel theme)
  loop       // Loop back to start after last item
}
```

### Component Props: `AppCarousel`

```dart
class AppCarousel extends StatefulWidget {
  // Content
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  // Sizing
  final double itemHeight;
  final double? itemWidth;
  final EdgeInsets padding;

  // Behavior
  final CarouselScrollBehavior scrollBehavior;
  final ValueChanged<int>? onIndexChanged;
  final bool enableAutoPlay;
  final Duration autoPlayDuration;

  // Navigation
  final bool showNavigationButtons;
  final CarouselStyle? style;
}
```

### Theme Spec: `CarouselStyle`

```dart
@TailorMixin()
class CarouselStyle extends ThemeExtension<CarouselStyle> {
  final Color navButtonColor;
  final Color navButtonHoverColor;
  final IconData previousIcon;
  final IconData nextIcon;
  final Duration animationDuration;
  final Curve animationCurve;

  // Pixel theme specific
  final bool useSnapScroll; // true = instant, false = smooth
  final double navButtonSize; // Pixel theme has larger buttons
}
```

### Validation Rules

- `itemCount` must be > 0
- `itemHeight` must be > 0
- `autoPlayDuration` must be positive (if autoPlay enabled)

---

## 8. Chip Group Component

### Entity: `ChipGroupState`

```dart
class ChipGroupState {
  final Set<int> selectedIndices;
  final bool allowMultiSelect;

  bool isChipSelected(int index) => selectedIndices.contains(index);

  ChipGroupState({
    required this.selectedIndices,
    required this.allowMultiSelect,
  });
}

class ChipItem {
  final String label;
  final bool enabled;
  final String? identifier;

  ChipItem({
    required this.label,
    this.enabled = true,
    this.identifier,
  });
}
```

### Component Props: `AppChipGroup`

```dart
class AppChipGroup extends StatefulWidget {
  // Content
  final List<ChipItem> chips;

  // Behavior
  final bool allowMultiSelect;
  final Set<int> initialSelectedIndices;
  final ValueChanged<Set<int>>? onSelectionChanged;

  // Layout
  final ChipGroupLayout layout; // wrap, scroll
  final Axis scrollDirection;

  // Theming
  final ChipGroupStyle? style;
}

enum ChipGroupLayout { wrap, scroll }
```

### Theme Spec: `ChipGroupStyle`

```dart
@TailorMixin()
class ChipGroupStyle extends ThemeExtension<ChipGroupStyle> {
  final Color unselectedBackground;
  final Color unselectedText;
  final Color selectedBackground;
  final Color selectedText;
  final Color selectedBorderColor;
  final double borderRadius;
  final EdgeInsets padding;

  // Theme-specific
  // Glass: selected chips show illuminated glass with subtle glow
  // Brutal: bold border change on selection
  // Pixel: inverted colors or bold outline
  // Neumorphic: subtle shadow depth change
  // Flat: simple color swap
}
```

### Validation Rules

- `chips.length` must be ≥ 1
- `initialSelectedIndices` indices must be valid
- If `allowMultiSelect == false`, max 1 chip can be selected at a time

---

## Common Patterns

### State Transition Rules

All components follow this pattern:

```dart
// User Action → State Change → UI Rebuild
// ✓ Observable, testable state transitions
// ✓ No side effects or async operations
// ✓ All callbacks are synchronous
```

### Callback Conventions

- `VoidCallback` for simple toggle/dismiss actions
- `ValueChanged<T>` for selection changes with value
- All callbacks are optional and null-safe

### Accessibility Requirements

Every component includes:
- `Semantics` wrapper with proper roles and labels
- Touch targets ≥ 48x48 dp
- Keyboard navigation support
- Screen reader announcements for state changes

### Theme Integration

Every component:
- Accepts optional `Style` parameter from theme extension
- Falls back to `context.extension<AppDesignTheme>()` for default style
- Never hardcodes colors or dimensions
- Respects `AppDesignTheme.spacingFactor` for layout scaling

---

## Theme Spec Implementation Guide

### Overview

Each theme spec is implemented in the corresponding theme file (`glass_design_theme.dart`, `brutal_design_theme.dart`, etc.). The properties listed above define the **structure and interface**; the values are filled in during theme implementation.

### Example: BottomSheetStyle Implementation Pattern

**Task**: Define BottomSheetStyle in each of the 5 themes

```dart
// lib/src/foundation/theme/design_system/styles/glass_design_theme.dart
BottomSheetStyle(
  overlayColor: Colors.black.withOpacity(0.2),   // Subtle overlay for Glass
  animationDuration: Duration(milliseconds: 400),
  animationCurve: Curves.easeInOutCubic,         // Smooth curve for Glass
  topBorderRadius: 16,
  dragHandleHeight: 8,
),

// lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart
BottomSheetStyle(
  overlayColor: Colors.black.withOpacity(0.5),   // Dark overlay for Brutal
  animationDuration: Duration(milliseconds: 200), // Fast animation
  animationCurve: Curves.linear,                  // Instant for Brutal
  topBorderRadius: 0,                             // Sharp corners
  dragHandleHeight: 12,                           // Thick handle
),

// lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart
BottomSheetStyle(
  overlayColor: Colors.black.withOpacity(0.4),
  animationDuration: Duration(milliseconds: 100),
  animationCurve: Curves.linear,                  // Snap animation
  topBorderRadius: 0,
  dragHandleHeight: 16,                           // Extra thick "tab" handle
),
```

### Property Implementation Checklist

For each theme spec (BottomSheetStyle, SideSheetStyle, TabsStyle, etc.):

1. **Color properties**: Use tokens from `AppPalette` or theme-specific colors
   - Glass: High contrast, subtle overlays, glow effects
   - Brutal: Dark, bold, high contrast
   - Flat: Clean, minimal, flat colors only
   - Neumorphic: Soft colors for shadow blending
   - Pixel: High contrast, retro colors, clear distinctions

2. **Duration properties**: Animation timings
   - Glass: 300-500ms (smooth)
   - Brutal: 100-200ms (fast/instant)
   - Flat: 200-300ms (standard)
   - Neumorphic: 250-400ms (gentle)
   - Pixel: 100ms (snap/instant)

3. **Curve properties**: Animation behavior
   - Glass: `Curves.easeInOutCubic` (smooth)
   - Brutal: `Curves.linear` or `Curves.easeInOut` (fast)
   - Flat: `Curves.easeInOut` (standard)
   - Neumorphic: `Curves.easeInOutQuad` (gentle)
   - Pixel: `Curves.linear` (no easing)

4. **Dimension properties**: Sizes
   - Glass: Refined, elegant (e.g., 8px handles, 16px radius)
   - Brutal: Bold, thick (e.g., 12px handles, 2px borders)
   - Flat: Minimal, clean (e.g., 6px handles, 12px radius)
   - Neumorphic: Subtle, soft (e.g., 8px handles, 20px radius)
   - Pixel: Discrete, multiples of 4 or 8 (e.g., 16px handles, 4px radius)

5. **Boolean/Enum properties**: Feature toggles
   - `useSnapScroll`: true for Pixel, false for others
   - `useDashedConnector`: true for Pixel, false for others
   - `useAsciiSeparators`: true for Pixel, false for others
   - `enableDithering`: true for Pixel (SideSheet), false for others

### Per-Theme Guidance

| Property | Glass | Brutal | Flat | Neumorphic | Pixel |
|----------|-------|--------|------|------------|-------|
| **Overlay Color** | 0.1-0.2 opacity | 0.4-0.5 opacity | 0.15 opacity | 0.2 opacity | 0.3 opacity |
| **Animation Duration** | 300-500ms | 100-200ms | 200-300ms | 250-400ms | 100ms |
| **Animation Curve** | easeInOutCubic | linear | easeInOut | easeInOutQuad | linear |
| **Border Radius** | 12-20px | 0-4px | 8-16px | 16-24px | 0-4px (multiples of 4) |
| **Text Weight** | 500 | 700+ | 400 | 500 | 700 |

### Implementation Workflow

1. **Task Phase 2** (T008-T015): Create spec files with @TailorMixin() annotation and property definitions
2. **Task Phase 2** (T017-T021): Implement each spec in the 5 theme files with concrete values
3. **Task Phase 2** (T022): Run `dart run build_runner build` to generate `copyWith()` and `lerp()` methods
4. **During Component Implementation**: Use theme.componentStyle to access the values

### Testing Theme Implementations

Each theme spec is verified during golden tests:
- T032, T043, T054, T063, T073, T083, T092, T102: Golden test files automatically render all 8 combinations (4 themes × 2 brightness)
- Visual verification: All themes should look visually distinct (no two themes look identical)
- Consistency: Behavior within a theme is consistent (Pixel = snap across all components, Glass = smooth across all components)

---

## Summary

The data model defines:
- ✓ 8 component state models
- ✓ 8 theme spec definitions with property structures
- ✓ Component API signatures (all follow Dart conventions)
- ✓ Validation rules for all inputs
- ✓ Accessibility and theming requirements
- ✓ Theme implementation guidance for all 5 visual languages

All models are immutable, testable, and follow Flutter best practices. Ready for implementation phase. Theme implementations are discovered and filled in during Phase 2 task execution (T017-T021).
