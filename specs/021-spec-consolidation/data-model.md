# Data Model: Theme Spec Consolidation

**Feature**: 021-spec-consolidation
**Date**: 2025-12-08

## Entity Definitions

### AnimationSpec

Shared specification for animation timing across all components.

```dart
@TailorMixin()
class AnimationSpec extends ThemeExtension<AnimationSpec>
    with _$AnimationSpecTailorMixin {

  /// Animation duration
  final Duration duration;

  /// Animation curve
  final Curve curve;

  const AnimationSpec({
    required this.duration,
    required this.curve,
  });

  // --- Presets ---

  /// Instant snap (Pixel theme, 0ms)
  static const instant = AnimationSpec(
    duration: Duration.zero,
    curve: Curves.linear,
  );

  /// Fast micro-interactions (150ms)
  static const fast = AnimationSpec(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeOut,
  );

  /// Standard animations (300ms)
  static const standard = AnimationSpec(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  /// Slow floating effects (500ms, Glass theme)
  static const slow = AnimationSpec(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOutExpo,
  );

  // --- Override Support ---

  AnimationSpec withOverride({
    Duration? duration,
    Curve? curve,
  }) {
    return AnimationSpec(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}
```

**Relationships**: Composed into OverlaySpec, SheetStyle, CarouselStyle, ExpansionPanelStyle, SlideActionStyle, TableStyle, GaugeStyle, LinkStyle (TopologySpec)

---

### StateColorSpec

Shared specification for interactive element color states including active/inactive, hover, pressed, disabled, and error.

```dart
@TailorMixin()
class StateColorSpec extends ThemeExtension<StateColorSpec>
    with _$StateColorSpecTailorMixin {

  /// Color when element is active/selected
  final Color active;

  /// Color when element is inactive/unselected
  final Color inactive;

  /// Color when element is hovered (optional, falls back to active/inactive)
  final Color? hover;

  /// Color when element is pressed (optional, falls back to active/inactive)
  final Color? pressed;

  /// Color when element is disabled (optional, falls back to inactive)
  final Color? disabled;

  /// Color when element has error state (optional)
  final Color? error;

  const StateColorSpec({
    required this.active,
    required this.inactive,
    this.hover,
    this.pressed,
    this.disabled,
    this.error,
  });

  // --- State Resolution ---

  /// Resolve the appropriate color based on current state.
  /// Priority: error > disabled > pressed > hover > active/inactive
  Color resolve({
    required bool isActive,
    bool isHovered = false,
    bool isPressed = false,
    bool isDisabled = false,
    bool hasError = false,
  }) {
    if (hasError && error != null) return error!;
    if (isDisabled) return disabled ?? inactive;
    if (isPressed && pressed != null) return pressed!;
    if (isHovered && hover != null) return hover!;
    return isActive ? active : inactive;
  }

  // --- Override Support ---

  StateColorSpec withOverride({
    Color? active,
    Color? inactive,
    Color? hover,
    Color? pressed,
    Color? disabled,
    Color? error,
  }) {
    return StateColorSpec(
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
      hover: hover ?? this.hover,
      pressed: pressed ?? this.pressed,
      disabled: disabled ?? this.disabled,
      error: error ?? this.error,
    );
  }
}
```

**Relationships**: Composed into TabsStyle, BreadcrumbStyle, ChipGroupStyle, CarouselStyle (navButtonColors), TableStyle (rowColors)

**Note**: StepperStyle uses a 3-state pattern (active/completed/pending) which does not fit the StateColorSpec 2-state model. StepperStyle retains separate color properties.

---

### OverlaySpec

Shared specification for modal overlay appearance (sheets, dialogs).

```dart
@TailorMixin()
class OverlaySpec extends ThemeExtension<OverlaySpec>
    with _$OverlaySpecTailorMixin {

  /// Scrim/backdrop color
  final Color scrimColor;

  /// Blur strength for Glass theme (0 for others)
  final double blurStrength;

  /// Animation timing for overlay transitions
  final AnimationSpec animation;

  const OverlaySpec({
    required this.scrimColor,
    this.blurStrength = 0.0,
    required this.animation,
  });

  // --- Presets ---

  /// Standard overlay (Flat/Brutal/Neumorphic themes)
  static const standard = OverlaySpec(
    scrimColor: Color(0x8A000000), // black54
    blurStrength: 0.0,
    animation: AnimationSpec.standard,
  );

  /// Glass theme overlay with blur
  static const glass = OverlaySpec(
    scrimColor: Color(0x42000000), // black26
    blurStrength: 10.0,
    animation: AnimationSpec.slow,
  );

  /// Pixel theme overlay (no blur, instant)
  static const pixel = OverlaySpec(
    scrimColor: Color(0xDE000000), // black87
    blurStrength: 0.0,
    animation: AnimationSpec.instant,
  );

  // --- Override Support ---

  OverlaySpec withOverride({
    Color? scrimColor,
    double? blurStrength,
    AnimationSpec? animation,
  }) {
    return OverlaySpec(
      scrimColor: scrimColor ?? this.scrimColor,
      blurStrength: blurStrength ?? this.blurStrength,
      animation: animation ?? this.animation,
    );
  }
}
```

