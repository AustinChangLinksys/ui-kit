# Phase 0: Research & Decisions

**Feature**: Interactive & Form Expansion
**Date**: 2025-12-01

## 1. Architecture Decisions

### 1.1 Form Validation Wrapper Pattern
- **Decision**: Implement `AppTextFormField` as a wrapper around `AppTextField` that integrates with Flutter's `FormField<String>`.
- **Rationale**: This separates the "View" (`AppTextField` - defined in Atom layer) from the "Logic" (Validation state - defined in Flutter Framework). It adheres to the "Composition over Inheritance" principle (Constitution 5.3).
- **Alternatives Considered**:
    - *Inheritance*: Extending `TextFormField` directly. Rejected as it binds the atom tightly to the form logic and makes styling adaptation harder.
    - *HookWidget*: Using `flutter_hooks` for form state. Rejected as it introduces a new paradigm dependency not standard in the project context.

### 1.2 Dropdown "Visual Mimicry"
- **Decision**: `AppDropdown` will compose `AppTextField` (or its internal renderer) for the trigger button to ensure pixel-perfect alignment in "Idle" state.
- **Rationale**: Ensuring visual rhythm is critical. Re-implementing the border/padding logic separately would lead to drift. Reusing the atom ensures that theme changes to inputs automatically reflect in dropdowns.
- **Implementation Detail**: The popup menu will use `OverlayEntry` (or a wrapper package if allowed, but native is preferred for "Dumb" components) to float above content.

### 1.3 Feedback Overlay System
- **Decision**: `AppToast` will be implemented using a purely view-based approach, likely relying on an external "Manager" or "Service" to insert it into the Overlay, **BUT** the component itself will just be the Widget (`AppToast`). The mechanism to show it is outside the strict scope of the "UI Kit" package's responsibility (which is to provide the *Widget*), but typically UI Kits provide a helper method or `ToastManager`.
- **Refinement**: Per Constitution 2.1 (Physical Isolation), the UI Kit should provide the *Widget* (`AppToast`) and potentially a static helper `AppToast.show(context, ...)` that uses `Overlay.of(context)`. It must NOT rely on global keys or third-party packages that inject global state if possible.
- **Animation**: Use `flutter_animate` for entry/exit effects (Fade + Slide/Scale) as per Constitution 8.1.

## 2. Theme Extension Design

### 2.1 LoaderStyle
- **Fields**:
    - `Color? color`: Primary color override.
    - `double strokeWidth`: Thickness for circular/linear.
    - `double size`: Default size.
    - `Duration period`: Animation cycle time.
- **Tailor**: Generated via `@TailorMixin`.

### 2.2 ToastStyle
- **Fields**:
    - `EdgeInsets padding`: Inner content padding.
    - `EdgeInsets margin`: Outer positioning margin.
    - `BorderRadius radius`: Shape.
    - `Color backgroundColor`: (Base, typically derived from SurfaceVariant).
    - `TextStyle titleStyle`: Font style.
    - `Duration displayDuration`: Default time before dismiss.

## 3. Unknowns & Clarifications (Resolved)

- **Q: Observability?** -> **A**: None required within the UI Kit.
- **Q: Out of Scope?** -> **A**: Multi-select, Custom Positioning, Complex Validation.
- **Q: Dropdown Data?** -> **A**: `itemAsString` + `itemValue`.
- **Q: A11y?** -> **A**: Standard Constitution adherence (Semantics).
- **Q: Performance?** -> **A**: 60 FPS target.

All clarifications from `/speckit.specify` have been integrated into the design strategy.
