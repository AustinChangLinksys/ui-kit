# Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Feature specification from `/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

[Extract from feature spec: primary requirement + technical approach from research]

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION]  
**Primary Dependencies**: [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION]  
**Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]  
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION]  
**Target Platform**: [e.g., Linux server, iOS 15+, WASM or NEEDS CLARIFICATION]
**Project Type**: [single/web/mobile - determines source structure]  
**Performance Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION]  
**Constraints**: [domain-specific, e.g., <200ms p95, <100MB memory, offline-capable or NEEDS CLARIFICATION]  
**Scale/Scope**: [domain-specific, e.g., 10k users, 1M LOC, 50 screens or NEEDS CLARIFICATION]

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

The following principles from the Project Constitution (v1.0.0) are critical gates for planning and must be adhered to:

- **Architectural Boundaries (Section 2):**
    - **2.1 Physical Isolation:** The UI Kit must remain an independent Dart package.
    - **2.2 Dependency Hygiene:** Strictly adhere to allowed UI and utility packages; no business logic or backend connectivity dependencies.
    - **2.3 Directory Structure:** Follow the defined Atomic Design variant (`src/foundation`, `src/atoms`, `src/molecules`, `src/organisms`, `src/layout`).
- **Component Design (Section 4):**
    - **4.1 Dumb Components:** Components must be stateless (UI transient state only) and receive data via constructors, emit events via callbacks.
    - **4.2 Composition over Inheritance:** Utilize the Slots Pattern.
- **Quality Assurance & Testing (Section 12):**
    - **12.1 Widgetbook:** All public components must have registered UseCases.
    - **12.2 Golden Tests:** Core components require screenshot tests for Light/Dark Mode, and Text Scale (1.0/1.5), ensuring zero overflow.

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
<!--
  The UI Kit project must adhere to the following directory structure as defined in the Project Constitution (v1.0.0, Section 2.3).
  Expand this structure with real paths as needed for the specific feature.
-->

```text
src/
├── foundation/ # Base styles (Colors, Typography, Spacing).
├── atoms/      # Indivisible units (Button, Icon, Badge).
├── molecules/  # Simple compositions (ListTile, InputField).
├── organisms/  # Complex sections (AppBar, ProductCard).
└── layout/     # Responsive layout utilities.
```

**Structure Decision**: [Document the selected structure and reference the real
directories captured above. This should always reflect the constitution's structure for UI Kit development.]

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
