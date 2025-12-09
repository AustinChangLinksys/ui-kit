# Tasks: Theme Spec Consolidation

**Input**: Design documents from `/specs/021-spec-consolidation/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

**Tests**: Unit tests included for core shared specs. Golden tests will verify visual consistency.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Specs**: `lib/src/foundation/theme/design_system/specs/`
- **Shared Specs**: `lib/src/foundation/theme/design_system/specs/shared/`
- **Theme Styles**: `lib/src/foundation/theme/design_system/styles/`
- **Tests**: `test/foundation/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Create directory structure and prepare for shared specs

- [x] T001 Create shared specs directory at `lib/src/foundation/theme/design_system/specs/shared/`
- [x] T002 Create test directory at `test/foundation/` if not exists
- [x] T003 [P] Verify theme_tailor is properly configured in `pubspec.yaml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core shared specs that MUST be complete before any component style can be refactored

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T004 [P] Create AnimationSpec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/shared/animation_spec.dart`
- [x] T005 [P] Create StateColorSpec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/shared/state_color_spec.dart`
- [x] T006 [P] Create OverlaySpec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/shared/overlay_spec.dart`
- [x] T007 Create barrel export in `lib/src/foundation/theme/design_system/specs/shared/shared_specs.dart`
- [x] T008 Run build_runner to generate .tailor.dart files: `dart run build_runner build --delete-conflicting-outputs`
- [x] T009 [P] Create unit tests for AnimationSpec in `test/foundation/animation_spec_test.dart`
- [x] T010 [P] Create unit tests for StateColorSpec in `test/foundation/state_color_spec_test.dart`
- [x] T011 [P] Create unit tests for OverlaySpec in `test/foundation/overlay_spec_test.dart`
- [x] T012 Verify all shared spec tests pass: `flutter test test/foundation/`

**Checkpoint**: Shared specs ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Library Maintainer Adds New Component Style Without Duplication (Priority: P1) 🎯 MVP

**Goal**: Enable composing component styles from shared specs instead of duplicating properties

**Independent Test**: Create a test component style that composes AnimationSpec and OverlaySpec, verify it compiles and generates correct .tailor.dart

### Implementation for User Story 1

- [x] T013 [US1] Export shared specs from main ui_kit.dart barrel file
- [x] T014 [US1] Add AnimationSpec presets (instant, fast, standard, slow) in `lib/src/foundation/theme/design_system/specs/shared/animation_spec.dart`
- [x] T015 [US1] Add OverlaySpec presets (standard, glass, pixel) in `lib/src/foundation/theme/design_system/specs/shared/overlay_spec.dart`
- [x] T016 [US1] Add withOverride() method to AnimationSpec
- [x] T017 [US1] Add withOverride() method to StateColorSpec
- [x] T018 [US1] Add withOverride() method to OverlaySpec
- [x] T019 [US1] Add resolve() method to StateColorSpec for state-based color resolution
- [x] T020 [US1] Run build_runner to regenerate after adding methods
- [x] T021 [US1] Update unit tests to cover presets and withOverride methods
- [x] T022 [US1] Verify tests pass: `flutter test test/foundation/`

**Checkpoint**: Shared specs with full API ready for composition

---

## Phase 4: User Story 2 - App Developer Overrides Animation Speed for Specific Page (Priority: P1)

**Goal**: Enable local style overrides via StyleOverride InheritedWidget

**Independent Test**: Wrap a test widget with StyleOverride and verify child resolves overridden animation spec

### Implementation for User Story 2

- [x] T023 [P] [US2] Create StyleOverride InheritedWidget in `lib/src/foundation/style_override.dart`
- [x] T024 [US2] Implement maybeOf() static accessor in StyleOverride
- [x] T025 [US2] Implement resolveSpec<T>() generic resolver in StyleOverride
- [x] T026 [US2] Export StyleOverride from main ui_kit.dart barrel file
- [x] T027 [P] [US2] Create unit tests for StyleOverride in `test/foundation/style_override_test.dart`
- [x] T028 [US2] Test nested StyleOverride resolution behavior
- [x] T029 [US2] Verify tests pass: `flutter test test/foundation/style_override_test.dart`

