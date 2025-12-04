# Implementation Plan: System Foundation Upgrades

**Branch**: `014-foundation-upgrade` | **Date**: 2025-12-04 | **Spec**: specs/014-foundation-upgrade/spec.md
**Input**: Feature specification from `/specs/014-foundation-upgrade/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

This plan details the architectural changes to the Flutter UI Component Library (`ui_kit`) to introduce dynamic motion, global visual effects, and adaptive iconography, supporting multiple visual styles (Flat, Glass, Pixel). It focuses on leveraging `AppDesignTheme` for configuration and adhering to IoC/DDS principles.

## Technical Context

**Language/Version**: Dart (latest stable), Flutter (latest stable)
**Primary Dependencies**: `flutter`, `theme_tailor`, `flutter_svg`, `flutter_gen`
**Storage**: N/A (UI Component Library)
**Testing**: `flutter_test`, `widgetbook_test`, Golden Tests (as per Constitution 12.2)
**Target Platform**: iOS, Android, Web (standard Flutter targets)
**Project Type**: Flutter UI Component Library (Dart Package)
**Performance Goals**: Maintain 60 FPS under normal operation; non-blocking UI for global effects.
**Constraints**: Strict adherence to UI Kit Constitution 2.0.0; Zero-Touch Policy for new styles on existing component code; no business logic allowed within the UI Kit.
**Scale/Scope**: Foundation for multi-paradigm visual styles across the entire application, impacting all components utilizing motion, global effects, or icons.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

This plan strictly adheres to the UI Component Library Charter (Version 2.0.0). Key principles reinforced include:

*   **3.1 Inversion of Control (IoC) & 3.2 Data-Driven Strategy (DDS)**: The new motion system (`MotionSpec`, `AppMotion`) and iconography (`AppIconStyle`) are designed as data-driven configurations provided by the theme, allowing components to "ask how" to render, not "who" they are.
*   **4.1 The Contract: AppDesignTheme**: New motion (`AppMotion motion`), icon style (`AppIconStyle iconStyle`), and global effect (`GlobalEffectsType globalEffects`) properties are integrated into `AppDesignTheme`, maintaining it as the single source of truth for visual language.
*   **4.4 Automation & Tooling (`theme_tailor`)**: `theme_tailor` will be used to manage the new theme extensions, prohibiting manual `copyWith` and `lerp` methods.
*   **6.1 Component Expansion Protocol ("No Runtime Type Checks")**: `AppIcon` will adapt its rendering based on `AppIconStyle` from the theme, specifically designed to avoid `runtimeType` checks.
*   **6.2 Style Expansion Protocol ("Zero-Touch Policy")**: The architecture ensures that new visual styles can customize motion, global effects, and icon rendering without requiring modifications to existing core component code.
*   **7.1 Assets Management (`flutter_gen`)**: The iconography solution continues to leverage `flutter_gen` for strong typing and access control of assets.

## Project Structure

### Documentation (this feature)

```text
specs/014-foundation-upgrade/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

The feature will extend the existing UI Kit package structure:

```text
lib/
├── src/
│   ├── foundation/
│   │   ├── motion/            # New directory for motion-related classes
│   │   │   ├── motion_spec.dart
│   │   │   ├── app_motion.dart
│   │   │   ├── flat_motion.dart
│   │   │   ├── glass_motion.dart
│   │   │   ├── pixel_motion.dart
│   │   │   └── steps_curve.dart
│   │   ├── effects/           # New directory for global effects
│   │   │   ├── global_effects_overlay.dart
│   │   │   └── global_effects_type.dart
│   │   ├── icons/             # New directory for icon-related enums/specs
│   │   │   └── app_icon_style.dart
│   │   └── theme/
│   │       └── design_system/
│   │           └── app_design_theme.dart     # Modified to include new properties
│   │           └── styles/*.dart             # Modified to implement new properties
│   ├── atoms/
│   │   └── icons/
│   │       └── app_icon.dart                 # Modified for adaptive iconography
│   └── ui_kit.dart            # Export new public APIs
└── generative_ui/example/
    └── lib/
        └── main.dart          # Modified to inject GlobalEffectsOverlay
```

**Structure Decision**: This plan extends the existing atomic design structure (`src/foundation`, `src/atoms`) by adding new domain-specific sub-directories within `src/foundation` for `motion`, `effects`, and `icons`. Modifications are made to existing core theme (`app_design_theme.dart`) and component (`app_icon.dart`) files.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| N/A | | |