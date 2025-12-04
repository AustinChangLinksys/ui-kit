# Tasks: Phase 2 UI Kit Components

**Input**: Design documents from `/specs/011-phase2-components/`
**Prerequisites**: plan.md, spec.md, data-model.md, contracts/widgets.md, research.md

**Tests**: Golden tests are REQUIRED per Constitution Section 12.2 (Test Matrix + Safe Mode Protocol).

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

**Status**: ✅ ALL PHASES COMPLETED

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Library source**: `lib/src/`
- **Theme specs**: `lib/src/foundation/theme/design_system/specs/`
- **Theme styles**: `lib/src/foundation/theme/design_system/styles/`
- **Molecules**: `lib/src/molecules/`
- **Organisms**: `lib/src/organisms/`
- **Tests**: `test/`
- **Widgetbook**: `widgetbook/lib/`

---

## Phase 1: Setup ✅

**Purpose**: Project initialization and directory structure

- [x] T001 Create organisms directory structure: `lib/src/organisms/app_bar/` and `lib/src/organisms/dialog/`
- [x] T002 [P] Create molecules directory structure: `lib/src/molecules/menu/`
- [x] T003 [P] Create test directory structure: `test/organisms/app_bar/`, `test/organisms/dialog/`, `test/molecules/menu/`
- [x] T004 [P] Create widgetbook story directories: `widgetbook/lib/stories/organisms/`, `widgetbook/lib/stories/molecules/`

---

## Phase 2: Foundational (Theme Specs - Blocking Prerequisites) ✅

**Purpose**: Style specifications that MUST be complete before ANY component implementation

**CRITICAL**: No user story work can begin until this phase is complete. All components depend on these specs.

### Style Spec Classes

- [x] T005 [P] Create AppBarStyle spec class in `lib/src/foundation/theme/design_system/specs/app_bar_style.dart`
- [x] T006 [P] Create MenuStyle spec class in `lib/src/foundation/theme/design_system/specs/app_menu_style.dart`
- [x] T007 [P] Create DialogStyle spec class in `lib/src/foundation/theme/design_system/specs/dialog_style.dart`

### AppDesignTheme Integration

- [x] T008 Add appBarStyle, menuStyle, dialogStyle fields to `lib/src/foundation/theme/design_system/app_design_theme.dart`
- [x] T009 Run build_runner to regenerate theme tailor code: `dart run build_runner build --delete-conflicting-outputs`

### Theme Style Implementations (Flat/Glass/Pixel/Neumorphic/Brutal)

- [x] T010 [P] Add AppBarStyle to FlatDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart`
- [x] T011 [P] Add MenuStyle to FlatDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart`
- [x] T012 [P] Add DialogStyle to FlatDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart`
- [x] T013 [P] Add AppBarStyle to GlassDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart`
- [x] T014 [P] Add MenuStyle to GlassDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart`
- [x] T015 [P] Add DialogStyle to GlassDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart`
- [x] T016 [P] Add AppBarStyle to PixelDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart`
- [x] T017 [P] Add MenuStyle to PixelDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart`
- [x] T018 [P] Add DialogStyle to PixelDesignTheme (light + dark) in `lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart`

### Verification

- [x] T019 Verify all theme styles compile and run `flutter analyze` to check for errors
- [x] T020 Add new specs to Neumorphic and Brutal themes (graceful defaults) in respective files

**Checkpoint**: ✅ Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Standard AppBar Integration (Priority: P1) ✅

**Goal**: Implement AppUnifiedBar component that automatically adapts visual appearance based on active design style (Flat, Glass, Pixel).

**Independent Test**: Place AppUnifiedBar in a Scaffold and switch between Flat/Glass/Pixel themes, verifying correct styling.

### Golden Tests for User Story 1

