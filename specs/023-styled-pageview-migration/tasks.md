# Tasks: StyledPageView Migration to UI Kit

**Input**: Design documents from `/specs/023-styled-pageview-migration/`
**Prerequisites**: plan.md (complete), spec.md (complete), research.md (complete), data-model.md (complete), contracts/ (complete)

**Tests**: Golden tests and integration tests included as specified in the UI Kit charter requirements.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3, US4)
- Include exact file paths in descriptions

## Path Conventions

This is a cross-project feature affecting:
- **UI Kit Library**: `lib/src/`, `test/`, `widgetbook/lib/stories/` at repository root
- **PrivacyGUI Application**: `../belkin/privacyGUI/PrivacyGUI/lib/page/`

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and directory structure for dual-repository feature

- [x] T001 Create theme specs directory structure in lib/src/foundation/theme/design_system/specs/
- [x] T002 [P] Create UI Kit component directories for molecules/layout/
- [x] T003 [P] Create UI Kit model directories for layout/models/
- [x] T004 [P] Create test directories for all new components
- [x] T005 [P] Create Widgetbook stories directories for navigation components
- [x] T006 [P] Create PrivacyGUI experimental component directories
- [x] T007 [P] Verify build_runner configuration for @TailorMixin code generation
- [x] T008 [P] Verify alchemist golden test configuration for theme matrix testing

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core theme system and shared models that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T009 Create shared specs directory structure in lib/src/foundation/theme/design_system/specs/shared/
- [x] T010 [P] Create AnimationSpec shared model in lib/src/foundation/theme/design_system/specs/shared/animation_spec.dart
- [x] T011 [P] Create StateColorSpec shared model in lib/src/foundation/theme/design_system/specs/shared/state_color_spec.dart
- [x] T012 [P] Create OverlaySpec shared model in lib/src/foundation/theme/design_system/specs/shared/overlay_spec.dart
- [x] T013 Update AppDesignTheme to include new page layout theme extensions in lib/src/foundation/theme/app_design_theme.dart
- [x] T014 [P] Create test utilities for theme matrix testing in test/test_utils/theme_matrix_builder.dart
- [x] T015 Run dart run build_runner build to generate initial theme extension code

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Enhanced Page Components (Priority: P1) 🎯 MVP

**Goal**: UI Kit developers can create modern application interfaces with AppBars, bottom action bars, responsive menus, and tabbed navigation

**Independent Test**: Create sample pages with all new features in Widgetbook and verify responsive behavior across desktop/mobile viewports

### Golden Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T016 [P] [US1] Create golden test for PageAppBarConfig model variations in test/layout/models/page_app_bar_config_golden_test.dart
- [x] T017 [P] [US1] Create golden test for PageBottomBarConfig model variations in test/layout/models/page_bottom_bar_config_golden_test.dart
- [x] T018 [P] [US1] Create golden test for PageMenuConfig model variations in test/layout/models/page_menu_config_golden_test.dart
- [x] T019 [P] [US1] Create golden test for enhanced AppPageView in test/layout/app_page_view_golden_test.dart
- [x] T020 [P] [US1] Create golden test for ResponsiveMenuHandler component in test/molecules/layout/responsive_menu_handler_golden_test.dart

### Configuration Models for User Story 1

- [x] T021 [P] [US1] Create PageAppBarConfig model with Equatable in lib/src/layout/models/page_app_bar_config.dart
- [x] T022 [P] [US1] Create PageBottomBarConfig model with Equatable in lib/src/layout/models/page_bottom_bar_config.dart
- [x] T023 [P] [US1] Create PageMenuConfig model with Equatable in lib/src/layout/models/page_menu_config.dart
- [x] T024 [P] [US1] Create PageMenuItem model with Equatable in lib/src/layout/models/page_menu_item.dart
- [x] T025 [US1] Create MenuPosition enum and factory constructors in lib/src/layout/models/page_menu_item.dart

### Theme Specifications for User Story 1

- [x] T026 [P] [US1] Create PageLayoutStyle with @TailorMixin in lib/src/foundation/theme/design_system/specs/page_layout_style.dart
- [x] T027 [P] [US1] Create AppBarStyle with @TailorMixin in lib/src/foundation/theme/design_system/specs/app_bar_style.dart
- [x] T028 [P] [US1] Create BottomBarStyle with @TailorMixin in lib/src/foundation/theme/design_system/specs/bottom_bar_style.dart
- [x] T029 [P] [US1] Create MenuStyle with @TailorMixin in lib/src/foundation/theme/design_system/specs/menu_style.dart
- [x] T030 [US1] Run dart run build_runner build to generate theme extension code for new specs

