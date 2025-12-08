# Implementation Plan: Theme Spec Consolidation

**Branch**: `021-spec-consolidation` | **Date**: 2025-12-08 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/021-spec-consolidation/spec.md`

## Summary

Refactor the `design_system/specs/` directory to extract shared base specs (AnimationSpec, StateColorSpec, OverlaySpec) with merge/override support. This consolidation reduces code duplication across 20+ spec files, unifies implementation patterns around `@TailorMixin`, and enables local style overrides at page/component level via `StyleOverride` InheritedWidget.

**Technical Approach**:
- Extract common property patterns into composable shared specs in `specs/shared/`
- Migrate all Equatable-based specs to `@TailorMixin` pattern (except foundational value objects)
- Merge BottomSheetStyle + SideSheetStyle into unified SheetStyle with direction discriminator
- Implement StyleOverride InheritedWidget for subtree-level overrides
- Add `withOverride()` methods to all shared specs for ergonomic local customization

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.13.0+
**Primary Dependencies**:
- Theming: `theme_tailor_annotation`, `theme_tailor`
- Code Generation: `build_runner`
- Equality: `equatable` (for value objects only)
- Testing: `alchemist`, `flutter_test`

**Storage**: N/A (UI library - no persistence)
**Testing**: `flutter test`, alchemist golden tests, Widgetbook manual verification
**Target Platform**: Flutter (iOS, Android, Web, Desktop)
**Project Type**: Single Dart package (UI library)
**Performance Goals**: Zero additional overhead for style resolution; maintain 60 FPS
**Constraints**:
- Zero breaking changes to public widget APIs
- All existing golden tests must pass without visual changes
- Generated code must compile without errors after refactoring

**Scale/Scope**:
- 20+ existing spec files to analyze
- 3 new shared specs to create (AnimationSpec, StateColorSpec, OverlaySpec)
- 2 styles to merge (BottomSheetStyle + SideSheetStyle)
- 1 new InheritedWidget (StyleOverride)
- ~10 spec files to migrate from Equatable to @TailorMixin
- **Phase 9 Addition**: 8 additional styles to refactor for AnimationSpec integration (including GaugeStyle)
- **Phase 9 Addition**: 1 additional style (ExpandableFabStyle) to refactor for OverlaySpec integration
- **Phase 9 Addition**: StateColorSpec extended with hover/pressed states
- **Phase 11-14 Addition**: NavigationStyle, StepperStyle, SkeletonStyle integration (P2)
- **Phase 14 Optional**: AppBarStyle, AppMenuStyle, DividerStyle, InputStyle, ToggleStyle migration (P3)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

✅ **PASS: Architectural Boundaries (Section 2)**
- All changes are within UI library scope ✓
- No forbidden dependencies introduced ✓
- Directory structure follows Atomic Design (`foundation/theme/design_system/specs/`) ✓

✅ **PASS: Core Principles (Section 3)**
- Inversion of Control (IoC): Components continue to ask Theme "How?" via specs ✓
- Data-Driven Strategy (DDS): Shared specs are data containers, no runtime type checks ✓
- Zero Internal Defaults: Shared specs require explicit values, no fallbacks ✓
- Configuration Injection: Override mechanism respects priority (local > theme) ✓

✅ **PASS: Theming & Styling (Section 4)**
- Single Source of Truth: AppDesignTheme remains entry point for all specs ✓
- Theme Tailor: `@TailorMixin` used for all new ThemeExtension specs ✓
- No hardcoded colors in new specs ✓

✅ **PASS: Component Design (Section 6)**
- Composition over Inheritance: Shared specs compose into component styles ✓
- No Runtime Checks: StyleOverride uses standard InheritedWidget pattern ✓

✅ **PASS: Quality Assurance (Section 13)**
- Existing golden tests will verify visual consistency ✓
- All components must update instantly when theme parameters change ✓

**No Constitution Violations Detected** - Plan is compliant with UI Kit Charter 3.0.0

### Animation Preset Alignment (Constitution 5.1)

AnimationSpec presets **intentionally map** to existing AppMotion tokens:

| AnimationSpec | AppMotion | Use Case |
|---------------|-----------|----------|
| `instant` (0ms) | `motion.instant` | Pixel theme instant snap |
| `fast` (150ms) | `motion.fast` | Quick micro-interactions |
| `standard` (300ms) | `motion.medium` | Standard animations |
| `slow` (500ms) | `motion.slow` | Glass theme fluid effects |

**Note**: Presets are for theme definition authors. Components still retrieve values from Theme, complying with Constitution 5.1.

## Project Structure

### Documentation (this feature)

```text
specs/021-spec-consolidation/
├── spec.md              # Feature specification
├── plan.md              # This file
├── research.md          # Phase 0: Design research & technology decisions
├── data-model.md        # Phase 1: Entity definitions, shared spec APIs
├── quickstart.md        # Phase 1: Setup guide and usage examples
├── contracts/           # Phase 1: API contracts
│   ├── shared_specs.md  # AnimationSpec, StateColorSpec, OverlaySpec APIs
│   ├── sheet_style.md   # Unified SheetStyle API
│   └── style_override.md # StyleOverride widget API
└── checklists/
    └── requirements.md   # Quality validation checklist