- [x] T021 [P] [US1] Create golden test for AppUnifiedBar default state in `test/organisms/app_bar/app_unified_bar_golden_test.dart`
- [x] T022 [P] [US1] Add golden test scenarios for AppUnifiedBar with title, actions, and bottom in `test/organisms/app_bar/app_unified_bar_golden_test.dart`

### Implementation for User Story 1

- [x] T023 [US1] Implement AppUnifiedBar widget implementing PreferredSizeWidget in `lib/src/organisms/app_bar/app_unified_bar.dart`
- [x] T024 [US1] Add AppSurface integration to AppUnifiedBar for theme-adaptive container rendering
- [x] T025 [US1] Implement automaticallyImplyLeading logic with Navigator.canPop check
- [x] T026 [US1] Add bottom widget support with style-aware divider from AppBarStyle.dividerStyle
- [x] T027 [US1] Add Semantics wrapper for accessibility (header: true, label: title)
- [x] T028 [US1] Export AppUnifiedBar from `lib/ui_kit.dart` barrel file
- [x] T029 [US1] Create Widgetbook story for AppUnifiedBar in `widgetbook/lib/stories/organisms/app_unified_bar.stories.dart`
- [x] T030 [US1] Update golden files: `flutter test --update-goldens --tags golden test/organisms/app_bar/`

**Checkpoint**: ✅ AppUnifiedBar independently functional and tested across all 8 style/mode combinations

---

## Phase 4: User Story 2 - Collapsible Sliver AppBar (Priority: P1) ✅

**Goal**: Implement AppUnifiedSliverBar with pinned/floating/snap behaviors and style-aware flexibleSpace overlay.

**Independent Test**: Place AppUnifiedSliverBar in CustomScrollView and verify pin/float/snap behaviors work smoothly across all design styles.

### Golden Tests for User Story 2

- [x] T031 [P] [US2] Create golden test for AppUnifiedSliverBar expanded state in `test/organisms/app_bar/app_unified_sliver_bar_golden_test.dart`
- [x] T032 [P] [US2] Add golden test scenarios for AppUnifiedSliverBar collapsed and with flexibleSpace in `test/organisms/app_bar/app_unified_sliver_bar_golden_test.dart`

### Implementation for User Story 2

- [x] T033 [US2] Implement AppUnifiedSliverBar widget wrapping Flutter's SliverAppBar in `lib/src/organisms/app_bar/app_unified_sliver_bar.dart`
- [x] T034 [US2] Implement custom FlexibleSpaceBar with style-aware overlay rendering
- [x] T035 [US2] Add blur overlay for Glass style when flexibleSpace is expanded using AppBarStyle.flexibleSpaceBlur
- [x] T036 [US2] Ensure Pixel style applies no blur effects (blurStrength: 0)
- [x] T037 [US2] Add smooth collapse/expand animations without jitter
- [x] T038 [US2] Export AppUnifiedSliverBar from `lib/ui_kit.dart` barrel file
- [x] T039 [US2] Add AppUnifiedSliverBar to Widgetbook story in `widgetbook/lib/stories/organisms/app_unified_sliver_bar.stories.dart`
- [x] T040 [US2] Update golden files: `flutter test --update-goldens --tags golden test/organisms/app_bar/`

**Checkpoint**: ✅ AppUnifiedSliverBar independently functional with smooth scroll behaviors

---

## Phase 5: User Story 3 - Popup Menu for Contextual Actions (Priority: P2) ✅

**Goal**: Implement AppPopupMenu and AppPopupMenuItem with style-adaptive container and 48dp touch targets.

**Independent Test**: Place AppPopupMenu in a screen, tap trigger icon, verify menu items render correctly with proper touch targets.

### Golden Tests for User Story 3

- [x] T041 [P] [US3] Create golden test for AppPopupMenu open state in `test/molecules/menu/app_popup_menu_golden_test.dart`
- [x] T042 [P] [US3] Add golden test scenarios for menu with destructive item and with icons in `test/molecules/menu/app_popup_menu_golden_test.dart`

