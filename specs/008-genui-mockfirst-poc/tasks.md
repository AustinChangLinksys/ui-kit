# Tasks: GenUI Client-Side Orchestration (Mock-First PoC)

**Input**: Design documents from `/specs/008-genui-mockfirst-poc/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/
**Branch**: `008-genui-mockfirst-poc`

**Organization**: Tasks organized by user story (US1-US4) for independent implementation and testing.

**Tests**: Unit and integration tests included as requested by specification (SC-002, SC-005, SC-006).

---

## Format: `- [ ] [TaskID] [P?] [Story?] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: User story label (US1, US2, US3, US4)
- Exact file paths included in all descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and Flutter package structure

- [ ] T001 Create Flutter package directory structure at `lib/src/generative_ui/`
- [ ] T002 Create pubspec.yaml with dependencies (flutter, ui_kit) at `lib/src/generative_ui/pubspec.yaml`
- [ ] T003 [P] Create domain layer directories: `lib/src/generative_ui/lib/src/domain/{entities,repositories,usecases}`
- [ ] T004 [P] Create data layer directories: `lib/src/generative_ui/lib/src/data/{datasources,utils}`
- [ ] T005 [P] Create presentation layer directories: `lib/src/generative_ui/lib/src/presentation/controllers`
- [ ] T006 [P] Create test directories: `lib/src/generative_ui/test/{domain,data,presentation}`
- [ ] T007 Create assets directory: `lib/src/generative_ui/assets/` (for ai_config.json)
- [ ] T008 Initialize library export file at `lib/src/generative_ui/lib/generative_ui.dart`

**Checkpoint**: Package structure ready

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core domain entities and repository interface that ALL user stories depend on

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T009 Create exception hierarchy in `lib/src/generative_ui/lib/src/domain/entities/gen_exception.dart` (ParsingException, ToolUseValidationException, ContentGenerationException, GenException)
- [ ] T010 [P] Create ContentBlock hierarchy in `lib/src/generative_ui/lib/src/domain/entities/content_block.dart` (ContentBlock, TextBlock, ToolUseBlock classes)
- [ ] T011 [P] Create LLMResponse model in `lib/src/generative_ui/lib/src/domain/entities/llm_response.dart` (with getFirstToolUse, validation methods)
- [ ] T012 [P] Create GenTool value object in `lib/src/generative_ui/lib/src/domain/entities/gen_tool.dart` (with toJson, fromJson methods)
- [ ] T013 Create IContentGenerator repository interface in `lib/src/generative_ui/lib/src/domain/repositories/i_content_generator.dart` (with generate method contract)
- [ ] T014 Create ai_config.json template at `lib/src/generative_ui/assets/ai_config.json` (with phase, mock, aws sections)
- [ ] T015 Update library exports in `lib/src/generative_ui/lib/generative_ui.dart` to include all domain layer exports

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Developer Validates JSON Parsing Logic (Priority: P1) 🎯 MVP

**Goal**: Implement robust JSON parser with Design by Contract that handles 5 malformed formats and enables independent testing without UI rendering.

**Independent Test**: Run unit tests for ResponseParser to verify:
  1. Valid JSON parses correctly
  2. Markdown-wrapped JSON extracts and parses
  3. JSON with whitespace parses after trimming
  4. Malformed JSON throws ParsingException with original input preserved
  5. Non-object JSON throws ParsingException

**Functional Requirements Met**: FR-003, FR-005 (partial - parsing only), SC-002, SC-005

### Implementation for User Story 1

- [ ] T016 [P] [US1] Create ResponseParser utility with DBC in `lib/src/generative_ui/lib/src/data/utils/response_parser.dart` (preconditions: non-empty input; postconditions: valid Map<String, dynamic> or exception)
- [ ] T017 [P] [US1] Implement JSON extraction logic for markdown code blocks in ResponseParser (`_extractJson` method, handles ```json...``` patterns)
- [ ] T018 [P] [US1] Implement JSON boundary detection in ResponseParser (find first '{' and last '}' for malformed input tolerance)
- [ ] T019 [US1] Add precondition validation to ResponseParser (empty string check, throw ArgumentError)
- [ ] T020 [US1] Add postcondition validation to ResponseParser (verify parsed result is Map<String, dynamic>)
- [ ] T021 [US1] Create unit tests for ResponseParser in `test/data/utils/response_parser_test.dart` (5 malformed format scenarios: markdown blocks, whitespace, annotations, nested blocks, escaped JSON)
- [ ] T022 [US1] Create integration test for parser + entity building in `test/data/utils/orchestrate_parser_test.dart` (verify parsed Map → LLMResponse domain model conversion)
- [ ] T023 [US1] Update library exports to include ResponseParser in `lib/src/generative_ui/lib/generative_ui.dart`

