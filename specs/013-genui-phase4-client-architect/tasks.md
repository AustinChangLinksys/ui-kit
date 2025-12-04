# Tasks: GenUI Phase 4 - Client Refactoring & Layout Architect

**Input**: Design documents from `/specs/013-genui-phase4-client-architect/`
**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, contracts/

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

All paths relative to `generative_ui/gen_ui_client/` unless otherwise noted.

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Rename project and establish Clean Architecture structure

- [ ] T001 Rename `generative_ui/example/` to `generative_ui/gen_ui_client/`
- [ ] T002 Update `generative_ui/gen_ui_client/pubspec.yaml` with new name and dependencies (riverpod, dart_style, flutter_highlight)
- [ ] T003 [P] Create directory structure: `lib/core/constants/`, `lib/core/errors/`
- [ ] T004 [P] Create directory structure: `lib/domain/entities/`, `lib/domain/services/`
- [ ] T005 [P] Create directory structure: `lib/data/services/`
- [ ] T006 [P] Create directory structure: `lib/presentation/providers/`, `lib/presentation/registry/`, `lib/presentation/views/`
- [ ] T007 Update path references in `generative_ui/gen_ui_client/pubspec.yaml` (generative_ui: path ../, ui_kit_library: path ../../)
- [ ] T008 Run `flutter pub get` to verify dependencies resolve

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core domain entities and error handling that ALL user stories depend on

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T009 [P] Create `lib/core/errors/contract_exception.dart` with ContractException class
- [ ] T010 [P] Create `lib/core/errors/failure.dart` with Failure sealed class
- [ ] T011 [P] Create `lib/domain/entities/design_language.dart` with DesignLanguage enum (glass, brutal, flat, neumorphic, pixel)
- [ ] T012 [P] Create `lib/domain/entities/theme_state.dart` with ThemeState entity (designLanguage, seedColor, brightness)
- [ ] T013 [P] Create `lib/domain/entities/layout_node.dart` with LayoutNode entity (type, props, children, fromJson, toJson)
- [ ] T014 [P] (Future) Create `lib/domain/entities/code_gen_result.dart` with CodeGenResult entity - skip for Phase 4
- [ ] T015 (Future) Create `lib/domain/services/i_code_gen_service.dart` with ICodeGenService interface - skip for Phase 4
- [ ] T016 Run `dart run build_runner build` to generate Riverpod code

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Theme-Aware Dynamic Components (Priority: P1) 🎯 MVP

**Goal**: AI-rendered components automatically adopt the current app theme (Glass/Brutal/Flat/Neumorphic/Pixel)

**Independent Test**: Switch themes at runtime and verify all AI-rendered components update their appearance accordingly

### Implementation for User Story 1

- [ ] T017 [P] [US1] Create `lib/presentation/providers/theme_provider.dart` with ThemeController notifier (designLanguage, seedColor, brightness)
- [ ] T018 [P] [US1] Create `lib/core/constants/theme_factories.dart` mapping DesignLanguage to AppDesignTheme factories
- [ ] T019 [US1] Update `lib/main.dart` to wrap app with ProviderScope and consume ThemeController
- [ ] T020 [US1] Create `lib/presentation/views/architect_view.dart` with theme-aware scaffold using ref.watch(themeControllerProvider)
- [ ] T021 [US1] Update existing demo components in `generative_ui/lib/src/presentation/widgets/demo_components.dart` to use AppSurface and AppText instead of Material widgets
- [ ] T022 [US1] Verify WifiSettingsCard uses AppSurface with variant parameter for theme-aware rendering
- [ ] T023 [US1] Verify InfoCard uses AppText with theme-inherited colors
- [ ] T024 [US1] Verify ConfirmationCard uses AppSurface for success/error states
- [ ] T025 [US1] Run `flutter run` and test theme switching updates all components

**Checkpoint**: Theme-aware rendering works - components update when theme changes

---

## Phase 4: User Story 2 - Complete UI Kit Component Registry (Priority: P1) 🎯 MVP

**Goal**: Comprehensive registry of all 31 UI Kit components (9 atoms + 22 molecules) for AI to utilize

**Independent Test**: Ask AI to create various UI layouts and verify it can use the full range of UI Kit components

### Implementation for User Story 2

