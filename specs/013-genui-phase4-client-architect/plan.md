# Implementation Plan: GenUI Phase 4 - Client Refactoring & Layout Architect

**Branch**: `013-genui-phase4-client-architect` | **Date**: 2025-12-04 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/013-genui-phase4-client-architect/spec.md`

## Summary

Upgrade `generative_ui/example/` to `generative_ui/gen_ui_client/` as a standalone AI-powered Layout Architect application. The client transforms from a simple demo into a production-ready tool with:
- Theme-aware dynamic UI rendering (all 5 design languages)
- Complete UI Kit component registry (31 components)
- Seed color customization
- Code generation export capability
- Clean Architecture (Domain/Data/Presentation layers)

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x
**Primary Dependencies**:
- Architecture: flutter_riverpod ^2.4.9, riverpod_annotation ^2.3.3, equatable ^2.0.5
- Data: json_annotation ^4.8.1, json_serializable ^6.7.1
- AWS: http ^1.2.1, aws_signature_v4 ^0.6.9, aws_common ^0.7.11, flutter_dotenv ^5.1.0
- Code Gen: dart_style ^2.3.0, flutter_highlight ^0.7.0
- UI: ui_kit_library (path: ../../), generative_ui (path: ../)

**Storage**: N/A (conversation state in memory only)
**Testing**: flutter_test, widget tests, integration tests
**Target Platform**: iOS, Android, Web (Chrome recommended for Glass effects)
**Project Type**: Mobile application (Flutter)
**Performance Goals**: Theme switch < 300ms, 60 fps during interactions
**Constraints**: Offline-capable for theme switching (LLM requires network)
**Scale/Scope**: Single-user chat interface, 31 registered components

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Compliance | Notes |
|-----------|------------|-------|
| **2.2 Dependency Hygiene** | ⚠️ JUSTIFIED | `riverpod` used in gen_ui_client (separate app), not in ui_kit_library itself |
| **3.1 IoC** | ✅ PASS | Components ask theme "how to look", never check theme type |
| **3.2 DDS** | ✅ PASS | Registry pattern uses data maps, no if/else for styles |
| **4.1 Token-First** | ✅ PASS | All colors from AppDesignTheme, no hardcoded values |
| **5.1 AppSurface Primitive** | ✅ PASS | Error fallback uses AppSurface, not Container |
| **6.1 No Runtime Type Checks** | ✅ PASS | No `if (theme is BrutalDesignTheme)` patterns |

**Justified Violation**: Riverpod is used in `gen_ui_client` application for state management. This is acceptable because:
1. `gen_ui_client` is a **standalone application**, not part of `ui_kit_library`
2. Constitution Section 2.2 applies to the **ui_kit_library package itself**
3. Applications consuming the library may use any state management

## Project Structure

### Documentation (this feature)

```text
specs/013-genui-phase4-client-architect/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output (tool schemas)
└── tasks.md             # Phase 2 output
```

### Source Code (repository root)

```text
generative_ui/
├── lib/src/                     # GenUI library (existing)
│   ├── domain/                  # Existing domain layer
│   ├── data/                    # Existing data layer
│   └── presentation/            # Existing presentation layer
│
└── gen_ui_client/               # NEW: Renamed from example/
    ├── pubspec.yaml
    ├── assets/
    │   ├── .env                 # AWS credentials (gitignored)
    │   └── system_prompt.txt    # Layout Architect persona
    ├── lib/
    │   ├── main.dart            # App entry with Riverpod
    │   ├── core/
    │   │   ├── constants/       # App constants
    │   │   └── errors/          # Failure, ContractException
    │   ├── domain/              # Client-specific domain (Pure Dart)
    │   │   ├── entities/        # LayoutBlueprint (extends ChatMessage)
    │   │   └── services/        # ICodeGenService interface
    │   ├── data/                # Client-specific data layer
    │   │   └── services/        # DartCodeGenService implementation
    │   └── presentation/
    │       ├── providers/       # Riverpod: theme_provider, architect_provider
    │       ├── registry/        # UiKitComponentRegistry (31 components)
    │       └── views/           # ArchitectView with Preview/Code tabs
    └── test/
```

**Structure Decision**: Clean Architecture with domain/data/presentation separation. The gen_ui_client app has its own thin domain layer for code generation while reusing generative_ui library's core domain entities.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| Riverpod in app | State management for theme + conversation + code gen | StatefulWidget would require prop drilling for 3+ state sources |
| Dual Registry (Widget + CodeGen) | Need both runtime rendering AND source code export | Single registry can't produce both Widget and String outputs |

## Architecture Decisions

### AD-001: Reuse generative_ui Domain vs New Domain

**Decision**: Extend, don't duplicate
- gen_ui_client imports generative_ui's ChatMessage, LLMResponse, etc.
- Only add client-specific entities (LayoutBlueprint) and services (ICodeGenService)
- Avoids code duplication while maintaining separation

### AD-002: Registry Pattern for 31 Components

**Decision**: Static map-based registry with factory functions
```dart
static final Map<String, Widget Function(BuildContext, Map, {void Function(Map)?})> builders = {
  'AppButton': (ctx, props, {onAction}) => AppButton(...),
  // ... 30 more
};
```
- O(1) lookup
- Type-safe factory signatures
- Easy to extend

### AD-003: Theme State Management

**Decision**: Riverpod with AppDesignTheme + ColorScheme.fromSeed
- ThemeController notifier manages: designLanguage (Glass/Brutal/etc), seedColor, brightness
- Rebuilds both AppDesignTheme and MaterialTheme on change
- Components automatically rebuild via Consumer/ref.watch

### AD-004: Code Generation Strategy

**Decision**: Visitor pattern with CodeGenRegistry
- Separate registry maps component names to code templates
- Recursive visitor walks layout JSON tree
- dart_style formats output
- Handles children/nesting via callback pattern