### Component Implementation for User Story 1

- [x] T031 [US1] Enhance AppPageView with new configuration properties in lib/src/layout/app_page_view.dart
- [x] T032 [P] [US1] Create ResponsiveMenuHandler component in lib/src/molecules/layout/responsive_menu_handler.dart
- [x] T033 [P] [US1] Create PageBottomBar component in lib/src/molecules/layout/page_bottom_bar.dart
- [x] T034 [US1] Add AppBar integration logic to AppPageView with theme styling
- [x] T035 [US1] Add bottom action bar integration logic to AppPageView with safe area handling
- [x] T036 [US1] Add responsive menu integration logic to AppPageView using context.isDesktop
- [x] T037 [US1] Add tabbed navigation support to AppPageView with SliverPersistentHeader

### Theme Integration for User Story 1

- [x] T038 [P] [US1] Implement Glass theme variations for all new page styles in lib/src/foundation/theme/design_system/styles/glass_design_theme.dart
- [x] T039 [P] [US1] Implement Brutal theme variations for all new page styles in lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart
- [x] T040 [P] [US1] Implement Flat theme variations for all new page styles in lib/src/foundation/theme/design_system/styles/flat_design_theme.dart
- [x] T041 [P] [US1] Implement Neumorphic theme variations for all new page styles in lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart
- [x] T042 [P] [US1] Implement Pixel theme variations for all new page styles in lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart
- [x] T043 [US1] Update main theme integration in lib/src/foundation/theme/app_design_theme.dart

### Factory Constructors and API Sugar for User Story 1

- [x] T044 [P] [US1] Add AppPageView.basic factory constructor with quickstart examples
- [x] T045 [P] [US1] Add AppPageView.withBottomBar factory constructor with action configuration
- [x] T046 [P] [US1] Add AppPageView.withMenu factory constructor with responsive menu
- [x] T047 [P] [US1] Add AppPageView.withTabs factory constructor with tab navigation
- [x] T048.1 [P] [US1] Add PageFabConfig model with FAB configuration support in lib/src/layout/models/page_fab_config.dart
- [x] T048.2 [P] [US1] Add AppPageView.withFAB factory constructor with standard/mini FAB support
- [x] T048.3 [P] [US1] Add AppPageView.withExpandableFAB factory constructor with AppExpandableFab integration
- [x] T048.4 [P] [US1] Add FAB configuration to main AppPageView constructor with backward compatibility
- [x] T048.5 [P] [US1] Export PageFabConfig in main ui_kit.dart library
- [ ] T045.5 [P] [US1] Export GenUiChatView component for FR-009 requirement in main ui_kit.dart library

### Widgetbook Stories for User Story 1

- [x] T048 [P] [US1] Create AppPageView enhanced stories in widgetbook/lib/stories/layout/app_page_view.stories.dart (including FAB stories)
- [x] T049 [P] [US1] Create ResponsiveMenuHandler stories - integrated in AppPageView stories demonstrating menuConfig functionality
- [x] T050 [P] [US1] Create PageBottomBar stories - integrated in AppPageView stories demonstrating bottomBarConfig functionality
- [x] T051 [US1] Update widgetbook navigation structure to include new component stories

**Checkpoint**: At this point, enhanced UI Kit AppPageView should be fully functional with all new features and testable independently through Widgetbook

---

## Phase 4: User Story 2 - API Compatibility Layer (Priority: P2)

**Goal**: PrivacyGUI developers have a drop-in replacement for StyledAppPageView with 100% API compatibility

**Independent Test**: Replace existing StyledAppPageView with ExperimentalUiKitPageView and verify identical visual and functional behavior

### Integration Tests for User Story 2

- [ ] T052 [P] [US2] Create compatibility test suite in ../belkin/privacyGUI/PrivacyGUI/test/page/components/experimental/compatibility_test.dart
- [ ] T053 [P] [US2] Create parameter conversion test suite in ../belkin/privacyGUI/PrivacyGUI/test/page/components/experimental/adapter_test.dart

### Parameter Conversion Logic for User Story 2

