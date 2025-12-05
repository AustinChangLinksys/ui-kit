# Component API Contracts

**Date**: 2025-12-04
**Location**: Component public interfaces for all 8 interaction & navigation components

---

## 1. AppBottomSheet Contract

```dart
class AppBottomSheet extends StatefulWidget {
  /// The content to display inside the bottom sheet.
  final Widget child;

  /// Maximum height of the sheet. Defaults to 80% of screen height.
  final double? maxHeight;

  /// Minimum height of the sheet. Defaults to auto-sizing.
  final double? minHeight;

  /// Padding inside the sheet.
  final EdgeInsets padding;

  /// Callback when sheet is dismissed.
  final VoidCallback? onDismiss;

  /// Whether sheet can be dismissed by tapping outside.
  /// Default: true
  final bool isDismissible;

  /// Whether sheet can be dragged to dismiss.
  /// Default: true
  final bool enableDrag;

  /// Custom style for this sheet (uses theme default if null).
  final BottomSheetStyle? style;

  const AppBottomSheet({
    Key? key,
    required this.child,
    this.maxHeight,
    this.minHeight,
    this.padding = const EdgeInsets.all(16),
    this.onDismiss,
    this.isDismissible = true,
    this.enableDrag = true,
    this.style,
  }) : super(key: key);

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}
```

---

## 2. AppSideSheet & AppDrawer Contract

```dart
class AppSideSheet extends StatefulWidget {
  /// The content to display inside the side sheet.
  final Widget child;

  /// Width of the sheet. Defaults to 250dp for drawer, 300dp for side sheet.
  final double? width;

  /// Position of sheet (left or right).
  /// Default: left
  final SheetPosition position;

  /// Whether sheet is always visible (persistent) or overlay.
  /// Default: false (overlay mode)
  final bool isPersistent;

  /// Callback when sheet is dismissed.
  final VoidCallback? onDismiss;

  /// Whether sheet can be dismissed (only in overlay mode).
  /// Default: true
  final bool isDismissible;

  /// Custom style for this sheet.
  final SideSheetStyle? style;

  const AppSideSheet({
    Key? key,
    required this.child,
    this.width,
    this.position = SheetPosition.left,
    this.isPersistent = false,
    this.onDismiss,
    this.isDismissible = true,
    this.style,
  }) : super(key: key);

  @override
  State<AppSideSheet> createState() => _AppSideSheetState();
}

enum SheetPosition { left, right }

/// Convenience drawer implementation
class AppDrawer extends AppSideSheet {
  const AppDrawer({
    Key? key,
    required Widget child,
    double? width,
    VoidCallback? onDismiss,
    SideSheetStyle? style,
  }) : super(
    key: key,
    child: child,
    width: width,
    position: SheetPosition.left,
    isPersistent: false,
    onDismiss: onDismiss,
    style: style,
  );
}
```

---

## 3. AppTabs Contract

```dart
class AppTabs extends StatefulWidget {
  /// List of tab items to display.
  final List<TabItem> tabs;

  /// Index of initially selected tab.
  /// Default: 0
  final int initialIndex;

  /// Display style for tabs (segmented, underline, scrollable).
  /// Default: underline
  final TabDisplayMode displayMode;

  /// Callback when tab selection changes.
  final ValueChanged<int>? onTabChanged;

  /// Custom style for tabs.
  final TabsStyle? style;

  const AppTabs({
    Key? key,
    required this.tabs,
    this.initialIndex = 0,
    this.displayMode = TabDisplayMode.underline,
    this.onTabChanged,
    this.style,
  }) : super(key: key);

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class TabItem {
  /// Display label for the tab.
  final String label;

  /// Content widget to display when this tab is active.
  final Widget content;

  /// Whether this tab can be selected.
  /// Default: true
  final bool enabled;

  TabItem({
    required this.label,
    required this.content,
    this.enabled = true,
  });
}

enum TabDisplayMode {
  segmented,   // Button-style tabs in a row
  underline,   // Tabs with underline indicator (default)
  scrollable,  // Horizontally scrollable tabs
}
```

---

## 4. AppStepper Contract