**Relationships**: Composed into SheetStyle, DialogStyle

---

### SheetStyle

Unified style for both bottom sheets and side sheets.

```dart
/// Direction discriminator for sheet positioning
enum SheetDirection {
  /// Sheet slides from bottom
  bottom,

  /// Sheet slides from side (left or right)
  side,
}

@TailorMixin()
class SheetStyle extends ThemeExtension<SheetStyle>
    with _$SheetStyleTailorMixin {

  /// Overlay appearance (scrim, blur, animation)
  final OverlaySpec overlay;

  /// Border radius for sheet corners
  final double borderRadius;

  /// Sheet width (for side sheets) or null for full width (bottom sheets)
  final double? width;

  /// Height of drag handle indicator (bottom sheets only)
  final double dragHandleHeight;

  /// Enable dithering texture (Pixel theme)
  final bool enableDithering;

  const SheetStyle({
    required this.overlay,
    required this.borderRadius,
    this.width,
    this.dragHandleHeight = 4.0,
    this.enableDithering = false,
  });

  // --- Override Support ---

  SheetStyle withOverride({
    OverlaySpec? overlay,
    double? borderRadius,
    double? width,
    double? dragHandleHeight,
    bool? enableDithering,
  }) {
    return SheetStyle(
      overlay: overlay ?? this.overlay,
      borderRadius: borderRadius ?? this.borderRadius,
      width: width ?? this.width,
      dragHandleHeight: dragHandleHeight ?? this.dragHandleHeight,
      enableDithering: enableDithering ?? this.enableDithering,
    );
  }
}
```

**Relationships**:
- Composes OverlaySpec
- Used by AppBottomSheet, AppSideSheet, AppDrawer
- Replaces deprecated BottomSheetStyle, SideSheetStyle

---

### StyleOverride

InheritedWidget for subtree-level spec overrides.

```dart
class StyleOverride extends InheritedWidget {
  /// Override for animation specs
  final AnimationSpec? animationSpec;

  /// Override for state color specs
  final StateColorSpec? stateColorSpec;

  /// Override for overlay specs
  final OverlaySpec? overlaySpec;

  const StyleOverride({
    super.key,
    required super.child,
    this.animationSpec,
    this.stateColorSpec,
    this.overlaySpec,
  });

  /// Get the nearest StyleOverride ancestor
  static StyleOverride? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StyleOverride>();
  }

  /// Resolve a specific spec type with fallback chain:
  /// StyleOverride > theme default
  static T? resolveSpec<T>(BuildContext context) {
    final override = maybeOf(context);
    if (override == null) return null;

    if (T == AnimationSpec) return override.animationSpec as T?;
    if (T == StateColorSpec) return override.stateColorSpec as T?;
    if (T == OverlaySpec) return override.overlaySpec as T?;

    return null;
  }

  @override
  bool updateShouldNotify(StyleOverride oldWidget) {
    return animationSpec != oldWidget.animationSpec ||
           stateColorSpec != oldWidget.stateColorSpec ||
           overlaySpec != oldWidget.overlaySpec;
  }
}
```

**Relationships**: Used by all components that need local override support

---

---

### CarouselStyle (Refactored)

Carousel navigation style composing AnimationSpec.

```dart
@TailorMixin()
class CarouselStyle extends ThemeExtension<CarouselStyle>
    with _$CarouselStyleTailorMixin {

  /// Navigation button colors (normal/hover)
  final StateColorSpec navButtonColors;

  /// Previous button icon
  final IconData previousIcon;

  /// Next button icon
  final IconData nextIcon;

  /// Animation timing for transitions
  final AnimationSpec animation;

  /// Whether to use snap scrolling
  final bool useSnapScroll;

  /// Navigation button size
  final double navButtonSize;

  const CarouselStyle({
    required this.navButtonColors,
    required this.previousIcon,
    required this.nextIcon,
    required this.animation,
    required this.useSnapScroll,
    required this.navButtonSize,
  });

  // --- Backward Compatibility ---

  /// Animation duration (convenience getter)
  Duration get animationDuration => animation.duration;

  /// Animation curve (convenience getter)
  Curve get animationCurve => animation.curve;

  /// Navigation button color (convenience getter)
  Color get navButtonColor => navButtonColors.inactive;

  /// Navigation button hover color (convenience getter)
  Color get navButtonHoverColor => navButtonColors.hover ?? navButtonColors.active;
}
```