- [ ] T054 [P] [US2] Create UiKitPageViewAdapter with AppBar conversion in ../belkin/privacyGUI/PrivacyGUI/lib/page/components/experimental/ui_kit_adapters.dart
- [ ] T055 [P] [US2] Add bottom bar parameter conversion to UiKitPageViewAdapter
- [ ] T056 [P] [US2] Add menu system parameter conversion to UiKitPageViewAdapter
- [ ] T057 [P] [US2] Add tab navigation parameter conversion to UiKitPageViewAdapter
- [ ] T058 [US2] Add edge case handling for malformed parameters in UiKitPageViewAdapter

### PrivacyGUI Domain Logic Wrappers for User Story 2

- [ ] T059 [P] [US2] Create PrivacyGUI connection state wrapper in ../belkin/privacyGUI/PrivacyGUI/lib/page/components/experimental/privacy_gui_wrappers.dart
- [ ] T060 [P] [US2] Create PrivacyGUI banner handling wrapper in privacy_gui_wrappers.dart
- [ ] T061 [P] [US2] Create PrivacyGUI scroll listener wrapper with menu controller integration
- [ ] T062 [P] [US2] Create PrivacyGUI localization wrapper for button labels
- [ ] T063 [US2] Create PrivacyGUI route navigation wrapper with context.pop integration

### Experimental Component Implementation for User Story 2

- [ ] T064 [US2] Create ExperimentalUiKitPageView with complete StyledAppPageView API in ../belkin/privacyGUI/PrivacyGUI/lib/page/components/experimental/experimental_ui_kit_page_view.dart
- [ ] T065 [US2] Add ExperimentalUiKitPageView.innerPage factory constructor with parameter mapping
- [ ] T066 [US2] Add ExperimentalUiKitPageView.withSliver factory constructor with Sliver support
- [ ] T067 [US2] Integrate all domain-specific wrappers into ExperimentalUiKitPageView
- [ ] T068 [US2] Add comprehensive error handling and fallback logic to experimental component

**Checkpoint**: At this point, ExperimentalUiKitPageView should work as exact drop-in replacement for StyledAppPageView

---

## Phase 5: Production UiKitPageView - Complete StyledPageView Replacement (Priority: P1) 🎯

**Goal**: Replace ExperimentalUiKitPageView with a production-ready, clean architecture that completely replaces StyledPageView

**Philosophy**: No more adapters, wrappers, or experimental code. This is the final, production-ready implementation with native PrivacyGUI integration.

### Core Architecture Redesign

- [ ] T069 [US5] Create enhanced UiKitPageView with native PrivacyGUI support in ../belkin/privacyGUI/PrivacyGUI/lib/page/components/ui_kit_page_view.dart
- [ ] ~~T070 [P] [US5] Create PrivacyGuiPageStyle with @TailorMixin~~ **Future Phase**: PrivacyGUI will use UI Kit's existing theme system directly
- [ ] ~~T071 [P] [US5] Create ConnectionStateStyle with @TailorMixin~~ **Future Phase**: Connection state styling handled via UI Kit themes
- [ ] ~~T072 [P] [US5] Create BannerStyle with @TailorMixin~~ **Future Phase**: Banner styling handled via UI Kit themes
- [ ] ~~T073 [US5] Run dart run build_runner build~~ **Not needed**: No PrivacyGUI-specific theme extensions required

### Native PrivacyGUI Integration

- [ ] T074 [US5] Add native TopBar support directly in UiKitPageView (no wrappers)
- [ ] T075 [P] [US5] Add native connection state handling with proper theming
- [ ] T076 [P] [US5] Add native banner system integration with consistent styling
- [ ] T077 [P] [US5] Add native scroll listener for hiding bottom navigation
- [ ] T078 [US5] Add native PrivacyGUI localization support using loc(context)

### Clean API Design

- [ ] T079 [US5] Design direct API that matches StyledPageView usage patterns
- [ ] T080 [P] [US5] Add UiKitPageView.login factory for login pages with TopBar
- [ ] T081 [P] [US5] Add UiKitPageView.dashboard factory for main app pages
- [ ] T082 [P] [US5] Add UiKitPageView.settings factory for settings pages with menus
- [ ] T083 [US5] Add comprehensive parameter validation and helpful error messages

### Theme Integration for PrivacyGUI

