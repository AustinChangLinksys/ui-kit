# Implementation Plan: Unified UI Kit Molecules

**Branch**: `003-ui-kit-molecules` | **Date**: 2025-11-29 | **Spec**: [specs/003-ui-kit-molecules/spec.md](../spec.md)
**Input**: Feature specification from `specs/003-ui-kit-molecules/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Implement the core `molecules` library for the Unified Design System (v2.0), comprising 10 fundamental components (`AppButton`, `AppTextField`, `AppNavigationBar`, etc.). Implementation follows the **Data-Driven Strategy (DDS)** and utilizes `AppSurface` as the root primitive. Verification includes interactive Widgetbook stories and Golden tests via `alchemist`.

## Technical Context

**Language/Version**: Dart 3.2+ (Flutter 3.22+)
**Primary Dependencies**: 
- `flutter`
- `theme_tailor` (Theming)
- `flutter_svg` (Icons)
- `alchemist` (Golden Tests)
- `shimmer` (Loading states)
**Storage**: N/A (UI Components)
**Testing**: `flutter test` (Unit), `alchemist` (Goldens)
**Target Platform**: Flutter (All supported platforms)
**Project Type**: Flutter Package
**Performance Goals**: 60fps rendering, efficient rebuilds (`RepaintBoundary` where appropriate).
**Constraints**: 
- No business logic dependencies (`bloc`, `provider`, etc.).
- Strict adherence to `AppSurface` primitive.
- No runtime type checks for theme identity.
**Scale/Scope**: 10 new components added to `lib/src/molecules/`.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

The following principles from the Project Constitution (v1.0.0) are critical gates for planning and must be adhered to:

- **Architectural Boundaries (Section 2):**
    - **2.1 Physical Isolation:** Yes, working within the `ui_kit` package.
    - **2.2 Dependency Hygiene:** Dependencies checked (`alchemist`, `theme_tailor`, etc. are allowed).
    - **2.3 Directory Structure:** Target directory is `lib/src/molecules/`.
- **Component Design (Section 4):**
    - **4.1 Dumb Components:** Components will rely on `VoidCallback` and `ValueChanged` for interaction.
    - **4.2 Composition over Inheritance:** `AppSlider` and complex wrappers use composition.
- **Quality Assurance & Testing (Section 12):**
    - **12.1 Widgetbook:** Stories planned for `widgetbook/lib/molecules/`.
    - **12.2 Golden Tests:** Tests planned using `alchemist` in `test/molecules/`.

## Project Structure

### Documentation (this feature)

```text
specs/003-ui-kit-molecules/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output (Component APIs)
├── quickstart.md        # Phase 1 output (Usage Examples)
├── contracts/           # N/A for UI Kit
└── tasks.md             # Phase 2 output
```

### Source Code (repository root)

```text
lib/src/
├── atoms/      # Existing (AppSurface, etc.)
└── molecules/  # Target Directory
    ├── buttons/
    │   ├── app_button.dart
    │   └── app_icon_button.dart
    ├── inputs/
    │   └── app_text_field.dart
    ├── selection/
    │   ├── app_checkbox.dart
    │   ├── app_radio.dart
    │   └── app_slider.dart
    ├── status/
    │   ├── app_badge.dart
    │   ├── app_tag.dart
    │   └── app_avatar.dart
    └── navigation/
        └── app_navigation_bar.dart
```

**Structure Decision**: Organizing molecules by functional category (`buttons`, `inputs`, `selection`, `status`, `navigation`) to maintain cleanliness as the library grows, matching the Atomic Design principles.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | N/A | N/A |