**Relationships**: Composes AnimationSpec, StateColorSpec

---

### ExpansionPanelStyle (Refactored)

Expansion panel style composing AnimationSpec.

```dart
@TailorMixin()
class ExpansionPanelStyle extends ThemeExtension<ExpansionPanelStyle>
    with _$ExpansionPanelStyleTailorMixin {

  final Color headerColor;
  final Color expandedBackgroundColor;
  final Color headerTextColor;
  final IconData expandIcon;

  /// Animation timing for expand/collapse
  final AnimationSpec animation;

  const ExpansionPanelStyle({
    required this.headerColor,
    required this.expandedBackgroundColor,
    required this.headerTextColor,
    required this.expandIcon,
    required this.animation,
  });

  // --- Backward Compatibility ---

  /// Animation duration (convenience getter)
  Duration get animationDuration => animation.duration;
}
```

**Relationships**: Composes AnimationSpec

---

### SlideActionStyle (Refactored)

Slide action style composing AnimationSpec.

```dart
@TailorMixin()
class SlideActionStyle extends ThemeExtension<SlideActionStyle>
    with _$SlideActionStyleTailorMixin {

  final SurfaceStyle standardStyle;
  final SurfaceStyle destructiveStyle;
  final BorderRadius borderRadius;
  final Color contentColor;
  final double iconSize;

  /// Animation timing for slide transitions
  final AnimationSpec animation;

  const SlideActionStyle({
    required this.standardStyle,
    required this.destructiveStyle,
    required this.borderRadius,
    required this.contentColor,
    required this.iconSize,
    required this.animation,
  });

  // --- Backward Compatibility ---

  /// Animation duration (convenience getter)
  Duration get animationDuration => animation.duration;

  /// Animation curve (convenience getter)
  Curve get animationCurve => animation.curve;
}
```

**Relationships**: Composes AnimationSpec

---

### ExpandableFabStyle (Refactored)

Expandable FAB style composing OverlaySpec.

```dart
@TailorMixin()
class ExpandableFabStyle extends ThemeExtension<ExpandableFabStyle>
    with _$ExpandableFabStyleTailorMixin {

  final BoxShape shape;
  final double distance;
  final FabAnimationType type;

  /// Overlay appearance (scrim, blur, animation)
  final OverlaySpec overlay;

  final bool showDitherPattern;
  final bool glowEffect;
  final bool highContrastBorder;

  const ExpandableFabStyle({
    required this.shape,
    required this.distance,
    required this.type,
    required this.overlay,
    required this.showDitherPattern,
    required this.glowEffect,
    required this.highContrastBorder,
  });

  // --- Backward Compatibility ---

  /// Overlay color (convenience getter)
  Color get overlayColor => overlay.scrimColor;

  /// Enable blur (convenience getter)
  bool get enableBlur => overlay.blurStrength > 0;
}
```

**Relationships**: Composes OverlaySpec

---

### TableStyle (Refactored)

Table style composing AnimationSpec for mode transitions.

```dart
@TailorMixin()
class TableStyle extends ThemeExtension<TableStyle>
    with _$TableStyleTailorMixin {

  final Color headerBackground;
  final Color rowBackground;
  final Color gridColor;
  final double gridWidth;
  final bool showVerticalGrid;
  final EdgeInsets cellPadding;
  final double rowHeight;
  final TextStyle headerTextStyle;
  final TextStyle cellTextStyle;
  final bool invertRowOnHover;
  final bool glowRowOnHover;
  final Color? hoverRowBackground;
  final Color? hoverRowContentColor;

  /// Animation timing for mode transitions
  final AnimationSpec modeTransition;

  const TableStyle({
    required this.headerBackground,
    required this.rowBackground,
    required this.gridColor,
    required this.gridWidth,
    required this.showVerticalGrid,
    required this.cellPadding,
    required this.rowHeight,
    required this.headerTextStyle,
    required this.cellTextStyle,
    required this.invertRowOnHover,
    required this.glowRowOnHover,
    this.hoverRowBackground,
    this.hoverRowContentColor,
    required this.modeTransition,
  });

  // --- Backward Compatibility ---

  /// Mode transition duration (convenience getter)
  Duration get modeTransitionDuration => modeTransition.duration;
}
```