- [ ] ~~T084 [P] [US5] Integrate PrivacyGuiPageStyle~~ **Not needed**: UiKitPageView uses existing UI Kit theme system directly
- [ ] T085 [P] [US5] Ensure connection state components work with all 5 UI Kit visual languages (Glass, Brutal, Flat, Neumorphic, Pixel)
- [ ] T086 [P] [US5] Ensure banner components work with all 5 UI Kit visual languages
- [ ] T087 [P] [US5] Ensure TopBar integrates properly with UI Kit design system theming
- [ ] ~~T088 [US5] Update AppDesignTheme~~ **Not needed**: No PrivacyGUI-specific extensions required

### Migration Path Implementation

- [ ] T089 [US5] Create StyledPageViewMigrationGuide with exact replacement patterns
- [ ] T090 [P] [US5] Add deprecation warnings to ExperimentalUiKitPageView
- [ ] T091 [P] [US5] Create automated migration script for common patterns
- [ ] T092 [US5] Document breaking changes and migration steps for each usage pattern

### Testing and Validation

- [ ] T093 [P] [US5] Create golden tests for UiKitPageView with all PrivacyGUI features
- [ ] T094 [P] [US5] Create integration tests for TopBar + AppBar combinations
- [ ] T095 [P] [US5] Create connection state integration tests
- [ ] T096 [US5] Validate performance parity with StyledPageView baseline

**Checkpoint**: At this point, UiKitPageView should be a complete, clean replacement for StyledPageView with zero adapters or experimental code

---

## Phase 6: Gradual Migration & Cleanup (Priority: P2)

**Goal**: Systematically replace StyledPageView usage across the PrivacyGUI application and clean up experimental code

### Migration Execution

- [ ] T097 [P] [US6] Replace LoginLocalView with new UiKitPageView
- [ ] T098 [P] [US6] Replace DashboardHomeView with new UiKitPageView
- [ ] T099 [P] [US6] Replace 5 most commonly used pages with new UiKitPageView
- [ ] T100 [US6] Test migrated pages for visual and functional parity

### Cleanup and Optimization

- [ ] T101 [P] [US6] Remove ExperimentalUiKitPageView and adapter files
- [ ] T102 [P] [US6] Remove UiKitPageViewAdapter and wrapper classes
- [ ] T103 [P] [US6] Update imports across codebase to use new UiKitPageView
- [ ] T104 [US6] Run flutter analyze to ensure no deprecated code remains

### Performance and Polish

- [ ] T105 [P] [US6] Optimize bundle size after removing experimental code
- [ ] T106 [P] [US6] Run performance benchmarks on migrated pages
- [ ] T107 [P] [US6] Update documentation and examples
- [ ] T108 [US6] Final constitutional compliance review

**Checkpoint**: Complete migration with clean, maintainable, production-ready code

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Final improvements and validation across all user stories

- [ ] T107 [P] Run flutter analyze to ensure code quality across all new components
- [ ] T108 [P] Run flutter test --update-goldens --tags golden to update all golden test files
- [ ] T109 [P] Update CLAUDE.md project documentation with new component guidance
- [ ] T110 [P] Create comprehensive migration documentation in specs/023-styled-pageview-migration/
- [ ] T111 [P] Performance optimization and memory leak testing across all components
- [ ] T112 [P] Accessibility testing for all new UI components (44px/48px touch targets)
- [ ] T113 [P] Cross-platform testing on iOS, Android, Web, Desktop
- [ ] T114 Run quickstart.md validation with all copy-paste examples
- [ ] T115 Final constitutional compliance review against UI Kit charter requirements

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-6)**: All depend on Foundational phase completion
  - US1 must complete before US2 (API compatibility depends on enhanced components)
  - US2 must complete before US3 (validation tools need experimental component)
  - US3 must complete before US4 (rollout system needs validation tools)
- **Polish (Phase 7)**: Depends on all user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational - Foundation for all other stories
- **User Story 2 (P2)**: Depends on US1 completion - Needs enhanced UI Kit components
- **User Story 5 (P1)**: Depends on US2 completion - Needs experimental component as reference for production implementation
- **User Story 6 (P2)**: Depends on US5 completion - Needs production UiKitPageView for migration

### Within Each User Story

- Golden tests MUST be written and FAIL before implementation
- Configuration models before theme specifications
- Theme specifications before component implementation
- Component implementation before integration
- Story complete and validated before moving to next priority

### Parallel Opportunities

