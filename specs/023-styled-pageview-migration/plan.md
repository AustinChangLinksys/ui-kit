# Implementation Plan: StyledPageView Migration to UI Kit

**Branch**: `023-styled-pageview-migration` | **Date**: 2025-12-10 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/023-styled-pageview-migration/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Complete 4-phase migration strategy to replace PrivacyGUI's StyledAppPageView with enhanced UI Kit AppPageView while maintaining 100% API compatibility. The strategy includes experimental testing approach with AppBar integration, bottom bar system, responsive menu system, tabs support, and Sliver mode enhancements, followed by production-ready UiKitPageView implementation with native PrivacyGUI integration and complete cleanup of experimental components.

## Technical Context

**Language/Version**: Dart 3.x / Flutter 3.13.0+
**Primary Dependencies**: flutter, theme_tailor_annotation, equatable, flutter_animate, alchemist (testing), flutter_gen, flutter_portal
**Storage**: N/A (UI library - no persistence required)
**Testing**: flutter test, golden tests with alchemist, widget tests, integration tests
**Target Platform**: Flutter multi-platform (iOS, Android, Web, Desktop)
**Project Type**: mobile/cross-platform library - UI Kit package structure
**Performance Goals**: Equivalent render time and memory usage compared to baseline StyledAppPageView, 60 FPS on mid-range devices
**Constraints**: 100% API compatibility requirement, native PrivacyGUI integration without adapters, clean production architecture
**Scale/Scope**: 8+ complex page components, 4 migration phases, 22 functional requirements, affects both UI Kit and PrivacyGUI projects

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Core Architectural Principles ✅

- **Inversion of Control (IoC)**: Enhanced AppPageView will receive styling from Theme, not make style decisions internally
- **Data-Driven Strategy (DDS)**: Components will render based on configuration specs (PageAppBarConfig, PageBottomBarConfig, PageMenuConfig) rather than conditional logic
- **Zero Internal Defaults**: All styling must come from theme specs; no hardcoded fallback values for visual properties
- **Configuration Injection**: Theme system supports both seed-based generation and explicit overrides

### Component Design Compliance ✅

- **AppSurface Usage**: All new visual containers must use AppSurface rather than direct Container+BoxDecoration
- **Dumb Components**: Page components receive configuration via constructor, pass events via callbacks
- **Composition Pattern**: Uses slots pattern (child, leading, trailing, actions)
- **Equatable Integration**: All configuration models must extend Equatable per UI Kit charter

### Theme Integration Requirements ✅

- **Theme Tailor**: Must use @TailorMixin for all new ThemeExtension classes
- **Semantic Colors**: Must use AppColorScheme properties, not hardcoded colors
- **Shared Specs**: Must compose AnimationSpec, StateColorSpec, OverlaySpec instead of duplicating properties
- **Typography System**: Must use appTextTheme tokens, not hardcoded TextStyle

### Responsive Architecture ✅

- **Layout System**: Must use context.isDesktop for responsive decisions, not column count
- **Breakpoint Strategy**: Desktop (>1200px), Tablet (600-1200px), Mobile (<600px)
- **No Global State**: Use LayoutBuilder/MediaQuery, never singletons

### Testing & Quality ✅

- **Golden Tests**: Must implement full test matrix (4 themes × 2 brightness modes)
- **Safe Mode Protocol**: Fixed-size containers, background visibility, animation freezing
- **Widgetbook Integration**: All new components require .stories.dart files

**GATE STATUS: PASSED** - All constitutional requirements can be satisfied by the proposed architecture.

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

This is a cross-project feature affecting both UI Kit library and PrivacyGUI application:

```text
# UI Kit Library (Main Project)
lib/src/
├── foundation/
│   └── theme/
│       └── design_system/
│           └── specs/
│               ├── page_style.dart           # New: Page layout theme spec
│               ├── app_bar_style.dart        # New: AppBar theme spec
│               └── bottom_bar_style.dart     # New: Bottom bar theme spec
├── layout/
│   ├── app_page_view.dart                    # Enhanced: Add new configurations
│   └── models/
│       ├── page_app_bar_config.dart          # New: AppBar configuration model
│       ├── page_bottom_bar_config.dart       # New: Bottom bar configuration model
│       ├── page_menu_config.dart             # New: Menu configuration model
│       └── page_menu_item.dart               # New: Menu item model
└── molecules/
    └── layout/
        ├── responsive_menu_handler.dart      # New: Responsive menu component
        └── page_bottom_bar.dart              # New: Bottom action bar component

test/
├── layout/
│   ├── app_page_view_golden_test.dart        # Enhanced: Test new configurations
│   └── models/
│       └── page_config_models_test.dart      # New: Model unit tests
└── molecules/
    └── layout/
        └── responsive_menu_handler_golden_test.dart  # New: Component tests

widgetbook/lib/stories/
├── layout/
│   └── app_page_view.stories.dart            # Enhanced: Show new features
└── molecules/
    └── layout/
        └── responsive_menu_handler.stories.dart     # New: Menu component stories

# PrivacyGUI Application (Secondary Project)
../belkin/privacyGUI/PrivacyGUI/lib/page/
├── components/
│   ├── experimental/
│   │   ├── experimental_ui_kit_page_view.dart    # Temporary: API-compatible wrapper (Phase 2)
│   │   ├── ui_kit_adapters.dart                  # Temporary: Parameter conversion logic (Phase 2)
│   │   └── privacy_gui_wrappers.dart             # Temporary: Domain-specific wrappers (Phase 2)
│   └── ui_kit_page_view.dart                     # New: Production UiKitPageView (Phase 3)
└── foundation/
    └── theme/
        └── design_system/
            └── specs/
                ├── privacy_gui_page_style.dart   # New: PrivacyGUI page theme spec (Phase 3)
                ├── connection_state_style.dart   # New: Connection state theme spec (Phase 3)
                └── banner_style.dart             # New: Banner notification theme spec (Phase 3)
```

**Structure Decision**: This is a dual-repository feature requiring coordinated development across UI Kit (primary) and PrivacyGUI (secondary) projects. The UI Kit receives enhanced capabilities while PrivacyGUI gets experimental integration components for safe migration testing (Phase 2), followed by production UiKitPageView with native PrivacyGUI integration and theme specifications (Phase 3), and complete cleanup of experimental components (Phase 4).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

**No constitutional violations identified** - This feature fully complies with UI Kit charter requirements and architectural principles.

## Phase 0: Research Complete ✅

**Research Analysis**: [research.md](research.md) - 10 architectural decision records covering data models, responsive strategy, theme integration, API compatibility, menu architecture, state management isolation, testing approach, Sliver enhancements, feature flags, and performance optimization.

**Key Technical Decisions**:
- Equatable-based configuration models following UI Kit charter
- `context.isDesktop` responsive layout strategy (not column count)
- @TailorMixin theme integration with shared spec composition
- 100% API compatibility adapter layer for safe migration
- Dual-mode responsive menu system (desktop sidebar, mobile modal)
- Hierarchical feature flag system with automatic fallback
- Performance parity requirement with baseline implementation

## Phase 1: Design Complete ✅

**Data Models**: [data-model.md](data-model.md) - Complete entity design with PageAppBarConfig, PageBottomBarConfig, PageMenuConfig, PageMenuItem, and theme integration models. Includes enhanced AppPageView API, PrivacyGUI adapter models, and testing validation structures.

**Developer Guide**: [quickstart.md](quickstart.md) - Copy-paste examples covering basic usage patterns, advanced multi-feature pages, factory constructor shortcuts, theme customization, and migration helpers from StyledAppPageView.

**API Contracts**: [contracts/component_apis.md](contracts/component_apis.md) - Formal interface specifications for AppPageView, configuration models, experimental adapter APIs, and testing contracts with comprehensive error handling requirements.

**Theme Contracts**: [contracts/theme_contracts.md](contracts/theme_contracts.md) - Theme integration specifications covering PageLayoutStyle, AppBarStyle, BottomBarStyle, MenuStyle with complete implementation requirements for all 5 visual languages (Glass, Pixel, Brutal, Neumorphic, Flat).

## Phase 2: Implementation Ready

**Next Steps**:
1. Generate actionable tasks using `/speckit.tasks` command
2. Begin UI Kit AppPageView enhancement implementation
3. Create comprehensive test coverage for new features
4. Implement PrivacyGUI experimental adapter layer (temporary)
5. Create production UiKitPageView with native PrivacyGUI integration
6. Implement PrivacyGUI theme specifications using @TailorMixin
7. Systematically migrate all StyledPageView usage to production UiKitPageView
8. Clean up all experimental components and adapters

**Architecture Foundation**: All design artifacts completed and validated against UI Kit constitutional requirements. Implementation can proceed with confidence in architectural decisions and component contracts. The experimental components serve as validation prototypes and will be completely removed after production implementation.
