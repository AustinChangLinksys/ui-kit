# Tasks: GenUI Phase 3 - AWS Integration & Complete Client

**Input**: Design documents from `/specs/012-genui-phase3-aws-client/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

**Tests**: Not explicitly requested in specification. Tests are omitted.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

Based on plan.md, this is a Flutter module within the ui_kit monorepo:
- **Module root**: `generative_ui/`
- **Source**: `generative_ui/lib/src/`
- **Entities**: `generative_ui/lib/src/domain/entities/`
- **Data sources**: `generative_ui/lib/src/data/datasources/`
- **Presentation**: `generative_ui/lib/src/presentation/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and dependency configuration

- [ ] T001 Update dependencies in generative_ui/pubspec.yaml (add aws_common ^0.7.11, aws_signature_v4 ^0.6.9, http ^1.2.1, flutter_dotenv ^5.1.0)
- [ ] T002 [P] Create .env.example template in generative_ui/assets/.env.example with AWS credential placeholders
- [ ] T003 [P] Update generative_ui/.gitignore to exclude assets/.env
- [ ] T004 [P] Register .env asset in generative_ui/pubspec.yaml flutter assets section
- [ ] T005 Run flutter pub get to verify dependency resolution in generative_ui/

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core entities and interfaces that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

### Exception Hierarchy

- [ ] T006 [P] Create GenUiException base class in generative_ui/lib/src/domain/entities/gen_exception.dart (add isRetryable property, message field)
- [ ] T007 [P] Create NetworkException extending GenUiException in generative_ui/lib/src/domain/entities/gen_exception.dart
- [ ] T008 [P] Create AuthenticationException extending GenUiException in generative_ui/lib/src/domain/entities/gen_exception.dart
- [ ] T009 [P] Create RateLimitException extending GenUiException in generative_ui/lib/src/domain/entities/gen_exception.dart
- [ ] T010 [P] Create ConfigurationException in generative_ui/lib/src/domain/entities/gen_exception.dart

### Core Entities

- [ ] T011 [P] Create ChatRole enum (user, assistant, system) in generative_ui/lib/src/domain/entities/chat_message.dart
- [ ] T012 [P] Create ContentPart abstract class with toMap() in generative_ui/lib/src/domain/entities/chat_message.dart
- [ ] T013 [P] Create TextContentPart class in generative_ui/lib/src/domain/entities/chat_message.dart
- [ ] T014 [P] Create ToolResultPart class in generative_ui/lib/src/domain/entities/chat_message.dart
- [ ] T015 Create ChatMessage class with factory constructors (user, assistant, toolResult, system) and toClaudeFormat() in generative_ui/lib/src/domain/entities/chat_message.dart (depends on T011-T014)
- [ ] T016 [P] Create ChatViewState enum (welcome, loading, content, error) in generative_ui/lib/src/domain/entities/conversation_state.dart
- [ ] T017 Create ConversationState class with state transition methods in generative_ui/lib/src/domain/entities/conversation_state.dart (depends on T015, T016)
- [ ] T018 [P] Create ToolActionOutput class in generative_ui/lib/src/domain/entities/tool_action_output.dart

### AWS Configuration

- [ ] T019 Create data/config/ directory in generative_ui/lib/src/data/config/
- [ ] T020 Create AWSConfig class with fromEnvironment() factory in generative_ui/lib/src/data/config/aws_config.dart (depends on T010)

### Interface Extension

- [ ] T021 Create IConversationGenerator interface with generateWithHistory() method in generative_ui/lib/src/domain/repositories/i_conversation_generator.dart (depends on T015)

### Registry Enhancement

- [ ] T022 Update GenUiWidgetBuilder typedef to add optional onAction callback parameter in generative_ui/lib/src/presentation/registry/component_registry.dart

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Send Message and Receive AI Response (Priority: P1) 🎯 MVP

**Goal**: User opens GenUI chat interface, sends a message, sees loading state, and receives AI response rendered as text or dynamic UI component.

**Independent Test**: Enter any text message and verify the system returns a contextually appropriate response from AWS Bedrock.

### AWS Bedrock Adapter Implementation