- All Setup tasks (T001-T008) marked [P] can run in parallel
- All Foundational tasks (T010-T012, T014) marked [P] can run in parallel within Phase 2
- Within each user story, all tasks marked [P] can run in parallel
- Configuration models (T021-T024) can all be built simultaneously
- Theme specifications (T026-T029) can all be built simultaneously after models complete
- Theme implementations across all 5 visual languages (T038-T042) can run in parallel
- Widgetbook stories (T048-T050) can be created in parallel

---

## Parallel Example: User Story 1 Configuration Models

```bash
# Launch all configuration models for User Story 1 together:
Task: "Create PageAppBarConfig model with Equatable in lib/src/layout/models/page_app_bar_config.dart"
Task: "Create PageBottomBarConfig model with Equatable in lib/src/layout/models/page_bottom_bar_config.dart"
Task: "Create PageMenuConfig model with Equatable in lib/src/layout/models/page_menu_config.dart"
Task: "Create PageMenuItem model with Equatable in lib/src/layout/models/page_menu_item.dart"

# Launch all theme specifications for User Story 1 together:
Task: "Create PageLayoutStyle with @TailorMixin in lib/src/foundation/theme/design_system/specs/page_layout_style.dart"
Task: "Create AppBarStyle with @TailorMixin in lib/src/foundation/theme/design_system/specs/app_bar_style.dart"
Task: "Create BottomBarStyle with @TailorMixin in lib/src/foundation/theme/design_system/specs/bottom_bar_style.dart"
Task: "Create MenuStyle with @TailorMixin in lib/src/foundation/theme/design_system/specs/menu_style.dart"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1 - Enhanced Page Components
4. **STOP and VALIDATE**: Test enhanced AppPageView independently through Widgetbook
5. Deploy enhanced UI Kit if ready for early adoption

### Incremental Delivery

1. Complete Setup + Foundational → Enhanced UI Kit foundation ready
2. Add User Story 1 → Test independently → Enhanced UI Kit ready for production
3. Add User Story 2 → Test independently → PrivacyGUI experimental component ready
4. Add User Story 5 → Test independently → Production UiKitPageView ready
5. Add User Story 6 → Test independently → Complete migration with cleanup
6. Each story builds toward final production-ready replacement

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done and User Story 1 starts:
   - Developer A: UI Kit enhanced components (US1)
   - Developer B: Can prepare PrivacyGUI experimental structure
3. Once User Story 1 completes:
   - Developer A: PrivacyGUI API compatibility layer (US2)
   - Developer B: Migration validation tools (US3)
   - Developer C: Safe rollout system planning (US4)
4. Stories integrate sequentially as dependencies allow

---

## Recent Progress Summary (Updated: 2025-12-11)

### Completed Phases ✅

**Phase 1: Setup** - ✅ Complete
- Directory structure, build configuration, test setup

**Phase 2: Foundational** - ✅ Complete
- Shared models, theme system foundation, design tokens

**Phase 3: User Story 1 - Enhanced Page Components** - ✅ Complete
- Configuration models, theme specifications, factory constructors
- All 5 visual language theme implementations
- Complete FAB configuration system
- Widgetbook stories and demonstrations

**Phase 4: User Story 2 - API Compatibility Layer** - ✅ Complete
- ExperimentalUiKitPageView with 100% StyledPageView API compatibility
- UiKitPageViewAdapter with parameter conversion logic
- PrivacyGuiWrappers with domain-specific behavior
- Successful validation with LoginLocalView and production app

### Current Architecture Assessment 🎯

**Experimental Implementation Status**: Working but temporary
- ExperimentalUiKitPageView = Functional adapter layer (as intended for testing)
- UiKitPageViewAdapter = Complex conversion logic (temporary scaffold)
- PrivacyGuiWrappers = Domain integration (needs to be native)
- **Ready for production refactor**: All experimental code has validated the design

### Next Phase Priorities 🚀

**Phase 5: Production UiKitPageView** - Starting Now
- Replace experimental code with clean, production-ready architecture
- Native PrivacyGUI integration without adapters
- Theme system integration with @TailorMixin specifications
- Direct API design matching StyledPageView usage patterns

## Notes

- [P] tasks = different files, no dependencies within the story
- [Story] label maps task to specific user story for traceability
- Each user story builds upon the previous - sequential dependency model
- Golden tests must fail before implementation to ensure proper TDD
- Theme matrix testing (4 themes × 2 brightness modes) required for all visual components
- Constitutional compliance must be maintained throughout implementation
- Performance parity with baseline StyledAppPageView is critical success criteria
- 100% API compatibility is non-negotiable requirement for User Story 2