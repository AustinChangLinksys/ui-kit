# Tasks: Interactive & Form Expansion

**Branch**: `004-interactive-forms` | **Spec**: [specs/004-interactive-forms/spec.md](../../specs/004-interactive-forms/spec.md)

## Implementation Strategy

This feature introduces 5 new interactive components. We will proceed story-by-story (priority order) to ensure deliverable increments.
- **Phase 2 (Foundational)**: Establish theme extensions (`LoaderStyle`, `ToastStyle`) required by multiple components.
- **Phase 3 (US1)**: `AppTextFormField` wrapping `AppTextField` (High value, low risk).
- **Phase 4 (US2)**: `AppDropdown` reusing `AppTextField` visuals.
- **Phase 5 (US3)**: `AppLoader` and `AppToast` for system feedback.
- **Phase 6 (US4)**: `AppListTile` for layout standardization.

Each phase includes implementation, Widgetbook stories, and Golden Tests (as required by Constitution).

---

## Phase 1: Setup

- [x] T001 Create feature directory structure (`molecules/forms`, `molecules/feedback`, `molecules/layout`)
- [x] T002 Update `AppDesignTheme` to support new extensions (register factories if needed) in `lib/src/foundation/theme/design_theme.dart`

---

## Phase 2: Foundational (Theme Extensions)

**Goal**: Define the visual configuration contracts for Loaders and Toasts before implementation.
**Criteria**: Theme extensions are generated and available in `AppDesignTheme`.

- [x] T003 Create `LoaderStyle` theme extension with fields (color, strokeWidth, size, period) in `lib/src/foundation/theme/loader_style.dart`
- [x] T004 Create `ToastStyle` theme extension with fields (padding, margin, radius, color, textStyle) in `lib/src/foundation/theme/toast_style.dart`
- [x] T005 Run `build_runner` to generate ThemeTailor code for new extensions

---

## Phase 3: User Story 1 - Validatable Form Inputs (P1 - Critical Path)

**Goal**: Enable form validation using `AppTextFormField`.
**Test Criteria**: `AppTextFormField` shows error state automatically on validation failure.

- [x] T006 [US1] Implement `AppTextFormField` widget wrapping `AppTextField` and `FormField` in `lib/src/molecules/forms/app_text_form_field.dart`
- [x] T007 [US1] Connect `validator`, `onSaved`, and `onChanged` callbacks in `lib/src/molecules/forms/app_text_form_field.dart`
- [x] T008 [US1] Implement visual state mapping (Error text display) in `lib/src/molecules/forms/app_text_form_field.dart`
- [x] T009 [US1] Create Widgetbook story for `AppTextFormField` (Valid, Error, Disabled states) in `widgetbook/lib/stories/molecules/forms/app_text_form_field.stories.dart`
- [x] T010 [US1] Create Golden Tests for `AppTextFormField` (Error State) in `test/molecules/forms/app_text_form_field_golden_test.dart`

---

## Phase 4: User Story 2 - Dropdown Selection (P2)

**Goal**: Dropdown component that visually mimics text fields.
**Test Criteria**: Idle state matches `AppTextField` pixel-for-pixel.

- [x] T011 [US2] Implement `AppDropdown<T>` widget structure in `lib/src/molecules/forms/app_dropdown.dart`
- [x] T012 [US2] Implement `Idle` state rendering using `AppTextField` (or mimicry) in `lib/src/molecules/forms/app_dropdown.dart`
- [x] T013 [US2] Implement logic for the popup menu (using purely UI overlay/portal mechanisms, strictly NO business logic) in `lib/src/molecules/forms/app_dropdown.dart`
- [x] T014 [US2] Implement menu item rendering using `AppSurface` (Elevated) and `AppListTile` (or standard row) in `lib/src/molecules/forms/app_dropdown.dart`
- [x] T015 [US2] Create Widgetbook story for `AppDropdown` (Idle, Expanded) in `widgetbook/lib/stories/molecules/forms/app_dropdown.stories.dart`
- [x] T016 [US2] Create Golden Tests for `AppDropdown` (Idle State) in `test/molecules/forms/app_dropdown_golden_test.dart`

