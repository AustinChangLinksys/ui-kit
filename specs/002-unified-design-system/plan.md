# Implementation Plan: UI Kit Unified Design System (v2.0)

**Branch**: `002-unified-design-system` | **Date**: November 27, 2025 | **Spec**: specs/002-unified-design-system/spec.md
**Input**: Feature specification from `/specs/002-unified-design-system/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

This feature implements the "Unified Design System (v2.0)" architecture, decoupling component semantics from visual styling. It introduces an abstract `AppDesignTheme` contract, an `AppSurface` primitive for rendering, and concrete implementations for **Glass**, **Brutal**, **Flat**, and **Neumorphic** design languages (all supporting Light/Dark modes). This allows runtime switching of the entire application's visual language. The plan includes migrating legacy components, implementing the orthogonal theme switching logic in Widgetbook (Design Language Knob + Theme Mode Addon), and verifying all 8 combinations.

## Technical Context

**Language/Version**: Dart 3.8+ (Utilizing Records, Patterns, Class Modifiers)
**Primary Dependencies**: `flutter`, `theme_tailor_annotation`, `equatable`
**Dev Dependencies**: `build_runner`, `theme_tailor`, `widgetbook`, `widgetbook_annotation`, `widgetbook_generator`, `alchemist`
**Storage**: N/A
**Testing**: `flutter_test` (unit), `widgetbook` (visual/manual), `alchemist` (golden/regression)
**Target Platform**: Flutter (iOS, Android, Web, MacOS, Windows, Linux)
**Project Type**: Flutter Package
**Performance Goals**: Runtime theme switching < 16ms (1 frame).
**Constraints**: Must strictly adhere to `theme_tailor` generation for `ThemeExtension`.
**Scale/Scope**: Foundation for all future UI components.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

The following principles from the Project Constitution (v1.0.0) are critical gates for planning and must be adhered to:

- **Architectural Boundaries (Section 2):**
    - **2.1 Physical Isolation:** Compliant. All code remains within the `ui_kit` package.
    - **2.2 Dependency Hygiene:** Compliant. No forbidden dependencies (bloc, provider, http, etc.) are introduced.
    - **2.3 Directory Structure:** Compliant. New files will be placed in `src/foundation/theme/design_system/` (base), `src/atoms/surfaces/` (primitives), and `src/molecules/` (components).
- **Component Design (Section 4):**
    - **4.1 Dumb Components:** Compliant. `AppCard` and `AppDialog` are stateless and data-driven. `AppSurface` encapsulates rendering logic but holds no business state.
    - **4.2 Composition over Inheritance:** Compliant. `AppCard` composes `AppSurface`. `AppDesignTheme` uses composition for style definitions.
- **Quality Assurance & Testing (Section 12):**
    - **12.1 Widgetbook:** Compliant. New components will have stories. Theme switching will be demonstrated via custom knobs.
    - **12.2 Golden Tests:** Compliant. Golden tests will be added to verify visual regression across all 4 themes.

## Project Structure

### Documentation (this feature)

```text
specs/002-unified-design-system/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/src/
├── foundation/
│   └── theme/
│       └── design_system/          # Design System Core
│           ├── app_design_theme.dart # Abstract Contract & ThemeExtension
│           ├── surface_style.dart    # Data classes (SurfaceStyle, AnimationSpec)
│           ├── styles/               # Concrete Implementations
│           │   ├── glass_design_theme.dart
│           │   ├── brutal_design_theme.dart
│           │   ├── flat_design_theme.dart       # NEW
│           │   └── neumorphic_design_theme.dart # NEW
├── atoms/
│   └── surfaces/
│       └── app_surface.dart        # Primitive Renderer
├── molecules/
│   ├── cards/
│   │   └── app_card.dart           # Semantic Card (migrated)
│   └── dialogs/
│       └── app_dialog.dart         # Semantic Dialog (migrated)
```

**Structure Decision**: We are introducing a sub-folder `design_system` under `foundation/theme` to encapsulate the new architecture logic, keeping the root `theme` folder clean. `AppSurface` is correctly placed in `atoms/surfaces` as it is a foundational building block.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| (None)    | N/A        | N/A                                 |