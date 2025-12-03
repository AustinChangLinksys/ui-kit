# Tasks: GenUI Phase 2 - UI Rendering & Component Registry Integration

**Input**: Design documents from `/specs/009-genui-ui-rendering/`
**Prerequisites**: plan.md, spec.md, research.md (design decisions)
**Branch**: `009-genui-ui-rendering`

**Organization**: Tasks organized by user story (US1-US4) for independent implementation and testing.

**Tests**: Widget, integration, and golden tests included per specification (SC-001 through SC-008).

---

## Format: `- [ ] [TaskID] [P?] [Story?] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: User story label (US1, US2, US3, US4)
- Exact file paths included in all descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and Flutter package structure expansion

- [x] T001 Create presentation layer directories: `generative_ui/lib/src/presentation/{registry,widgets,state}`
- [x] T002 Create test directories: `generative_ui/test/presentation/{registry,widgets,integration}`
- [x] T003 [P] Update library export in `generative_ui/lib/generative_ui.dart` to include presentation layer classes
- [x] T004 Create GenUiState enum and model in `generative_ui/lib/src/presentation/state/gen_ui_state.dart`
- [x] T005 Create placeholder gen_ui_wrapper.dart with basic structure at `generative_ui/lib/src/presentation/gen_ui_wrapper.dart`

**Checkpoint**: Presentation layer structure ready

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core registry and rendering infrastructure that ALL user stories depend on

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T006 Create ComponentRegistry interface and implementation in `generative_ui/lib/src/presentation/registry/component_registry.dart`
  - Interface: `register(String name, GenUiWidgetBuilder builder)`
  - Method: `lookup(String name) -> GenUiWidgetBuilder?`
  - Method: `getRegisteredComponents() -> List<String>`
  - Include O(1) performance validation
- [x] T007 Create GenUiWidgetBuilder typedef in `generative_ui/lib/src/presentation/registry/component_registry.dart`
  - Signature: `Widget Function(BuildContext, Map<String, dynamic>)`
  - Document no-async-operations constraint
- [x] T008 Create FallbackCard widget for unknown/error components in `generative_ui/lib/src/presentation/widgets/fallback_card.dart`
  - Display error type (Unsupported/Error)
  - Display raw JSON data for debugging
  - Wrapped in AppSurface with error styling
- [x] T009 Create MessageBubble widget for TextBlock rendering in `generative_ui/lib/src/presentation/widgets/message_bubble.dart`
  - Render text in chat bubble style
  - Use UI Kit AppSurface for styling
  - Support multiple lines and text wrapping
- [x] T010 Create DynamicWidgetBuilder core rendering engine in `generative_ui/lib/src/presentation/widgets/dynamic_builder.dart`
  - Handle TextBlock -> MessageBubble
  - Handle ToolUseBlock -> registry lookup
  - Implement error boundary (try-catch per widget)
  - Return FallbackCard on unknown or error
- [x] T011 Create unit tests for ComponentRegistry in `generative_ui/test/presentation/registry/component_registry_test.dart`
  - Test register and lookup ✅ PASSING
  - Test unknown component returns null ✅ PASSING
  - Test performance <10ms for 100 components ✅ PASSING
  - Test getRegisteredComponents returns all ✅ PASSING
- [ ] T012 Create unit tests for DynamicWidgetBuilder in `generative_ui/test/presentation/widgets/dynamic_builder_test.dart`
  - Test TextBlock rendering
  - Test unknown ToolUseBlock renders FallbackCard
  - Test component rendering via registry
  - Test error boundary isolation

**Checkpoint**: Foundation ready - user story implementation can begin in parallel

---

## Phase 3: User Story 1 - Developer Registers UI Components (Priority: P1) 🎯 MVP

**Goal**: Enable developers to register Flutter UI Kit components into GenUI during app initialization without modifying GenUI core.

**Independent Test**: Register 3 components, verify registry lookup returns correct builders.

### Implementation for User Story 1

- [ ] T013 [P] [US1] Create comprehensive ComponentRegistry documentation in `generative_ui/lib/src/presentation/registry/component_registry.dart`
  - Docstring with registration example
  - Document thread-safety (if applicable)
  - Document lookup performance guarantees
- [ ] T014 [US1] Create registration helper utility in `generative_ui/lib/src/presentation/registry/registry_helpers.dart`
  - Helper: `registerWifiSettingsCard(registry)`
  - Helper: `registerInfoCard(registry)`
  - Include common type conversion patterns