### Implementation for User Story 3

- [x] T043 [P] [US3] Create AppPopupMenuItem data class in `lib/src/molecules/menu/app_popup_menu_item.dart`
- [x] T044 [US3] Implement AppPopupMenu StatefulWidget with overlay management in `lib/src/molecules/menu/app_popup_menu.dart`
- [x] T045 [US3] Add AppSurface integration for menu container with MenuStyle.containerStyle
- [x] T046 [US3] Implement menu item rendering with 48dp minimum height constraint
- [x] T047 [US3] Add destructive item styling using MenuStyle.destructiveItemStyle
- [x] T048 [US3] Implement hover/focus states using MenuStyle.itemHoverStyle
- [x] T049 [US3] Add Semantics for menu items (button: true, label: item.label)
- [x] T050 [US3] Handle menu positioning and dismiss on outside tap
- [x] T051 [US3] Export AppPopupMenu and AppPopupMenuItem from `lib/ui_kit.dart` barrel file
- [x] T052 [US3] Create Widgetbook story for AppPopupMenu in `widgetbook/lib/stories/molecules/menu/app_popup_menu.stories.dart`
- [x] T053 [US3] Update golden files: `flutter test --update-goldens --tags golden test/molecules/menu/`

### Additional Features Implemented

- [x] T053a [US3] Add `menuOffset` parameter for configurable gap between trigger and menu
- [x] T053b [US3] Add `hasSubmenu` property to AppPopupMenuItem for submenu indicators
- [x] T053c [US3] Create AppPopupMenuPreview widget for static preview (golden tests)
- [x] T053d [US3] Create CascadingMenuPreview widget for three-level menu visualization
- [x] T053e [US3] Add golden tests for cascading menu preview
- [x] T053f [US3] Add interactive multi-level menu story
- [x] T053g [US3] Add context menu demo story

**Checkpoint**: ✅ AppPopupMenu independently functional and tested across all 8 style/mode combinations

---

## Phase 6: User Story 4 - Modal Dialog for Confirmations (Priority: P2) ✅

**Goal**: Enhance existing AppDialog with structured button API, isDestructive flag, and style-adaptive container.

**Independent Test**: Trigger AppDialog display, verify content renders correctly, buttons respond, and dialog dismisses appropriately.

### Golden Tests for User Story 4

- [x] T054 [P] [US4] Create golden test for AppDialog default state in `test/molecules/dialogs/app_dialog_golden_test.dart`
- [x] T055 [P] [US4] Add golden test scenarios for destructive dialog and scrollable content in `test/molecules/dialogs/app_dialog_golden_test.dart`

### Implementation for User Story 4

- [x] T056 [US4] Implement AppDialog with structured parameters in `lib/src/molecules/dialogs/app_dialog.dart`
- [x] T057 [US4] Add content and customContent support
- [x] T058 [US4] Implement isDestructive flag for danger state on primary button
- [x] T059 [US4] Add scrollable content support with fixed action button area
- [x] T060 [US4] Integrate DialogStyle.containerStyle via AppSurface
- [x] T061 [US4] Implement barrier styling with DialogStyle.barrierColor and barrierBlur for Glass mode
- [x] T062 [US4] Add showAppDialog helper function for simplified usage with theme propagation
- [x] T063 [US4] Add showAppConfirmDialog helper for confirmation dialogs
- [x] T064 [US4] Add Semantics for dialog (scopesRoute: true, namesRoute: true, label: title)
- [x] T065 [US4] Create/update Widgetbook story for AppDialog in `widgetbook/lib/stories/molecules/dialogs/app_dialog.stories.dart`
- [x] T066 [US4] Update golden files: `flutter test --update-goldens --tags golden test/molecules/dialogs/`

### Bug Fixes

- [x] T066a [US4] Fix showAppDialog theme propagation - wrap dialog content with Theme widget

