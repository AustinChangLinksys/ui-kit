# Research: Phase 2 UI Kit Components

**Feature**: 011-phase2-components
**Date**: 2025-12-04
**Status**: Complete

## Research Summary

This document captures research findings and design decisions for implementing Phase 2 UI Kit components (AppBar, SliverAppBar, PopupMenu, Dialog) with multi-style support.

---

## 1. Existing Codebase Patterns

### 1.1 Theme Spec Pattern

**Decision**: Follow established `*Style` spec pattern with `SurfaceStyle` composition

**Rationale**: Existing specs (InputStyle, ToggleStyle, NavigationStyle) demonstrate the pattern:
- Specs are plain Dart classes with `Equatable` for value comparison
- Specs contain `SurfaceStyle` references for visual properties
- Specs contain additional semantic properties specific to the component
- Specs are registered in `AppDesignTheme` and populated per design language

**Alternatives Considered**:
- Direct SurfaceStyle usage without wrapper: Rejected - loses component-specific semantics
- Widget-level style classes: Rejected - violates DDS principle

**Reference Files**:
- `lib/src/foundation/theme/design_system/specs/input_style.dart`
- `lib/src/foundation/theme/design_system/specs/navigation_style.dart`
- `lib/src/foundation/theme/design_system/specs/toggle_style.dart`

### 1.2 Component Structure Pattern

**Decision**: Use `AppSurface` as rendering primitive, slots pattern for composition

**Rationale**: Constitution mandates AppSurface for all visual containers. Existing molecules demonstrate:
- `AppSurface(variant: ...)` for simple cases
- `AppSurface(style: theme.xxxStyle.someProperty)` for specific overrides
- Slots via `child`, `leading`, `trailing`, `content` parameters

**Reference Files**:
- `lib/src/molecules/dialogs/app_dialog.dart` (existing minimal implementation)
- `lib/src/molecules/buttons/app_button.dart`
- `lib/src/molecules/layout/app_list_tile.dart`

### 1.3 Golden Test Pattern

**Decision**: Use `buildThemeMatrix()` for comprehensive visual testing

**Rationale**: Constitution Section 12.2 mandates Test Matrix with Safe Mode Protocol:
- `buildThemeMatrix()` generates 8 scenarios (4 themes x 2 modes)
- Built-in safe mode: explicit constraints, background visibility, animation freezing
- Test file structure: `test/{tier}/{component}/*_golden_test.dart`

**Reference Files**:
- `test/molecules/buttons/app_button_golden_test.dart`
- `test/test_utils/golden_test_matrix_factory.dart`

---

## 2. Style-Specific Rendering Research

### 2.1 Flat Style Characteristics

**Decision**: Solid fills, standard radius (8px), minimal shadows, no blur

**Key Properties**:
- `backgroundColor`: Solid color from `scheme.surface`
- `borderRadius`: 8.0
- `borderWidth`: 0-1px (hairline or none)
- `shadows`: Minimal or none
- `blurStrength`: 0.0 (CRITICAL: no BackdropFilter)

**Performance Note**: Flat style must NOT use BackdropFilter to avoid resource waste (FR-016).

### 2.2 Glass Style Characteristics

**Decision**: Translucent fills, large radius (24px), blur effect, subtle glow

**Key Properties**:
- `backgroundColor`: `scheme.surface.withValues(alpha: 0.02-0.15)`
- `borderRadius`: 24.0
- `borderWidth`: 1.5px with translucent border
- `blurStrength`: 20-35 sigma
- `shadows`: Soft glow effects with primary color tint

**AppBar Glass Note**: When content scrolls underneath, blur must be visible. AppBar background opacity < 1.0.

### 2.3 Pixel Style Characteristics

**Decision**: Sharp corners (2px radius), thick borders (2px), block shadows

**Key Properties**:
- `backgroundColor`: Solid opaque
- `borderRadius`: 2.0 (near-sharp)
- `borderWidth`: 2.0
- `shadows`: Hard-edge offset shadows `Offset(2,2)` or `Offset(4,4)`, `blurRadius: 0`
- `blurStrength`: 0.0 (no blur)

---

## 3. Component-Specific Research

### 3.1 AppBar Implementation

**Decision**: Create custom `AppAppBar` implementing `PreferredSizeWidget`

**Rationale**: Flutter's `AppBar` is heavily tied to Material design. Custom implementation:
- Full control over rendering via `AppSurface`
- Theme-driven appearance without Material constraints
- Bottom divider handling per style

**Key Implementation Details**:
- Height: Standard 56-64dp, customizable
- Layout: Row with leading (IconButton slot), Expanded title, actions (List<Widget>)
- Bottom: Optional `PreferredSizeWidget` with style-aware divider
- Glass mode: Semi-transparent with scroll-aware blur (needs `scrolledUnderElevation` equivalent)

### 3.2 SliverAppBar Implementation

**Decision**: Wrap Flutter's `SliverAppBar` with custom flexibleSpace renderer

