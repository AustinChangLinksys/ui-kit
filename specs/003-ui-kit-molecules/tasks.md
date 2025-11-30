# Tasks: Unified UI Kit Molecules

**Branch**: `003-ui-kit-molecules`
**Spec**: [specs/003-ui-kit-molecules/spec.md](../spec.md)

## Implementation Strategy

- **Incremental Build**: We will build components in functional groups (Atoms first, then Molecules).
- **Testing First**: Golden Tests will be set up immediately after component structure to verify theming.
- **Widgetbook Integration**: Each component will be immediately registered in Widgetbook for visual verification.
- **Phase Order**: Foundation -> Buttons/Inputs (P1) -> Navigation (P1) -> Status/Info (P2).

## Dependencies

1. **Phase 1 (Setup)**: Must be completed first.
2. **Phase 2 (Foundation)**: Must be completed before any User Stories.
3. **Phase 3 (US1)**: Independent.
4. **Phase 4 (US2)**: Independent.
5. **Phase 5 (US3)**: Independent.
6. **Phase 6 (Polish)**: Runs after all stories.

## Phase 1: Setup
*Goal: Prepare the project structure and testing environment.*

- [x] T001 Create molecule directory structure in `lib/src/molecules/` (buttons, inputs, selection, status, navigation)
- [x] T002 Create test directory structure in `test/molecules/` matching source layout
- [x] T003 Create Widgetbook directory structure in `widgetbook/lib/molecules/` matching source layout

## Phase 2: Foundation
*Goal: Establish shared utilities and theme extensions required by molecules.*

- [x] T004 Update `AppDesignTheme` to include `buttonHeight` and `navBarSpec` properties via Theme Tailor
- [x] T005 Implement `ToggleContentRenderer` logic in `lib/src/molecules/selection/toggle_content_renderer.dart` (shared by Radio/Checkbox)
- [x] T006 Create `NavigationItem` data class in `lib/src/molecules/navigation/navigation_item.dart`

## Phase 3: User Story 1 - Core Interactive Elements (P1)
*Goal: Implement Buttons, Inputs, and Toggles.*
*Test Criteria: Forms demo page in Widgetbook, interactive states (loading, error, focus).*

**AppButton & AppIconButton**
- [x] T007 [US1] Create `AppButton` implementation in `lib/src/molecules/buttons/app_button.dart`
- [x] T008 [US1] Create `AppIconButton` implementation in `lib/src/molecules/buttons/app_icon_button.dart`
- [x] T009 [US1] Create Widgetbook story for Buttons in `widgetbook/lib/molecules/buttons/buttons.story.dart`
- [x] T010 [US1] Create Golden Test for Buttons in `test/molecules/buttons/buttons_golden_test.dart`

**AppTextField**
- [x] T011 [US1] Create `AppTextField` implementation with FocusNode listener in `lib/src/molecules/inputs/app_text_field.dart`
- [x] T012 [US1] Create Widgetbook story for TextField in `widgetbook/lib/molecules/inputs/text_field.story.dart`
- [x] T013 [US1] Create Golden Test for TextField in `test/molecules/inputs/text_field_golden_test.dart`

**Selection Controls**
- [x] T014 [US1] Create `AppCheckbox` implementation in `lib/src/molecules/selection/app_checkbox.dart`
- [x] T015 [US1] Create `AppRadio` implementation in `lib/src/molecules/selection/app_radio.dart`
- [x] T016 [US1] Create `AppSlider` implementation with divisions support in `lib/src/molecules/selection/app_slider.dart`
- [x] T017 [US1] Create Widgetbook story for Selection controls in `widgetbook/lib/molecules/selection/selection.story.dart`
- [x] T018 [US1] Create Golden Test for Selection controls in `test/molecules/selection/selection_golden_test.dart`

## Phase 4: User Story 2 - Navigation Structure (P1)
*Goal: Implement AppNavigationBar.*
*Test Criteria: Responsive layout adaptation (Floating vs Fixed) and 5-item limit enforcement.*

- [x] T019 [US2] Create `AppNavigationBar` implementation in `lib/src/molecules/navigation/app_navigation_bar.dart`
- [x] T020 [US2] Implement assertion for max 5 items in `AppNavigationBar` constructor
- [x] T021 [US2] Create Widgetbook story for NavigationBar in `widgetbook/lib/molecules/navigation/navigation_bar.story.dart`
- [x] T022 [US2] Create Golden Test for NavigationBar in `test/molecules/navigation/navigation_bar_golden_test.dart`

## Phase 5: User Story 3 - Informational Elements (P2)
*Goal: Implement Avatar, Badge, and Tag.*
*Test Criteria: Shape enforcement (Capsule/Circle) and content fallbacks.*

- [x] T023 [US3] Create `AppBadge` and `AppTag` implementations in `lib/src/molecules/status/app_badge.dart` and `app_tag.dart`
- [x] T024 [US3] Create `AppAvatar` implementation with center-crop logic in `lib/src/molecules/status/app_avatar.dart`
- [x] T025 [US3] Create Widgetbook story for Status elements in `widgetbook/lib/molecules/status/status.story.dart`
- [x] T026 [US3] Create Golden Test for Status elements in `test/molecules/status/status_golden_test.dart`

## Phase 6: Polish & QA
*Goal: Final verification and strict compliance checks.*

- [x] T027 Verify `AppDesignTheme` usage (no hardcoded values) across all new files
- [x] T028 Verify `AppSurface` usage (no `Container`/`DecoratedBox`) via search
- [x] T029 Run full `flutter test` suite ensuring all Goldens pass
- [x] T030 Verify 0 instances of `runtimeType` checks or `is BrutalTheme`
