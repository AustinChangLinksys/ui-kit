# Implementation Plan: Live Theme Editor

**Branch**: `006-theme-editor` | **Date**: 2025-12-02 | **Spec**: [/specs/006-theme-editor/spec.md](/specs/006-theme-editor/spec.md)
**Input**: Feature specification from `/specs/006-theme-editor/spec.md`

## Summary

Build a standalone Flutter Web application that provides a WYSIWYG interface for real-time tuning of AppDesignTheme parameters. The editor features a split-screen layout with a live preview (Dashboard Hero Demo) on the left and a hierarchically organized control panel on the right. Theme adjustments trigger instant preview updates (< 16ms), and users can export working Dart code directly into their projects. The editor is architecturally isolated from the core UI Kit library, consuming it as a dependency to prevent pollution of production code with development tooling dependencies.

## Technical Context

**Language/Version**: Dart (latest Flutter SDK)
**Primary Dependencies**:
  - Flutter Web (latest SDK)
  - UI Kit library (path-based: `path: ../`)
  - Provider (^6.0.0 or latest for state management)
  - flex_color_picker (^3.0.0 for color picker UI)
  - gap (^3.0.0 for layout spacing helper)
**Storage**: LocalStorage/SessionStorage (browser-only, for session-local state persistence)
**Testing**: Flutter testing framework, widget tests for components (not the editor itself, per design)
**Target Platform**: Web (Flutter Web/WASM)
**Project Type**: Standalone Flutter Web application (`editor/` directory in repository root)
**Performance Goals**: Real-time preview updates within 16ms; editor loads and becomes interactive in under 3 seconds
**Constraints**: Zero external API dependencies (offline-capable once loaded); zero editor-specific dependencies in core UI Kit's pubspec.yaml; export must produce valid, production-ready Dart code
**Scale/Scope**: Single-app editor tool; ~5-10 screens (control panel sections); supports all 6 core DDS specs (Surface, Input, Global Metrics, Loader, Toggle, Navigation)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Status**: ✅ PASS (Constitution template unfilled; no explicit constraints violated)

**Gate Evaluation**:
- ✅ **Isolation Verified**: Editor is a standalone app in `editor/` directory, consuming UI Kit as external dependency
- ✅ **Dependency Isolation**: Zero editor-specific dependencies added to core UI Kit's pubspec.yaml
- ✅ **Testing Strategy**: Component widgets are testable independently; editor itself is end-user tool, not library code
- ✅ **Simplicity**: Single-app architecture with clear separation of concerns (state → UI → export)
- ✅ **Offline Operation**: No external API calls; all logic runs locally in browser

**Constitution Note**: The project constitution is a template (unfilled). No explicit constraints conflict with this implementation plan. The editor follows library-first principles by remaining isolated and not polluting the core library.

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
editor/
├── lib/
│   ├── main.dart                      # Entry point; initializes app and routes
│   ├── app.dart                       # Root widget, theme setup
│   ├── pages/
│   │   ├── live_editor_page.dart      # Main layout: preview + control panel split
│   │   └── [future: responsive mobile layout]
│   ├── models/
│   │   └── theme_editor_state.dart    # State model for current theme + brightness
│   ├── controllers/
│   │   └── theme_editor_controller.dart  # Provider-managed state; updateTheme(), reset(), generateCode()
│   ├── widgets/
│   │   ├── preview_area.dart          # Preview pane: embeds Dashboard Hero Demo
│   │   ├── control_panel.dart         # Control pane: toolbar + spec editors
│   │   ├── property_editors/
│   │   │   ├── double_property.dart   # Numeric slider + keyboard input
│   │   │   ├── color_property.dart    # Color picker integration
│   │   │   ├── bool_property.dart     # Toggle/switch
│   │   │   └── enum_property.dart     # Dropdown for enum values
│   │   └── spec_editors/
│   │       ├── surface_style_editor.dart    # Edit SurfaceStyle (Base, Elevated, Highlight)
│   │       ├── input_style_editor.dart      # Edit InputStyle (Outline, Underline, Filled)
│   │       ├── global_metrics_editor.dart   # Edit spacing, animation speed
│   │       ├── loader_spec_editor.dart      # Edit LoaderSpec
│   │       ├── toggle_spec_editor.dart      # Edit ToggleSpec
│   │       └── navigation_spec_editor.dart  # Edit NavigationSpec
│   └── utils/
│       ├── code_generator.dart        # Dart code string generation from theme
│       └── color_utils.dart           # Color format parsing/serialization
├── pubspec.yaml                       # Dependencies (Provider, flex_color_picker, gap, ui_kit_library)
├── web/
│   ├── index.html                     # Web entry point
│   └── manifest.json
└── test/                              # Widget tests for components (optional)
    ├── widgets/
    │   └── property_editors_test.dart
    └── controllers/
        └── theme_editor_controller_test.dart