```dart
class AppStepper extends StatefulWidget {
  /// List of steps to display.
  final List<StepItem> steps;

  /// Index of the current step (0-based).
  final int currentStep;

  /// Set of step indices that have been completed.
  /// Default: empty set
  final Set<int> completedSteps;

  /// Callback when a step is tapped.
  final ValueChanged<int>? onStepTapped;

  /// Whether stepper is linear (must complete steps in order) or non-linear.
  /// Default: linear
  final StepperType type;

  /// Custom style for stepper.
  final StepperStyle? style;

  const AppStepper({
    Key? key,
    required this.steps,
    required this.currentStep,
    this.completedSteps = const {},
    this.onStepTapped,
    this.type = StepperType.linear,
    this.style,
  }) : super(key: key);

  @override
  State<AppStepper> createState() => _AppStepperState();
}

class StepItem {
  /// Title displayed for this step.
  final String title;

  /// Optional description displayed below the title.
  final String? description;

  /// Whether this step can be interacted with.
  /// Default: true
  final bool enabled;

  StepItem({
    required this.title,
    this.description,
    this.enabled = true,
  });
}

enum StepperType {
  linear,      // Must complete steps in order
  nonLinear,   // Can jump to any step
}
```

---

## 5. AppBreadcrumb Contract

```dart
class AppBreadcrumb extends StatelessWidget {
  /// List of breadcrumb items in order.
  final List<BreadcrumbItem> items;

  /// How to handle overflow (ellipsis, scroll, or wrap).
  /// Default: ellipsis
  final BreadcrumbOverflowBehavior overflowBehavior;

  /// Custom style for breadcrumb.
  final BreadcrumbStyle? style;

  const AppBreadcrumb({
    Key? key,
    required this.items,
    this.overflowBehavior = BreadcrumbOverflowBehavior.ellipsis,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ...; // Implementation
}

class BreadcrumbItem {
  /// Text label for this breadcrumb segment.
  final String label;

  /// Callback when this breadcrumb is tapped.
  /// Must be null if isCurrentLocation is true.
  final VoidCallback? onTap;

  /// Whether this is the current location (last item).
  /// Exactly one item must have this set to true.
  /// Default: false
  final bool isCurrentLocation;

  BreadcrumbItem({
    required this.label,
    this.onTap,
    this.isCurrentLocation = false,
  });
}

enum BreadcrumbOverflowBehavior {
  ellipsis, // Show "..." for hidden items
  scroll,   // Horizontal scroll for overflow items
  wrap,     // Wrap to multiple lines
}
```

---

## 6. AppExpansionPanel Contract

```dart
class AppExpansionPanel extends StatefulWidget {
  /// List of expansion panels.
  final List<ExpansionPanel> panels;

  /// Indices of initially expanded panels.
  /// Default: empty set
  final Set<int> initialExpandedIndices;

  /// Whether multiple panels can be open simultaneously.
  /// Default: true
  final bool allowMultipleOpen;

  /// Callback when a panel is toggled.
  final ValueChanged<int>? onPanelToggled;

  /// Custom style for expansion panels.
  final ExpansionPanelStyle? style;

  const AppExpansionPanel({
    Key? key,
    required this.panels,
    this.initialExpandedIndices = const {},
    this.allowMultipleOpen = true,
    this.onPanelToggled,
    this.style,
  }) : super(key: key);

  @override
  State<AppExpansionPanel> createState() => _AppExpansionPanelState();
}

class ExpansionPanel {
  /// Title displayed in the panel header.
  final String headerTitle;

  /// Content displayed when panel is expanded.
  final Widget content;

  /// Whether this panel can be interacted with.
  /// Default: true
  final bool enabled;

  /// Whether this panel can be expanded.
  /// Default: true
  final bool canExpand;

  ExpansionPanel({
    required this.headerTitle,
    required this.content,
    this.enabled = true,
    this.canExpand = true,
  });
}
```

---

## 7. AppCarousel Contract