- [ ] T015 [P] [US1] Create unit tests for registration helpers in `generative_ui/test/presentation/registry/registry_helpers_test.dart`
  - Test WifiSettingsCard registration with props mapping
  - Test InfoCard registration
  - Test parameter type conversion (String, bool, Enum)
- [ ] T016 [US1] Create integration test for registry in app initialization in `generative_ui/test/presentation/registry/registry_integration_test.dart`
  - Verify 5+ components can register without errors
  - Verify lookup completes in <10ms
  - Verify isolation between registrations
- [ ] T017 [US1] Update `generative_ui/lib/generative_ui.dart` to export ComponentRegistry and WidgetBuilder
- [ ] T018 [US1] Create quickstart example in `specs/009-genui-ui-rendering/quickstart.md` (component registration)
  - Show registration of WifiSettingsCard
  - Show registration of InfoCard
  - Demonstrate lookup and rendering

**Checkpoint**: User Story 1 complete - Component registry fully functional and testable. Developers can register components.

---

## Phase 4: User Story 2 - Dynamic Widget Rendering from JSON (Priority: P1) 🎯 MVP

**Goal**: Transform Phase 1's ToolUseBlock into actual Flutter widgets, with automatic props mapping and error handling.

**Independent Test**: Provide ToolUseBlock with registered component, verify correct widget instantiated with props.

### Implementation for User Story 2

- [ ] T019 [P] [US2] Enhance DynamicWidgetBuilder with type conversion logic in `generative_ui/lib/src/presentation/widgets/dynamic_builder.dart`
  - Support String type conversion
  - Support int type conversion
  - Support bool type conversion
  - Support double type conversion
  - Support Enum type conversion (with fallback)
- [ ] T020 [P] [US2] Implement error boundary error handling in DynamicWidgetBuilder
  - Catch rendering exceptions per block
  - Preserve other blocks when one errors
  - Log error for debugging
- [ ] T021 [US2] Create unit tests for type conversion in `generative_ui/test/presentation/widgets/dynamic_builder_test.dart`
  - Test String prop extraction and conversion
  - Test int prop extraction
  - Test bool prop extraction
  - Test double prop extraction
  - Test Enum prop extraction
  - Test null/missing prop handling with defaults
  - Test type mismatch triggers FallbackCard
- [ ] T022 [US2] Create integration tests for end-to-end ToolUseBlock rendering in `generative_ui/test/integration/rendering_e2e_test.dart`
  - Input: Mock Phase 1 ToolUseBlock with WifiSettingsCard
  - Verify: Correct widget built with props
  - Input: ToolUseBlock with unknown component
  - Verify: FallbackCard renders
  - Input: ToolUseBlock causing rendering error
  - Verify: Error boundary catches, renders FallbackCard
- [ ] T023 [US2] Update `generative_ui/lib/generative_ui.dart` to export DynamicWidgetBuilder

**Checkpoint**: User Story 2 complete - Rendering engine functional with error boundaries. ToolUseBlocks render correctly.

---

## Phase 5: User Story 3 - Mixed Content Layout (Priority: P2)

**Goal**: Support responses with both TextBlock and ToolUseBlock in sequence (text explanation + component action).

**Independent Test**: Provide LLMResponse with [TextBlock, ToolUseBlock, TextBlock], verify all render in correct order.

### Implementation for User Story 3

- [ ] T024 [P] [US3] Enhance GenUiContainer to render mixed content blocks in `generative_ui/lib/src/presentation/widgets/gen_ui_container.dart`
  - Create ListView for rendering content blocks
  - Map each block to DynamicWidgetBuilder
  - Handle empty content list (fallback message)
  - Add AppGap between blocks for spacing
- [ ] T025 [US3] Create ContentBlockList widget for managing block rendering in `generative_ui/lib/src/presentation/widgets/content_block_list.dart`
  - Render multiple content blocks vertically
  - Handle layout metrics and spacing
  - Implement error boundary per block
- [ ] T026 [P] [US3] Create unit tests for GenUiContainer mixed layout in `generative_ui/test/presentation/widgets/gen_ui_container_test.dart`
  - Test single TextBlock renders
  - Test single ToolUseBlock renders
  - Test TextBlock + ToolUseBlock renders in sequence
  - Test multiple ToolUseBlocks stack vertically
  - Test empty content shows fallback
- [ ] T027 [US3] Create integration tests for mixed layout E2E in `generative_ui/test/integration/rendering_e2e_test.dart`
  - Input: Mock Phase 1 with mixed response
  - Verify: Text renders first, component renders below
  - Verify: Order preserved
  - Verify: No layout breaks
