# Implementation Plan: Phase 4 - Interaction & Navigation

**Branch**: `015-interaction-navigation` | **Date**: 2025-12-04 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/015-interaction-navigation/spec.md`

## Summary

Implement 8 key navigation and interaction components (AppBottomSheet, AppDrawer/AppSideSheet, AppTabs, AppStepper, AppBreadcrumb, AppExpansionPanel, AppCarousel, AppChipGroup) for the Flutter UI Kit library. Each component will be theme-aware with support for all 5 visual languages (Glass, Brutal, Flat, Neumorphic, Pixel) and light/dark brightness modes. Components follow Atomic Design principles, use AppSurface for styling, and integrate with the theme_tailor code generation system for consistency.

**Technical Approach**:
- Implement components as dumb, composable widgets following the Slots Pattern
- Define theme specs with `@TailorMixin()` for each component in `lib/src/foundation/theme/design_system/specs/`
- Use Renderer Pattern for theme-specific visual variations (especially Pixel theme)
- Apply Data-Driven Strategy to eliminate runtime type checks
- Create comprehensive golden tests using alchemist matrix factory (4 themes × 2 brightness = 8 combinations per component)
- Add Widgetbook stories for each component with full interactivity demo

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.13.0+
**Primary Dependencies**:
- Theming: `theme_tailor_annotation`, `theme_tailor`
- Testing: `alchemist`, `flutter_test`
- Animation: `flutter_animate`
- Code Generation: `build_runner`, `flutter_gen_runner`
- SVG/Assets: `flutter_svg`, `flutter_portal`

**Storage**: N/A (UI library - no persistence)
**Testing**: `flutter test`, alchemist golden tests, Widgetbook manual verification
**Target Platform**: Flutter (iOS, Android, Web, Desktop via Flutter)
**Project Type**: Single Dart package (UI library)
**Performance Goals**: 60 FPS on mid-range devices, 100ms response to user input, smooth animations
**Constraints**:
- Components must comply with WCAG 2.1 AA accessibility standards
- Must support keyboard navigation and screen readers
- Zero overflow at 1.5x text scale (per Test Isolation Protocol)
- Must work seamlessly with existing UI Kit components

**Scale/Scope**:
- 8 new components
- 37 functional requirements
- 30+ acceptance scenarios
- 40+ golden test scenarios (8 components × 5+ scenarios each)
- 8 Widgetbook story files

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

✅ **PASS: Architectural Boundaries**
- All components are UI-only with zero business logic ✓
- No forbidden dependencies (bloc, provider, http, firebase) ✓
- All composition-based, follows AppSurface Primitive rule ✓

✅ **PASS: Component Design Principles**
- Inversion of Control (IoC): Components ask Theme "How?" not "Who?" ✓
- Data-Driven Strategy (DDS): Theme specs eliminate runtime type checks ✓
- Composition over Inheritance: Using Slots Pattern for component configuration ✓

✅ **PASS: Theming & Styling**
- All components use AppDesignTheme as single source of truth ✓
- Token-first approach (no hardcoded colors) ✓
- Using @TailorMixin for automated theme generation ✓

✅ **PASS: Testing & Quality**
- Golden test matrix planned (4 themes × 2 brightness) ✓
- Widgetbook stories for all components ✓
- Test Isolation Protocol compliance (explicit constraints, backgrounds, animation freezing) ✓

✅ **PASS: Accessibility & i18n**
- No hardcoded strings planned ✓
- Touch targets ≥ 48x48 dp ✓
- Semantic widgets with proper labels planned ✓

**No Constitution Violations Detected** - Plan is compliant with UI Kit Charter 2.0.0

## Project Structure

### Documentation (this feature)

```text
specs/015-interaction-navigation/
├── spec.md              # Feature specification
├── plan.md              # This file
├── research.md          # Phase 0: Design research & technology decisions
├── data-model.md        # Phase 1: Entity definitions, state models, component props
├── quickstart.md        # Phase 1: Setup guide and usage examples
├── contracts/           # Phase 1: Component API contracts (Dart type definitions)
│   ├── bottom_sheet_contract.md
│   ├── side_sheet_contract.md
│   ├── tabs_contract.md
│   ├── stepper_contract.md
│   ├── breadcrumb_contract.md
│   ├── expansion_panel_contract.md
│   ├── carousel_contract.md
│   └── chip_group_contract.md
├── checklists/
│   └── requirements.md   # Quality validation checklist
└── tasks.md             # Phase 2 output (/speckit.tasks - NOT created by /speckit.plan)
```

### Source Code (repository root)

Flutter UI Kit Single Package Structure:

```text
lib/src/
├── foundation/
│   └── theme/
│       └── design_system/
│           ├── specs/
│           │   ├── bottom_sheet_style.dart (NEW)
│           │   ├── side_sheet_style.dart (NEW)
│           │   ├── tabs_style.dart (NEW)
│           │   ├── stepper_style.dart (NEW)
│           │   ├── breadcrumb_style.dart (NEW)
│           │   ├── expansion_panel_style.dart (NEW)
│           │   ├── carousel_style.dart (NEW)
│           │   └── chip_group_style.dart (NEW)
│           └── styles/
│               ├── glass_design_theme.dart (MODIFY)
│               ├── brutal_design_theme.dart (MODIFY)
│               ├── flat_design_theme.dart (MODIFY)
│               ├── neumorphic_design_theme.dart (MODIFY)
│               └── pixel_design_theme.dart (MODIFY)
│
├── molecules/
│   ├── bottom_sheet/ (NEW)
│   │   ├── app_bottom_sheet.dart
│   │   └── bottom_sheet_state.dart
│   ├── side_sheet/ (NEW)
│   │   ├── app_side_sheet.dart
│   │   └── app_drawer.dart
│   ├── tabs/ (NEW)
│   │   ├── app_tabs.dart
│   │   ├── tab_bar.dart
│   │   └── tab_content.dart
│   ├── stepper/ (NEW)
│   │   ├── app_stepper.dart
│   │   ├── step_indicator.dart
│   │   └── stepper_renderer.dart
│   ├── breadcrumb/ (NEW)
│   │   ├── app_breadcrumb.dart
│   │   └── breadcrumb_renderer.dart
│   ├── expansion_panel/ (NEW)
│   │   ├── app_expansion_panel.dart
│   │   └── expansion_item.dart
│   ├── carousel/ (NEW)
│   │   ├── app_carousel.dart
│   │   ├── carousel_nav_buttons.dart
│   │   └── carousel_renderer.dart
│   └── chip_group/ (NEW)
│       ├── app_chip_group.dart
│       ├── app_chip.dart
│       └── chip_renderer.dart
│
└── widgetbook/lib/stories/
    ├── bottom_sheet_story.dart (NEW)
    ├── side_sheet_story.dart (NEW)
    ├── tabs_story.dart (NEW)
    ├── stepper_story.dart (NEW)
    ├── breadcrumb_story.dart (NEW)
    ├── expansion_panel_story.dart (NEW)
    ├── carousel_story.dart (NEW)
    └── chip_group_story.dart (NEW)