- [ ] T023 [US1] Implement request body builder method in AwsContentGenerator (buildBedrockRequest) in generative_ui/lib/src/data/datasources/aws_content_generator.dart
- [ ] T024 [US1] Implement SigV4 signing logic using AWSSigV4Signer in generative_ui/lib/src/data/datasources/aws_content_generator.dart (depends on T020)
- [ ] T025 [US1] Implement HTTP POST to Bedrock Runtime endpoint in generative_ui/lib/src/data/datasources/aws_content_generator.dart (depends on T024)
- [ ] T026 [US1] Implement response parsing and LLMResponse conversion in generative_ui/lib/src/data/datasources/aws_content_generator.dart
- [ ] T027 [US1] Implement generate() method (IContentGenerator) delegating to generateWithHistory() in generative_ui/lib/src/data/datasources/aws_content_generator.dart (depends on T021)
- [ ] T028 [US1] Implement generateWithHistory() method (IConversationGenerator) in generative_ui/lib/src/data/datasources/aws_content_generator.dart (depends on T023-T026)

### Chat Controller

- [ ] T029 [US1] Create ChatController class with ConversationState in generative_ui/lib/src/presentation/chat/chat_controller.dart (depends on T017)
- [ ] T030 [US1] Implement sendMessage() method in ChatController (user → loading → response → content) in generative_ui/lib/src/presentation/chat/chat_controller.dart (depends on T028, T029)

### Chat UI Components

- [ ] T031 [P] [US1] Create ChatInputArea widget (TextField + Send button) in generative_ui/lib/src/presentation/chat/chat_input_area.dart
- [ ] T032 [US1] Update DynamicWidgetBuilder.buildBlock() to accept optional onAction callback in generative_ui/lib/src/presentation/widgets/dynamic_builder.dart (depends on T022)
- [ ] T033 [US1] Create GenUiChatView main widget integrating ChatController, message list, and input area in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart (depends on T029-T032)
- [ ] T034 [US1] Implement welcome state UI (initial screen before conversation starts) in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart
- [ ] T035 [US1] Implement loading state UI (indicator while waiting for AI response) in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart
- [ ] T036 [US1] Implement content state UI (message list with mixed text bubbles and dynamic components) in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart

### Export Updates

- [ ] T037 [US1] Export new entities (ChatMessage, ConversationState, ChatRole, ChatViewState) from generative_ui/lib/generative_ui.dart
- [ ] T038 [US1] Export chat widgets (GenUiChatView, ChatController) from generative_ui/lib/generative_ui.dart

**Checkpoint**: User Story 1 complete - users can send messages and receive AI responses

---

## Phase 4: User Story 2 - Complete Actions on Dynamic UI Components (Priority: P1)

**Goal**: User interacts with rendered UI component (e.g., clicks "Save"), action result is sent back to AI, and AI responds with confirmation.

**Independent Test**: Render any actionable component, perform an action, verify AI receives tool output and responds.

### Tool Action Flow

- [ ] T039 [US2] Implement _handleToolAction() method in ChatController to create tool_result message in generative_ui/lib/src/presentation/chat/chat_controller.dart (depends on T018, T030)
- [ ] T040 [US2] Connect onAction callback from DynamicWidgetBuilder to ChatController._handleToolAction() in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart (depends on T032, T039)
- [ ] T041 [US2] Implement automatic follow-up request after tool_result (send tool output → get AI confirmation) in generative_ui/lib/src/presentation/chat/chat_controller.dart (depends on T039)

### Component Registry Integration

- [ ] T042 [US2] Update existing component registrations to pass onAction callback (demo_components.dart or registry_helpers.dart) in generative_ui/lib/src/presentation/widgets/demo_components.dart
- [ ] T043 [US2] Update _buildToolUseBlock in DynamicWidgetBuilder to pass toolUseId with onAction in generative_ui/lib/src/presentation/widgets/dynamic_builder.dart (depends on T032)

### Export Updates

- [ ] T044 [US2] Export ToolActionOutput from generative_ui/lib/generative_ui.dart

