# Implementation Plan: Unified Button System Architecture

**Branch**: `022-button-system-unified` | **Date**: 2025-12-09 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/022-button-system-unified/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Unify the button system architecture by consolidating ButtonStyle, IconButtonStyle, and TextButtonStyle into a single ButtonStyle system with StateColorSpec integration. Add 18 named constructors for common button patterns, support three style variants (filled/outline/text), and maintain 100% backward compatibility across all 5 existing themes.

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x
**Primary Dependencies**: flutter, theme_tailor_annotation, equatable, flutter_animate, alchemist (testing)
**Storage**: N/A (UI library, no persistence)
**Testing**: flutter test, alchemist for golden tests, widgetbook for visual testing
**Target Platform**: Flutter (iOS, Android, Web, Desktop)
**Project Type**: UI component library
**Performance Goals**: Zero performance regression, theme switching <100ms
**Constraints**: 100% backward compatibility, zero visual pixel differences for equivalent configurations
**Scale/Scope**: 18 named constructors across 2 button classes, 5 theme implementations, ~50 test scenarios

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Section 2: Architectural Boundaries
✅ **PASS**: Feature maintains library independence as UI-only changes
✅ **PASS**: No forbidden dependencies added (uses existing theme_tailor_annotation, flutter)
✅ **PASS**: Follows atomic design structure in src/molecules/buttons/

### Section 3: Core Principles
✅ **PASS**: Maintains Inversion of Control - buttons ask theme for styling
✅ **PASS**: Uses Data-Driven Strategy - ButtonStyle contains variant-specific data
✅ **PASS**: Zero Internal Defaults - relies on theme system for all styling
✅ **PASS**: Configuration Injection - ButtonStyle integrates with @TailorMixin

### Section 4: Theming & Styling
✅ **PASS**: Uses AppDesignTheme as single source of truth
✅ **PASS**: Integrates with existing StateColorSpec for state management
✅ **PASS**: Composes shared specs (StateColorSpec, AnimationSpec)
✅ **PASS**: @TailorMixin used for theme generation

### Section 6: Component Design
✅ **PASS**: Buttons already compose AppSurface as required
✅ **PASS**: Maintains dumb component pattern (data via constructor, events via callback)
✅ **PASS**: Uses composition over inheritance with existing patterns

### Section 13: Quality Assurance
✅ **PASS**: Will maintain Widgetbook stories for all button variants
✅ **PASS**: Will update golden tests for all theme combinations
✅ **PASS**: Feature enhances theme editor integration (better IoC compliance)

**GATE RESULT: ✅ APPROVED - No violations detected. Feature aligns with all constitutional requirements.**

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
lib/src/foundation/theme/design_system/specs/
├── button_style.dart                    # Unified ButtonStyle (NEW)
├── shared/
│   └── state_color_spec.dart           # Existing StateColorSpec (UPDATED)

lib/src/molecules/buttons/
├── app_button.dart                      # Enhanced with named constructors
├── app_icon_button.dart                # Enhanced with named constructors
└── enums/                              # NEW directory
    ├── button_style_variant.dart       # filled/outline/text enum
    └── app_button_icon_position.dart   # leading/trailing enum

lib/src/foundation/theme/design_system/styles/
├── glass_design_theme.dart             # Updated to use unified ButtonStyle
├── brutal_design_theme.dart            # Updated to use unified ButtonStyle
├── flat_design_theme.dart              # Updated to use unified ButtonStyle
├── neumorphic_design_theme.dart        # Updated to use unified ButtonStyle
└── pixel_design_theme.dart             # Updated to use unified ButtonStyle

test/molecules/buttons/
├── app_button_golden_test.dart         # Updated for new variants
├── app_icon_button_golden_test.dart    # Updated for new variants
├── button_style_test.dart              # NEW - unit tests for ButtonStyle
└── named_constructors_test.dart        # NEW - tests for all named constructors

widgetbook/lib/stories/molecules/buttons/
├── app_button.stories.dart             # Updated with named constructor examples
└── app_icon_button.stories.dart        # Updated with named constructor examples
```

**Structure Decision**: Flutter UI component library structure with atomic design organization. Primary changes focus on molecules/buttons with foundation-level style system updates. All existing paths are preserved to maintain backward compatibility.

## Complexity Tracking

*No constitutional violations detected. This section is omitted.*
