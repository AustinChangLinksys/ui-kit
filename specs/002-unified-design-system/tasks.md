# Tasks: Unified Design System

**Input**: Design documents from `/specs/002-unified-design-system/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Tests are included as requested by the Golden Test requirement in the plan.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Path Conventions

- `lib/src/foundation/theme/design_system/`
- `lib/src/atoms/surfaces/`
- `lib/src/molecules/cards/`
- `lib/src/molecules/dialogs/`

## Constitutional Alignment

- **Architectural Boundaries**: Adhere to directory structure.
- **Theming & Styling**: Use `theme_tailor`.
- **Component Design**: Dumb components, composition.
- **Quality Assurance**: Widgetbook, Golden Tests.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and directory structure.

- [x] T001 Update `pubspec.yaml` with `equatable` and `alchemist` dependencies. (`pubspec.yaml`)
- [x] T002 Create directory `lib/src/foundation/theme/design_system/` for design system core files.
- [x] T003 Create directory `lib/src/foundation/theme/design_system/styles/` for concrete style implementations.
- [x] T004 Create directory `lib/src/atoms/surfaces/` for primitives.
- [x] T005 Create directory `lib/src/molecules/cards/` and `lib/src/molecules/dialogs/` (if not present).

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete.

- [x] T006 Create `lib/src/foundation/theme/design_system/surface_style.dart` defining `SurfaceStyle`, `AnimationSpec`, and `TypographySpec` classes.
- [x] T007 Create `lib/src/foundation/theme/design_system/app_design_theme.dart` defining the abstract `AppDesignTheme` class using `@TailorMixin`.
- [x] T008 [P] Create `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart` implementing `GlassDesignTheme`.
- [x] T009 [P] Create `lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart` implementing `BrutalDesignTheme`.
- [x] T010 [P] Create `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart` implementing `FlatDesignTheme` (Light/Dark).
- [x] T011 [P] Create `lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart` implementing `NeumorphicDesignTheme` (Light/Dark).
- [x] T012 Run `dart run build_runner build` to generate theme extensions.
- [x] T013 Update `lib/src/foundation/theme/app_theme.dart` to allow injecting `AppDesignTheme`.

**Checkpoint**: Theme infrastructure is ready.

---

## Phase 3: User Story 1 - Foundation: Theming & Primitives (Priority: P1)

**Goal**: Implement the unified `AppSurface` primitive that adapts to the active theme.

**Independent Test**: `AppSurface` renders correctly based on the active theme (Glass vs Brutal).

### Implementation for User Story 1

- [x] T014 [US1] Create `lib/src/atoms/surfaces/app_surface.dart`.
- [x] T015 [US1] Implement `AppSurface` build logic to read `AppDesignTheme` and render container/decoration.
- [x] T016 [US1] Implement `AppSurface` interaction logic using `AnimationSpec` (implicit animations).
- [x] T017 [US1] Create basic widget test `test/atoms/surfaces/app_surface_test.dart` to verify theme reading.

**Checkpoint**: `AppSurface` works and adapts to theme changes.

---

## Phase 4: User Story 2 - Component Migration: Card & Dialog (Priority: P2)

**Goal**: Migrate Card and Dialog components to use the new `AppSurface`.

**Independent Test**: `AppCard` and `AppDialog` render correctly and switch styles when theme changes.

### Implementation for User Story 2

- [x] T018 [P] [US2] Create `lib/src/molecules/cards/app_card.dart` composing `AppSurface`.
- [x] T019 [P] [US2] Create `lib/src/molecules/dialogs/app_dialog.dart` composing `AppSurface`.
- [x] T020 [US2] Update `lib/src/molecules/cards/liquid_glass_card.dart` to wrap `AppCard` (or deprecate/redirect).
- [x] T021 [US2] Update `lib/src/molecules/dialogs/liquid_glass_dialog.dart` to wrap `AppDialog` (or deprecate/redirect).
- [x] T022 [US2] Export new components in `lib/ui_kit.dart`.

**Checkpoint**: Semantic components are available and legacy components are backward compatible.

---

## Phase 5: User Story 3 - Widgetbook Visualization (Priority: P3)

**Goal**: Demonstrate design language switching in Widgetbook.

**Independent Test**: Switching the "Design Language" knob/theme in Widgetbook instantly updates components.

### Implementation for User Story 3

- [x] T023 [US3] Update `widgetbook/lib/main.dart` to implement orthogonal switching: Design Language (Knob) + Theme Mode (Addon).
- [x] T024 [P] [US3] Create `widgetbook/lib/stories/atoms/surfaces/app_surface.stories.dart`.
- [x] T025 [P] [US3] Create/Update `widgetbook/lib/stories/molecules/cards/app_card.stories.dart`.
- [x] T026 [P] [US3] Create/Update `widgetbook/lib/stories/molecules/dialogs/app_dialog.stories.dart`.

**Checkpoint**: Visual verification complete.

---

## Final Phase: Polish & Cross-Cutting Concerns

**Purpose**: Verification and final touches.

- [x] T027 Add Golden Tests for `AppCard` in different themes (`test/molecules/cards/app_card_golden_test.dart`).
- [x] T028 Run all tests and verification scripts.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies.
- **Foundational (Phase 2)**: Depends on Setup.
- **US1 (Phase 3)**: Depends on Foundational.
- **US2 (Phase 4)**: Depends on US1 (needs `AppSurface`).
- **US3 (Phase 5)**: Depends on US2 (needs components).
- **Polish**: Depends on all phases.

### Parallel Opportunities

- T008, T009, T010, T011 can be done in parallel.
- T018 and T019 can be done in parallel.
- T024, T025, T026 can be done in parallel.

---

## Implementation Strategy

### Incremental Delivery

1.  **Foundation**: Build the theme engine (`AppDesignTheme`).
2.  **Primitive**: Build `AppSurface` to prove the engine works.
3.  **Components**: Build `AppCard`/`AppDialog` on top of `AppSurface`.
4.  **Showcase**: Enable switching in Widgetbook.