**Checkpoint**: User Story 1 complete - Parser is tested, robust, and ready for mock scenarios. Can validate SC-002 (5 malformed formats handled).

---

## Phase 4: User Story 2 - Developer Triggers Mock Scenarios via Text Input (Priority: P1)

**Goal**: Implement MockContentGenerator with 3 predefined scenarios (Wi-Fi, Info, Error) that can be triggered by keywords, enabling rapid testing without modifying code.

**Independent Test**: Can be tested by triggering each mock scenario via text input and verifying JSON output:
  1. "Setup Wi-Fi" or "wifi" → Returns WifiSettingsCard tool_use JSON
  2. "Hello" or default → Returns InfoCard text JSON
  3. "Test Error" or "error" → Returns malformed JSON for error handling validation

**Functional Requirements Met**: FR-001, FR-002, FR-006, FR-009, SC-001, SC-007, SC-008

### Implementation for User Story 2

- [ ] T024 [P] [US2] Create MockContentGenerator class implementing IContentGenerator in `lib/src/generative_ui/lib/src/data/datasources/mock_content_generator.dart` (with generate method, keyword matching logic)
- [ ] T025 [P] [US2] Implement Wi-Fi scenario in MockContentGenerator (`_getResponseForPrompt` keyword: "wifi", returns WifiSettingsCard JSON with ssid, security, isEnabled)
- [ ] T026 [P] [US2] Implement Info scenario in MockContentGenerator (default case, returns InfoCard text JSON)
- [ ] T027 [P] [US2] Implement Error scenario in MockContentGenerator (keyword: "error", returns intentionally malformed JSON for error handling tests)
- [ ] T028 [US2] Add async simulation (Future.delayed 100ms) to MockContentGenerator to match real LLM latency
- [ ] T029 [US2] Create unit tests for MockContentGenerator in `test/data/datasources/mock_content_generator_test.dart` (verify 3 scenarios, keyword matching, response format)
- [ ] T030 [US2] Create tests for scenario extensibility and edge cases in `test/data/datasources/mock_content_generator_test.dart`: (1) verify adding new scenario requires <10 lines (SC-007), (2) verify 100 rapid consecutive requests don't cause state pollution or duplicate responses (edge case 4)
- [ ] T031 [US2] Update library exports to include MockContentGenerator in `lib/src/generative_ui/lib/generative_ui.dart`

**Checkpoint**: User Story 2 complete - MockContentGenerator is tested, triggers 3 scenarios correctly, enables rapid testing. Can validate SC-001 (3 scenarios) and SC-008 (<100ms response).

---

## Phase 5: User Story 3 - Schema Generator Serializes Flutter Widgets to JSON Schema (Priority: P2)

**Goal**: Implement schema generator that converts Flutter component definitions to JSON Schema format compatible with LLM tool_use, establishing the contract for Phase 3 AWS integration.

**Independent Test**: Can be tested by verifying schema generation for 2-3 components:
  1. WifiSettingsCard schema includes ssid (string), security (enum), isEnabled (boolean)
  2. InfoCard schema includes text (string)
  3. Generated schema matches JSON Schema Draft 7 standard

**Functional Requirements Met**: FR-004, SC-003

### Implementation for User Story 3

- [ ] T032 [P] [US3] Create SchemaField value class in `lib/src/generative_ui/lib/src/data/utils/schema_generator.dart` (type, description, required, enum fields)
- [ ] T033 [P] [US3] Create SchemaGenerator utility class in `lib/src/generative_ui/lib/src/data/utils/schema_generator.dart` (generateSchema method, takes componentName + fields map, returns tool_use compatible schema)
- [ ] T034 [US3] Implement schema builder logic in SchemaGenerator (creates "object" type schema, maps fields to JSON Schema properties with types and descriptions)
- [ ] T035 [US3] Implement enum support in SchemaGenerator (if SchemaField has enum, include in output schema)
- [ ] T036 [US3] Implement required fields tracking in SchemaGenerator (tracks required: true fields in schema output)
- [ ] T037 [US3] Create unit tests for SchemaGenerator in `test/data/utils/schema_generator_test.dart` (test WifiSettingsCard and InfoCard schema generation, enum handling, required fields)
- [ ] T038 [US3] Create schema validation test in `test/data/utils/schema_generator_test.dart` (verify output matches JSON Schema Draft 7 structure - SC-003)
- [ ] T039 [US3] Update library exports to include SchemaGenerator in `lib/src/generative_ui/lib/generative_ui.dart`