- [ ] T026 [P] [US2] Create `lib/presentation/registry/component_builder.dart` with ComponentBuilder typedef
- [ ] T027 [P] [US2] Create `lib/presentation/registry/ui_kit_component_registry.dart` with static Map<String, ComponentBuilder>
- [ ] T028 [US2] Register Atoms in registry: AppSurface, AppText, AppIcon, AppGap, AppDivider, AppSkeleton
- [ ] T029 [US2] Register Atoms in registry: ThemeAwareImage, ThemeAwareSvg, ProductImage
- [ ] T030 [US2] Register Molecules - Buttons: AppButton, AppIconButton
- [ ] T031 [US2] Register Molecules - Inputs: AppTextField, AppTextFormField, AppDropdown
- [ ] T032 [US2] Register Molecules - Network Inputs: AppIPv4TextField, AppIPv6TextField, AppMacAddressTextField
- [ ] T033 [US2] Register Molecules - Selection: AppCheckbox, AppRadio, AppSlider
- [ ] T034 [US2] Register Molecules - Toggles: AppSwitch
- [ ] T035 [US2] Register Molecules - Status: AppBadge, AppTag, AppAvatar
- [ ] T036 [US2] Register Molecules - Feedback: AppLoader, AppToast
- [ ] T037 [US2] Register Molecules - Display: AppTooltip
- [ ] T038 [US2] Register Molecules - Layout: AppListTile, AppCard
- [ ] T039 [US2] Register Molecules - Navigation: AppNavigationBar, AppNavigationRail, AppNavigationItem
- [ ] T040 [US2] Register Molecules - Dialogs: AppDialog
- [ ] T041 [US2] Register Molecules - Menu: AppPopupMenu, AppPopupMenuItem
- [ ] T042 [US2] Register Flutter Layout Containers: Column, Row, Wrap, Stack, Center, Padding, SizedBox, Expanded, Flexible
- [ ] T043 [US2] Implement error fallback in `ui_kit_component_registry.dart` using AppSurface with error message for unknown components
- [ ] T044 [US2] Wire onAction callbacks for all interactive components (AppButton, AppTextField, AppCheckbox, AppSwitch, etc.)
- [ ] T045 [US2] Update DynamicWidgetBuilder in generative_ui to use UiKitComponentRegistry instead of demo registry
- [ ] T045.5 [US2] Export pre-configured GenUiChatView from gen_ui_client in `lib/gen_ui_client.dart` barrel file (FR-009)
- [ ] T046 [US2] Verify 31 components are registered by testing each component type renders correctly

**Checkpoint**: All 31 UI Kit components available for AI to use

---

## Phase 5: User Story 3 - Seed Color Theme Switching (Priority: P2)

**Goal**: Users can switch seed color at runtime and all components update their color palette

**Independent Test**: Change seed color from UI and verify all colors update throughout the application

### Implementation for User Story 3

- [ ] T047 [P] [US3] Add setSeedColor(Color) method to ThemeController in `lib/presentation/providers/theme_provider.dart`
- [ ] T048 [P] [US3] Add toggleBrightness() method to ThemeController for dark/light mode toggle
- [ ] T049 [US3] Update theme_factories.dart to use ColorScheme.fromSeed() with provided seed color
- [ ] T050 [US3] Create seed color picker UI in `lib/presentation/views/theme_controls.dart`
- [ ] T051 [US3] Add seed color buttons to AppBar in architect_view.dart
- [ ] T052 [US3] Verify seed color change propagates to all AI-rendered components without re-render of conversation
- [ ] T053 [US3] Test dark/light mode toggle works with seed color changes

**Checkpoint**: Seed color customization works - all components update when seed changes

---

## Phase 6: User Story 4 - System Prompt Injection (Priority: P2)

**Goal**: Configurable Layout Architect system prompt describing AI's role and available components

**Independent Test**: Configure custom system prompt and verify AI follows the injected instructions

### Implementation for User Story 4

- [ ] T054 [P] [US4] Create `assets/system_prompt.txt` with default Layout Architect prompt
- [ ] T055 [P] [US4] Create `lib/core/constants/layout_architect_prompt.dart` with prompt loading utility
- [ ] T056 [US4] Update GenUiChatView usage in architect_view.dart to inject system prompt
- [ ] T057 [US4] Add prompt override capability via environment variable or config parameter
- [ ] T058 [US4] Verify AI responds in Layout Architect context when prompted about UI design
- [ ] T059 [US4] Verify default prompt is used when no custom prompt provided

**Checkpoint**: System prompt injection works - AI acts as Layout Architect

