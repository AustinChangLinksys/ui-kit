# Feature Specification: Legacy Components Migration

**Feature Branch**: `019-legacy-migration`
**Status**: Draft

## Clarifications

### Session 2025-12-06
- Q: Should the legacy components (`AppSlideActionContainer`, `ExpandableFab`, `AnimatedMeter`) be deleted immediately after creating the new ones, or kept and marked `@deprecated`? → A: **Deprecate** - Keep old files, add `@deprecated` annotation; allows incremental refactoring.

## 1. Problem Statement

The application currently contains legacy components (`AppSlideActionContainer`, `ExpandableFab`, `AnimatedMeter`) that do not adhere to the Unified Design System (v2.0). These components lack support for the required multi-theme architecture (Glass, Pixel, Neumorphic, Brutal) and rely on hardcoded styles or outdated dependencies. This fragmentation creates visual inconsistencies and prevents the application from fully leveraging the dynamic theming engine.

## 2. User Scenarios

### 2.1 Contextual Actions (Slide Action)
**Actors**: End User
**Flow**:
1.  User views a list of items.
2.  User performs a horizontal swipe gesture on an item.
3.  The item reveals hidden contextual actions (e.g., Edit, Delete) based on the swipe depth.
4.  User taps an action to execute it, or taps outside to close the item.

### 2.2 Quick Actions (Expandable FAB)
**Actors**: End User
**Flow**:
1.  User sees a primary Floating Action Button (FAB) on the screen.
2.  User taps the FAB.
3.  The FAB expands (fan-out, float, or grid-snap based on theme) to reveal secondary satellite actions.
4.  A background scrim appears to block interaction with the underlying content.
5.  User selects a secondary action or taps the scrim to dismiss.

### 2.3 Data Visualization (Gauge)
**Actors**: End User
**Flow**:
1.  User views a dashboard or status screen.
2.  User sees a circular arc meter representing a value (e.g., Signal Strength, Speed).
3.  The meter visually updates its position and style (e.g., neon glow in Glass mode, segmented blocks in Pixel mode) to reflect the current data value.

## 3. Functional Requirements

### 3.1 AppSlideAction (Molecule)
*   **Interaction**: Must support horizontal drag gestures with velocity detection.
*   **Snapping**: Must automatically snap to the "Open" state if dragged beyond 50% width or flicked; otherwise, it must snap back to closed.
*   **Auto-Close**: Must close open items when the user interacts with another item or taps the background.
*   **Configuration**: Must accept a list of action items, each defining a label, icon, callback, and semantic variant (e.g., standard, destructive).
*   **Theme Adaptation**:
    *   **Motion**: Must vary animation timing and curve (e.g., 300ms ease vs. 500ms elastic) per theme.
    *   **Visuals**: Must render the action area background and icons according to the active theme style (e.g., blurred glass, solid block, or high-contrast border).
    *   **Migration**: The new component `AppSlideAction` will coexist with `AppSlideActionContainer`. The legacy component must be marked as `@deprecated`.

### 3.2 AppExpandableFab (Organism)
*   **State Management**: Must manage Open/Closed state with a primary toggle button.
*   **Transition**: The primary icon must animate (e.g., rotate) during state changes.
*   **Scrim**: Must display a modal barrier/overlay behind the expanded actions to prevent interaction with the background.
*   **Theme Adaptation**:
    *   **Layout**: Animation of secondary actions must vary by theme (Fan-out, Float, Grid Snap).
    *   **Shape**: Button shapes must adapt (Circle, Square, Soft Circle).
    *   **Feedback**: Must trigger specific haptic feedback on toggle and selection.
    *   **Migration**: The new component `AppExpandableFab` will coexist with `ExpandableFab`. The legacy component must be marked as `@deprecated`.

### 3.3 AppGauge (Organism)
*   **Rendering**: Must draw a circular arc representing a normalized value (0.0 - 1.0).
*   **Composability**: Must provide slots for centralized content (Value display) and bottom labels.
*   **Theme Adaptation**:
    *   **Renderer**: The drawing logic must be completely swappable based on the theme (e.g., drawing a continuous gradient line vs. drawing discrete segmented blocks).
    *   **Decoration**: Must support theme-specific embellishments like "Comet Tips" (fading tails) or "Knobs" at the end of the arc.
    *   **Motion**: Animation of value changes must respect theme physics (Smooth vs. Stepped).
    *   **Migration**: The new component `AppGauge` will coexist with `AnimatedMeter`. The legacy component must be marked as `@deprecated`.

## 4. Success Criteria

### 4.1 Visual Fidelity (Golden Tests)
*   **Pixel Theme**: AppSlideAction snaps instantly (0ms) without sliding animation; AppGauge renders as discrete segments without anti-aliasing.
*   **Glass Theme**: AppExpandableFab overlay applies a background blur; AppGauge displays a "Comet" tail gradient effect.
*   **Brutal Theme**: All components feature thick, high-contrast borders and "hard" shadows/strokes.

### 4.2 Integration & Consistency
*   All components utilize `AppTheme.of(context)` and `AppColorScheme` exclusively for styling (no hardcoded colors).
*   Components respond correctly to global theme changes at runtime.
*   Haptic feedback is triggered consistently on interactive elements (Heavy for Pixel/Brutal, Light for Glass/Neumorphic).
*   Legacy components (`AppSlideActionContainer`, `ExpandableFab`, `AnimatedMeter`) are marked as `@deprecated` but remain functional.

## 5. Assumptions & Dependencies

*   **Dependencies**: The project already contains `AppColorScheme`, `AppMotion`, `AppFeedback`, and `AppTheme` definitions.
*   **Assets**: Necessary icons and base assets are available in the project or can be generated via existing scripts.
*   **Architecture**: The `ThemeExtension` or similar mechanism is available to inject the specific style parameters (timings, render modes) required for these components.