**Checkpoint**: User Story 3 complete - SchemaGenerator produces valid JSON Schema for components. Establishes foundation for Phase 2 system prompt and Phase 3 AWS integration.

---

## Phase 6: User Story 4 - Configuration Prepared for Future AWS Integration (Priority: P2)

**Goal**: Implement configuration loading system and OrchestrateUIFlowUseCase that unifies parser + mock generator, enabling seamless future AWS transition.

**Independent Test**: Can be tested by verifying:
  1. ai_config.json loads without errors at app startup
  2. Configuration phase can be switched from "mock" to "aws" without code changes (except one line in switch statement)
  3. OrchestrateUIFlowUseCase correctly chains: Mock → Parser → Validator → LLMResponse

**Functional Requirements Met**: FR-001, FR-007, FR-008, SC-004

### Implementation for User Story 4

- [ ] T040 [P] [US4] Create OrchestrateUIFlowUseCase in `lib/src/generative_ui/lib/src/domain/usecases/orchestrate_ui_flow.dart` (takes IContentGenerator + ResponseParser, orchestrates generate → parse → validate flow)
- [ ] T041 [P] [US4] Implement execute method in OrchestrateUIFlowUseCase (generates raw response, parses, builds LLMResponse domain model, validates)
- [ ] T042 [US4] Implement _buildResponse in OrchestrateUIFlowUseCase (handles Claude format with content[] array, creates TextBlock or ToolUseBlock based on type field)
- [ ] T043 [US4] Implement _validateResponse in OrchestrateUIFlowUseCase (checks content non-empty, validates each ToolUseBlock)
- [ ] T044 [US4] Create AwsPassThroughGenerator placeholder in `lib/src/generative_ui/lib/src/data/datasources/aws_content_generator.dart` (implements IContentGenerator, throws UnimplementedError with Phase 3 note)
- [ ] T045 [US4] Create ai_config.json loading utility in `lib/src/generative_ui/lib/src/domain/usecases/config_loader.dart` (loads from assets, parses JSON, exposes phase setting)
- [ ] T046 [US4] Create unit tests for OrchestrateUIFlowUseCase in `test/domain/usecases/orchestrate_ui_flow_test.dart` (Wi-Fi scenario, Info scenario, Error scenario, validation chain)
- [ ] T047 [US4] Create unit tests for config loading in `test/domain/usecases/config_loader_test.dart` (verify ai_config.json loads, phase property accessible)
- [ ] T048 [US4] Create integration test in `test/integration/end_to_end_test.dart` (MockContentGenerator → ResponseParser → OrchestrateUIFlowUseCase → LLMResponse, verify all 3 mock scenarios work end-to-end - SC-001)
- [ ] T049 [US4] Update library exports in `lib/src/generative_ui/lib/generative_ui.dart` to include OrchestrateUIFlowUseCase, ConfigLoader, AwsPassThroughGenerator

**Checkpoint**: User Story 4 complete - Full orchestration pipeline implemented. All 4 user stories functional, independently testable. Can validate SC-001, SC-004, SC-006 (existing tests still pass), SC-008.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Final validation, documentation, and preparation for Phase 2 UI rendering

- [ ] T050 [P] Run all unit tests: `flutter test test/` and verify all pass
- [ ] T051 [P] Run test coverage and document baseline in `lib/src/generative_ui/` (target: >80% for parser, mock generator, orchestrator)
- [ ] T052 [P] Verify SC-006: Run existing ui_kit tests from repository root (`flutter test`) and confirm no regressions
- [ ] T053 [P] Create INTEGRATION_EXAMPLES.md in `specs/008-genui-mockfirst-poc/` with usage examples for developers
- [ ] T054 Update spec.md with actual test metrics (parser handles X formats, mock scenarios respond in Xms, etc.)
- [ ] T055 Commit Phase 1 to git: `git add lib/src/generative_ui/` and `git commit -m "feat: Implement GenUI mock orchestration Phase 1"`
- [ ] T056 Document Phase 2 preparation in `specs/008-genui-mockfirst-poc/PHASE2_PREP.md` (GenUiWrapper widget scaffolding, UI component integration points)

**Checkpoint**: Phase 1 complete. Ready for Phase 2 (UI rendering) or Phase 3 (AWS integration).

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
- **Polish (Phase 7)**: Depends on desired user stories being complete

### Within User Story Execution

- Parallelizable tasks [P] should run together (different files)
- Sequential dependencies must complete in order (listed without [P])
- Tests should be written and fail **before** implementation

