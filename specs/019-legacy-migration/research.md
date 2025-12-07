# Research & Technical Context: Legacy Components Migration

**Status**: Complete
**Branch**: `019-legacy-migration`

## 1. Technical Context

### 1.1 Unknowns & Clarifications
*   **Resolved**: Haptic Feedback strategy is confirmed as "Internal Handling" via `AppFeedback`.
*   **Resolved**: Migration strategy is "Deprecate" (keep old files with `@deprecated` annotation).
*   **Implicit**: `AppTheme.motion` already handles theme-specific durations (e.g., Pixel = 0ms).
*   **Implicit**: `AppColorScheme` already provides semantic colors (`signalStrong`, `surfaceContainer`, etc.).

### 1.2 Dependencies & Integration
*   **AppFeedback**: Component triggers `onTap()`, internal logic maps to Heavy/Light haptics based on theme.
*   **AppTheme**: Driven by `ThemeExtension`.
*   **Animations**: `flutter_animate` for simple effects, `AnimationController` for complex physics (Slide, Gauge).
*   **Drawing**: `CustomPainter` required for `AppGauge` (rendering Arcs, Segments, Gradients).

## 2. Technology Decisions

| Decision | Context | Rationale | Alternatives |
| :--- | :--- | :--- | :--- |
| **Theme Extensions** | Styling | Isolate visual parameters (colors, durations, shapes) from logic. Follows established "Tailor" pattern. | Hardcoding `if (theme.isPixel)` inside widgets (Forbidden by Charter). |
| **Composition** | `AppSlideAction` | Use `Stack` + `GestureDetector` for custom swipe physics. | `Dismissible` (Too rigid, hard to customize threshold logic). |
| **OverlayEntry** | `AppExpandableFab` | Necessary to render the "Barrier/Scrim" over the entire screen, above the Scaffold. | `Stack` (limited to parent constraints), `Portal` (valid alternative, but OverlayEntry is standard for FABs). |
| **CustomPainter** | `AppGauge` | Complex rendering requirements (Gradients vs Segments) require low-level canvas control. | `CircularProgressIndicator` (Too limited for "Comet" or "Segmented" styles). |

## 3. Best Practices (from Constitution)

*   **IoC**: Components must ask `SlideActionStyle` for properties, not check `AppTheme.type`.
*   **Feedback**: All interactions must trigger `AppFeedback.onTap()`.
*   **Safe Mode**: Golden tests must wrap components in fixed `SizedBox` and `ColoredBox` for visibility.
*   **Motion**: `Pixel` theme must have `0ms` duration.