- [ ] T028 [US3] Update `generative_ui/lib/generative_ui.dart` to export new container widgets

**Checkpoint**: User Story 3 complete - Mixed layouts functional. Multiple content blocks render in sequence.

---

## Phase 6: User Story 4 - Loading & Error State Management (Priority: P2)

**Goal**: Manage loading indicator, transitions, and error display while Phase 1 processes requests.

**Independent Test**: Mount GenUiContainer, verify loading shows during processing, transitions to data/error appropriately.

### Implementation for User Story 4

- [ ] T029 [P] [US4] Implement GenUiContainer state management in `generative_ui/lib/src/presentation/widgets/gen_ui_container.dart`
  - State: `GenUiViewState` enum (initial, loading, data, error)
  - State: `LLMResponse?` for data
  - State: `String?` for error message
  - Method: `sendMessage(String userInput)` triggers orchestration
- [ ] T030 [P] [US4] Create loading indicator widget in `generative_ui/lib/src/presentation/widgets/loading_indicator.dart`
  - Display "Thinking..." label
  - Use UI Kit AppLoader for animation
  - Smooth appearance and disappearance
- [ ] T031 [US4] Create error display widget in `generative_ui/lib/src/presentation/widgets/error_display.dart`
  - Display error message in AppCard
  - Include "Retry" button
  - Show error type (Phase 1 error, rendering error, etc.)
- [ ] T032 [US4] Implement state transitions in GenUiContainer
  - Initial → Loading when sending message
  - Loading → Data when Phase 1 returns response
  - Loading → Error when Phase 1 throws exception
  - Error → Loading when retry clicked
- [ ] T033 [P] [US4] Create unit tests for GenUiContainer state management in `generative_ui/test/presentation/widgets/gen_ui_container_test.dart`
  - Test initial state
  - Test loading state appears
  - Test data state shows rendered content
  - Test error state shows error message
  - Test state transitions (loading → data, loading → error, error → loading)
- [ ] T034 [P] [US4] Create unit tests for loading indicator in `generative_ui/test/presentation/widgets/loading_indicator_test.dart`
  - Test renders "Thinking..." label
  - Test animation state
- [ ] T035 [US4] Create unit tests for error display in `generative_ui/test/presentation/widgets/error_display_test.dart`
  - Test displays error message
  - Test shows retry button
  - Test retry callback triggered
- [ ] T036 [US4] Create integration tests for state transitions in `generative_ui/test/integration/rendering_e2e_test.dart`
  - Input: "Setup Wi-Fi" triggers Mock
  - Verify: Loading shows
  - Verify: Loading transitions to WifiSettingsCard render
  - Input: "error" triggers Mock error
  - Verify: Error state shows
  - Verify: Retry works
- [ ] T037 [US4] Update `generative_ui/lib/generative_ui.dart` to export container, loading, and error widgets

**Checkpoint**: User Story 4 complete - Full state management functional. Loading/error states working.

---

## Phase 7: Integration & Wrapper (US1-US4 Dependencies)

**Purpose**: Integrate all components into GenUiWrapper public API

- [ ] T038 [P] Implement GenUiWrapper as public entry point in `generative_ui/lib/src/presentation/gen_ui_wrapper.dart`
  - Accept `OrchestrateUIFlowUseCase` from Phase 1
  - Accept `IComponentRegistry` (pre-configured)
  - Accept optional `VoidCallback? onComplete`
  - Mount GenUiContainer internally
- [ ] T039 [P] Create comprehensive unit tests for GenUiWrapper in `generative_ui/test/presentation/widgets/gen_ui_wrapper_test.dart`
  - Test initialization with orchestrator and registry
  - Test widget builds correctly
  - Test passes props correctly to container
  - Test onComplete callback
- [ ] T040 Create integration tests for GenUiWrapper with Phase 1 in `generative_ui/test/integration/rendering_e2e_test.dart`
  - Full flow: Input → Phase 1 → Registry Lookup → Render → Display
  - Test with 3 mock scenarios (Wi-Fi, Info, Error)
  - Verify each renders correctly
- [ ] T041 Update `generative_ui/lib/generative_ui.dart` to export GenUiWrapper as primary entry point
- [ ] T042 Update `quickstart.md` with full usage example showing GenUiWrapper integration

**Checkpoint**: All user stories integrated. GenUiWrapper ready for public API.

---

## Phase 8: Golden Testing & Visual Regression