```

**Structure Decision**:
This is a **single standalone Flutter Web application** that serves as an internal development tool. It follows a clean architecture pattern:
- **Presentation Layer** (`pages/`, `widgets/`): UI components organized by responsibility (preview, controls, atomic editors, spec editors)
- **Business Logic** (`controllers/`, `models/`): State management via Provider pattern; theme state encapsulation
- **Utilities** (`utils/`): Code generation and color handling
- **Test Layer**: Component-level tests for reusable widgets; integration tests for editor workflows optional

The structure is intentionally flat and focused, as this is a tool application, not a library. All editor-specific dependencies stay within this directory; the core UI Kit library remains clean.

## Complexity Tracking

**Status**: ✅ NO VIOLATIONS — No complexity trade-offs needed. All design decisions maintain simplicity.

---

## Phase 0: Research (NEXT STEP)

**Objective**: Resolve any unknowns and validate technology choices

**Research Topics**:

1. **Provider State Management Pattern in Flutter Web**
   - How to structure Provider for efficient rebuilds in responsive layouts
   - Comparing Provider vs. Riverpod vs. GetX for this use case
   - Expected outcome: Finalized state management approach in `research.md`

2. **DashboardPage Integration & Export**
   - Verify that Dashboard Hero Demo is available and can be embedded as a Widget
   - Determine if any modifications needed to make it embeddable (ensure it's widget-based, not page-based)
   - Expected outcome: Integration checklist in `research.md`

3. **Color Picker Integration (flex_color_picker)**
   - Best practices for integrating flex_color_picker in a Flutter Web context
   - Performance implications for real-time updates
   - Expected outcome: Integration patterns documented in `research.md`

4. **Dart Code Generation from Theme Objects**
   - Strategies for serializing AppDesignTheme to Dart constructor code
   - Handling Color objects and other complex types
   - Expected outcome: Code generation strategy in `research.md`

5. **Flutter Web Performance & 16ms Target**
   - Profiling techniques to verify 16ms update target
   - Potential optimization strategies if target not met
   - Expected outcome: Performance testing approach in `research.md`

**Phase 0 Deliverables**: `research.md` with findings from all topics, decision rationale, and any architectural adjustments needed

---

## Phase 1: Design & Contracts

**Prerequisites**: Phase 0 research complete

**Objectives**:

1. **Data Model** (`data-model.md`):
   - Document `AppDesignTheme` structure as it applies to the editor
   - Define `ThemeEditorState` model (current theme, brightness mode, modified flags)
   - Outline relationships between specs (Surface, Input, etc.) and their parameter types

2. **API Contracts** (`contracts/`):
   - Define controller methods and their signatures
   - Document code generator output format (Dart string structure)
   - Export/import operations if applicable

3. **Quickstart** (`quickstart.md`):
   - Step-by-step guide for running the editor locally (`flutter run -d web`)
   - How to adjust a single parameter and verify preview updates
   - How to export and integrate generated code

4. **Agent Context Update**:
   - Run `.specify/scripts/bash/update-agent-context.sh claude`
   - Add Flutter Web, Provider pattern, and code generation context
   - Preserve existing context between markers

**Phase 1 Deliverables**: `data-model.md`, `contracts/` directory with method specs, `quickstart.md`, updated agent context

---

## Phase 2: Task Generation

**Command**: `/speckit.tasks` (not run by this command; executed after Phase 1)

**Output**: `tasks.md` with detailed, prioritized, dependency-ordered implementation tasks

**Expected Task Breakdown**:
- Project setup & dependency configuration
- State management infrastructure
- Property editor components (atomic widgets)
- Spec editors (composite widgets)
- Layout & integration (main page)
- Code export implementation
- Testing & verification
- Deployment & CI setup

---

## Next Steps

1. ✅ **Branch created**: `006-theme-editor`
2. ✅ **Spec finalized**: `/specs/006-theme-editor/spec.md`
3. ✅ **Plan written**: This file
4. ⏭️ **Phase 0 Research**: Execute research tasks (see above)
5. ⏭️ **Phase 1 Design**: Generate data-model.md, contracts, quickstart
6. ⏭️ **Phase 2 Tasks**: Run `/speckit.tasks` to generate detailed task breakdown

**Recommendation**: Proceed to Phase 0 research to resolve any remaining unknowns before task generation.
