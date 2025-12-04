# Implementation Plan: Phase 2 UI Kit Components

**Branch**: `011-phase2-components` | **Date**: 2025-12-04 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/011-phase2-components/spec.md`

## Summary

Implement Phase 2 UI Kit components (AppBar, SliverAppBar, PopupMenu, Dialog) following the established Atomic Design architecture. Components must automatically adapt their visual appearance based on active design style (Flat, Glass, Pixel) through the existing theme system, using `AppSurface` for rendering and theme-driven specs for style differentiation.

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.x
**Primary Dependencies**: flutter, theme_tailor_annotation, equatable, flutter_animate, alchemist (testing)
**Storage**: N/A (UI library, no persistence)
**Testing**: flutter_test + alchemist for golden tests, buildThemeMatrix for 8-style coverage (4 themes × 2 modes)
**Target Platform**: iOS, Android, Web (Flutter multi-platform)
**Project Type**: Flutter package (UI component library)
**Performance Goals**: 60fps animations, no BackdropFilter in Flat style
**Constraints**: WCAG AA contrast ratios, 48x48dp minimum touch targets
**Scale/Scope**: 4 new components, 3 styles x 2 modes = 6 visual combinations per component

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Requirement | Status | Notes |
|-----------|-------------|--------|-------|
| **2.1 Physical Isolation** | Library exists as independent Dart Package | PASS | Existing package structure maintained |
| **2.2 Dependency Hygiene** | No bloc/provider/http/dio | PASS | UI-only components |
| **2.3 Directory Structure** | Atomic Design (foundation/atoms/molecules/organisms) | PASS | AppBar/Dialog in organisms/, Menu in molecules/ |
| **3.1 IoC** | Components ask "How" not "Who" | PASS | Use theme specs, no runtimeType checks |
| **3.2 DDS** | Spec over Logic, no if/else for styles | PASS | New style specs for AppBar/Menu/Dialog |
| **4.1 AppDesignTheme Contract** | Single Source of Truth for visuals | PASS | Extend AppDesignTheme with new specs |
| **4.2 Token-First** | No hardcoded colors | PASS | All colors from ColorScheme |
| **4.4 Theme Tailor** | Use @TailorMixin for ThemeExtension | PASS | Will regenerate after adding specs |
| **5.1 AppSurface Primitive** | All containers compose AppSurface | PASS | All components use AppSurface |
| **5.2 Dumb Components** | Constructor data, Callback events | PASS | No business state in components |
| **5.3 Composition over Inheritance** | Use Slots Pattern | PASS | child/content/actions slots |
| **6.1 Component Expansion** | No runtime type checks | PASS | Style via specs only |
| **6.2 Style Expansion** | Zero-Touch Policy | PASS | New styles don't modify components |
| **10.1 A11y** | Semantics + 48x48dp touch targets | PASS | FR-010, FR-017 address this |
| **10.2 i18n** | No hardcoded strings | PASS | All labels passed externally |
| **12.1 Widgetbook** | UseCases for all components | PASS | Widgetbook stories required |
| **12.2 Golden Tests** | Test Matrix + Safe Mode Protocol | PASS | buildThemeMatrix for 8-style coverage |

**Gate Result**: PASS - All constitution requirements met.

## Project Structure

### Documentation (this feature)

```text
specs/011-phase2-components/
├── spec.md              # Feature specification
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output (widget API contracts)
└── tasks.md             # Phase 2 output (/speckit.tasks command)
```

### Source Code (repository root)

```text
lib/src/
├── foundation/
│   └── theme/
│       └── design_system/
│           ├── specs/
│           │   ├── app_bar_style.dart           # NEW: AppBar style spec
│           │   ├── menu_style.dart              # NEW: PopupMenu style spec
│           │   └── dialog_style.dart            # NEW: Dialog style spec
│           ├── styles/
│           │   ├── flat_design_theme.dart       # UPDATE: Add new specs
│           │   ├── glass_design_theme.dart      # UPDATE: Add new specs
│           │   └── pixel_design_theme.dart      # UPDATE: Add new specs
│           └── app_design_theme.dart            # UPDATE: Add new spec fields
├── molecules/
│   └── menu/
│       ├── app_popup_menu.dart                  # NEW: PopupMenu component
│       └── app_popup_menu_item.dart             # NEW: MenuItem data class
├── organisms/
│   ├── app_bar/
│   │   ├── app_unified_bar.dart                 # NEW: Standard AppBar
│   │   └── app_unified_sliver_bar.dart          # NEW: Sliver AppBar
│   └── dialog/
│       └── app_dialog.dart                      # UPDATE: Enhance existing

widgetbook/lib/
└── stories/
    ├── organisms/
    │   ├── app_bar_story.dart                   # NEW: AppBar widgetbook
    │   └── dialog_story.dart                    # NEW/UPDATE: Dialog widgetbook
    └── molecules/
        └── menu_story.dart                      # NEW: Menu widgetbook

test/
├── organisms/
│   ├── app_bar/
│   │   ├── app_unified_bar_golden_test.dart         # NEW
│   │   └── app_unified_sliver_bar_golden_test.dart  # NEW
│   └── dialog/
│       └── app_dialog_golden_test.dart          # NEW/UPDATE
└── molecules/
    └── menu/
        └── app_popup_menu_golden_test.dart      # NEW
```

**Structure Decision**: Following existing Atomic Design structure. AppBar and Dialog are organisms (complex, standalone sections). PopupMenu is a molecule (semantic combination of atoms). All components use existing `AppSurface` atom for rendering.

## Complexity Tracking

> No constitution violations requiring justification. Design follows established patterns.

| Aspect | Decision | Rationale |
|--------|----------|-----------|
| Naming | `AppUnifiedBar`/`AppUnifiedSliverBar` for AppBar (avoids Flutter native conflict), `App` prefix for others (AppDialog, AppPopupMenu) | Balances codebase convention with avoiding Flutter's native AppBar naming collision |
| Dialog enhancement | Update existing vs new | Existing `AppDialog` is minimal; enhance rather than replace |
| Style specs | 3 new spec classes | AppBarStyle, MenuStyle, DialogStyle for DDS compliance |