---

## Phase 5: User Story 3 - System Feedback (P3)

**Goal**: Standardized Loaders and Toasts.
**Test Criteria**: Components respect `LoaderStyle` and `ToastStyle` across themes.

### Part A: AppLoader
- [x] T017 [P] [US3] Implement `AppLoader` with Circular and Linear variants in `lib/src/molecules/feedback/app_loader.dart` (Consider `RepaintBoundary` for performance per Constitution 11.0)
- [x] T018 [P] [US3] Apply `LoaderStyle` properties (stroke, color) and animations in `lib/src/molecules/feedback/app_loader.dart` (Consider `RepaintBoundary` for performance per Constitution 11.0)
- [x] T019 [P] [US3] Create Widgetbook story for `AppLoader` (Circular, Linear) in `widgetbook/lib/stories/molecules/feedback/app_loader.stories.dart`
- [x] T020 [P] [US3] Create Golden Tests for `AppLoader` (Static snapshot) in `test/molecules/feedback/app_loader_golden_test.dart`

### Part B: AppToast
- [x] T021 [P] [US3] Define `ToastType` enum (Success, Error, Info, Warning) in `lib/src/molecules/feedback/app_toast.dart`
- [x] T022 [P] [US3] Implement `AppToast` widget layout using `AppSurface` and `ToastStyle` in `lib/src/molecules/feedback/app_toast.dart`
- [x] T023 [P] [US3] Implement static helper `show()` using `Overlay` (if viable) or documentation for usage in `lib/src/molecules/feedback/app_toast.dart`
- [x] T024 [P] [US3] Create Widgetbook story for `AppToast` (All types) in `widgetbook/lib/stories/molecules/feedback/app_toast.stories.dart`
- [x] T025 [P] [US3] Create Golden Tests for `AppToast` in `test/molecules/feedback/app_toast_golden_test.dart`

---

## Phase 6: User Story 4 - Standardized List Items (P4)

**Goal**: Consistent list rows.
**Test Criteria**: Padding scales with `spacingFactor`.

- [x] T026 [US4] Implement `AppListTile` with slots (Leading, Title, Subtitle, Trailing) in `lib/src/molecules/layout/app_list_tile.dart`
- [x] T027 [US4] Apply theme scaling logic (padding * spacingFactor) in `lib/src/molecules/layout/app_list_tile.dart`
- [x] T028 [US4] Create Widgetbook story for `AppListTile` (Various configs) in `widgetbook/lib/stories/molecules/layout/app_list_tile.stories.dart`
- [x] T029 [US4] Create Golden Tests for `AppListTile` in `test/molecules/layout/app_list_tile_golden_test.dart`

---

## Phase 7: Polish & Cross-Cutting

- [x] T030 Export all new components in `lib/ui_kit.dart`
- [x] T031 Run full test suite (unit + goldens) to ensure no regression
- [x] T032 Update `README.md` or top-level documentation with new component usage
- [ ] T033 Perform performance benchmarking for animations (target >60 FPS on low-end simulation) using DevTools/Driver tests

---

## Dependencies

1. **T001-T005** (Setup/Foundations) must be completed first.
2. **US1 (Forms)** is independent.
3. **US2 (Dropdown)** depends on US1 (conceptually) or `AppTextField` (existing).
4. **US3 (Feedback)** is independent after Foundations.
5. **US4 (ListTile)** is independent.

## Parallel Execution Options

- **After Phase 2**:
    - Team A can work on **US1 (Forms)**.
    - Team B can work on **US3 (Feedback)** (Loader/Toast are independent).
    - Team C can work on **US4 (ListTile)**.
- **Within US3**: `AppLoader` and `AppToast` can be built in parallel.