```

### Source Code (repository root)

Flutter UI Kit Single Package Structure:

```text
lib/src/foundation/theme/design_system/
├── specs/
│   ├── shared/                    # NEW: Shared base specs
│   │   ├── animation_spec.dart
│   │   ├── animation_spec.tailor.dart
│   │   ├── state_color_spec.dart
│   │   ├── state_color_spec.tailor.dart
│   │   ├── overlay_spec.dart
│   │   ├── overlay_spec.tailor.dart
│   │   └── shared_specs.dart      # Barrel export
│   │
│   ├── sheet_style.dart           # NEW: Merged from bottom_sheet + side_sheet
│   ├── sheet_style.tailor.dart
│   │
│   ├── bottom_sheet_style.dart    # DEPRECATED: Redirect to sheet_style
│   ├── side_sheet_style.dart      # DEPRECATED: Redirect to sheet_style
│   │
│   ├── tabs_style.dart            # MODIFY: Compose StateColorSpec
│   ├── stepper_style.dart         # MODIFY (Phase 12): AnimationSpec only (StateColorSpec skipped per 3-state pattern)
│   ├── carousel_style.dart        # MODIFY (Phase 9): Compose AnimationSpec, StateColorSpec
│   ├── expansion_panel_style.dart # MODIFY (Phase 9): Compose AnimationSpec
│   ├── breadcrumb_style.dart      # MODIFY: Compose StateColorSpec
│   ├── chip_group_style.dart      # MODIFY: Compose StateColorSpec
│   ├── slide_action_style.dart    # MODIFY (Phase 9): Compose AnimationSpec
│   ├── expandable_fab_style.dart  # MODIFY (Phase 9): Compose OverlaySpec
│   ├── table_style.dart           # MODIFY (Phase 9): Compose AnimationSpec
│   ├── topology_spec.dart         # MODIFY (Phase 9): LinkStyle compose AnimationSpec
│   ├── gauge_style.dart           # MODIFY (Phase 9): Compose AnimationSpec
│   │
│   ├── dialog_style.dart          # MIGRATE: Equatable → @TailorMixin
│   ├── toast_style.dart           # KEEP: Already @TailorMixin
│   ├── loader_style.dart          # KEEP: Already @TailorMixin
│   │
│   ├── navigation_style.dart      # MODIFY (Phase 11): Add @TailorMixin, AnimationSpec, StateColorSpec
│   ├── stepper_style.dart         # MODIFY (Phase 12): Replace Duration with AnimationSpec
│   ├── skeleton_style.dart        # MODIFY (Phase 13): Add @TailorMixin, AnimationSpec
│   │
│   ├── app_bar_style.dart         # OPTIONAL (Phase 14): Equatable → @TailorMixin
│   ├── app_menu_style.dart        # OPTIONAL (Phase 14): Equatable → @TailorMixin
│   ├── divider_style.dart         # OPTIONAL (Phase 14): Equatable → @TailorMixin
│   ├── input_style.dart           # OPTIONAL (Phase 14): Equatable → @TailorMixin
│   ├── toggle_style.dart          # OPTIONAL (Phase 14): Add @TailorMixin
│   │
│   ├── surface_style.dart         # KEEP: Equatable (foundational value object)
│   ├── interaction_spec.dart      # KEEP: Equatable (foundational value object)
│   └── ...
│
└── styles/
    ├── glass_design_theme.dart    # MODIFY: Update to use shared specs
    ├── brutal_design_theme.dart   # MODIFY: Update to use shared specs
    ├── flat_design_theme.dart     # MODIFY: Update to use shared specs
    ├── neumorphic_design_theme.dart # MODIFY: Update to use shared specs
    └── pixel_design_theme.dart    # MODIFY: Update to use shared specs

lib/src/foundation/
└── style_override.dart            # NEW: InheritedWidget for local overrides

test/foundation/
├── shared_specs_test.dart         # NEW: Unit tests for shared specs
├── sheet_style_test.dart          # NEW: Unit tests for merged style
└── style_override_test.dart       # NEW: Unit tests for override mechanism
```

**Structure Decision**: Single Dart package with shared specs in new `specs/shared/` subdirectory. Foundational value objects (SurfaceStyle, InteractionSpec) remain Equatable-based as they are composed into ThemeExtensions, not registered independently. All other component styles migrate to @TailorMixin pattern.

## Complexity Tracking

No Constitution violations identified - plan fully complies with UI Kit Charter 3.0.0 without requiring justification or workarounds.