```dart
class AppCarousel extends StatefulWidget {
  /// Number of items in the carousel.
  final int itemCount;

  /// Builder function to create each carousel item.
  final Widget Function(BuildContext, int) itemBuilder;

  /// Height of each carousel item.
  final double itemHeight;

  /// Optional width of each carousel item.
  /// Default: container width
  final double? itemWidth;

  /// Padding around the carousel.
  final EdgeInsets padding;

  /// How the carousel should scroll between items.
  /// Default: smooth
  final CarouselScrollBehavior scrollBehavior;

  /// Callback when active item index changes.
  final ValueChanged<int>? onIndexChanged;

  /// Whether to automatically advance items.
  /// Default: false
  final bool enableAutoPlay;

  /// Duration between auto-play advances (only if enableAutoPlay is true).
  /// Default: 3 seconds
  final Duration autoPlayDuration;

  /// Whether to show previous/next navigation buttons.
  /// Default: true
  final bool showNavigationButtons;

  /// Custom style for carousel.
  final CarouselStyle? style;

  const AppCarousel({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.itemHeight,
    this.itemWidth,
    this.padding = const EdgeInsets.all(0),
    this.scrollBehavior = CarouselScrollBehavior.smooth,
    this.onIndexChanged,
    this.enableAutoPlay = false,
    this.autoPlayDuration = const Duration(seconds: 3),
    this.showNavigationButtons = true,
    this.style,
  }) : super(key: key);

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

enum CarouselScrollBehavior {
  smooth, // Smooth animation between items
  snap,   // Instant snap to next item
  loop,   // Loop back to start after last item
}
```

---

## 8. AppChipGroup Contract

```dart
class AppChipGroup extends StatefulWidget {
  /// List of chips in this group.
  final List<ChipItem> chips;

  /// Whether multiple chips can be selected simultaneously.
  /// Default: false (single-select)
  final bool allowMultiSelect;

  /// Indices of initially selected chips.
  /// Default: empty set
  final Set<int> initialSelectedIndices;

  /// Callback when selection changes.
  /// Passes set of selected chip indices.
  final ValueChanged<Set<int>>? onSelectionChanged;

  /// How chips should be laid out (wrap or scroll).
  /// Default: wrap
  final ChipGroupLayout layout;

  /// Direction for scrolling (only if layout == scroll).
  /// Default: horizontal
  final Axis scrollDirection;

  /// Custom style for chip group.
  final ChipGroupStyle? style;

  const AppChipGroup({
    Key? key,
    required this.chips,
    this.allowMultiSelect = false,
    this.initialSelectedIndices = const {},
    this.onSelectionChanged,
    this.layout = ChipGroupLayout.wrap,
    this.scrollDirection = Axis.horizontal,
    this.style,
  }) : super(key: key);

  @override
  State<AppChipGroup> createState() => _AppChipGroupState();
}

class ChipItem {
  /// Display text for the chip.
  final String label;

  /// Whether this chip can be selected.
  /// Default: true
  final bool enabled;

  /// Optional unique identifier for this chip.
  /// If not provided, index is used as identifier.
  final String? identifier;

  ChipItem({
    required this.label,
    this.enabled = true,
    this.identifier,
  });
}

enum ChipGroupLayout {
  wrap,   // Wrap to multiple lines
  scroll, // Scroll horizontally/vertically
}
```

---

## Theme Spec Contracts

### BottomSheetStyle

```dart
@TailorMixin()
class BottomSheetStyle extends ThemeExtension<BottomSheetStyle> {
  final Color overlayColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final double topBorderRadius;
  final double dragHandleHeight;

  const BottomSheetStyle({
    required this.overlayColor,
    required this.animationDuration,
    required this.animationCurve,
    required this.topBorderRadius,
    required this.dragHandleHeight,
  });

  @override
  BottomSheetStyle copyWith({...}) => ...;

  @override
  BottomSheetStyle lerp(BottomSheetStyle? other, double t) => ...;
}
```

### SideSheetStyle, TabsStyle, StepperStyle, etc.

Similar structure to BottomSheetStyle above. Each has:
- Required properties for the component
- Theme-specific overrides
- Auto-generated `copyWith()` and `lerp()` methods via @TailorMixin

---

## Usage Summary

All components follow these patterns:

```dart
// 1. Basic constructor with required child/content parameter
// 2. Optional theme style parameter
// 3. Callback parameters for user interactions
// 4. Configuration parameters (sizing, behavior, display mode)
// 5. All parameters are documented with dartdoc

// Example:
AppTabs(
  tabs: [...],                              // Required
  initialIndex: 0,                          // Configuration
  onTabChanged: (index) => print(index),   // Callback
  style: null,                              // Optional theme style
)
```

All components:
- ✅ Accept optional style parameters (use theme default if null)
- ✅ Are dumb/presentational (no business logic)
- ✅ Use callbacks for all user interactions
- ✅ Have explicit documentation for all parameters
- ✅ Follow Dart naming conventions
- ✅ Are fully testable with unit/widget/golden tests

---

**Generated**: 2025-12-04 as part of Phase 4 planning
**Ready for**: Implementation phase