**Relationships**: Composes AnimationSpec

---

### LinkStyle (Refactored - within TopologySpec)

Network link style composing AnimationSpec.

```dart
class LinkStyle {
  final Color color;
  final double width;
  final List<double>? dashPattern;
  final Color glowColor;
  final double glowRadius;

  /// Animation timing for link effects
  final AnimationSpec animation;

  const LinkStyle({
    required this.color,
    required this.width,
    this.dashPattern,
    required this.glowColor,
    required this.glowRadius,
    required this.animation,
  });

  // --- Backward Compatibility ---

  /// Animation duration (convenience getter)
  Duration get animationDuration => animation.duration;
}
```

**Relationships**: Composes AnimationSpec, contained within TopologySpec

---

### GaugeStyle (Refactored)

Gauge rendering style composing AnimationSpec.

```dart
@TailorMixin()
class GaugeStyle extends ThemeExtension<GaugeStyle>
    with _$GaugeStyleTailorMixin {

  final GaugeRenderType type;
  final GaugeCapType cap;
  final Color trackColor;
  final Color indicatorColor;
  final bool showTicks;
  final int? tickCount;
  final double? tickInterval;
  final double strokeWidth;
  final bool enableGlow;
  final double fillRatio;
  final double offsetAngle;
  final double markerRadius;
  final bool displayMarkerValues;
  final Color markerColor;
  final double innerGlowWidth;
  final double innerGlowOpacity;

  /// Animation timing for gauge transitions
  final AnimationSpec animation;

  const GaugeStyle({
    required this.type,
    required this.cap,
    required this.trackColor,
    required this.indicatorColor,
    required this.showTicks,
    this.tickCount,
    this.tickInterval,
    required this.strokeWidth,
    required this.enableGlow,
    this.fillRatio = 0.8,
    this.offsetAngle = 0.942,
    this.markerRadius = 4.0,
    this.displayMarkerValues = true,
    this.markerColor = Colors.white,
    this.innerGlowWidth = 80.0,
    this.innerGlowOpacity = 0.1,
    required this.animation,
  });

  // --- Backward Compatibility ---

  /// Animation duration (convenience getter)
  Duration get animationDuration => animation.duration;

  /// Animation curve (convenience getter)
  Curve get animationCurve => animation.curve;
}
```

**Relationships**: Composes AnimationSpec

---

## Entity Relationships

```
┌─────────────────────────────────────────────────────────────────┐
│                         AppDesignTheme                          │
│  (Single Source of Truth for all specs)                         │
└─────────────────────────────────────────────────────────────────┘
                                │
         ┌──────────────────────┼──────────────────────┐
         │                      │                      │
         ▼                      ▼                      ▼
┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
│   SheetStyle    │   │    TabsStyle    │   │  StepperStyle   │
│  (bottom/side)  │   │                 │   │                 │
└────────┬────────┘   └────────┬────────┘   └────────┬────────┘
         │                     │                     │
         ▼                     ▼                     ▼
┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
│   OverlaySpec   │   │  StateColorSpec │   │  AnimationSpec  │
│ (scrim, blur,   │   │ (active/inactive│   │ (duration,      │
│  animation)     │   │  colors)        │   │  curve)         │
└────────┬────────┘   └─────────────────┘   └─────────────────┘
         │
         ▼
┌─────────────────┐
│  AnimationSpec  │
│ (nested)        │
└─────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                        StyleOverride                            │
│  (InheritedWidget for local overrides)                          │
│  - animationSpec?: AnimationSpec                                │
│  - stateColorSpec?: StateColorSpec                              │
│  - overlaySpec?: OverlaySpec                                    │
└─────────────────────────────────────────────────────────────────┘
```

## Validation Rules

### AnimationSpec
- `duration` must be non-negative (enforced by Duration type)
- `curve` must be a valid Flutter Curve

### StateColorSpec
- `active` and `inactive` are required (non-nullable)
- `disabled` and `error` are optional with sensible fallbacks

### OverlaySpec
- `blurStrength` must be >= 0
- `animation` is required (no default to enforce explicit configuration)

### SheetStyle
- `borderRadius` must be >= 0
- `dragHandleHeight` must be >= 0
- `width` is nullable (null = full width for bottom sheets)

## State Transitions

Not applicable - these are immutable data classes without state transitions.