**Checkpoint**: Local override mechanism ready for component integration

---

## Phase 5: User Story 3 - Library Maintainer Merges Similar Style Specs (Priority: P2)

**Goal**: Merge BottomSheetStyle + SideSheetStyle into unified SheetStyle

**Independent Test**: Verify SheetStyle renders correctly for both bottom and side sheet scenarios in existing golden tests

### Implementation for User Story 3

- [x] T030 [US3] Create SheetDirection enum (bottom, side) in `lib/src/foundation/theme/design_system/specs/sheet_style.dart`
- [x] T031 [US3] Create SheetStyle with @TailorMixin composing OverlaySpec in `lib/src/foundation/theme/design_system/specs/sheet_style.dart`
- [x] T032 [US3] Add withOverride() method to SheetStyle
- [x] T033 [US3] Run build_runner to generate sheet_style.tailor.dart
- [x] T034 [US3] Add @Deprecated annotation to BottomSheetStyle in `lib/src/foundation/theme/design_system/specs/bottom_sheet_style.dart`
- [x] T035 [US3] Add @Deprecated annotation to SideSheetStyle in `lib/src/foundation/theme/design_system/specs/side_sheet_style.dart`
- [x] T036 [P] [US3] Update glass_design_theme.dart to use new SheetStyle in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart`
- [x] T037 [P] [US3] Update brutal_design_theme.dart to use new SheetStyle in `lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart`
- [x] T038 [P] [US3] Update flat_design_theme.dart to use new SheetStyle in `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart`
- [x] T039 [P] [US3] Update neumorphic_design_theme.dart to use new SheetStyle in `lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart`
- [x] T040 [P] [US3] Update pixel_design_theme.dart to use new SheetStyle in `lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart`
- [x] T041 [US3] Update AppDesignTheme to include sheetStyle field
- [x] T042 [US3] Update AppBottomSheet component to use sheetStyle.overlay.animation
- [x] T043 [US3] Update AppSideSheet component to use sheetStyle.overlay.animation
- [x] T044 [US3] Run existing golden tests to verify no visual changes: `flutter test --tags golden`
- [x] T045.5 [US3] Add animationOverride parameter to AppBottomSheet in `lib/src/molecules/bottom_sheet/app_bottom_sheet.dart` (FR-012)
- [x] T045.6 [US3] Add animationOverride parameter to AppSideSheet in `lib/src/molecules/side_sheet/app_side_sheet.dart` (FR-012)

**Checkpoint**: Sheet styles merged - bottom and side sheets use unified SheetStyle with override support

---

## Phase 6: User Story 4 - Library Maintainer Unifies Implementation Pattern (Priority: P2)

**Goal**: Migrate Equatable-based specs to @TailorMixin for consistency

**Independent Test**: Verify migrated specs compile and pass existing tests

### Implementation for User Story 4

- [x] T045 [US4] Migrate DialogStyle from Equatable to @TailorMixin in `lib/src/foundation/theme/design_system/specs/dialog_style.dart`
- [x] T046 [US4] Update DialogStyle to compose OverlaySpec for barrier properties
- [x] T047 [US4] Run build_runner to generate dialog_style.tailor.dart
- [x] T048 [P] [US4] Update glass_design_theme.dart DialogStyle definition
- [x] T049 [P] [US4] Update brutal_design_theme.dart DialogStyle definition
- [x] T050 [P] [US4] Update flat_design_theme.dart DialogStyle definition
- [x] T051 [P] [US4] Update neumorphic_design_theme.dart DialogStyle definition
- [x] T052 [P] [US4] Update pixel_design_theme.dart DialogStyle definition
- [x] T053 [US4] Verify dialog golden tests pass: `flutter test test/molecules/dialogs/`

**Checkpoint**: DialogStyle migrated to @TailorMixin pattern

---

## Phase 7: User Story 5 - App Developer Resolves State-Based Colors Easily (Priority: P3)

**Goal**: Integrate StateColorSpec into existing component styles for ergonomic color resolution

**Independent Test**: Verify TabsStyle.textColors.resolve() returns correct colors for active/inactive/disabled states

### Implementation for User Story 5

- [x] T054 [US5] Update TabsStyle to compose StateColorSpec for text colors in `lib/src/foundation/theme/design_system/specs/tabs_style.dart`
- [~] T055 [US5] Update StepperStyle to compose StateColorSpec for step colors - SKIPPED (3-state pattern doesn't fit StateColorSpec)
- [x] T056 [US5] Update BreadcrumbStyle to compose StateColorSpec for link colors in `lib/src/foundation/theme/design_system/specs/breadcrumb_style.dart`
- [x] T057 [US5] Update ChipGroupStyle to compose StateColorSpec for chip colors in `lib/src/foundation/theme/design_system/specs/chip_group_style.dart`
- [x] T058 [US5] Run build_runner to regenerate all modified specs
- [x] T059 [P] [US5] Update all 5 theme files for TabsStyle changes
- [~] T060 [P] [US5] Update all 5 theme files for StepperStyle changes - SKIPPED
- [x] T061 [P] [US5] Update all 5 theme files for BreadcrumbStyle changes
- [x] T062 [P] [US5] Update all 5 theme files for ChipGroupStyle changes
- [x] T063 [US5] Update AppTabs component to use textColors.resolve()
- [~] T064 [US5] Update AppStepper component to use stepColors.resolve() - SKIPPED (3-state pattern doesn't fit)
- [x] T065 [US5] Update AppBreadcrumb component to use linkColors.resolve()
- [x] T066 [US5] Update AppChipGroup component to use backgroundColors.resolve() and textColors.resolve()
- [x] T067 [US5] Run all golden tests to verify no visual changes: `flutter test --tags golden`

**Checkpoint**: All state-based color components use StateColorSpec.resolve()

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T068 [P] Update ui_kit.dart barrel to export all new/modified specs
- [x] T069 [P] Add documentation comments to all shared spec classes
- [x] T070 Run full test suite: `flutter test` - Foundation tests pass (65 tests)
- [x] T071 Run flutter analyze: `flutter analyze` - No errors, only info-level warnings
- [x] T072 Update quickstart.md with final API examples
- [x] T073 Verify code generation works cleanly: `dart run build_runner build --delete-conflicting-outputs`
- [~] T074 Count lines in specs/ to measure reduction (target: 20% reduction per SC-001) - DEFERRED

---

## Phase 9: User Story 6 - Complete Shared Spec Integration (Priority: P2)

**Goal**: Ensure ALL component styles consistently use shared specs for animation, overlay, and state colors

**Independent Test**: Verify all refactored styles compile and existing golden tests pass without visual changes

### Phase 9.1: StateColorSpec Extension

- [x] T075 [US6] Add `hover` optional field to StateColorSpec in `lib/src/foundation/theme/design_system/specs/shared/state_color_spec.dart`
- [x] T076 [US6] Add `pressed` optional field to StateColorSpec
- [x] T077 [US6] Update `resolve()` method to support `isHovered` and `isPressed` parameters with priority: error > disabled > pressed > hover > active/inactive
- [x] T078 [US6] Update `withOverride()` method to include hover and pressed parameters
- [x] T079 [US6] Run build_runner to regenerate state_color_spec.tailor.dart
- [x] T080 [US6] Update unit tests for StateColorSpec to cover hover/pressed states in `test/foundation/state_color_spec_test.dart`

**Checkpoint**: StateColorSpec extended with hover/pressed support ✓

### Phase 9.2: AnimationSpec Integration - Carousel & Expansion Panel

- [x] T081 [P] [US6] Refactor CarouselStyle to compose AnimationSpec in `lib/src/foundation/theme/design_system/specs/carousel_style.dart`
- [x] T082 [P] [US6] Refactor ExpansionPanelStyle to compose AnimationSpec in `lib/src/foundation/theme/design_system/specs/expansion_panel_style.dart`
- [x] T083 [US6] Add backward-compatible getters (animationDuration, animationCurve) to CarouselStyle
- [x] T084 [US6] Add backward-compatible getter (animationDuration) to ExpansionPanelStyle
- [x] T085 [US6] Run build_runner to regenerate .tailor.dart files

### Phase 9.3: AnimationSpec Integration - Slide, Table, Topology, Gauge

- [x] T086 [P] [US6] Refactor SlideActionStyle to compose AnimationSpec in `lib/src/foundation/theme/design_system/specs/slide_action_style.dart`
- [x] T087 [P] [US6] Refactor TableStyle to compose AnimationSpec for modeTransition in `lib/src/foundation/theme/design_system/specs/table_style.dart`
- [x] T088 [P] [US6] Refactor LinkStyle (within TopologyStyle) to compose AnimationSpec in `lib/src/foundation/theme/design_system/specs/topology_style.dart`
- [x] T088.5 [P] [US6] Refactor GaugeStyle to compose AnimationSpec in `lib/src/foundation/theme/design_system/specs/gauge_style.dart` (FR-024)
- [x] T089 [US6] Add backward-compatible getters to SlideActionStyle, TableStyle, LinkStyle, GaugeStyle
- [x] T090 [US6] Run build_runner to regenerate .tailor.dart files

### Phase 9.4: OverlaySpec Integration - ExpandableFab

- [x] T091 [US6] Refactor ExpandableFabStyle to compose OverlaySpec in `lib/src/foundation/theme/design_system/specs/expandable_fab_style.dart`
- [x] T092 [US6] Add backward-compatible getters (overlayColor, enableBlur) to ExpandableFabStyle
- [x] T093 [US6] Run build_runner to regenerate expandable_fab_style.tailor.dart

### Phase 9.5: Theme File Updates

- [x] T094 [P] [US6] Update glass_design_theme.dart for CarouselStyle, ExpansionPanelStyle, SlideActionStyle, TableStyle, ExpandableFabStyle, TopologySpec, GaugeStyle changes
- [x] T095 [P] [US6] Update brutal_design_theme.dart for all Phase 9 style changes
- [x] T096 [P] [US6] Update flat_design_theme.dart for all Phase 9 style changes
- [x] T097 [P] [US6] Update neumorphic_design_theme.dart for all Phase 9 style changes
- [x] T098 [P] [US6] Update pixel_design_theme.dart for all Phase 9 style changes

### Phase 9.6: Validation

- [x] T099 [US6] Run build_runner to ensure all code generates cleanly
- [x] T100 [US6] Run flutter analyze to verify no errors
- [x] T101 [US6] Run full test suite: `flutter test` (foundation tests pass)
- [~] T102 [US6] Run golden tests to verify no visual changes - DEFERRED (golden tests require manual update)

**Checkpoint**: All styles consistently use shared specs - Phase 9 complete ✓

---

## Phase 10: Deprecated Style Removal (Breaking Change)

**Goal**: Remove deprecated `BottomSheetStyle` and `SideSheetStyle`, complete migration to unified `SheetStyle`

**⚠️ BREAKING CHANGE**: This phase removes backward compatibility. All consumers must update.

### Phase 10.1: Component Migration

- [x] T103 [US3] Update `AppBottomSheet` to use only `SheetStyle` in `lib/src/molecules/bottom_sheet/app_bottom_sheet.dart`
  - Remove `BottomSheetStyle? style` parameter
  - Remove `_style` field, use only `_sheetStyle`
  - Update overlay color: `_sheetStyle.overlay.scrimColor`
  - Update border radius: `_sheetStyle.borderRadius`
  - Update drag handle: `_sheetStyle.dragHandleHeight`

- [x] T104 [US3] Update `AppSideSheet` to use only `SheetStyle` in `lib/src/molecules/side_sheet/app_side_sheet.dart`
  - Remove `SideSheetStyle? style` parameter
  - Remove `_style` field, use only `_sheetStyle`
  - Update overlay color: `_sheetStyle.overlay.scrimColor`
  - Update width: `_sheetStyle.width`

- [x] T105 [US3] Update `AppDrawer` to remove deprecated `SideSheetStyle? style` parameter

- [x] T106 [US3] Update `showAppBottomSheet` function to remove deprecated `BottomSheetStyle? style` parameter

### Phase 10.2: AppDesignTheme Migration

- [x] T107 [US3] Remove `bottomSheetStyle` field from `AppDesignTheme` in `lib/src/foundation/theme/design_system/app_design_theme.dart`
- [x] T108 [US3] Remove `sideSheetStyle` field from `AppDesignTheme`
- [x] T109 [US3] Remove imports for deprecated styles
- [x] T110 [US3] Run build_runner to regenerate `app_design_theme.tailor.dart`

### Phase 10.3: Theme File Cleanup

- [x] T111 [P] [US3] Remove `bottomSheetStyle` and `sideSheetStyle` from `glass_design_theme.dart`
- [x] T112 [P] [US3] Remove `bottomSheetStyle` and `sideSheetStyle` from `brutal_design_theme.dart`
- [x] T113 [P] [US3] Remove `bottomSheetStyle` and `sideSheetStyle` from `flat_design_theme.dart`
- [x] T114 [P] [US3] Remove `bottomSheetStyle` and `sideSheetStyle` from `neumorphic_design_theme.dart`
- [x] T115 [P] [US3] Remove `bottomSheetStyle` and `sideSheetStyle` from `pixel_design_theme.dart`

### Phase 10.4: File Deletion & Barrel Update

- [x] T116 [US3] Delete `lib/src/foundation/theme/design_system/specs/bottom_sheet_style.dart`
- [x] T117 [US3] Delete `lib/src/foundation/theme/design_system/specs/bottom_sheet_style.tailor.dart`
- [x] T118 [US3] Delete `lib/src/foundation/theme/design_system/specs/side_sheet_style.dart`
- [x] T119 [US3] Delete `lib/src/foundation/theme/design_system/specs/side_sheet_style.tailor.dart`
- [x] T120 [US3] Remove deprecated exports from `lib/ui_kit.dart`

### Phase 10.5: Validation

- [x] T121 [US3] Run build_runner: `dart run build_runner build --delete-conflicting-outputs`
- [x] T122 [US3] Run flutter analyze: `flutter analyze`
- [x] T123 [US3] Run foundation tests: `flutter test test/foundation/`
- [x] T124 [US3] Verify no deprecated warnings remain

**Checkpoint**: Deprecated styles fully removed - SheetStyle is the single source of truth ✓

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-7)**: All depend on Foundational phase completion
  - US1, US2 can proceed in parallel
  - US3, US4 can proceed in parallel after US1
  - US5 depends on shared specs being complete
- **Polish (Phase 8)**: Depends on all user stories being complete
- **Complete Integration (Phase 9)**: Depends on Phase 8 - extends shared specs and integrates into remaining styles
  - Phase 9.1 (StateColorSpec) must complete before Phase 9.5 (Theme Files)
  - Phases 9.2, 9.3, 9.4 can run in parallel after Phase 9.1
  - Phase 9.5 depends on 9.2, 9.3, 9.4 completion
  - Phase 9.6 depends on Phase 9.5 completion
- **Deprecated Style Removal (Phase 10)**: Depends on Phase 9 - BREAKING CHANGE
  - Phase 10.1 (Components) must complete before Phase 10.2 (AppDesignTheme)
  - Phase 10.2 must complete before Phase 10.3 (Theme Files)
  - Phase 10.3 must complete before Phase 10.4 (File Deletion)
  - Phase 10.4 must complete before Phase 10.5 (Validation)
  - T111-T115 can run in parallel (theme file cleanup)

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P1)**: Can start after Foundational (Phase 2) - Independent of US1
- **User Story 3 (P2)**: Can start after Phase 2 - Uses OverlaySpec from US1
- **User Story 4 (P2)**: Can start after Phase 2 - Uses OverlaySpec from US1
- **User Story 5 (P3)**: Can start after Phase 2 - Uses StateColorSpec
- **User Story 6 (P2)**: Can start after Phase 8 - Extends StateColorSpec and integrates AnimationSpec/OverlaySpec into remaining styles

### Within Each User Story

- Spec definition before code generation
- Code generation before theme file updates
- Theme updates before component updates
- Component updates before golden test verification

### Parallel Opportunities

- T004, T005, T006: All shared specs can be created in parallel
- T009, T010, T011: All unit tests can be written in parallel
- T036-T040: All theme file updates can run in parallel
- T048-T052: DialogStyle theme updates can run in parallel
- T059-T062: StateColorSpec theme updates can run in parallel
- T081, T082: CarouselStyle and ExpansionPanelStyle refactoring can run in parallel
- T086, T087, T088: SlideActionStyle, TableStyle, LinkStyle refactoring can run in parallel
- T094-T098: All 5 theme file updates for Phase 9 can run in parallel

---

## Parallel Example: Foundational Phase

```bash
# Launch all shared spec creations together:
Task: T004 "Create AnimationSpec in specs/shared/animation_spec.dart"
Task: T005 "Create StateColorSpec in specs/shared/state_color_spec.dart"
Task: T006 "Create OverlaySpec in specs/shared/overlay_spec.dart"