### Parallel Opportunities

**Setup Phase**: Tasks T003-T006 can run in parallel (different directories)

**Foundational Phase**: Tasks T010-T012 can run in parallel (different entity files)

**User Story 1**:
- Parser implementation tasks T016-T018 can run in parallel (different methods)
- Tests T021-T022 depend on T016-T020 implementation first

**User Story 2**:
- Scenarios T025-T027 can run in parallel (different keyword branches)
- Async simulation T028 depends on scenarios T024-T027
- Tests T029-T030 depend on implementation T024-T028

**User Story 3**:
- Schema field class T032 and SchemaGenerator utility T033 can run in parallel
- Builder logic T034 depends on T032-T033

**User Story 4**:
- OrchestrateUIFlowUseCase T040-T041 and AwsPassThroughGenerator T044 can run in parallel
- Config loader T045-T046 depends on async work from T040-T043

**Cross-Story Parallel** (after Foundational Phase 2 complete):
- US1 Parser: Can work on independently
- US2 MockGenerator: Can work on independently while US1 progresses
- US3 SchemaGenerator: Can start after US1-US2 (doesn't need their outputs)
- US4 Orchestration: Depends on US1 (Parser) and US2 (MockGenerator) completion

### Team Execution Example (3 Developers)

```
Phase 1 (Setup) - 1 dev, 2-3 hours
Phase 2 (Foundational) - All devs together, 3-4 hours (CRITICAL PATH)

Then parallel execution:
  Developer A: US1 (Parser) + US2 (MockGenerator) - 6 hours
  Developer B: US3 (SchemaGenerator) - 4 hours (can start after Phase 2)
  Developer C: US4 (Orchestration) - 4 hours (waits for US1+US2, then 3 hours)

Phase 7 (Polish) - All devs together, 2 hours
```

---

## Implementation Strategy

### MVP First (User Stories 1-2 Only)

**Delivers**: Complete JSON parsing + mock scenarios for rapid iteration

1. ✅ Complete Phase 1: Setup (T001-T008, ~2-3 hours)
2. ✅ Complete Phase 2: Foundational (T009-T015, ~3-4 hours)
3. ✅ Complete Phase 3: User Story 1 - Parser (T016-T023, ~4-5 hours)
4. ✅ Complete Phase 4: User Story 2 - Mock Scenarios (T024-T031, ~3-4 hours)
5. **STOP and VALIDATE**: Run all Phase 1-4 tests, verify SC-001 + SC-002
6. **Deploy/Demo MVP**: Show parser robustness + 3 mock scenarios working
7. Use for rapid UI component testing in Phase 2

**Total MVP Time**: ~12-16 hours per developer (full parallel with Foundation bottleneck)

### Incremental Delivery (Full Phase 1)

1. Complete MVP (above)
2. Add User Story 3 - SchemaGenerator (T032-T039, ~3-4 hours)
3. Add User Story 4 - Orchestration (T040-T049, ~4-5 hours)
4. Polish & validation (T050-T055, ~2-3 hours)
5. Proceed to Phase 2 (UI rendering integration)

**Total Phase 1 Time**: ~20-28 hours per developer (with parallelization: ~15-20 hours wall clock with small team)

---

## Success Metrics

**Phase 1 Complete When**:

- [ ] All Phase 1-7 tasks checked ✅
- [ ] All unit tests pass (T021-T022, T029-T030, T037-T038, T046-T048)
- [ ] SC-001: All 3 mock scenarios trigger and return correct JSON
- [ ] SC-002: Parser handles all 5 malformed formats without crashing
- [ ] SC-003: SchemaGenerator produces valid JSON Schema for 2-3 components
- [ ] SC-004: ai_config.json loads successfully
- [ ] SC-005: Parser unit tests and integration tests are independent
- [ ] SC-006: Existing UI Kit tests still pass
- [ ] SC-007: New mock scenario can be added with <10 lines
- [ ] SC-008: MockContentGenerator responds in <100ms

---

## Notes

- All file paths are relative to repository root
- `lib/src/generative_ui/` is the Flutter package location
- Tests can be run with: `flutter test test/`
- Configuration switches via `ai_config.json` `phase` field (currently "mock", will be "aws" in Phase 3)
- Phase 3 AWS integration only requires creating `AwsPassThroughGenerator` implementation (placeholder already in T044)
- Each user story is independently deployable - can demo after US1, US2, US3, or US4
- Golden tests deferred to Phase 2 (when GenUiWrapper UI integration happens)

---

**Ready for implementation. Begin with Phase 1 Setup tasks (T001-T008).**
