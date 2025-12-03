# Design System Parameters Guide

Complete reference documentation for all spec classes and theme implementations in the UI Kit design system.

**Table of Contents:**
- [Architecture Overview](#architecture-overview)
- [Spec Classes](#spec-classes)
  - [Core Surface Styling](#core-surface-styling)
  - [Interaction & Behavior](#interaction--behavior)
  - [Layout & Responsiveness](#layout--responsiveness)
  - [Component Styling](#component-styling)
- [Theme Implementations](#theme-implementations)
- [Usage Examples](#usage-examples)

---

## Architecture Overview

The design system is built on a two-layer architecture:

1. **Spec Classes** (`lib/src/foundation/theme/design_system/specs/`)
   - Define the parameters and structure for visual elements
   - Provide abstract contracts that themes implement
   - Include enums and data models for type safety

2. **Theme Implementations** (`lib/src/foundation/theme/design_system/styles/`)
   - Five distinct visual languages (Glass, Brutal, Flat, Neumorphic, Pixel)
   - Each theme assigns concrete values to spec parameters
   - Themes implement `AppDesignTheme` contract
   - All themes use the same spec classes but with different aesthetics

**Dependency Chain:**
```
Spec Classes (parameters)
    ↓
Theme Implementations (values)
    ↓
Components (usage)
```

---

## Spec Classes

### Core Surface Styling

#### SurfaceStyle

**Purpose:** Define the visual appearance of any surface element (buttons, cards, containers).

**Parameters:**

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `backgroundColor` | `Color` | Required | The main background color of the surface |
| `borderColor` | `Color` | Required | Color of the surface border |
| `contentColor` | `Color` | Required | Color of content (text/icons) on this surface |
| `borderWidth` | `double` | Required | Thickness of the border in logical pixels |
| `borderRadius` | `double` | Required | Corner radius of the surface in logical pixels |
| `customBorder` | `BoxBorder?` | `null` | Custom border implementation (overrides borderColor/borderWidth) |
| `shadows` | `List<BoxShadow>` | `[]` | Box shadows for depth and elevation |
| `blurStrength` | `double` | `0.0` | Blur filter strength (0.0 = no blur, used in glass morphism) |
| `interaction` | `InteractionSpec?` | `null` | Defines response to user interactions (hover, press) |

**Methods:**

```dart
// Create a modified copy with new parameters
SurfaceStyle copyWith({...})

// Blend two styles based on a parameter t (0.0 to 1.0)
static SurfaceStyle lerp(SurfaceStyle a, SurfaceStyle b, double t)

// Check equality
@override
List<Object?> get props => [...]
```

**Usage Example:**
```dart
// Base surface (low emphasis)
const SurfaceStyle(
  backgroundColor: Colors.white,
  borderColor: Colors.grey,
  contentColor: Colors.black,
  borderWidth: 1.0,
  borderRadius: 8.0,
  shadows: [],
  blurStrength: 0.0,
)

// Elevated surface (high emphasis with shadow)
SurfaceStyle(
  backgroundColor: Colors.white,
  borderColor: Colors.transparent,
  contentColor: Colors.black,
  borderWidth: 0.0,
  borderRadius: 12.0,
  shadows: [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 8.0,
      offset: const Offset(0, 2),
    )
  ],
  blurStrength: 0.0,
)
```

---

#### InteractionSpec

**Purpose:** Define how surfaces respond to user interactions (hover, press, drag).

**Parameters:**

| Parameter | Type | Default | Range | Purpose |
|-----------|------|---------|-------|---------|
| `hoverOpacity` | `double` | `1.0` | 0.0-1.0 | Opacity change when user hovers over surface |
| `pressedOpacity` | `double` | `1.0` | 0.0-1.0 | Opacity change when surface is pressed |
| `pressedScale` | `double` | `1.0` | 0.5-1.0 | Scale factor during press (1.0 = no scale, 0.95 = 5% shrink) |
| `pressedOffset` | `Offset` | `Offset.zero` | - | Translation offset during press (for bounce effects) |

**Theme Variations:**

| Theme | Hover | Pressed | Scale | Offset |
|-------|-------|---------|-------|--------|
| Glass | 0.8 | 0.7 | 0.98 | (0, 2) |
| Brutal | 1.0 | 1.0 | 1.0 | (1, 1) |
| Flat | 0.9 | 0.8 | 1.0 | (0, 0) |
| Neumorphic | 0.95 | 0.9 | 0.97 | (0, 1) |
| Pixel | 1.0 | 1.0 | 1.0 | (2, 2) |

**Usage Example:**
```dart
// Responsive button interaction (glass morphism)
const InteractionSpec(
  hoverOpacity: 0.8,
  pressedOpacity: 0.7,
  pressedScale: 0.98,
  pressedOffset: Offset(0, 2),
)

// Mechanical interaction (pixel/brutal)
const InteractionSpec(
  hoverOpacity: 1.0,
  pressedOpacity: 1.0,
  pressedScale: 1.0,
  pressedOffset: Offset(2, 2),
)
```

---

### Interaction & Behavior

#### ToggleStyle

**Purpose:** Define the visual appearance and animation behavior of toggle switches/checkboxes.

**Parameters:**

| Parameter | Type | Purpose |
|-----------|------|---------|
| `onSurface` | `SurfaceStyle` | Style when toggle is ON |
| `offSurface` | `SurfaceStyle` | Style when toggle is OFF |
| `animationDuration` | `Duration` | Duration of toggle animation |
| `animationCurve` | `Curve` | Easing curve for toggle animation |
| `contentBuilder` | `Function(bool)` | Custom widget builder for toggle content |

**Theme Variations:**

| Theme | On/Off Style | Animation | Content |
|-------|-------------|-----------|---------|
| Glass | Transparent surfaces | 300ms easeInOut | Dot indicator (smooth) |
| Brutal | High contrast solid | 200ms linear | Text 'ON'/'OFF' |
| Flat | Material semantic | 250ms easeInOut | Dot indicator (snappy) |
| Neumorphic | Soft raised | 300ms easeInOut | Dot indicator (smooth) |
| Pixel | Hard edges, 2px border | 150ms linear | Text 'ON'/'OFF' with dashes |

---

#### SkeletonStyle

**Purpose:** Define the appearance and animation of loading skeleton screens.

**Parameters:**

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `baseColor` | `Color` | Required | Background color of skeleton |
| `highlightColor` | `Color` | Required | Highlight/shimmer color |
| `animationType` | `SkeletonAnimationType` | Required | Animation style (shimmer/pulse/blink) |
| `borderRadius` | `double` | `0.0` | Corner radius of skeleton blocks |

**SkeletonAnimationType Enum:**

```dart
enum SkeletonAnimationType {
  shimmer,  // Gradient scan left-to-right (creates perception of content loading)
  pulse,    // Smooth opacity fade in/out (gentle, meditative loading effect)
  blink,    // Hard on/off opacity change (mechanical, low-effort effect)
}
```

**Theme Variations:**

| Theme | Animation | Duration | Base Color | Highlight |
|-------|-----------|----------|-----------|-----------|
| Glass | Pulse | 1200ms | Primary (10% alpha) | Primary (20% alpha) |
| Brutal | Blink | 800ms | Solid gray | White |
| Flat | Shimmer | 1500ms | Surface gray | Lighter gray |
| Neumorphic | Pulse | 1200ms | Surface (subtle) | Highlight (soft) |
| Pixel | Blink | 600ms | Solid color | Inverted color |

**Usage Example:**
```dart
// Pulse skeleton (gentle loading)
const SkeletonStyle(
  baseColor: Colors.grey,
  highlightColor: Colors.white,
  animationType: SkeletonAnimationType.pulse,
  borderRadius: 8.0,
)

// Shimmer skeleton (premium feel)
const SkeletonStyle(
  baseColor: Colors.grey,
  highlightColor: Colors.white,
  animationType: SkeletonAnimationType.shimmer,
  borderRadius: 12.0,
)
```

---

#### LoaderStyle

**Purpose:** Define the appearance and behavior of loading spinners/indicators.

**Parameters:**

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `type` | `LoaderType` | Required | Shape of loader (circular/block/pulse) |
| `color` | `Color` | Required | Primary color of the loader |
| `backgroundColor` | `Color?` | `null` | Background color (for some loader types) |
| `strokeWidth` | `double` | `4.0` | Width of stroke for circular loaders |
| `size` | `double` | `40.0` | Diameter/size of loader in logical pixels |
| `period` | `Duration` | `1600ms` | Duration of one complete rotation |
| `shadows` | `List<BoxShadow>` | `[]` | Shadows for depth |
| `borderRadius` | `double` | `0.0` | Border radius (for block loader type) |

**LoaderType Enum:**

```dart
enum LoaderType {
  circular,  // Rotating circle with gap (spinner)
  block,     // Animated rectangular block (pulse effect)
  pulse,     // Smooth size/opacity pulse
}
```

**Theme Variations:**

| Theme | Type | Speed | Size | Has Shadow |
|-------|------|-------|------|-----------|
| Glass | Circular | 1600ms | 36px | Yes (soft) |
| Brutal | Block | 1200ms | 32px | Yes (hard) |
| Flat | Circular | 1600ms | 40px | No |
| Neumorphic | Pulse | 1200ms | 36px | Yes (complex) |
| Pixel | Block | 800ms | 32px | Yes (offset) |

---

#### ToastStyle

**Purpose:** Define the appearance and timing of toast notifications.

**Parameters:**

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `padding` | `EdgeInsets` | `EdgeInsets.all(16)` | Internal spacing within toast |
| `margin` | `EdgeInsets` | `EdgeInsets.all(16)` | External spacing from screen edges |
| `borderRadius` | `BorderRadius` | `BorderRadius.all(Radius.circular(8))` | Corner radius of toast |
| `backgroundColor` | `Color` | Required | Background color of toast |
| `textStyle` | `TextStyle` | Required | Typography for toast message |
| `displayDuration` | `Duration` | `Duration(seconds: 4)` | How long toast displays |

**Theme Variations:**

| Theme | Border Radius | Background Style | Duration | Text Color |
|-------|--------------|------------------|----------|-----------|
| Glass | 12px | Semi-transparent with blur | 4s | White |
| Brutal | 0px (sharp) | Solid color with dark border | 3s | White |
| Flat | 8px | Semantic color (success/error/warning) | 4s | On-color |
| Neumorphic | 16px | Soft color with shadow | 5s | Dark |
| Pixel | 2px (minimal) | Solid with pixel border | 3s | Contrasting |

---

### Layout & Responsiveness

#### LayoutSpec

**Purpose:** Define responsive breakpoints and spacing rules for the entire application.

**Parameters:**

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `breakpointMobile` | `double` | `600.0` | Width threshold for mobile layout (< 600px) |
| `breakpointTablet` | `double` | `900.0` | Width threshold for tablet layout (600-900px) |
| `breakpointDesktop` | `double` | `1200.0` | Width threshold for desktop layout (> 900px) |
| `gutterMobile` | `double` | `16.0` | Column gutter/spacing on mobile |
| `gutterTablet` | `double` | `24.0` | Column gutter/spacing on tablet |
| `gutterDesktop` | `double` | `24.0` | Column gutter/spacing on desktop |
| `marginMobile` | `double` | `16.0` | Screen edge margin on mobile |
| `marginTablet` | `double` | `32.0` | Screen edge margin on tablet |
| `marginDesktop` | `double` | `64.0` | Screen edge margin on desktop |
| `maxColumns` | `int` | `12` | Maximum number of grid columns |

**Helper Methods:**

```dart
// Get appropriate gutter for current width
double gutter(double width) {
  if (width < breakpointMobile) return gutterMobile;
  if (width < breakpointTablet) return gutterTablet;
  return gutterDesktop;
}

// Get appropriate margin for current width
double margin(double width) {
  if (width < breakpointMobile) return marginMobile;
  if (width < breakpointTablet) return marginTablet;
  return marginDesktop;
}

// Check if width is mobile breakpoint
bool isMobile(double width) => width < breakpointTablet;
```

**Usage Example:**
```dart
// Get spacing for current screen size
final spacing = layoutSpec.gutter(MediaQuery.of(context).size.width);

// Create responsive grid with correct columns
int columns = MediaQuery.of(context).size.width < 900 ? 6 : 12;

// Apply responsive margins
final margin = layoutSpec.margin(deviceWidth);
```

**Typical Values by Theme:**

All themes follow the same default LayoutSpec:
- Mobile: < 600px, gutter 16px, margin 16px
- Tablet: 600-900px, gutter 24px, margin 32px
- Desktop: > 900px, gutter 24px, margin 64px
- Grid: 12 columns max

---

#### NavigationStyle

**Purpose:** Define the structure and behavior of navigation rails and bottom navigation.

**Parameters:**

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `height` | `double` | `80.0` | Height of bottom nav / width of nav rail |
| `isFloating` | `bool` | `false` | Whether navigation floats above content |
| `floatingMargin` | `double` | `16.0` | Margin when navigation is floating |
| `itemSpacing` | `double` | `8.0` | Spacing between navigation items |

**Theme Variations:**

| Theme | Height | Floating | Margin | Item Spacing |
|-------|--------|----------|--------|--------------|
| Glass | 80px | true | 16px | 8px |
| Brutal | 80px | false | 0px | 12px |
| Flat | 80px | true | 12px | 8px |
| Neumorphic | 88px | true | 16px | 8px |
| Pixel | 72px | false | 0px | 4px |

**Methods:**

```dart
// Interpolate between two navigation styles
static NavigationStyle lerp(NavigationStyle a, NavigationStyle b, double t)
```

---

### Component Styling

#### DividerStyle

**Purpose:** Define the appearance of divider lines used throughout the UI.

**Parameters:**

| Parameter | Type | Default | Purpose |
|-----------|------|---------|---------|
| `color` | `Color` | Required | Primary color of divider |
| `secondaryColor` | `Color?` | `null` | Secondary color (for patterned dividers) |
| `thickness` | `double` | `1.0` | Height/thickness of divider line |
| `indent` | `double` | `0.0` | Left-side spacing from container edge |
| `endIndent` | `double` | `0.0` | Right-side spacing from container edge |
| `glowStrength` | `double` | `0.0` | Glow/blur effect strength (0.0 = no glow) |
| `pattern` | `DividerPattern` | `solid` | Pattern style (solid/dashed/jagged) |

**DividerPattern Enum:**

```dart
enum DividerPattern {
  solid,   // Continuous line
  dashed,  // Spaced dashes (-- -- --)
  jagged,  // Zigzag/sawtooth pattern
}
```

**Theme Variations:**

| Theme | Color | Thickness | Pattern | Glow |
|-------|-------|-----------|---------|------|
| Glass | Primary (20% alpha) | 1px | Solid | 2.0 |
| Brutal | Black | 2px | Solid | 0.0 |
| Flat | Outline color | 1px | Solid | 0.0 |
| Neumorphic | Surface blend | 1px | Solid | 1.0 |
| Pixel | Black | 2px | Dashed | 0.0 |

**Usage Example:**
```dart
// Subtle divider with glow (glass morphism)
const DividerStyle(
  color: Colors.white,
  thickness: 1.0,
  indent: 16.0,
  endIndent: 16.0,
  glowStrength: 2.0,
  pattern: DividerPattern.solid,
)

// Mechanical divider (brutal/pixel)
const DividerStyle(
  color: Colors.black,
  thickness: 2.0,
  indent: 0.0,
  endIndent: 0.0,
  glowStrength: 0.0,
  pattern: DividerPattern.solid,
)
```

---

#### InputStyle

**Purpose:** Define all visual states for form input elements (text fields, checkboxes, radio buttons).

**Parameters:**

| Parameter | Type | Purpose |
|-----------|------|---------|
| `outlineStyle` | `SurfaceStyle` | Style for outlined/bordered input |
| `underlineStyle` | `SurfaceStyle` | Style for underline-only input |
| `filledStyle` | `SurfaceStyle` | Style for filled/background input |
| `focusModifier` | `SurfaceStyle` | Overlay style when input has focus |
| `errorModifier` | `SurfaceStyle` | Overlay style when input has validation error |

**Usage Example:**
```dart
// Material 3 style input
InputStyle(
  outlineStyle: SurfaceStyle(
    backgroundColor: Colors.transparent,
    borderColor: Colors.grey,
    contentColor: Colors.black,
    borderWidth: 1.0,
    borderRadius: 4.0,
  ),
  underlineStyle: SurfaceStyle(...),
  filledStyle: SurfaceStyle(...),
  focusModifier: SurfaceStyle(
    borderColor: Colors.blue,
    borderWidth: 2.0,
  ),
  errorModifier: SurfaceStyle(
    borderColor: Colors.red,
  ),
)
```

---

## Theme Implementations

Each theme implements all spec classes with a cohesive visual language. Here's the summary:

### Glass Design Theme

**Visual Language:** Glassmorphism - liquid, transparent, and ethereal

**Characteristics:**
- Extensive use of transparency and `blurStrength` (15-35)
- White borders with alpha transparency for softness
- Soft box shadows with low opacity
- High emphasis on interaction states with opacity changes
- Soft corner radius (typically 24px)

**Skeleton Animation:** Pulse (1200ms)

**Key Surface Examples:**
```dart
// surfaceSecondary uses:
backgroundColor: scheme.primary.withValues(alpha: 0.12)
borderColor: Colors.white.withValues(alpha: 0.4)
blurStrength: 15.0
InteractionSpec: pressedScale 0.92, hoverOpacity 0.8
```

---

### Brutal Design Theme

**Visual Language:** Brutalism - hard-edged, geometric, and high-contrast

**Characteristics:**
- Zero border radius (sharp corners)
- Thick borders (2-3px) with black/dark colors
- Prominent box shadows for clear depth
- High contrast between surfaces
- Mechanical, grid-like aesthetic

**Skeleton Animation:** Blink (800ms) - mechanical on/off

**Key Surface Examples:**
```dart
// surfaceHighlight uses:
backgroundColor: Colors.black
borderColor: Colors.white
borderWidth: 3.0
borderRadius: 0.0  (sharp corners)
shadows: [thick dark shadow]
```

---

### Flat Design Theme

**Visual Language:** Material 3 - clean, minimal, semantic colors

**Characteristics:**
- Moderate border radius (8px)
- Minimal or no shadows
- Semantic color usage (primary, secondary, tertiary)
- Transparent backgrounds for base surfaces
- Smooth, snappy animations

**Skeleton Animation:** Shimmer (1500ms) - premium loading feel

**Key Surface Examples:**
```dart
// surfaceBase uses:
backgroundColor: Colors.transparent
borderColor: scheme.outline.withValues(alpha: 0.12)
borderWidth: 1.0
borderRadius: 8.0
shadows: []
```

---

### Neumorphic Design Theme

**Visual Language:** Neumorphism - soft, raised surfaces with diffused shadows

**Characteristics:**
- Complex shadow implementations (inner and outer)
- Soft color blending and gradients
- Emphasis on depth through shadow effects
- Smooth border radius (12-20px)
- Tactile, "pressable" appearance

**Skeleton Animation:** Pulse (1200ms) - smooth, gentle

**Key Surface Examples:**
```dart
// surfaceHighlight uses:
backgroundColor: scheme.primary.withValues(alpha: 0.15)
shadows: [
  BoxShadow(color: Colors.white.withValues(alpha: 0.5), offset: Offset(-2, -2)),
  BoxShadow(color: Colors.black.withValues(alpha: 0.15), offset: Offset(2, 2)),
]
borderRadius: 16.0
```

---

### Pixel Design Theme

**Visual Language:** Retro - 8-bit inspired, mechanical, text-based

**Characteristics:**
- Minimal border radius (2px) for pixel-grid appearance
- Consistent 2px borders
- Sharp, offset shadows (not blurred)
- Dashed dividers instead of solid
- Text-based toggles ('ON'/'OFF')
- Low color palette

**Skeleton Animation:** Blink (600ms) - fast, mechanical

**Key Surface Examples:**
```dart
// surfaceBase uses:
backgroundColor: Colors.white
borderColor: Colors.black
borderWidth: 2.0
borderRadius: 2.0  (minimal, pixel-grid)
shadows: [BoxShadow(color: Colors.black, offset: Offset(2, 2))]
```

---

## Usage Examples

### Example 1: Creating a Custom Button with Specs

```dart
// Using specs to create a consistent button
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final AppDesignTheme theme;

  const CustomButton({
    required this.label,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    // Get surface style from current theme
    final surfaceStyle = theme.surfaceHighlight;
    final interaction = surfaceStyle.interaction ?? const InteractionSpec();

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: surfaceStyle.backgroundColor,
          border: Border.all(
            color: surfaceStyle.borderColor,
            width: surfaceStyle.borderWidth,
          ),
          borderRadius: BorderRadius.circular(surfaceStyle.borderRadius),
          boxShadow: surfaceStyle.shadows,
        ),
        child: InkWell(
          onTap: onTap,
          onHover: (_) {}, // Use interaction.hoverOpacity for state
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              label,
              style: TextStyle(color: surfaceStyle.contentColor),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Example 2: Responsive Layout Using LayoutSpec

```dart
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final AppDesignTheme theme;

  const ResponsiveGrid({
    required this.children,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final spec = theme.layoutSpec;

    // Determine number of columns
    int columns = 1;
    if (width >= spec.breakpointDesktop) {
      columns = 3;
    } else if (width >= spec.breakpointTablet) {
      columns = 2;
    }

    // Get appropriate spacing
    final gutter = spec.gutter(width);
    final margin = spec.margin(width);

    return Padding(
      padding: EdgeInsets.all(margin),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: gutter,
          mainAxisSpacing: gutter,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}
```

### Example 3: Theme Switching with Lerp

```dart
class ThemeTransitionButton extends StatefulWidget {
  @override
  State<ThemeTransitionButton> createState() => _ThemeTransitionButtonState();
}

class _ThemeTransitionButtonState extends State<ThemeTransitionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Interpolate between Glass and Brutal themes
        final glassTheme = GlassDesignTheme();
        final brutalTheme = BrutalDesignTheme();

        // Lerp navigation style
        final navStyle = NavigationStyle.lerp(
          glassTheme.navigationStyle,
          brutalTheme.navigationStyle,
          _animation.value,
        );

        return Container(
          height: navStyle.height,
          color: Colors.grey,
        );
      },
    );
  }
}
```

### Example 4: Creating a Themed Loading State

```dart
class LoadingIndicator extends StatelessWidget {
  final AppDesignTheme theme;

  const LoadingIndicator({required this.theme});

  @override
  Widget build(BuildContext context) {
    final loaderStyle = theme.loaderStyle;

    return SizedBox(
      width: loaderStyle.size,
      height: loaderStyle.size,
      child: CustomPaint(
        painter: _LoaderPainter(
          style: loaderStyle,
          progress: _getAnimationProgress(context),
        ),
      ),
    );
  }

  double _getAnimationProgress(BuildContext context) {
    // Implementation depends on animation controller
    return 0.0;
  }
}
```

### Example 5: Input Styling with InputStyle

```dart
class ThemedTextField extends StatelessWidget {
  final String label;
  final AppDesignTheme theme;

  const ThemedTextField({
    required this.label,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final inputStyle = theme.inputStyle;

    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: inputStyle.outlineStyle.borderColor,
            width: inputStyle.outlineStyle.borderWidth,
          ),
          borderRadius: BorderRadius.circular(
            inputStyle.outlineStyle.borderRadius,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: inputStyle.focusModifier.borderColor,
            width: inputStyle.focusModifier.borderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: inputStyle.errorModifier.borderColor,
            width: inputStyle.errorModifier.borderWidth,
          ),
        ),
        filled: true,
        fillColor: inputStyle.filledStyle.backgroundColor,
      ),
    );
  }
}
```

---

## Summary Table: Spec Classes

| Class | Purpose | Key Parameters | Themes |
|-------|---------|-----------------|--------|
| **SurfaceStyle** | Visual appearance of surfaces | backgroundColor, borderColor, borderWidth, borderRadius, shadows, blurStrength | All themes |
| **InteractionSpec** | User interaction response | hoverOpacity, pressedOpacity, pressedScale, pressedOffset | All themes |
| **LayoutSpec** | Responsive layout rules | breakpoints, gutters, margins, maxColumns | All themes (same defaults) |
| **NavigationStyle** | Navigation structure | height, isFloating, floatingMargin, itemSpacing | All themes |
| **DividerStyle** | Divider appearance | color, thickness, pattern, glowStrength | All themes |
| **InputStyle** | Form input states | outlineStyle, underlineStyle, filledStyle, focusModifier, errorModifier | All themes |
| **SkeletonStyle** | Loading skeleton animation | baseColor, highlightColor, animationType, borderRadius | All themes |
| **LoaderStyle** | Loading spinner appearance | type, color, size, period, strokeWidth | All themes |
| **ToastStyle** | Notification appearance | padding, backgroundColor, textStyle, displayDuration | All themes |

---

## Summary Table: Theme Characteristics

| Theme | Visual Style | Border Radius | Shadows | Animation | Best For |
|-------|-------------|--------------|---------|-----------|----------|
| **Glass** | Glassmorphism | 24px (soft) | Soft, subtle | Smooth (300ms) | Modern, premium apps |
| **Brutal** | Brutalism | 0px (sharp) | Hard, prominent | Snappy (200ms) | Bold, high-contrast UIs |
| **Flat** | Material 3 | 8px (moderate) | Minimal | Clean (250ms) | Standard, familiar feel |
| **Neumorphic** | Neumorphism | 12-20px (soft) | Complex, embossed | Smooth (300ms) | Tactile, raised surfaces |
| **Pixel** | Retro 8-bit | 2px (minimal) | Offset, hard | Fast (150ms) | Retro, gaming aesthetics |

---

## Quick Reference: Parameter Defaults

### All Themes Use Same LayoutSpec Defaults:
- `breakpointMobile`: 600.0
- `breakpointTablet`: 900.0
- `breakpointDesktop`: 1200.0
- `gutterMobile`: 16.0, `gutterTablet`: 24.0, `gutterDesktop`: 24.0
- `marginMobile`: 16.0, `marginTablet`: 32.0, `marginDesktop`: 64.0
- `maxColumns`: 12

### InteractionSpec Defaults (Glass):
- `hoverOpacity`: 0.8
- `pressedOpacity`: 0.7
- `pressedScale`: 0.98
- `pressedOffset`: Offset(0, 2)

### Common SurfaceStyle Patterns:
- **Base**: Transparent background, thin border, no shadow
- **Elevated**: White background, subtle shadow, larger border radius
- **Highlight**: Primary color, prominent border, interactive effects
- **Tonal**: Primary color (low alpha), light shadow, medium radius