**Checkpoint**: User Story 2 complete - closed-loop interaction working (Chat-to-Action)

---

## Phase 5: User Story 3 - Manage Conversation History (Priority: P2)

**Goal**: User conducts multi-turn conversation where AI remembers context from previous messages. Full conversation history visible.

**Independent Test**: Send multiple related messages and verify AI maintains context throughout conversation.

### Multi-turn Support

- [ ] T045 [US3] Ensure ConversationState.toClaudeMessages() correctly formats full history for API in generative_ui/lib/src/domain/entities/conversation_state.dart
- [ ] T046 [US3] Pass complete message history in generateWithHistory() calls in generative_ui/lib/src/presentation/chat/chat_controller.dart (verify existing implementation)
- [ ] T047 [US3] Add system prompt injection via ChatMessage.system() in initial conversation in generative_ui/lib/src/presentation/chat/chat_controller.dart

### History Display

- [ ] T048 [US3] Implement scrollable message list with proper ListView.builder in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart
- [ ] T049 [US3] Apply visual distinction for message types (user bubble style vs assistant style) using AppSurface in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart
- [ ] T050 [US3] Handle mixed content rendering (text bubbles interleaved with dynamic components) in message list in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart

**Checkpoint**: User Story 3 complete - multi-turn conversations with full context

---

## Phase 6: User Story 4 - Handle Errors Gracefully (Priority: P2)

**Goal**: When network issues or invalid credentials occur, user sees friendly error message with retry option.

**Independent Test**: Simulate network failure or invalid credentials and verify error UI appears with retry functionality.

### Error Handling in AWS Adapter

- [ ] T051 [US4] Implement HTTP error code mapping in AwsContentGenerator (400→ValidationException, 401/403→AuthenticationException, 429→RateLimitException) in generative_ui/lib/src/data/datasources/aws_content_generator.dart (depends on T006-T010)
- [ ] T052 [US4] Implement network error catching (SocketException, TimeoutException) → NetworkException in generative_ui/lib/src/data/datasources/aws_content_generator.dart
- [ ] T053 [US4] Implement malformed response handling → GenUiException in generative_ui/lib/src/data/datasources/aws_content_generator.dart

### Error State in Controller

- [ ] T054 [US4] Implement error state transition in ChatController.sendMessage() catch block in generative_ui/lib/src/presentation/chat/chat_controller.dart (depends on T051-T053)
- [ ] T055 [US4] Implement retry() method in ChatController (re-attempt last failed message) in generative_ui/lib/src/presentation/chat/chat_controller.dart (depends on T054)

### Error UI

- [ ] T056 [US4] Implement error state UI with user-friendly message in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart (depends on T054)
- [ ] T057 [US4] Add retry button to error UI (visible when isRetryable is true) in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart (depends on T055, T056)
- [ ] T058 [US4] Add non-retryable error guidance (e.g., "Check AWS configuration") in generative_ui/lib/src/presentation/chat/gen_ui_chat_view.dart

**Checkpoint**: User Story 4 complete - graceful error handling with retry

---

## Phase 7: User Story 5 - Configure AWS Credentials Securely (Priority: P3)

**Goal**: Developer integrates GenUI by providing AWS credentials via environment variables without hardcoding secrets.

**Independent Test**: Configure credentials via .env and verify successful AWS communication with no credentials in source code.

### Credential Loading

- [ ] T059 [US5] Add dotenv.load() initialization call documentation/example in generative_ui example app or README
- [ ] T060 [US5] Implement credential validation on AWSConfig construction (throw ConfigurationException with clear message) in generative_ui/lib/src/data/config/aws_config.dart (verify T020)
- [ ] T061 [US5] Handle missing credentials gracefully in AwsContentGenerator constructor in generative_ui/lib/src/data/datasources/aws_content_generator.dart

### Security Verification

- [ ] T062 [US5] Verify .env is in .gitignore (audit task)
- [ ] T063 [US5] Verify no hardcoded credentials in any Dart files (audit task)
- [ ] T064 [US5] Create .env.example with placeholder values (verify T002 content matches research.md spec)

