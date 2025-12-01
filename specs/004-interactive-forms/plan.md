# Implementation Plan: Interactive & Form Expansion

**Branch**: `004-interactive-forms` | **Date**: 2025-12-01 | **Spec**: [specs/004-interactive-forms/spec.md](../../specs/004-interactive-forms/spec.md)
**Input**: Feature specification from `/specs/004-interactive-forms/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

This phase implements critical interactive components for form handling and user feedback, bridging the gap in "Complex Interactions". Key additions include `AppTextFormField` (form wrapper), `AppDropdown` (selection), `AppLoader` & `AppToast` (feedback), and `AppListTile` (layout). The approach utilizes a "Wrapper Pattern" for forms to decouple validation logic from UI, and "Visual Mimicry" for dropdowns to ensure consistency. Styles for loaders and toasts will be defined in `AppDesignTheme` extensions.

## Technical Context

**Language/Version**: Dart 3.0+ (Flutter 3.10+)
**Primary Dependencies**:
- `flutter`: Core framework
- `theme_tailor`: Theme extension generation (Constitution 4.4)
- `flutter_animate`: Animations (Constitution 6.0/8.1)
- `flutter_svg`: Icons
- `widgetbook`: Component catalog (Constitution 12.1)
- `alchemist`: Golden tests (implied by Constitution 12.2)

**Storage**: N/A (UI Kit is stateless)
**Testing**: `flutter_test`, `alchemist` for Goldens, `widgetbook` for visual verification.
**Target Platform**: iOS, Android, Web, macOS (Cross-platform UI Kit)
**Project Type**: Flutter Package (UI Library)
**Performance Goals**: 60 FPS for all animations (`AppLoader`, `AppToast`), specifically on low-end devices (per SC-006).
**Constraints**: No business logic dependencies (`bloc`, `provider`, etc. are forbidden). Components must be "Dumb".
**Scale/Scope**: 5 new components, 2 new theme extensions (`LoaderStyle`, `ToastStyle`).

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

The following principles from the Project Constitution (v2.0.0) are critical gates for planning and must be adhered to:

- **Architectural Boundaries (Section 2):**
    - **2.1 Physical Isolation:** The UI Kit remains an independent package.
    - **2.2 Dependency Hygiene:** Using only allowed packages (`flutter`, `theme_tailor`, `flutter_animate`, etc.). No business logic deps.
    - **2.3 Directory Structure:** Adheres to `lib/src/{foundation,atoms,molecules}`.
- **Component Design (Section 5):**
    - **5.2 Dumb Components:** All new components (`AppTextFormField`, `AppDropdown`, etc.) are stateless or manage only transient UI state (e.g., dropdown open/close).
    - **5.3 Composition over Inheritance:** `AppListTile` uses Slots Pattern. `AppTextFormField` wraps `AppTextField`.
- **Theming & Styling (Section 4):**
    - **4.1 The Contract:** All styles defined in `AppDesignTheme` extensions (`LoaderStyle`, `ToastStyle`).
    - **4.4 Automation:** Using `@TailorMixin`.
- **Quality Assurance & Testing (Section 12):**
    - **12.1 Widgetbook:** Planned stories for all new components.
    - **12.2 Golden Tests:** Planned Matrix coverage (Light/Dark x 4 Styles).

## Project Structure

### Documentation (this feature)

```text
specs/004-interactive-forms/
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
│   └── theme/ # Extensions: loader_style.dart, toast_style.dart
├── molecules/
│   ├── forms/ # AppTextFormField, AppDropdown
│   ├── feedback/ # AppLoader, AppToast
│   └── layout/ # AppListTile
└── ...
```

**Structure Decision**: New components fit naturally into `molecules` as they compose atoms (like `AppSurface`, `AppTextField`, `AppIcon`). `AppTextFormField` and `AppDropdown` go to `molecules/forms`, `AppLoader` and `AppToast` to `molecules/feedback` (new directory), and `AppListTile` to `molecules/layout` (or `organisms` if it becomes very complex, but `molecules` fits standard list tiles better).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | N/A | N/A |