**Rationale**: SliverAppBar's sliver protocol is complex; leverage Flutter's implementation:
- Custom `FlexibleSpaceBar` replacement for style-aware overlay
- Glass mode: Blur overlay on flexibleSpace image when expanded
- Pixel mode: No overlay effects

**Key Implementation Details**:
- Use `SliverAppBar` for scroll physics (pinned/floating/snap)
- Custom `flexibleSpace` widget that applies style-specific overlays
- Delegate foreground rendering to `AppSurface`

### 3.3 PopupMenu Implementation

**Decision**: Custom overlay-based popup using `flutter_portal` or `Overlay`

**Rationale**:
- Flutter's `PopupMenuButton` uses Material styling not easily overridden
- Custom implementation allows full `AppSurface` integration
- Menu container styling via theme specs

**Key Implementation Details**:
- Trigger: `AppIconButton` or custom widget with `GestureDetector`
- Popup: Positioned overlay with `AppSurface` container
- Items: List of `AppPopupMenuItem<T>` rendered as interactive rows
- Touch targets: Minimum 48x48dp per item (a11y requirement)
- Destructive items: Use `scheme.error` for text/icon color

### 3.4 Dialog Enhancement

**Decision**: Enhance existing `AppDialog` with additional parameters

**Rationale**: Current implementation is minimal. Enhance rather than replace to maintain compatibility.

**Enhancements Needed**:
- Add `content` (String) vs `customContent` (Widget) with mutual exclusivity
- Add button parameters: `primaryButtonText`, `onPrimaryPressed`, etc.
- Add `isDestructive` flag for danger styling
- Add scrollable content support
- Style-aware button rendering

---

## 4. Naming Convention Resolution

**Decision**: Use `App` prefix (AppAppBar, AppDialog, AppPopupMenu)

**Rationale**:
- Existing codebase uses `App` prefix consistently (AppButton, AppTextField, AppSurface)
- Spec's "Unified" prefix not used elsewhere in codebase
- Consistency > external spec naming

**Alternatives Considered**:
- `UnifiedAppBar`, `UnifiedDialog`: Rejected - inconsistent with codebase
- `UKAppBar` (UI Kit): Rejected - unnecessary abbreviation

---

## 5. Style Spec Design

### 5.1 AppBarStyle Spec

```dart
class AppBarStyle {
  final SurfaceStyle containerStyle;      // AppBar background/border/shadow
  final SurfaceStyle bottomStyle;         // Bottom area (TabBar container)
  final DividerStyle dividerStyle;        // Bottom divider (Flat: hairline, Pixel: thick)
  final double height;                    // Standard height
  final double collapsedHeight;           // For SliverAppBar
  final double expandedHeight;            // For SliverAppBar
  final double flexibleSpaceBlurStrength; // Glass mode overlay blur
}
```

### 5.2 MenuStyle Spec

```dart
class MenuStyle {
  final SurfaceStyle containerStyle;      // Popup container
  final SurfaceStyle itemStyle;           // Default item style
  final SurfaceStyle itemHoverStyle;      // Hovered item
  final SurfaceStyle destructiveStyle;    // Destructive item
  final double itemHeight;                // Min 48dp
  final double itemPadding;               // Horizontal padding
  final double iconSize;                  // Leading icon size
}
```

### 5.3 DialogStyle Spec

```dart
class DialogStyle {
  final SurfaceStyle containerStyle;      // Dialog container
  final SurfaceStyle barrierStyle;        // Background barrier (Glass: more visible)
  final double maxWidth;                  // Desktop constraint
  final double padding;                   // Internal padding
  final double buttonSpacing;             // Gap between buttons
}
```

---

## 6. Accessibility Considerations

### 6.1 Touch Targets

**Decision**: Enforce 48x48dp minimum for all interactive elements

**Implementation**:
- Menu items: `constraints: BoxConstraints(minHeight: 48)`
- AppBar leading/actions: Use `AppIconButton` which already enforces 48dp
- Dialog buttons: Use `AppButton` which enforces minimum height

### 6.2 Semantics

**Decision**: Wrap interactive elements with `Semantics` widget

**Implementation**:
- AppBar: `Semantics(header: true, label: title)`
- Menu items: `Semantics(button: true, label: item.label)`
- Dialog: `Semantics(scopesRoute: true, namesRoute: true, label: title)`

### 6.3 Contrast

**Decision**: Rely on theme's ColorScheme for WCAG AA compliance

**Rationale**: ColorScheme generated with accessibility in mind. Components use semantic colors (`onSurface`, `onPrimary`, `error`) which maintain contrast across light/dark modes.

---

## 7. Unresolved Items

All research questions have been resolved. No NEEDS CLARIFICATION items remain.

---

## References

- Constitution: `.specify/memory/constitution.md` v2.0.0
- Existing Dialog: `lib/src/molecules/dialogs/app_dialog.dart`
- Theme System: `lib/src/foundation/theme/design_system/app_design_theme.dart`
- Style Examples: `lib/src/foundation/theme/design_system/styles/`
- Test Patterns: `test/molecules/buttons/app_button_golden_test.dart`