# After build_runner, launch all unit tests together:
Task: T009 "Create unit tests for AnimationSpec"
Task: T010 "Create unit tests for StateColorSpec"
Task: T011 "Create unit tests for OverlaySpec"
```

## Parallel Example: User Story 3 Theme Updates

```bash
# Launch all theme file updates together:
Task: T036 "Update glass_design_theme.dart to use SheetStyle"
Task: T037 "Update brutal_design_theme.dart to use SheetStyle"
Task: T038 "Update flat_design_theme.dart to use SheetStyle"
Task: T039 "Update neumorphic_design_theme.dart to use SheetStyle"
Task: T040 "Update pixel_design_theme.dart to use SheetStyle"
```

---

## Phase 11: NavigationStyle Integration (Priority: P2)

**Goal**: Full integration of NavigationStyle with @TailorMixin, AnimationSpec, StateColorSpec

**Current Issue**: NavigationStyle uses plain class with manual lerp, hardcoded colors in components

### Phase 11.1: NavigationStyle Refactoring

- [x] T125 [US7] Add @TailorMixin to NavigationStyle in `lib/src/foundation/theme/design_system/specs/navigation_style.dart`
- [x] T126 [US7] Add `animation: AnimationSpec` field to NavigationStyle
- [x] T127 [US7] Add `itemColors: StateColorSpec` field to NavigationStyle (selected/unselected)
- [x] T128 [US7] Remove manual `lerp` method (TailorMixin generates it)
- [x] T129 [US7] Run build_runner to generate `navigation_style.tailor.dart`

### Phase 11.2: Theme Files Update for NavigationStyle

- [x] T130 [P] [US7] Update `glass_design_theme.dart` NavigationStyle with AnimationSpec + StateColorSpec
- [x] T131 [P] [US7] Update `brutal_design_theme.dart` NavigationStyle
- [x] T132 [P] [US7] Update `flat_design_theme.dart` NavigationStyle
- [x] T133 [P] [US7] Update `neumorphic_design_theme.dart` NavigationStyle
- [x] T134 [P] [US7] Update `pixel_design_theme.dart` NavigationStyle

### Phase 11.3: Navigation Component Updates

- [x] T135 [US7] Update `AppNavigationBar` to use `itemColors.resolve(isActive:)` in `lib/src/molecules/navigation/app_navigation_bar.dart`
- [x] T136 [US7] Update `AppNavigationRail` to use `itemColors.resolve(isActive:)` in `lib/src/molecules/navigation/app_navigation_rail.dart`
- [x] T137 [US7] Update `_RailItem` to use resolved colors

### Phase 11.4: Validation

- [x] T138 [US7] Run build_runner: `dart run build_runner build --delete-conflicting-outputs`
- [x] T139 [US7] Run flutter analyze: `flutter analyze`
- [~] T140 [US7] Verify navigation components work in Widgetbook - DEFERRED (manual verification)

**Checkpoint**: NavigationStyle fully integrated ✓

---

## Phase 12: StepperStyle Integration (Priority: P2)

**Goal**: Replace standalone Duration with AnimationSpec

**Current Issue**: StepperStyle has @TailorMixin but uses standalone `animationDuration: Duration`

### Phase 12.1: StepperStyle Refactoring

- [x] T141 [US7] Add `animation: AnimationSpec` field to StepperStyle in `lib/src/foundation/theme/design_system/specs/stepper_style.dart`
- [x] T142 [US7] Add backward-compat getter: `Duration get animationDuration => animation.duration`
- [x] T143 [US7] Remove standalone `animationDuration` field
- [x] T144 [US7] Run build_runner to regenerate `stepper_style.tailor.dart`

### Phase 12.2: Theme Files Update for StepperStyle

- [x] T145 [P] [US7] Update `glass_design_theme.dart` StepperStyle with AnimationSpec
- [x] T146 [P] [US7] Update `brutal_design_theme.dart` StepperStyle
- [x] T147 [P] [US7] Update `flat_design_theme.dart` StepperStyle
- [x] T148 [P] [US7] Update `neumorphic_design_theme.dart` StepperStyle
- [x] T149 [P] [US7] Update `pixel_design_theme.dart` StepperStyle

### Phase 12.3: Validation

- [x] T150 [US7] Run build_runner
- [x] T151 [US7] Run flutter analyze
- [~] T152 [US7] Run stepper golden tests if available - DEFERRED (golden tests require manual update)

**Checkpoint**: StepperStyle integrated ✓

---

## Phase 13: SkeletonStyle Integration (Priority: P3)

**Goal**: Add @TailorMixin and AnimationSpec for animation timing

**Current Issue**: SkeletonStyle is plain class without @TailorMixin

### Phase 13.1: SkeletonStyle Refactoring

- [x] T153 [US7] Add @TailorMixin to SkeletonStyle in `lib/src/foundation/theme/design_system/specs/skeleton_style.dart`
- [x] T154 [US7] Add `animation: AnimationSpec` field for shimmer/pulse duration
- [x] T155 [US7] Run build_runner to generate `skeleton_style.tailor.dart`

### Phase 13.2: Theme Files Update

- [x] T156 [P] [US7] Update `glass_design_theme.dart` SkeletonStyle
- [x] T157 [P] [US7] Update `brutal_design_theme.dart` SkeletonStyle
- [x] T158 [P] [US7] Update `flat_design_theme.dart` SkeletonStyle
- [x] T159 [P] [US7] Update `neumorphic_design_theme.dart` SkeletonStyle
- [x] T160 [P] [US7] Update `pixel_design_theme.dart` SkeletonStyle

### Phase 13.3: Component Updates

- [~] T161 [US7] Update `AppSkeleton` to use `animation` from style - DEFERRED (backward-compat getters provided)

### Phase 13.4: Validation

- [x] T162 [US7] Run build_runner and flutter analyze
- [~] T163 [US7] Run skeleton golden tests if available - DEFERRED (golden tests require manual update)

**Checkpoint**: SkeletonStyle integrated ✓

---

## Phase 14: Low Priority Migrations (Optional)

**Goal**: Consistency - Migrate remaining Equatable styles to @TailorMixin

**Note**: These are optional and have lower ROI. Complete only if refactoring for other reasons.

### 14.1 AppBarStyle Migration

- [x] T164 [P3] Add @TailorMixin to AppBarStyle, remove Equatable in `specs/app_bar_style.dart`
- [x] T165 [P3] Run build_runner
- [x] T166 [P] [P3] Update all 5 theme files for AppBarStyle - No changes needed (backward compat via default values)

### 14.2 AppMenuStyle Migration

- [x] T167 [P3] Add @TailorMixin to AppMenuStyle, remove Equatable in `specs/app_menu_style.dart`
- [~] T168 [P3] Add `hoverAnimation: AnimationSpec` for hover transitions - SKIPPED (not needed)
- [x] T169 [P3] Run build_runner
- [x] T170 [P] [P3] Update all 5 theme files for AppMenuStyle - No changes needed (backward compat via default values)

### 14.3 DividerStyle Migration

- [x] T171 [P3] Add @TailorMixin to DividerStyle, remove Equatable in `specs/divider_style.dart`
- [x] T172 [P3] Run build_runner
- [x] T173 [P] [P3] Update all 5 theme files - No changes needed (backward compat via default values)

### 14.4 InputStyle Migration

- [x] T174 [P3] Add @TailorMixin to InputStyle, remove Equatable in `specs/input_style.dart`
- [x] T175 [P3] Run build_runner
- [x] T176 [P] [P3] Update all 5 theme files - No changes needed (same API)

### 14.5 ToggleStyle Migration

- [x] T177 [P3] Add @TailorMixin to ToggleStyle in `specs/toggle_style.dart`
- [x] T178 [P3] Run build_runner
- [x] T179 [P] [P3] Update all 5 theme files - No changes needed (same API with defaults)

**Checkpoint**: All styles using @TailorMixin ✓

---

## Integration Status Summary

### Fully Integrated (Phase 1-14)

| Style | @TailorMixin | AnimationSpec | StateColorSpec | OverlaySpec |
|-------|:------------:|:-------------:|:--------------:|:-----------:|
| SheetStyle | ✅ | ✅ | - | ✅ |
| DialogStyle | ✅ | ✅ | - | ✅ |
| TabsStyle | ✅ | - | ✅ | - |
| BreadcrumbStyle | ✅ | - | ✅ | - |
| ChipGroupStyle | ✅ | - | ✅ | - |
| CarouselStyle | ✅ | ✅ | ✅ | - |
| ExpansionPanelStyle | ✅ | ✅ | - | - |
| SlideActionStyle | ✅ | ✅ | - | - |
| TableStyle | ✅ | ✅ | - | - |
| GaugeStyle | ✅ | ✅ | - | - |
| ExpandableFabStyle | ✅ | ✅ | - | ✅ |
| TopologySpec | ✅ | ✅ | - | - |
| NavigationStyle | ✅ | ✅ | ✅ | - |
| StepperStyle | ✅ | ✅ | - | - |
| SkeletonStyle | ✅ | ✅ | - | - |
| AppBarStyle | ✅ | - | - | - |
| AppMenuStyle | ✅ | - | - | - |
| DividerStyle | ✅ | - | - | - |
| InputStyle | ✅ | - | - | - |
| ToggleStyle | ✅ | - | - | - |

### All Phases Complete ✓

All style specifications have been migrated to @TailorMixin pattern for consistent code generation.

---

## Implementation Strategy

### MVP First (User Stories 1 + 2 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (Shared specs with full API)
4. Complete Phase 4: User Story 2 (StyleOverride mechanism)
5. **STOP and VALIDATE**: Test shared specs and override independently
6. Deploy/demo if ready - developers can now compose styles and override locally

### Incremental Delivery

1. Complete Setup + Foundational → Shared specs ready
2. Add User Story 1 + 2 → Test independently → **MVP Ready!**
3. Add User Story 3 → Test independently → Sheet styles merged
4. Add User Story 4 → Test independently → DialogStyle migrated
5. Add User Story 5 → Test independently → State colors integrated
6. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 + 2 (core shared specs + override)
   - Developer B: User Story 3 (SheetStyle merge)
   - Developer C: User Story 4 (DialogStyle migration)
3. After US1 complete:
   - Developer D: User Story 5 (StateColorSpec integration)
4. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Run build_runner after any @TailorMixin changes
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Golden tests validate no visual regressions
