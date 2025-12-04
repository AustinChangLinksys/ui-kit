# Implementation Plan: GenUI Phase 3 - AWS Integration & Complete Client

**Branch**: `012-genui-phase3-aws-client` | **Date**: 2025-12-04 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/012-genui-phase3-aws-client/spec.md`

## Summary

Transform GenUI from a mock-based proof-of-concept into a production-ready AI solution by:
1. Implementing AWS Bedrock adapter with SigV4 authentication to replace `MockContentGenerator`
2. Building a complete Chat Interface Widget that manages conversation state and history
3. Implementing the closed-loop interaction pattern where UI component actions feed back to the AI

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x (SDK >=3.0.0 <4.0.0, Flutter >=3.13.0)
**Primary Dependencies**:
- Existing: `ui_kit_library`, `flutter`, `alchemist`
- New: `aws_common` ^0.7.11, `aws_signature_v4` ^0.6.9, `http` ^1.2.1, `flutter_dotenv` ^5.1.0
**Storage**: N/A (in-memory conversation history; no persistence required per spec)
**Testing**: `flutter_test`, `alchemist` (golden tests)
**Target Platform**: Flutter (iOS, Android, Web) - Chrome recommended for Glass effects
**Project Type**: Flutter module (generative_ui) within ui_kit monorepo
**Performance Goals**: Responsive UI state transitions, no crashes during E2E flow
**Constraints**: SigV4 signing required; no hardcoded credentials; .env must be gitignored
**Scale/Scope**: Single-user conversation, synchronous request/response (no streaming)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| **2.2 Dependency Hygiene** | JUSTIFIED EXCEPTION | `http`, `aws_common`, `aws_signature_v4` are network dependencies. However, `generative_ui` is a separate module from `ui_kit` library and explicitly handles LLM connectivity. This is out of scope for the core UI component library restrictions. |
| **2.3 Directory Structure** | PASS | New code follows existing structure in `data/datasources/` and `presentation/chat/` |
| **3.1 Inversion of Control** | PASS | Chat UI will use existing `AppSurface` and theme specs from ui_kit |
| **3.2 Data-Driven Strategy** | PASS | State management uses existing `GenUiViewState` enum pattern |
| **4.1 Token-First** | PASS | All visual styling comes from `AppDesignTheme` via `ui_kit_library` |
| **5.1 AppSurface Primitive** | PASS | Chat bubbles and containers will compose `AppSurface` |
| **5.2 Dumb Components** | PASS | Chat widget receives data via constructor, emits via callbacks |
| **6.1 No Runtime Type Checks** | PASS | No `if (theme is X)` checks in new code |
| **12.1 Widgetbook** | PASS | New chat components will have Widgetbook stories |
| **12.2 Golden Tests** | PASS | Chat UI will have golden tests following Safe Mode Protocol |

**Dependency Exception Justification**: The `generative_ui` module is architecturally separate from the `ui_kit` core library. Its explicit purpose is LLM connectivity and orchestration. The constitution's dependency hygiene rules (Section 2.2) apply to the core UI component library (`lib/src/`), not to specialized integration modules. The `generative_ui/pubspec.yaml` already depends on `ui_kit_library` as a path dependency, establishing this separation.

## Project Structure

### Documentation (this feature)

```text
specs/012-genui-phase3-aws-client/
├── plan.md              # This file
├── research.md          # Phase 0: AWS SigV4 patterns, Claude API format
├── data-model.md        # Phase 1: ChatMessage, ConversationState entities
├── quickstart.md        # Phase 1: Integration guide
├── contracts/           # Phase 1: API contracts
│   └── bedrock-messages-api.md
└── tasks.md             # Phase 2 output (via /speckit.tasks)
```

### Source Code (repository root)

```text
generative_ui/
├── lib/
│   └── src/
│       ├── data/
│       │   └── datasources/
│       │       ├── aws_content_generator.dart     # [MODIFY] Replace placeholder
│       │       └── mock_content_generator.dart    # [KEEP] For testing
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── content_block.dart             # [KEEP] TextBlock, ToolUseBlock
│       │   │   ├── llm_response.dart              # [KEEP] LLMResponse
│       │   │   ├── gen_tool.dart                  # [KEEP] GenTool
│       │   │   ├── chat_message.dart              # [NEW] Multi-turn message model
│       │   │   └── conversation_state.dart        # [NEW] Chat state container
│       │   └── repositories/
│       │       └── i_content_generator.dart       # [MODIFY] Extend for multi-turn
│       └── presentation/
│           ├── chat/                              # [NEW] Chat module
│           │   ├── gen_ui_chat_view.dart          # Main chat interface widget
│           │   ├── chat_controller.dart           # Conversation state management
│           │   └── chat_input_area.dart           # Text input component
│           ├── widgets/
│           │   ├── dynamic_builder.dart           # [MODIFY] Add onAction callback
│           │   ├── message_bubble.dart            # [KEEP] Text rendering
│           │   └── ...
│           └── registry/
│               └── component_registry.dart        # [KEEP] O(1) lookup
├── assets/
│   ├── ai_config.json                             # [KEEP] Tool schemas
│   └── .env.example                               # [NEW] Credential template
├── pubspec.yaml                                   # [MODIFY] Add AWS dependencies
└── .gitignore                                     # [MODIFY] Add .env
```

**Structure Decision**: Extends existing `generative_ui` module structure. New chat presentation layer follows atomic design (chat/ as an organism). AWS integration replaces existing placeholder in datasources.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| Network dependencies (`http`, `aws_*`) in generative_ui | AWS Bedrock requires HTTP communication with SigV4 signing | Direct REST calls are the standard AWS pattern; no simpler alternative exists for Bedrock |
| flutter_dotenv dependency | Secure credential injection from environment | Hardcoded credentials would violate security requirements (FR-010, SC-003) |

## Phase 0: Research Topics

1. **AWS Bedrock Runtime API**
   - Claude Messages API request/response format
   - SigV4 signing process for Bedrock service
   - Tool use (function calling) format in Bedrock

2. **AWS Dart SDK Patterns**
   - `aws_common` AWSHttpRequest usage
   - `aws_signature_v4` AWSSigV4Signer patterns
   - Credential provider patterns

3. **Interface Extension Strategy**
   - How to extend `IContentGenerator` for multi-turn without breaking existing implementations
   - Adapter pattern considerations

## Phase 1: Design Outputs

1. **data-model.md**: Define ChatMessage, ToolOutput, ConversationState entities
2. **contracts/bedrock-messages-api.md**: Claude Messages API contract
3. **quickstart.md**: Integration guide for developers

## Key Implementation Notes

### Existing Interfaces to Integrate With

**IContentGenerator** (current):
```dart
abstract class IContentGenerator {
  Future<String> generate(String userInput);
}
```

**ComponentRegistry** (current):
```dart
typedef GenUiWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props,
);
```

**DynamicWidgetBuilder** (current):
```dart
Widget buildBlock(ContentBlock block, BuildContext context)
```

### Extension Points

1. `IContentGenerator` needs multi-turn support → new method or extended interface
2. `DynamicWidgetBuilder` needs `onAction` callback → modify signature
3. `GenUiViewState` already supports required states (initial, loading, data, error)
4. `LLMResponse` / `ContentBlock` entities are already compatible with Claude format