---

## Phase 7: User Story 5 - Project Restructuring (Priority: P3)

**Goal**: Complete restructuring of example/ to gen_ui_client/ with Clean Architecture

**Independent Test**: Build and run renamed project, verify all existing functionality works

### Implementation for User Story 5

- [ ] T060 [P] [US5] Update all import paths in `lib/` files to reflect new package name
- [ ] T061 [P] [US5] Update `README.md` with gen_ui_client name and Layout Architect description
- [ ] T062 [US5] Clean up old demo-specific code that's no longer needed
- [ ] T063 [US5] Verify `flutter run -d chrome` launches successfully from gen_ui_client/
- [ ] T064 [US5] Verify existing AWS Bedrock integration still works
- [ ] T065 [US5] Verify mock mode fallback still works when credentials unavailable

**Checkpoint**: Project restructuring complete - gen_ui_client is standalone application

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T066 [P] Update `generative_ui/README.md` to document gen_ui_client and Layout Architect concept
- [ ] T067 [P] Add inline documentation to UiKitComponentRegistry explaining registration pattern
- [ ] T068 Run `flutter analyze` and fix any warnings
- [ ] T069 Run full app test: send "Create a login form" to AI and verify layout renders with theme
- [ ] T070 Verify theme switch completes within 300ms (performance goal)
- [ ] T071 Update checklist.md with completed status for all requirements

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-7)**: All depend on Foundational phase completion
  - US1 and US2 are both P1 priority - complete both for MVP
  - US3 and US4 are P2 priority - can proceed in parallel after MVP
  - US5 is P3 priority - can be done anytime after MVP
- **Polish (Phase 8)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational - No dependencies on other stories
- **User Story 2 (P1)**: Can start after Foundational - No dependencies on other stories
- **User Story 3 (P2)**: Depends on US1 (ThemeController must exist) - Extends theme capabilities
- **User Story 4 (P2)**: Can start after Foundational - Independent of US1-3
- **User Story 5 (P3)**: Can start after Foundational - Independent (project organization)

### Within Each User Story

- Providers/entities before views
- Registry before dynamic rendering
- Core implementation before integration
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks T003-T006 marked [P] can run in parallel
- All Foundational entity tasks T009-T014 marked [P] can run in parallel
- US1 and US2 can proceed in parallel (different concerns: theme vs registry)
- US3 and US4 can proceed in parallel (both P2 priority)
- US5 can run anytime in parallel with other work

---

## Parallel Example: Phase 2 Foundational

```bash
# Launch all entity creation tasks together:
Task: "Create lib/core/errors/contract_exception.dart"
Task: "Create lib/core/errors/failure.dart"
Task: "Create lib/domain/entities/design_language.dart"
Task: "Create lib/domain/entities/theme_state.dart"
Task: "Create lib/domain/entities/layout_node.dart"
Task: "Create lib/domain/entities/code_gen_result.dart"
```

## Parallel Example: User Story 2 Registry

```bash
# Launch all component registration tasks together (different lines in same file):
# NOTE: These should be done sequentially to avoid conflicts in the same file
# But different molecule categories can be assigned to different developers
```

---

## Implementation Strategy

### MVP First (User Stories 1 + 2)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 (Theme-Aware)
4. Complete Phase 4: User Story 2 (Component Registry)
5. **STOP and VALIDATE**: Test both stories - should have theme-aware rendering with full component set
6. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add US1 + US2 → Test → Deploy/Demo (MVP!)
3. Add US3 (Seed Color) → Test → Deploy/Demo
4. Add US4 (System Prompt) → Test → Deploy/Demo
5. Add US5 (Restructuring) → Test → Deploy/Demo
6. Each story adds value without breaking previous stories

---

## Summary

| Phase | Story | Task Count | Parallel |
|-------|-------|------------|----------|
| Phase 1 | Setup | 8 | 4 |
| Phase 2 | Foundational | 8 | 6 |
| Phase 3 | US1 Theme-Aware | 9 | 2 |
| Phase 4 | US2 Registry | 21 | 2 |
| Phase 5 | US3 Seed Color | 7 | 2 |
| Phase 6 | US4 System Prompt | 6 | 2 |
| Phase 7 | US5 Restructuring | 6 | 2 |
| Phase 8 | Polish | 6 | 2 |
| **Total** | | **71** | **22** |

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story is independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- MVP = US1 + US2 (theme-aware + full registry)