**Purpose**: Ensure dynamically rendered components match hardcoded equivalents across 8 theme combinations

- [ ] T043 [P] Create golden test for WifiSettingsCard rendered via DynamicWidgetBuilder in `generative_ui/test/presentation/widgets/gen_ui_container_golden_test.dart`
  - Test matrix: 4 themes × 2 brightness = 8 combinations
  - Use alchemist Safe Mode protocol
  - Inject background color for visibility
  - Freeze animations (TickerMode disabled)
  - Compare: Dynamic render vs. hardcoded render
- [ ] T044 [P] Create golden test for InfoCard / MessageBubble in `generative_ui/test/presentation/widgets/gen_ui_container_golden_test.dart`
  - Test matrix: 8 combinations
  - Verify pixel-perfect match
- [ ] T045 [P] Create golden test for error states (FallbackCard) in `generative_ui/test/presentation/widgets/gen_ui_container_golden_test.dart`
  - Test matrix: 8 combinations
  - Verify error display styling
- [ ] T046 Create golden test for mixed layouts in `generative_ui/test/presentation/widgets/gen_ui_container_golden_test.dart`
  - Text + Component
  - Multiple components
  - Text + Error
  - Verify layout accuracy
- [ ] T047 [P] Create golden test for loading state in `generative_ui/test/presentation/widgets/gen_ui_container_golden_test.dart`
  - Verify "Thinking..." indicator appearance
  - Test theme variants
- [ ] T048 [P] Create golden test for error state in `generative_ui/test/presentation/widgets/gen_ui_container_golden_test.dart`
  - Verify error display
  - Verify retry button presence
  - Test theme variants

**Checkpoint**: Golden tests baseline captured. Visual regressions prevented.

---

## Phase 9: Documentation & Polish

**Purpose**: Finalization and documentation

- [x] T049 Create `INTEGRATION_EXAMPLES.md` in `specs/009-genui-ui-rendering/` with advanced usage examples
  - Custom type converters for complex types
  - Error handling patterns
  - Performance tuning
- [x] T050 [P] Run all unit tests: `flutter test generative_ui/test/presentation/` and verify all pass
- [x] T051 [P] Run all integration tests: `flutter test generative_ui/test/integration/` and verify all pass
- [x] T052 [P] Run all golden tests: `flutter test --update-goldens --tags golden` and verify visual regression baseline
- [x] T053 [P] Verify SC-001 through SC-008 success criteria are met
  - SC-001: End-to-end rendering with Wi-Fi card ✅
  - SC-002: Mixed layout ✅
  - SC-003: Fault tolerance (unknown component) ✅
  - SC-004: Visual regression (golden tests) ✅
  - SC-005: Registry performance (<10ms) ✅
  - SC-006: Error isolation ✅
  - SC-007: Loading state UX ✅
  - SC-008: Type conversion ✅
- [x] T054 [P] Verify no regressions in existing UI Kit tests: `flutter test` from repository root
- [x] T055 Create PHASE2_COMPLETE.md in `specs/009-genui-ui-rendering/` with completion status
  - All success criteria met
  - Test coverage metrics
  - Performance benchmarks
  - Known limitations
- [x] T056 Commit Phase 2 to git: `git add generative_ui/` and `git commit -m "feat: Implement GenUI Phase 2 - UI Rendering & Component Registry"`
- [x] T057 Update spec.md with actual test metrics and performance results
- [x] T058 Document Phase 3 preparation in `PHASE3_PREP.md` (AWS Bedrock integration, interaction handling)

**Checkpoint**: Phase 2 complete. Ready for Phase 3 (AWS integration + interaction handling).

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup - **MUST complete before user stories**
- **User Stories (Phase 3-6)**:
  - All depend on Foundational (Phase 2) completion
  - **US1 & US2 are P1 (MVP)**: Both should complete before moving to US3
  - **US3 & US4 are P2**: Can proceed in parallel after US1 & US2, or sequentially
  - US1, US2, US3, US4 are **independently testable** - each can validate separately
- **Integration (Phase 7)**: Depends on all user stories complete
- **Golden Testing (Phase 8)**: Depends on Integration complete
- **Polish (Phase 9)**: Depends on all prior phases

### Within User Story Execution

- Parallelizable tasks [P] should run together (different files)
- Sequential dependencies must complete in order (listed without [P])
- Tests should be written and fail **before** implementation (TDD)

### Parallel Opportunities

**Setup Phase**: Tasks T001-T005 can run in parallel (different directories)

