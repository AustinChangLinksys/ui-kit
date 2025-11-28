# Tasks: UI Kit Initialization

**Input**: Design documents from `/specs/001-ui-kit-init/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: The examples below include test tasks. Tests are OPTIONAL - only include them if explicitly requested in the feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

The UI Kit project must adhere to the directory structure defined in the Project Constitution (v1.0.0, Section 2.3).
Tasks will use paths relative to the `src/` directory within the UI Kit package:

- `src/foundation/`
- `src/atoms/`
- `src/molecules/`
- `src/organisms/`
- `src/layout/`

## Constitutional Alignment

All tasks for feature implementation MUST align with the principles outlined in the Project Constitution (v1.0.0). Pay particular attention to:

- **Architectural Boundaries**: Especially Dependency Hygiene (Section 2.2) and Directory Structure (Section 2.3).
- **Theming & Styling**: Ensure components follow Token-First Design (Section 3.1) and use Theme Tailor (Section 3.3).
- **Component Design**: Enforce "Dumb Components" (Section 4.1) and "Composition over Inheritance" (Section 4.2).
- **Assets Management**: Adhere to Access Standards (Section 5.1) and Formatting Standards (Section 5.2).
- **Quality Assurance & Testing**: Mandatory Widgetbook (Section 12.1) and Golden Test (Section 12.2) requirements.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create or update `pubspec.yaml` with specified dependencies and configuration. (`pubspec.yaml`)
- [x] T002 [P] Create the root asset directories: `assets/`, `assets/icons/`, `assets/images/`, `assets/anims/`. (`assets/`, `assets/icons/`, `assets/images/`, `assets/anims/`)
- [x] T003 [P] Create the core `lib/src/` subdirectories: `foundation/`, `atoms/`, `molecules/`, `organisms/`, `layout/`. (`lib/src/foundation/`, `lib/src/atoms/`, `lib/src/molecules/`, `lib/src/organisms/`, `lib/src/layout/`)
- [x] T004 [P] Create the `foundation/gen/` subdirectory for generated files. (`lib/src/foundation/gen/`)
- [x] T005 [P] Create the `foundation/theme/` subdirectory for theme definitions. (`lib/src/foundation/theme/`)
- [x] T006 [P] Create `lib/ui_kit.dart` as a barrel file. (`lib/ui_kit.dart`)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T007 Create `app_layout.dart` with `AppLayout` definition using `theme_tailor_annotation`. (`lib/src/foundation/theme/app_layout.dart`)
- [x] T008 Create `app_theme.dart` with `AppTheme.create` method. (`lib/src/foundation/theme/app_theme.dart`)

---

## Phase 3: User Story 1 - Initialize UI Kit Project (Priority: P1) 🎯 MVP

**Goal**: Developer can successfully initialize the UI Kit project with specified dependencies, directory structure, and boilerplate code.

**Independent Test**: Running `flutter pub get` and `dart run build_runner build -d` without errors, and verifying presence of generated files and correct directory structure.

### Implementation for User Story 1

- [x] T009 [US1] Run `flutter pub get` in the project root to install dependencies. (`.` - project root)
- [x] T010 [US1] Run `dart run build_runner build -d` to generate `app_layout.tailor.dart` and `assets.gen.dart`. (`.` - project root)
- [x] T011 [US1] Verify that `app_layout.tailor.dart` is generated in `lib/src/foundation/theme/`. (`lib/src/foundation/theme/app_layout.tailor.dart`)
- [x] T012 [US1] Verify that `assets.gen.dart` is generated in `lib/src/foundation/gen/`. (`lib/src/foundation/gen/assets.gen.dart`)
- [x] T013 [US1] Verify the existence of all specified core directories. (`lib/src/foundation/`, `lib/src/atoms/`, etc.)

---

## Phase 4: User Story 2 - Set up Widgetbook Environment (Priority: P1)

**Goal**: Developer can successfully set up the Widgetbook environment within the UI Kit project.

**Independent Test**: Widgetbook project initializes, fetches dependencies, and successfully references the main UI Kit library.

### Implementation for User Story 2

- [x] T014 Create `widgetbook/` directory in the project root. (`widgetbook/`)
- [x] T015 Create `widgetbook/pubspec.yaml` with Widgetbook dependencies and reference to `ui_kit_library`. (`widgetbook/pubspec.yaml`)
- [x] T016 [US2] Change directory to `widgetbook` and run `flutter pub get`. (`widgetbook/`)
- [x] T017 [US2] Change directory back to project root. (`.`)

---

## Final Phase: Polish & Cross-Cutting Concerns

**Purpose**: Final validation of the setup.

- [x] T018 Run quickstart.md validation steps. (`quickstart.md`)

---

## Dependencies & Execution Order

### Phase Dependencies

-   **Setup (Phase 1)**: No dependencies - can start immediately
-   **Foundational (Phase 2)**: Depends on Setup completion
-   **User Story 1 (Phase 3)**: Depends on Foundational completion
-   **User Story 2 (Phase 4)**: Depends on Phase 1 completion (specifically T001) - can be worked on in parallel with Phase 2 and 3 if T001 is done.
-   **Polish (Final Phase)**: Depends on all other phases being complete

### User Story Dependencies

-   **User Story 1 (P1)**: No dependencies on other stories
-   **User Story 2 (P1)**: No dependencies on other stories. Requires the main `pubspec.yaml` to be set up (T001).

### Within Each User Story

-   Dependencies are sequential unless marked `[P]`.

### Parallel Opportunities

-   `T002`, `T003`, `T004`, `T005`, `T006` in Phase 1 can be done in parallel.
-   `T007` and `T008` in Phase 2 can be done in parallel.
-   `T011`, `T012`, `T013` in Phase 3 can be done in parallel (verification steps).
-   `T014`, `T015` in Phase 4 can be done in parallel.
-   Once Phase 1 and 2 are complete, User Story 1 and User Story 2 can conceptually be worked on by different individuals.

---

## Parallel Example: User Story 1

```bash
# Launch all tests for User Story 1 together (if tests requested):
# Not applicable for this story as no explicit test generation was requested beyond verification steps.

# Launch all models for User Story 1 together:
# Not applicable for this story as it's an initialization feature.
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1.  Complete Phase 1: Setup
2.  Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3.  Complete Phase 3: User Story 1
4.  **STOP and VALIDATE**: Test User Story 1 independently
5.  Deploy/demo if ready

### Incremental Delivery

1.  Complete Setup + Foundational → Foundation ready
2.  Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3.  Add User Story 2 → Test independently → Deploy/Demo
4.  Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1.  Team completes Setup together (T001-T006).
2.  Team completes Foundational (T007-T008).
3.  Once Foundational is done:
    -   Developer A: User Story 1 (T009-T013)
    -   Developer B: User Story 2 (T014-T017)
4.  Stories complete and integrate independently.

---

## Notes

-   `[P]` tasks = different files, no dependencies
-   `[Story]` label maps task to specific user story for traceability
-   Each user story should be independently completable and testable
-   Verify tests fail before implementing
-   Commit after each task or logical group
-   Stop at any checkpoint to validate story independently
-   Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