**Checkpoint**: User Story 5 complete - secure credential management

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T065 [P] Add Widgetbook story for GenUiChatView in widgetbook/lib/widgetbook.dart
- [ ] T066 [P] Add Widgetbook story for ChatInputArea in widgetbook/lib/widgetbook.dart
- [ ] T067 [P] Update quickstart.md with actual usage examples after implementation in specs/012-genui-phase3-aws-client/quickstart.md
- [ ] T068 Run flutter analyze on generative_ui/ and fix any warnings
- [ ] T069 Run full E2E flow validation per SC-001 acceptance criteria
- [ ] T070 Code review for AppSurface composition compliance (constitution 5.1)
- [ ] T071 Code review for token-first styling compliance (constitution 4.1)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-7)**: All depend on Foundational phase completion
  - US1 and US2 are both P1 - US2 depends on US1 infrastructure
  - US3 and US4 are both P2 - can proceed after US1/US2
  - US5 is P3 - can proceed in parallel with P2 stories after foundation
- **Polish (Phase 8)**: Depends on all user stories being complete

### User Story Dependencies

```
Phase 2 (Foundation)
       │
       ▼
    US1 (P1) ─────────────────────────────┐
       │                                   │
       ▼                                   │
    US2 (P1) ─────► US3 (P2) ──┐          │
                               │           │
    US5 (P3) ◄─────────────────┴───────────┘
                               │
                               ▼
                            US4 (P2)
                               │
                               ▼
                         Phase 8 (Polish)
```

- **US1**: Can start after Foundation - no story dependencies
- **US2**: Requires US1 chat infrastructure (ChatController, DynamicWidgetBuilder updates)
- **US3**: Requires US1/US2 foundation but adds independently testable history features
- **US4**: Requires US1 AWS adapter but adds independently testable error handling
- **US5**: Can technically start after Foundation (just .env setup) but better after US1 for validation

### Parallel Opportunities

- All Setup tasks T002-T004 marked [P] can run in parallel
- All exception classes T006-T010 can run in parallel
- All content part classes T011-T014 can run in parallel
- ChatInputArea T031 can run parallel with AWS adapter work
- Widgetbook stories T065-T066 can run in parallel

---

## Parallel Example: Foundation Phase

```bash
# Launch all exception classes together:
Task: "Create GenUiException base class in gen_exception.dart"
Task: "Create NetworkException in gen_exception.dart"
Task: "Create AuthenticationException in gen_exception.dart"
Task: "Create RateLimitException in gen_exception.dart"
Task: "Create ConfigurationException in gen_exception.dart"

# Launch all content part classes together:
Task: "Create ChatRole enum in chat_message.dart"
Task: "Create ContentPart abstract class in chat_message.dart"
Task: "Create TextContentPart class in chat_message.dart"
Task: "Create ToolResultPart class in chat_message.dart"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (5 tasks)
2. Complete Phase 2: Foundational (17 tasks) - CRITICAL
3. Complete Phase 3: User Story 1 (16 tasks)
4. **STOP and VALIDATE**: Test sending a message and receiving AI response
5. Deploy/demo if ready - this delivers core "Chat-to-Action" value

### Incremental Delivery

1. Setup + Foundational → Foundation ready
2. Add US1 → Test send/receive → **MVP ready**
3. Add US2 → Test closed-loop actions → Full interaction loop
4. Add US3 + US4 → Test history + errors → Production-ready
5. Add US5 + Polish → Security audit complete → Release

### Task Summary

| Phase | User Story | Task Count | Parallel Tasks |
|-------|------------|------------|----------------|
| 1 | Setup | 5 | 3 |
| 2 | Foundational | 17 | 13 |
| 3 | US1 - Send/Receive | 16 | 2 |
| 4 | US2 - Actions | 6 | 0 |
| 5 | US3 - History | 6 | 0 |
| 6 | US4 - Errors | 8 | 0 |
| 7 | US5 - Security | 6 | 0 |
| 8 | Polish | 7 | 3 |
| **Total** | | **71** | **21** |

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- US1 + US2 together deliver the core E2E flow (SC-001)
- Constitution compliance checks included in Polish phase