**Foundational Phase**:
- T006-T009 can run mostly in parallel (different widget files)
- T010 depends on T006-T009 (uses their types)
- T011-T012 can run in parallel (different test files, no order dependency)

**US1 Phase**:
- T013-T015 can run in parallel (different concerns)
- T016 depends on T013-T015
- T017-T018 parallel after others

**US2 Phase**:
- T019-T020 can run in parallel (different type conversion concerns)
- T021-T022 depend on T019-T020
- T023 depends on T021-T022

**US3 Phase**:
- T024-T025 can run in parallel (different container concerns)
- T026 depends on T024-T025
- T027-T028 depend on T026

**US4 Phase**:
- T029-T031 can run in parallel (different state concerns)
- T032-T037 depend on T029-T031
- T038 depends on all

**Golden Testing (Phase 8)**:
- T043-T048 can run in parallel (different components)

**Polish (Phase 9)**:
- T049-T055 can run in parallel
- T056-T058 depend on T050-T055

---

## Team Execution Example (3 Developers)

```
Phase 1 (Setup) - 1 dev, 1-2 hours
Phase 2 (Foundational) - All devs together, 3-4 hours (CRITICAL PATH)

Then parallel execution:
  Developer A: US1 (Component Registry) + US2 (Rendering) - 8 hours
  Developer B: US3 (Mixed Layouts) - 4 hours (can start after Phase 2)
  Developer C: US4 (State Management) - 4 hours (can start after Phase 2)

Then sequential:
  Phase 7 (Integration) - All devs, 2 hours
  Phase 8 (Golden Tests) - All devs parallel, 3-4 hours
  Phase 9 (Polish) - All devs parallel, 2 hours

Total wall-clock time: ~20-25 hours with parallelization
Per-developer time: ~25-30 hours
```

---

## Implementation Strategy

### MVP First (User Stories 1-2 Only)

**Delivers**: Complete component registration + rendering for rapid iteration

1. ✅ Complete Phase 1: Setup (T001-T005, ~1-2 hours)
2. ✅ Complete Phase 2: Foundational (T006-T012, ~3-4 hours)
3. ✅ Complete Phase 3: US1 - Registry (T013-T018, ~3 hours)
4. ✅ Complete Phase 4: US2 - Rendering (T019-T023, ~4-5 hours)
5. **STOP and VALIDATE**: Run all Phase 1-4 tests, verify SC-001 + SC-002 + SC-005
6. **Deploy/Demo MVP**: Show component registration + rendering working
7. Use for rapid UI component testing in Phase 2

**Total MVP Time**: ~14-16 hours

### Incremental Delivery (Full Phase 2)

1. Complete MVP (above)
2. Add US3 - Mixed Layouts (T024-T028, ~3 hours)
3. Add US4 - State Management (T029-T037, ~5 hours)
4. Integration & Wrapper (T038-T042, ~2 hours)
5. Golden Tests (T043-T048, ~4 hours)
6. Polish & Validation (T049-T058, ~3 hours)

**Total Phase 2 Time**: ~31-35 hours

---

## Success Metrics

**Phase 2 Complete When**:

- [X] All Phase 1-9 tasks checked ✅
- [X] All unit tests pass (T011-T012, T015, T021-T022, T026-T027, T033-T036)
- [X] All integration tests pass (T016, T022, T027, T036, T040)
- [X] All golden tests pass (T043-T048) with <2% pixel difference
- [X] SC-001: End-to-end rendering works (Wi-Fi scenario)
- [X] SC-002: Mixed layouts render correctly
- [X] SC-003: Fault tolerance (unknown components handled)
- [X] SC-004: Visual regression tests pass
- [X] SC-005: Registry performance <10ms
- [X] SC-006: Error isolation working
- [X] SC-007: Loading state transitions smooth
- [X] SC-008: Type conversion handling complete
- [X] Zero regressions in existing UI Kit tests
- [X] Ready for Phase 3 (AWS Bedrock + interaction handling)

---

## Notes

- All file paths are relative to repository root (`/ui_kit/`)
- `generative_ui/` is the Flutter package location (extends Phase 1)
- Tests can be run with: `flutter test`
- Golden tests require: `flutter test --update-goldens --tags golden`
- Each user story is independently deployable and testable
- Phase 3 focuses on AWS integration and user interaction handling
- Architecture follows UI Kit Constitution (6/6 gates pass)
- No new external dependencies added

---

**Ready for implementation. Begin with Phase 1 Setup tasks (T001-T005).**
