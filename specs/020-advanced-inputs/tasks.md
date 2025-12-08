# Tasks: Advanced Inputs

**Branch**: `020-advanced-inputs`
**Spec**: `specs/020-advanced-inputs/spec.md`

## Phase 1: Setup

Goal: Initialize the feature branch and prepare shared configuration.

- [x] T001 Create feature directory `lib/src/molecules/inputs/range`
- [x] T002 Create feature directory `lib/src/molecules/inputs/pin`
- [x] T003 Create feature directory `lib/src/molecules/inputs/password`
- [x] T004 Create Theme Extension file `lib/src/foundation/theme/design_system/specs/range_input_style.dart`
- [x] T005 Create Theme Extension file `lib/src/foundation/theme/design_system/specs/pin_input_style.dart`
- [x] T006 Create Theme Extension file `lib/src/foundation/theme/design_system/specs/password_input_style.dart`
- [x] T007 Register new ThemeExtensions in `lib/src/foundation/theme/design_system/app_design_theme.dart` (Add to `AppDesignTheme` class and factory)

## Phase 2: Foundational

Goal: Implement the Data Models and Theme Extensions required by all components.

- [x] T008 Implement `RangeInputStyle` ThemeExtension in `lib/src/foundation/theme/design_system/specs/range_input_style.dart` with `theme_tailor` annotation
- [x] T009 Implement `PinInputStyle` ThemeExtension and `PinCellShape` enum in `lib/src/foundation/theme/design_system/specs/pin_input_style.dart`
- [x] T010 Implement `PasswordInputStyle` ThemeExtension in `lib/src/foundation/theme/design_system/specs/password_input_style.dart`
- [x] T011 Run `dart run build_runner build` to generate Tailor mixins
- [x] T012 Update `FlatDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart` to populate new extensions
- [x] T013 Update `GlassDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart` to populate new extensions
- [x] T014 Update `PixelDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart` to populate new extensions
- [x] T015 Update `NeumorphicDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart` to populate new extensions
- [x] T016 Update `BrutalDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart` to populate new extensions

## Phase 3: User Story 1 (Range Input)

Goal: Implement `AppRangeInput` molecule.

- [x] T017 [US1] Create `AppRangeInput` widget skeleton in `lib/src/molecules/inputs/range/app_range_input.dart`
- [x] T018 [US1] Implement Layout Logic (United Box vs Separated) based on `RangeInputStyle.mergeContainers` in `lib/src/molecules/inputs/range/app_range_input.dart`
- [x] T019 [US1] Implement Visual Separator rendering (Text vs Widget) based on `RangeInputStyle` in `lib/src/molecules/inputs/range/app_range_input.dart`
- [x] T020 [US1] Implement Validation Logic (start < end check) and Error State visualization in `lib/src/molecules/inputs/range/app_range_input.dart`
- [x] T021 [US1] Add `AppRangeInput` UseCase to Widgetbook in `widgetbook/lib/stories/molecules/inputs/range_input.stories.dart`
- [x] T022 [US1] Create Golden Test for Range Input in `test/molecules/inputs/range/app_range_input_golden_test.dart` (Verify Neumorphic Recess, Flat Border using Safe Mode protocol with explicit SizedBox and ColoredBox)

## Phase 4: User Story 2 (PIN Input)

Goal: Implement `AppPinInput` molecule.

- [x] T023 [US2] Create `AppPinInput` widget skeleton in `lib/src/molecules/inputs/pin/app_pin_input.dart`
- [x] T024 [US2] Implement Ghost Input strategy (Hidden TextField) for keyboard handling with proper `Semantics` configuration for accessibility in `lib/src/molecules/inputs/pin/app_pin_input.dart`
- [x] T025 [US2] Implement Cell Rendering (Underline, Box, Circle) based on `PinInputStyle.cellShape` in `lib/src/molecules/inputs/pin/app_pin_input.dart`
- [x] T026 [US2] Implement Active State Animation (Blink/Glow) using `AppTheme.motion` in `lib/src/molecules/inputs/pin/app_pin_input.dart`
- [x] T027 [US2] Implement `onCompleted` callback and `AppFeedback.onSuccess` trigger in `lib/src/molecules/inputs/pin/app_pin_input.dart`
- [x] T028 [US2] Add `AppPinInput` UseCase to Widgetbook in `widgetbook/lib/stories/molecules/inputs/pin_input.stories.dart`
- [x] T029 [US2] Create Golden Test for Pin Input in `test/molecules/inputs/pin/app_pin_input_golden_test.dart` (Verify Pixel Blocks, Glass Glow using Safe Mode protocol with explicit SizedBox and ColoredBox)
- [x] T030 [US2] Create Interaction Test for Paste functionality in `test/molecules/inputs/pin/app_pin_input_test.dart`

## Phase 5: User Story 3 (Password Input)

Goal: Implement `AppPasswordInput` molecule.

- [x] T031 [US3] Implement `AppPasswordRule` entity in `lib/src/molecules/inputs/password/app_password_rule.dart`
- [x] T032 [US3] Create `AppPasswordInput` widget skeleton in `lib/src/molecules/inputs/password/app_password_input.dart`
- [x] T033 [US3] Implement Rule Validation Logic (Real-time check on every keystroke) in `lib/src/molecules/inputs/password/app_password_input.dart`
- [x] T034 [US3] Implement Rule List Rendering (Icon + Text) based on `PasswordInputStyle` in `lib/src/molecules/inputs/password/app_password_input.dart`
- [x] T035 [US3] Implement Visibility Toggle (Eye Icon) and Obscure Text logic in `lib/src/molecules/inputs/password/app_password_input.dart`
- [x] T036 [US3] Integrate `AppFeedback` for rule success (Light) and form success (Medium) in `lib/src/molecules/inputs/password/app_password_input.dart`
- [x] T037 [US3] Add `AppPasswordInput` UseCase to Widgetbook in `widgetbook/lib/stories/molecules/inputs/password_input.stories.dart`
- [x] T038 [US3] Create Golden Test for Password Input in `test/molecules/inputs/password/app_password_input_golden_test.dart` (Verify Rule List Styling, Pixel ASCII Icons using Safe Mode protocol with explicit SizedBox and ColoredBox)

## Phase 6: Polish & Cross-Cutting

Goal: Finalize exports and verification.

- [x] T039 Export all new components in `lib/ui_kit.dart`
- [ ] T040 Run `flutter test --update-goldens` to ensure all new goldens are generated
- [ ] T041 Verify all tests pass with `flutter test`
- [ ] T042 Verify Pixel Theme animations are instant (0ms) across all new components

## Dependencies

- Phase 1 & 2 blocks all User Stories
- User Stories (US1, US2, US3) can be implemented in parallel
- Phase 6 blocks completion

## Implementation Strategy

1.  **MVP**: Complete Phase 1 & 2 to establish the styling foundation.
2.  **Incremental**: Implement components in order (Range -> Pin -> Password).
3.  **Parallel**: Multiple developers can work on US1, US2, and US3 simultaneously after Phase 2 is complete.
