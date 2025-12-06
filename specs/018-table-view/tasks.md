---
description: "Task list for Table View Component implementation"
---

# Tasks: Table View Component

**Input**: Design documents from `/specs/018-table-view/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), data-model.md, contracts/

**Tests**: OPTIONAL. Included where verification steps are explicit in the plan.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and theme infrastructure

- [ ] T001 Create feature directory structure in `lib/src/molecules/table/`
- [ ] T002 Define `TableStyle` class in `lib/src/foundation/theme/styles/table_style.dart`
- [ ] T003 Update `ThemeFactory` to inject `TableStyle` into `NeumorphicDesignTheme` and `PixelDesignTheme`
- [ ] T004 Run `build_runner` to generate theme extensions

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

- [ ] T005 Create `AppDataTable` widget scaffold in `lib/src/molecules/table/app_data_table.dart`
- [ ] T006 Create `AppTableColumn` definition in `lib/src/molecules/table/table_column.dart`
- [ ] T007 [P] Implement `_TableHeader` component in `lib/src/molecules/table/widgets/table_header.dart`
- [ ] T008 [P] Implement `_TablePagination` component in `lib/src/molecules/table/widgets/table_pagination.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View and Navigate Data Responsively (Priority: P1) 🎯 MVP

**Goal**: Display data effectively across Desktop, Laptop, and Mobile viewports with correct theming.

**Independent Test**: Verify data rendering and layout adaptation on all device sizes.

### Implementation for User Story 1

- [ ] T009 [US1] Implement `_GridRenderer` for Desktop/Laptop in `lib/src/molecules/table/renderers/grid_renderer.dart`
- [ ] T010 [US1] Implement `_CardRenderer` for Mobile in `lib/src/molecules/table/renderers/card_renderer.dart`
- [ ] T011 [US1] Implement `LayoutBuilder` logic in `AppDataTable` to switch renderers based on breakpoint
- [ ] T012 [US1] Apply `TableStyle` (Pixel grid vs Glass blur) to rows in `_GridRenderer`
- [ ] T013 [US1] Implement text truncation and tooltip logic for long content in `_DataRow`
- [ ] T014 [US1] Implement embedded component scaling logic in cell builders

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Edit Data (Single Row) (Priority: P1)

**Goal**: Enable single-row editing with diverse input support and proper state management.

**Independent Test**: Trigger edit mode, verify UI behavior, save/cancel actions.

### Implementation for User Story 2

- [ ] T015 [US2] Implement internal state management for `editingRowIndex` in `AppDataTable`
- [ ] T016 [US2] Implement "Edit", "Delete", and "Cancel" action buttons in `_DataRow` and `_CardRenderer`
- [ ] T017 [US2] Implement `editBuilder` support in `_DataRow` to render custom input widgets
- [ ] T018 [US2] Implement fallback `AppTextFormField` logic when `editBuilder` is null
- [ ] T019 [US2] Implement row dimming/disabling logic for non-editing rows
- [ ] T020 [US2] Apply theme-specific motion (Instant vs Fluid) for mode transitions

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Error Handling during Edit (Priority: P2)

**Goal**: Provide clear, non-intrusive error feedback without layout shifts.

**Independent Test**: Trigger validation errors and verify layout stability and visual indicators.

### Implementation for User Story 3

- [ ] T021 [US3] Integrate validation logic into `AppTextFormField` within table rows
- [ ] T022 [US3] Implement error visual indicators (border color, icon) using `AppColorScheme.error`
- [ ] T023 [US3] Ensure validation error tooltip appears on interaction

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T024 [P] Implement haptic feedback for key actions (Edit, Save)
- [ ] T025 [P] Implement sound cues for Pixel theme success/failure
- [ ] T026 Create Widgetbook stories in `widgetbook/lib/stories/table_stories.dart`
- [ ] T027 [Constitution] Implement Golden Tests (Light/Dark, Pixel/Glass, Scale 1.0/1.5) in `test/molecules/table_golden_test.dart`
- [ ] T028 [Constitution] Integrate `TableStyle` parameters into Theme Editor control panel
- [ ] T029 Code cleanup and final lint check

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
- **Polish (Phase 6)**: Depends on all user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2)
- **User Story 2 (P1)**: Can start after Foundational (Phase 2), but conceptually builds on US1's rendering logic. Ideally start after T009/T010.
- **User Story 3 (P2)**: Depends on US2 (Edit Mode) being functional.

### Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1 & 2 (Setup & Foundation)
2. Complete Phase 3 (View & Responsive Layout)
3. **STOP and VALIDATE**: Verify data display and theme adaptation.

### Incremental Delivery

1. Foundation ready (Phase 1 & 2)
2. Add View Mode (US1) → Test
3. Add Edit Mode (US2) → Test
4. Add Validation (US3) → Test
5. Polish (Phase 6)