test/
├── molecules/
│   ├── bottom_sheet_test.dart (NEW)
│   ├── bottom_sheet_golden_test.dart (NEW)
│   ├── side_sheet_test.dart (NEW)
│   ├── side_sheet_golden_test.dart (NEW)
│   ├── tabs_test.dart (NEW)
│   ├── tabs_golden_test.dart (NEW)
│   ├── stepper_test.dart (NEW)
│   ├── stepper_golden_test.dart (NEW)
│   ├── breadcrumb_test.dart (NEW)
│   ├── breadcrumb_golden_test.dart (NEW)
│   ├── expansion_panel_test.dart (NEW)
│   ├── expansion_panel_golden_test.dart (NEW)
│   ├── carousel_test.dart (NEW)
│   ├── carousel_golden_test.dart (NEW)
│   ├── chip_group_test.dart (NEW)
│   └── chip_group_golden_test.dart (NEW)
└── goldens/ (NEW)
    ├── molecules/
    │   ├── bottom_sheet_*.png
    │   ├── side_sheet_*.png
    │   ├── tabs_*.png
    │   ├── stepper_*.png
    │   ├── breadcrumb_*.png
    │   ├── expansion_panel_*.png
    │   ├── carousel_*.png
    │   └── chip_group_*.png
```

**Structure Decision**: Single Dart package with Atomic Design hierarchy. Each component is a separate module in `lib/src/molecules/` with corresponding theme specs in `lib/src/foundation/theme/design_system/specs/`. Testing follows existing pattern with unit tests, golden tests, and Widgetbook stories. No complexity violations.

## Complexity Tracking

No Constitution violations identified - plan fully complies with UI Kit Charter 2.0.0 without requiring justification or workarounds.
