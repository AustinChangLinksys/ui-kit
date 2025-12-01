# Feature Specification: Interactive & Form Expansion

**Feature Branch**: `004-interactive-forms`
**Created**: 2025-12-01
**Status**: Draft
**Input**: User description: "Interactive & Form Expansion (Phase 3)"

## Clarifications

### Session 2025-12-01
- Q: Should these new UI components require specific observability (logging, metrics)? → A: No specific requirements; rely on existing application-level observability.
- Q: Are there specific features explicitly out of scope for this phase? → A: Yes; multi-select dropdowns, custom toast positioning, and complex validation logic beyond basic wrapping are out of scope.
- Q: For `AppDropdown`'s "generic data types," how should items be identified/displayed? → A: Require `itemAsString` function (for display string) and optional `itemValue` (for uniqueness), defaulting to `toString()`.
- Q: Are there specific accessibility requirements beyond constitutional adherence? → A: No additional accessibility features required; follow general constitutional guidelines.
- Q: Are there specific performance targets for AppLoader or AppToast animations? → A: Animations should maintain above 60 FPS, even on lower-end devices.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Validatable Form Inputs (Priority: P1)

Developers need a way to easily build forms with validation that integrates seamlessly with the existing design system, without writing manual glue code for error states.

**Why this priority**: Forms are a fundamental part of application interactivity. Lack of integrated validation components forces developers to rebuild error UI manually, leading to inconsistency.

**Independent Test**: Create a form with `AppTextFormField`, add a validator that fails, trigger validation, and verify the component visually updates to the error state (red border/text) automatically.

**Acceptance Scenarios**:

1. **Given** a form with an `AppTextFormField` inside, **When** the form's `validate()` method is called and the field is empty (required), **Then** the field should visually change to the error state (e.g., red border) and display the error message.
2. **Given** a valid form, **When** `save()` is called, **Then** the `onSaved` callback of the `AppTextFormField` should be triggered.
3. **Given** a disabled form field, **When** user attempts to interact, **Then** it should remain non-interactive and show the disabled visual state.

---

### User Story 2 - Dropdown Selection (Priority: P2)

Developers need a dropdown component that visually matches text inputs to create consistent-looking forms where users can select from a list of options.

**Why this priority**: Selection is the second most common form interaction. Inconsistent dropdowns break visual rhythm in forms.

**Independent Test**: Place an `AppTextField` and an `AppDropdown` vertically stacked. Verify their height, border, and background are identical in the idle state.

**Acceptance Scenarios**:

1. **Given** an `AppDropdown` in idle state, **When** displayed next to an `AppTextField`, **Then** it should have identical visual dimensions and styling (mimicry).
2. **Given** the dropdown is tapped, **When** the menu opens, **Then** the popup should use `AppSurface` (Elevated variant) and respect the theme's shadow/blur settings (Glass vs. Flat).
3. **Given** a custom item builder, **When** data is provided, **Then** the dropdown menu should render items using the custom template.

---

### User Story 3 - System Feedback (Loaders & Toasts) (Priority: P3)

Developers need standardized ways to show "Processing" states and transient "Success/Error" messages that float above content without disrupting layout.

**Why this priority**: Providing feedback is crucial for UX. Ad-hoc loaders and toasts often fail to respect the design language (e.g., showing a material loader in a brutalist theme).

**Independent Test**: Trigger a "Success" toast and verify it uses the correct semantic color and animation. Show a "Circular" loader and verify it matches the theme (e.g., glowing in Glass, spinning block in Brutal).

**Acceptance Scenarios**:

1. **Given** a long running task, **When** `AppLoader` is shown with `variant: circular` in Glass theme, **Then** it should render a glowing/fluid indicator.
2. **Given** the same loader in Brutal theme, **Then** it should render a high-contrast geometric spinner.
3. **Given** a user action completes, **When** an `AppToast` is triggered with `type: success`, **Then** it should appear as a floating overlay and auto-dismiss after the set timer.
4. **Given** an `AppLoader` with `variant: linear`, **When** placed at the top of a page, **Then** it should show a horizontal progress bar.

---

### User Story 4 - Standardized List Items (Priority: P4)

Developers need a consistent list tile component to build setting screens, menus, and data lists without rebuilding layout logic.

**Why this priority**: List views are ubiquitous. A shared component ensures consistent padding, typography, and interaction states across the app.

**Independent Test**: Create a list of items using `AppListTile` with various slots filled (Leading icon, Trailing switch). Verify layout consistency and tap effects.

**Acceptance Scenarios**:

1. **Given** an `AppListTile`, **When** configured with Leading, Title, Subtitle, and Trailing widgets, **Then** they should appear in the correct standardized layout slots.
2. **Given** the tile is tapped, **When** `onTap` is provided, **Then** the appropriate theme interaction effect (e.g., glow in Glass) should trigger.
3. **Given** the theme spacing factor changes, **When** the tile renders, **Then** its padding should scale automatically.

### Edge Cases

- **Dropdown Overlay**: What happens when the dropdown is at the bottom of the screen? (Should open upwards).
- **Toast Stacking**: What happens if multiple toasts are triggered rapidly? (Should stack or queue without overlapping to unreadable mess).
- **Form Reset**: When form is reset, `AppTextFormField` must clear error states visually.
- **Long Text**: How do `AppListTile` title/subtitle handle overflow? (Ellipsis or wrap - standard should be defined, likely ellipsis for single line).

## Constitutional Alignment

*GATE: All specifications MUST adhere to the principles outlined in the Project Constitution (v1.0.0).*

- **2. Architectural Boundaries**: `AppTextFormField` must wrap `AppTextField` but stay within `molecules`. It depends on `AppTextField` (atom/molecule) and Flutter `Form` logic.
- **3. Theming & Styling**: `AppLoader` and `AppToast` styles must be defined in `AppDesignTheme` via `ThemeExtension`. `LoaderStyle` and `ToastStyle` will be added.
- **4. Component Design**: `AppTextFormField` separates visual (delegated to `AppTextField`) from logic (validation). `AppListTile` uses slots.
- **5. Assets Management**: Icons used in templates (like standard toast icons) must be strictly typed.
- **6. Animation Strategy**: `AppToast` entry/exit and `AppLoader` animations must use `flutter_animate` or `Rive` where appropriate, respecting the theme (e.g., reduced motion if needed, though not explicitly requested yet).
- **8. Accessibility**: `AppTextFormField` must link error text semantics to the input. `AppLoader` must have semantic labels ("Loading").

## Requirements *(mandatory)*

### Functional Requirements

#### Form & Input (`AppTextFormField`)
- **FR-001**: System MUST provide `AppTextFormField` that integrates with Flutter's `Form` widget lifecycle (validate, save, reset).
- **FR-002**: `AppTextFormField` MUST visually mimic `AppTextField` states (Focus, Error, Disabled) exactly.
- **FR-003**: System MUST automatically display error messages provided by the `validator` callback without manual UI state management by the developer.

#### Selection (`AppDropdown`)
- **FR-004**: `AppDropdown` MUST support generic data types and custom `itemBuilder` for menu rows, requiring an `itemAsString` function (for display string) and supporting an optional `itemValue` (for uniqueness), with `toString()` as default display.
- **FR-005**: `AppDropdown` visual appearance (height, border, background) in idle state MUST match `AppTextField` to ensure visual rhythm.
- **FR-006**: `AppDropdown` popup menu MUST use `AppSurface` (Elevated variant) and mimic theme-specific shadows/blur (Glassmorphism).

#### Feedback (`AppLoader`, `AppToast`)
- **FR-007**: `AppLoader` MUST support `variant: circular` (default) and `variant: linear`.
- **FR-008**: `AppLoader` MUST support both indeterminate (loop) and determinate (0-100%) modes.
- **FR-009**: `AppLoader` visual style MUST adapt to theme: Glowing/Fluid for Glass, Geometric/High-Contrast for Brutal, Standard for Flat.
- **FR-010**: `AppToast` MUST support semantic types: Success, Error, Info, Warning.
- **FR-011**: `AppToast` MUST float above content (Overlay) and support auto-dismissal timers and manual dismissal.

#### Lists (`AppListTile`)
- **FR-012**: `AppListTile` MUST provide standardized slots for Leading (icon/avatar), Title (text), Subtitle (text), and Trailing (action/indicator).
- **FR-013**: `AppListTile` padding MUST scale dynamically based on the theme's `spacingFactor`.

### Key Entities

- **LoaderStyle**: Theme extension defining stroke width, sizing, and color logic for loaders.
- **ToastStyle**: Theme extension defining default position, padding, and animation curves for toasts.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: `AppTextFormField` validation errors trigger visual error state (red border) in 100% of test cases without manual `setState`.
- **SC-002**: `AppDropdown` idle state is visually indistinguishable from `AppTextField` in pixel comparison tests (Visual Regression).
- **SC-003**: `AppLoader` renders 3 distinct visual styles (Glass, Brutal, Flat) based on the active theme configuration.
- **SC-004**: `AppListTile` layout adapts to 4 different `spacingFactor` settings, maintaining alignment of slots.
- **SC-005**: All 5 new components pass Golden Tests across all 8 theme/mode combinations (4 Themes x 2 Modes).
- **SC-006**: `AppLoader` and `AppToast` animations maintain a minimum of 60 frames per second (FPS) across all supported devices.