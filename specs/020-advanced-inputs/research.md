# Research & Technical Context: Advanced Inputs

**Status**: Complete
**Branch**: `020-advanced-inputs`

## 1. Technical Context

### 1.1 Unknowns & Clarifications
*   **Resolved**: Pin Input Strategy is "Ghost Input" (hidden TextField) for best accessibility and keyboard support.
*   **Resolved**: Validation logic uses pure Dart functions.
*   **Resolved**: Styling uses Theme Extensions.

### 1.2 Dependencies & Integration
*   **AppTextField**: Base component for Range and Password inputs.
*   **AppTheme**: Driven by `ThemeExtension`.
*   **AppFeedback**: Used for success/error haptics.
*   **AppMotion**: Used for animations (0ms for Pixel).

## 2. Technology Decisions

| Decision | Context | Rationale | Alternatives |
| :--- | :--- | :--- | :--- |
| **Ghost Input** | `AppPinInput` | Ensures native keyboard behavior (paste, autofill, delete) works seamlessly without managing focus manually per cell. | Managing N separate TextFields (complex focus logic). |
| **Composite Widget** | `AppRangeInput` | Composes two existing `AppTextField`s to reuse existing logic while adding range-specific validation. | Creating a new RenderObject (overkill). |
| **Theme Extensions** | Styling | Encapsulates style parameters (shapes, icons, layouts) to support multi-paradigm design system. | Hardcoded styles. |

## 3. Best Practices (from Constitution)

*   **IoC**: Components ask Theme Extensions for style, not `AppTheme.type`.
*   **Feedback**: All interactions trigger `AppFeedback`.
*   **Safe Mode**: Golden tests must use Safe Mode protocol.
*   **Zero Internal Defaults**: Styles come from Theme.