**Checkpoint**: ✅ AppDialog independently functional and tested across all 8 style/mode combinations

---

## Phase 7: User Story 5 - Theme Mode Consistency (Priority: P3) ✅

**Goal**: Verify all Phase 2 components maintain WCAG AA contrast ratios in both Light and Dark modes.

**Independent Test**: Render each component in Light and Dark mode for each design style and verify text/icon contrast.

### Verification for User Story 5

- [x] T067 [US5] Run all golden tests to verify 8-style matrix coverage (4 themes × 2 modes: Flat/Glass/Pixel/Neumorphic × Light/Dark)
- [x] T068 [US5] Manually verify AppUnifiedBar contrast in Light/Dark for all themes using Widgetbook
- [x] T069 [US5] Manually verify AppUnifiedSliverBar contrast in Light/Dark for all themes using Widgetbook
- [x] T070 [US5] Manually verify AppPopupMenu contrast in Light/Dark for all themes using Widgetbook
- [x] T071 [US5] Manually verify AppDialog contrast in Light/Dark for all themes using Widgetbook
- [x] T072 [US5] Fix any contrast issues found by adjusting theme style implementations

**Checkpoint**: ✅ All components pass WCAG AA contrast verification

---

## Phase 8: Polish & Cross-Cutting Concerns ✅

**Purpose**: Improvements that affect multiple user stories

- [x] T073 [P] Run `flutter analyze` and fix any warnings or errors
- [x] T074 [P] Run `flutter test` to ensure all tests pass
- [x] T075 [P] Verify BackdropFilter is NOT used in Flat style (FR-016 compliance)
- [x] T076 [P] Verify all touch targets are minimum 48x48dp (FR-010, FR-017 compliance)
- [x] T077 Update library exports in `lib/ui_kit.dart` to include new components
- [x] T078 Widgetbook verification across all design styles
- [x] T079 Final golden test verification

### Additional Polish Tasks

- [x] T080 Create Theme Editor spec editors for new styles (AppBarSpecEditor, MenuSpecEditor, DialogSpecEditor)
- [x] T081 Update ThemeEditorController with update methods for new styles
- [x] T082 Add "Components" tab to Theme Editor control panel

### Extended Widgetbook Stories

- [x] T083 Add AppUnifiedBar stories: Left Aligned, Drawer Menu, Search Field, Action Badges, Detail Page, Transparent, Multiple Action Groups
- [x] T084 Add AppPopupMenu stories: Interactive Multi-Level Menu, Context Menu Demo
- [x] T085 Add AppUnifiedSliverBar stories: Custom Title, With Actions

---

## Summary

**Total Tasks**: 85+ tasks completed
**Golden Tests**: 44+ golden test scenarios across all components
**Widgetbook Stories**: 20+ interactive stories for component documentation

### Components Delivered

1. **AppUnifiedBar** - Theme-aware standard AppBar with PreferredSizeWidget
2. **AppUnifiedSliverBar** - Collapsible sliver AppBar with flexible space
3. **AppPopupMenu** - Theme-aware popup menu with overlay management
4. **AppPopupMenuItem** - Menu item data class with submenu support
5. **AppPopupMenuPreview** - Static menu preview for golden tests
6. **CascadingMenuPreview** - Three-level cascading menu visualization
7. **AppDialog** - Theme-aware modal dialog with barrier blur
8. **showAppDialog** - Helper function with theme propagation
9. **showAppConfirmDialog** - Confirmation dialog helper

### Theme Specs Added

1. **AppBarStyle** - AppBar container, divider, and flexible space styling
2. **AppMenuStyle** - Menu container, item, hover, and destructive styling
3. **DialogStyle** - Dialog container, barrier, and button styling

### All 5 Design Styles Supported

- Flat (Light/Dark)
- Glass (Light/Dark) - with backdrop blur
- Pixel (Light/Dark)
- Neumorphic (Light/Dark)
- Brutal (Light/Dark)
