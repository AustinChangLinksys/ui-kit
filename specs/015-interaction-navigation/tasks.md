# Tasks: Phase 4 - Interaction & Navigation Components

**Input**: Design documents from `/specs/015-interaction-navigation/`
**Prerequisites**: plan.md ✓, spec.md ✓, research.md ✓, data-model.md ✓, contracts/ ✓

**Organization**: Tasks grouped by user story (US1-US8) enabling independent implementation and testing

**Total Tasks**: 71 across 10 phases

---

## Format: `[ID] [P?] [Story] Description`

- **[ID]**: Task identifier (T001, T002, etc.)
- **[P]**: Can run in parallel (different files, no cross-dependencies)
- **[Story]**: User story label (US1, US2, US3, etc.) - appears as `[US1]` in task title
  - Phase 3 (T023-T033): [US1] AppExpansionPanel
  - Phase 4 (T034-T044): [US2] AppCarousel
  - Phase 5 (T045-T055): [US3] AppStepper
  - Phase 6 (T056-T064): [US4] AppBottomSheet
  - Phase 7 (T065-T074): [US5] AppDrawer/SideSheet
  - Phase 8 (T075-T084): [US6] AppTabs
  - Phase 9 (T085-T093): [US7] AppBreadcrumb
  - Phase 10 (T094-T103): [US8] AppChipGroup
- **File paths**: Relative to repository root (lib/src/, test/, widgetbook/)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Foundation layer for all 8 components - theme specs, test utilities, code generation

- [ ] T001 Create theme spec files directory structure: `lib/src/foundation/theme/design_system/specs/`
- [ ] T002 Create component directories: `lib/src/molecules/bottom_sheet/`, `lib/src/molecules/side_sheet/`, `lib/src/molecules/tabs/`, `lib/src/molecules/stepper/`, `lib/src/molecules/breadcrumb/`, `lib/src/molecules/expansion_panel/`, `lib/src/molecules/carousel/`, `lib/src/molecules/chip_group/`
- [ ] T003 [P] Create test directories: `test/molecules/bottom_sheet/`, `test/molecules/side_sheet/`, `test/molecules/tabs/`, `test/molecules/stepper/`, `test/molecules/breadcrumb/`, `test/molecules/expansion_panel/`, `test/molecules/carousel/`, `test/molecules/chip_group/`
- [ ] T004 [P] Create Widgetbook story files: `widgetbook/lib/stories/navigation/` directory
- [ ] T005 Create test utilities for theme matrix: `test/test_utils/theme_matrix_builder.dart` (Golden test matrix factory wrapper)
- [ ] T006 [P] Configure build_runner for code generation: Update `pubspec.yaml` with latest `build_runner` version if needed
- [ ] T007 [P] Configure alchemist for golden testing: Verify `alchemist` configuration in `pubspec.yaml`

**Checkpoint**: Foundation infrastructure ready - theme specs and test setup complete

---

## Phase 2: Foundational (Blocking Prerequisites for All Components)

**Purpose**: Core theme specs and shared styling that ALL 8 components depend on

**⚠️ CRITICAL**: No component can be implemented until this phase is complete

### Theme Spec Definitions

- [ ] T008 [P] Create `BottomSheetStyle` spec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/bottom_sheet_style.dart`
  - Properties: overlayColor, animationDuration, animationCurve, topBorderRadius, dragHandleHeight
  - Supports @TailorMixin generation of copyWith() and lerp()

- [ ] T009 [P] Create `SideSheetStyle` spec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/side_sheet_style.dart`
  - Properties: width, overlayColor, animationDuration, animationCurve, blurStrength, enableDithering
  - Pixel-specific properties: useSnapAnimation, ditherPattern

- [ ] T010 [P] Create `TabsStyle` spec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/tabs_style.dart`
  - Properties: activeTextColor, inactiveTextColor, indicatorColor, tabBackgroundColor, animationDuration, indicatorThickness

- [ ] T011 [P] Create `StepperStyle` spec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/stepper_style.dart`
  - Properties: activeStepColor, completedStepColor, pendingStepColor, connectorColor, stepSize, useDashedConnector
  - Pixel-specific: pixelCheckmarkIcon

- [ ] T012 [P] Create `BreadcrumbStyle` spec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/breadcrumb_style.dart`
  - Properties: activeLinkColor, inactiveLinkColor, separatorColor, separatorText, itemTextStyle
  - Pixel-specific: useAsciiSeparators

- [ ] T013 [P] Create `ExpansionPanelStyle` spec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/expansion_panel_style.dart`
  - Properties: headerColor, expandedBackgroundColor, headerTextColor, expandIcon, animationDuration
  - Glass-specific: recessedBackgroundDepth

- [ ] T014 [P] Create `CarouselStyle` spec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/carousel_style.dart`
  - Properties: navButtonColor, navButtonHoverColor, previousIcon, nextIcon, animationDuration, animationCurve
  - Pixel-specific: useSnapScroll, navButtonSize

- [ ] T015 [P] Create `ChipGroupStyle` spec with @TailorMixin in `lib/src/foundation/theme/design_system/specs/chip_group_style.dart`
  - Properties: unselectedBackground, unselectedText, selectedBackground, selectedText, selectedBorderColor, borderRadius
  - Glass-specific: illuminationGlowEffect

### Integration with Theme Extensions

- [ ] T016 Update `app_design_theme.dart` to include all 8 new specs in `AppDesignTheme` class using @TailorMixin

### Theme Implementation Updates

- [ ] T017 [P] Update `glass_design_theme.dart` to provide all 8 style implementations (blue-based, high blur, glow effects)
- [ ] T018 [P] Update `brutal_design_theme.dart` to provide all 8 style implementations (dark, bold borders, fast animations)
- [ ] T019 [P] Update `flat_design_theme.dart` to provide all 8 style implementations (minimal, clean colors)
- [ ] T020 [P] Update `neumorphic_design_theme.dart` to provide all 8 style implementations (inset/outset shadows)
- [ ] T021 [P] Update `pixel_design_theme.dart` to provide all 8 style implementations (large buttons, snap animations, dithering, ASCII separators)

### Code Generation

- [ ] T022 Run `dart run build_runner build --delete-conflicting-outputs` to generate all theme spec extensions

**Checkpoint**: All theme specs defined and code-generated - ready for component implementation

---

## Phase 3: User Story 1 - Collapsible Panels with AppExpansionPanel (Priority: P1) 🎯 MVP

**Goal**: Implement `AppExpansionPanel` component allowing developers to create collapsible content sections for FAQs, settings, product details

**Independent Test**: Component renders multiple panels, toggles expand/collapse, and different themes apply correct styling

### Component Implementation

- [ ] T023 [P] [US1] Create `AppExpansionPanel` widget in `lib/src/molecules/expansion_panel/app_expansion_panel.dart`
  - Constructor: panels (required), initialExpandedIndices, allowMultipleOpen, onPanelToggled, style
  - State management: ValueNotifier for expanded panels set
  - AppSurface usage: One AppSurface per panel header + content area

- [ ] T024 [P] [US1] Create `ExpansionItem` helper widget in `lib/src/molecules/expansion_panel/expansion_item.dart`
  - Handles individual panel expand/collapse animation
  - Uses flutter_animate for smooth transitions
  - Semantics wrapper for accessibility

- [ ] T025 [US1] Create `ExpansionPanelRenderer` for theme-specific rendering in `lib/src/molecules/expansion_panel/expansion_panel_renderer.dart`
  - Glass theme: Deepened background on expand (recessed look via AppSurface variant)
  - Pixel theme: Pixel-perfect expand/collapse indicator animation
  - Returns themed expand icon widget

- [ ] T026 [US1] Update `AppExpansionPanel` to use Renderer Pattern with `ExpansionPanelRenderer`

### Theme Integration

- [ ] T027 [US1] Verify `ExpansionPanelStyle` applied in all 5 themes via theme extension lookup

### Accessibility & Testing

- [ ] T028 [US1] Add Semantics to `AppExpansionPanel`: label="Expansion Panel Group", button role on headers, announces expand/collapse state
- [ ] T029 [US1] Add Semantics to each `ExpansionItem`: expandable=true, expanded=isExpanded state
- [ ] T030 [US1] Verify touch targets ≥ 48x48dp on header areas

### Widgetbook Story

- [ ] T031 [US1] Create Widgetbook story in `widgetbook/lib/stories/navigation/expansion_panel_story.dart`
  - Show single, multiple open, all closed, all open states
  - Theme switcher knobs
  - Knobs for content variations (text, icons, long content)

### Golden Tests

- [ ] T032 [US1] Create golden test file `test/molecules/expansion_panel/app_expansion_panel_golden_test.dart`
  - Test all 8 theme combinations (4 themes × 2 brightness): collapsed state, expanded state, multiple panels
  - Use buildThemeMatrix() factory
  - Explicit size constraints (300×400), ColoredBox background
  - Total golden files: 5 scenarios × 8 combinations = 40 files expected

### Unit Tests

- [ ] T033 [US1] Create unit test file `test/molecules/expansion_panel/app_expansion_panel_test.dart`
  - Test expand/collapse toggle functionality
  - Test allowMultipleOpen behavior (single vs multiple)
  - Test initialExpandedIndices parameter
  - Test onPanelToggled callback
  - Test disabled panels (canExpand=false)

**Checkpoint**: AppExpansionPanel complete and fully tested - ready for independent deployment

---

## Phase 4: User Story 2 - Sequential Content Navigation with AppCarousel (Priority: P1)

**Goal**: Implement `AppCarousel` component for displaying sequential items (onboarding, galleries, banners) with theme-aware navigation

**Independent Test**: Component displays items, navigates forward/backward, adapts to theme (smooth for Glass/Brutal, snap for Pixel)

### Component Implementation

- [ ] T034 [P] [US2] Create `AppCarousel` widget in `lib/src/molecules/carousel/app_carousel.dart`
  - Constructor: itemCount (required), itemBuilder (required), itemHeight (required), itemWidth, padding, scrollBehavior, onIndexChanged, enableAutoPlay, autoPlayDuration, showNavigationButtons, style
  - State management: ValueNotifier for currentItemIndex, auto-play timer if enabled
  - Uses ListView.builder for lazy rendering (performance for large lists)

- [ ] T035 [P] [US2] Create `CarouselNavButtons` widget in `lib/src/molecules/carousel/carousel_nav_buttons.dart`
  - Previous/Next buttons using AppSurface with interactive=true
  - Disabled state at boundaries (unless carousel loops)
  - Semantics: "Previous item", "Next item" labels

- [ ] T036 [US2] Create `CarouselRenderer` for theme-specific button rendering in `lib/src/molecules/carousel/carousel_renderer.dart`
  - Glass theme: Subtle button styling, smooth scroll animation
  - Brutal theme: Bold buttons, fast scroll
  - Pixel theme: Large pixelated arrow buttons (48+px), snap scroll (no smooth animation)
  - Returns themed navigation button widgets

- [ ] T037 [US2] Update `AppCarousel` to use CarouselRenderer for nav buttons based on `CarouselStyle.useSnapScroll`

### Theme Integration

- [ ] T038 [US2] Verify `CarouselStyle` applied via theme extension with snap behavior per theme

### Accessibility & Testing

- [ ] T039 [US2] Add Semantics to carousel: "Carousel, item {current} of {total}"
- [ ] T040 [US2] Add Semantics to nav buttons: disabled state announced
- [ ] T041 [US2] Keyboard support: Left/Right arrow keys navigate carousel

### Widgetbook Story

- [ ] T042 [US2] Create Widgetbook story in `widgetbook/lib/stories/navigation/carousel_story.dart`
  - Show different carousel sizes
  - Theme switcher
  - Knobs for: auto-play toggle, item count, display mode variations

### Golden Tests

- [ ] T043 [US2] Create golden test `test/molecules/carousel/app_carousel_golden_test.dart`
  - Test 8 theme combinations: default state, at first item, at last item, with nav buttons
  - Explicit constraints (300×200), ColoredBox background, TickerMode(enabled: false) for auto-play
  - Total: 4 scenarios × 8 combinations = 32 golden files

### Unit Tests

- [ ] T044 [US2] Create unit test `test/molecules/carousel/app_carousel_test.dart`
  - Test navigation (next/previous buttons)
  - Test boundary conditions (first/last item)
  - Test carousel looping
  - Test auto-play behavior
  - Test onIndexChanged callback
  - Test lazy rendering (builder called correctly)

**Checkpoint**: AppCarousel complete and tested - can display sequential content with theme-aware navigation

---

## Phase 5: User Story 3 - Multi-Step Progress with AppStepper (Priority: P1)

**Goal**: Implement `AppStepper` component for displaying linear process progress (registration, checkout, forms)

**Independent Test**: Component shows step indicators, marks steps complete, handles Pixel theme dashed connectors and checkmarks

### Component Implementation

- [ ] T045 [P] [US3] Create `AppStepper` widget in `lib/src/molecules/stepper/app_stepper.dart`
  - Constructor: steps (required), currentStep (required), completedSteps, onStepTapped, type, style
  - State management: Tracks currentStep and completedSteps
  - Renders step indicators horizontally with connectors between steps

- [ ] T046 [P] [US3] Create `StepIndicator` widget in `lib/src/molecules/stepper/step_indicator.dart`
  - Single step circle/indicator with title and optional description
  - Shows: pending (outline), active (filled), completed (checkmark or indicator)
  - Uses AppSurface for styling (SurfaceVariant.base for inactive, highlight for active)

- [ ] T047 [US3] Create `StepperRenderer` for theme-specific rendering in `lib/src/molecules/stepper/stepper_renderer.dart`
  - Glass theme: Smooth connectors, glowing active step
  - Brutal theme: Bold filled circles, thick connectors
  - Pixel theme: Dashed connectors, pixel checkmark icon (✓ in pixel font or custom icon)
  - Neumorphic theme: Recessed pending, raised completed

- [ ] T048 [US3] Update `AppStepper` to use StepperRenderer for connectors and completion indicators

### Theme Integration

- [ ] T049 [US3] Verify `StepperStyle` applied with dashed/solid connector logic per theme

### Accessibility & Testing

- [ ] T050 [US3] Add Semantics to stepper: "Step indicator, step {current+1} of {total}"
- [ ] T051 [US3] Add Semantics to each step: "Step {n}, {completed/active/pending}" + title
- [ ] T052 [US3] Keyboard support: Tab navigates between steps in non-linear mode

### Widgetbook Story

- [ ] T053 [US3] Create Widgetbook story in `widgetbook/lib/stories/navigation/stepper_story.dart`
  - Show different step counts
  - Linear vs non-linear mode toggle
  - Theme switcher
  - Progress slider knob

### Golden Tests

- [ ] T054 [US3] Create golden test `test/molecules/stepper/app_stepper_golden_test.dart`
  - Test 8 combinations: initial state, current step 2, all completed, mixed states
  - Explicit size (400×120), ColoredBox background
  - Total: 4+ scenarios × 8 combinations = 32+ golden files

### Unit Tests

- [ ] T055 [US3] Create unit test `test/molecules/stepper/app_stepper_test.dart`
  - Test step tapping (onStepTapped callback)
  - Test completed steps display
  - Test linear vs non-linear stepping
  - Test disabled steps
  - Test currentStep validation

**Checkpoint**: AppStepper complete - shows multi-step progress with theme-aware connectors and indicators

---

## Phase 6: User Story 4 - Secondary Actions Panel with AppBottomSheet (Priority: P2)

**Goal**: Implement `AppBottomSheet` component for presenting secondary options/details without navigation

**Independent Test**: Sheet animates in from bottom, can be dismissed, Pixel theme shows folder-tab handle

### Component Implementation

- [ ] T056 [P] [US4] Create `AppBottomSheet` widget in `lib/src/molecules/bottom_sheet/app_bottom_sheet.dart`
  - Constructor: child (required), maxHeight, minHeight, padding, onDismiss, isDismissible, enableDrag, style
  - Animation: Slides up from bottom using flutter_animate
  - Uses SingleChildScrollView for content scrolling if exceeds max height

- [ ] T057 [US4] Create `BottomSheetHandle` widget in `lib/src/molecules/bottom_sheet/bottom_sheet_handle.dart`
  - Draggable indicator at top of sheet
  - Glass theme: Subtle line
  - Pixel theme: Thick black line (folder tab style)
  - Nemorphic theme: Shadow-based handle

### Theme Integration

- [ ] T058 [US4] Verify `BottomSheetStyle` applied (overlayColor scrim, animation timing)

### Accessibility & Testing

- [ ] T059 [US4] Add Semantics: dialog role, title announcement, close button labeled
- [ ] T060 [US4] Add Semantics to handle: "Draggable handle to dismiss"
- [ ] T061 [US4] Keyboard support: Escape key dismisses sheet

### Widgetbook Story

- [ ] T062 [US4] Create Widgetbook story in `widgetbook/lib/stories/navigation/bottom_sheet_story.dart`
  - Show various content heights
  - Theme switcher
  - Knobs for max/min height

### Golden Tests

- [ ] T063 [US4] Create golden test `test/molecules/bottom_sheet/app_bottom_sheet_golden_test.dart`
  - Test 8 combinations: open state (different heights), with/without handle
  - Explicit size (375×300), ColoredBox background
  - TickerMode(enabled: false) for animation
  - Total: 3+ scenarios × 8 combinations = 24+ golden files

### Unit Tests

- [ ] T064 [US4] Create unit test `test/molecules/bottom_sheet/app_bottom_sheet_test.dart`
  - Test dismiss (tap outside, drag down, button click)
  - Test scroll behavior when content exceeds max height
  - Test isDismissible parameter
  - Test onDismiss callback
  - Test height constraints

**Checkpoint**: AppBottomSheet complete - secondary actions panel ready for use

---

## Phase 7: User Story 5 - Side Navigation with AppDrawer/AppSideSheet (Priority: P2)

**Goal**: Implement `AppDrawer` and `AppSideSheet` components for responsive navigation on web/tablet layouts

**Independent Test**: Drawer opens/closes, glass theme shows blur, Pixel theme shows snap animation with dithering

### Component Implementation

- [ ] T065 [P] [US5] Create `AppSideSheet` widget in `lib/src/molecules/side_sheet/app_side_sheet.dart`
  - Constructor: child (required), width, position (left/right), isPersistent, onDismiss, isDismissible, style
  - Animation: Slides in from side using flutter_animate
  - Overlay mode: Scrim behind sheet, tappable to dismiss
  - Persistent mode: Always visible, no scrim

- [ ] T066 [US5] Create `AppDrawer` as convenience wrapper in `lib/src/molecules/side_sheet/app_drawer.dart`
  - Subclass/wrapper of AppSideSheet with left position, overlay mode defaults

- [ ] T067 [US5] Create `SideSheetRenderer` in `lib/src/molecules/side_sheet/side_sheet_renderer.dart`
  - Glass theme: High blur (20+), rim light edges, smooth slide animation
  - Brutal theme: Dark overlay, fast snap animation
  - Pixel theme: Dithering background texture, no smooth animation (snap open)
  - Flat theme: Minimal shadow
  - Neumorphic theme: Inset shadow for recessed appearance

### Theme Integration

- [ ] T068 [US5] Verify `SideSheetStyle` with theme-specific blur, dithering, animation per theme

### Accessibility & Testing

- [ ] T069 [US5] Add Semantics: navigation role, "Navigation drawer" or "Side panel"
- [ ] T070 [US5] Add Semantics to navigation items inside: links with proper labels
- [ ] T071 [US5] Keyboard support: Escape closes drawer, Tab cycles through items

### Widgetbook Story

- [ ] T072 [US5] Create Widgetbook story in `widgetbook/lib/stories/navigation/side_sheet_story.dart`
  - Show drawer (temporary) vs side sheet (persistent)
  - Theme switcher
  - Knobs for width, position variations

### Golden Tests

- [ ] T073 [US5] Create golden test `test/molecules/side_sheet/app_side_sheet_golden_test.dart`
  - Test 8 combinations: open drawer, persistent side sheet
  - Explicit size (400×400), ColoredBox background
  - TickerMode(enabled: false)
  - Total: 3+ scenarios × 8 combinations = 24+ golden files

### Unit Tests

- [ ] T074 [US5] Create unit test `test/molecules/side_sheet/app_side_sheet_test.dart`
  - Test open/close toggle
  - Test persistent vs temporary modes
  - Test dismiss (tap outside, programmatic)
  - Test onDismiss callback
  - Test width parameter

**Checkpoint**: AppDrawer/AppSideSheet complete - responsive navigation ready

---

## Phase 8: User Story 6 - Tab-Based Navigation with AppTabs (Priority: P2)

**Goal**: Implement `AppTabs` component for parallel content switching (All/Favorites/Recent tabs)

**Independent Test**: Tabs switch content, Pixel theme shows inverted/connected block styling

### Component Implementation

- [ ] T075 [P] [US6] Create `AppTabs` widget in `lib/src/molecules/tabs/app_tabs.dart`
  - Constructor: tabs (required), initialIndex, displayMode, onTabChanged, style
  - State management: ValueNotifier for selectedIndex
  - Supports: underline (default), segmented, scrollable modes
  - Shows only selected tab's content (content.isEmpty for unselected)

- [ ] T076 [P] [US6] Create `TabBar` widget in `lib/src/molecules/tabs/tab_bar.dart`
  - Row of tab buttons with indicator
  - Uses AppSurface for button styling
  - Indicator animation: smooth underline or background transition

- [ ] T077 [US6] Create `TabRenderer` in `lib/src/molecules/tabs/tab_renderer.dart`
  - Glass theme: Smooth indicator animation, glow on active
  - Brutal theme: Bold text on active, thick indicator
  - Pixel theme: Inverted colors (black on white, white on black) or connected block style
  - Flat theme: Minimal styling, underline only
  - Neumorphic theme: Subtle shadow on active tab

### Theme Integration

- [ ] T078 [US6] Verify `TabsStyle` applied with indicator and text colors per theme

### Accessibility & Testing

- [ ] T079 [US6] Add Semantics to tab bar: "Tab bar, {count} tabs"
- [ ] T080 [US6] Add Semantics to each tab: "Tab {n} of {total}" + label, selected state
- [ ] T081 [US6] Keyboard support: Arrow keys navigate tabs, Enter/Space selects

### Widgetbook Story

- [ ] T082 [US6] Create Widgetbook story in `widgetbook/lib/stories/navigation/tabs_story.dart`
  - Show different tab counts
  - Display mode variations (underline, segmented, scrollable)
  - Theme switcher
  - Knobs for content variations

### Golden Tests

- [ ] T083 [US6] Create golden test `test/molecules/tabs/app_tabs_golden_test.dart`
  - Test 8 combinations: tab 1 active, tab 2 active, scrollable tabs
  - Explicit size (300×200), ColoredBox background
  - Total: 3+ scenarios × 8 combinations = 24+ golden files

### Unit Tests

- [ ] T084 [US6] Create unit test `test/molecules/tabs/app_tabs_test.dart`
  - Test tab switching (onTabChanged callback)
  - Test initialIndex parameter
  - Test displayMode variations
  - Test horizontal scrolling overflow
  - Test tab disabling

**Checkpoint**: AppTabs complete - tab-based navigation fully functional

---

## Phase 9: User Story 7 - Hierarchical Navigation with AppBreadcrumb (Priority: P3)

**Goal**: Implement `AppBreadcrumb` component for displaying navigation hierarchy (documentation, e-commerce)

**Independent Test**: Breadcrumb displays path, tapping navigates, Pixel theme shows ASCII separators

### Component Implementation

- [ ] T085 [US7] Create `AppBreadcrumb` widget in `lib/src/molecules/breadcrumb/app_breadcrumb.dart`
  - Constructor: items (required), overflowBehavior, style
  - Layout: Row of breadcrumb items with separators
  - Overflow handling: ellipsis (hide middle items), scroll, or wrap modes

- [ ] T086 [US7] Create `BreadcrumbRenderer` in `lib/src/molecules/breadcrumb/breadcrumb_renderer.dart`
  - Glass theme: Smooth separators, glow on hover
  - Brutal theme: Bold separators
  - Pixel theme: ASCII-style separators (">", "|", etc. based on separator_text)
  - Flat theme: Simple "/" separators
  - Neumorphic theme: Shadow-styled separators

### Theme Integration

- [ ] T087 [US7] Verify `BreadcrumbStyle` with separatorText override for Pixel theme ASCII style

### Accessibility & Testing

- [ ] T088 [US7] Add Semantics: navigation role, "Breadcrumb navigation"
- [ ] T089 [US7] Add Semantics to items: links with aria-current="page" for current location
- [ ] T090 [US7] Current location item: NOT clickable, aria-current="page" semantic

### Widgetbook Story

- [ ] T091 [US7] Create Widgetbook story in `widgetbook/lib/stories/navigation/breadcrumb_story.dart`
  - Show various path depths
  - Overflow behavior variations
  - Theme switcher
  - Long path knobs

### Golden Tests

- [ ] T092 [US7] Create golden test `test/molecules/breadcrumb/app_breadcrumb_golden_test.dart`
  - Test 8 combinations: short path, long path (overflow), different separators
  - Explicit size (400×60), ColoredBox background
  - Total: 3+ scenarios × 8 combinations = 24+ golden files

### Unit Tests

- [ ] T093 [US7] Create unit test `test/molecules/breadcrumb/app_breadcrumb_test.dart`
  - Test breadcrumb item tapping (navigation)
  - Test current location item (not tappable)
  - Test overflow behavior (ellipsis, scroll, wrap)
  - Test item validation (exactly one isCurrentLocation)

**Checkpoint**: AppBreadcrumb complete - hierarchical navigation ready

---

## Phase 10: User Story 8 - Quick Filtering with AppChipGroup (Priority: P3)

**Goal**: Implement `AppChipGroup` component for quick filtering/multi-select (search results, status tags)

**Independent Test**: Chips select/deselect, Glass theme shows glow effect, multi-select works

### Component Implementation

- [ ] T094 [US8] Create `AppChipGroup` widget in `lib/src/molecules/chip_group/app_chip_group.dart`
  - Constructor: chips (required), allowMultiSelect, initialSelectedIndices, onSelectionChanged, layout, scrollDirection, style
  - State management: ValueNotifier for selectedIndices
  - Layout: Wrap (default) or scroll modes

- [ ] T095 [P] [US8] Create `AppChip` widget in `lib/src/molecules/chip_group/app_chip.dart`
  - Individual chip with label, optional icon
  - Uses AppSurface for styling (unselected vs selected)
  - Interactive=true on AppSurface

- [ ] T096 [US8] Create `ChipRenderer` in `lib/src/molecules/chip_group/chip_renderer.dart`
  - Glass theme: Selected chips show illuminated glass with subtle glow
  - Brutal theme: Bold border change on selection
  - Pixel theme: Inverted colors or bold outline
  - Neumorphic theme: Subtle shadow depth change
  - Flat theme: Simple color swap

### Theme Integration

- [ ] T097 [US8] Verify `ChipGroupStyle` applied with selection colors and glow per theme

### Accessibility & Testing

- [ ] T098 [US8] Add Semantics to chip group: "Filterable options, {count} choices"
- [ ] T099 [US8] Add Semantics to each chip: "Option {label}, {selected/unselected}"
- [ ] T100 [US8] Keyboard support: Tab to chip, Space/Enter toggles selection

### Widgetbook Story

- [ ] T101 [US8] Create Widgetbook story in `widgetbook/lib/stories/navigation/chip_group_story.dart`
  - Show single-select vs multi-select modes
  - Wrap vs scroll layout variations
  - Theme switcher
  - Many chips knob (overflow behavior)

### Golden Tests

- [ ] T102 [US8] Create golden test `test/molecules/chip_group/app_chip_group_golden_test.dart`
  - Test 8 combinations: unselected, single selected, multiple selected, many chips
  - Explicit size (350×150), ColoredBox background
  - Total: 4+ scenarios × 8 combinations = 32+ golden files

### Unit Tests

- [ ] T103 [US8] Create unit test `test/molecules/chip_group/app_chip_group_test.dart`
  - Test single-select mode (only one chip selected at a time)
  - Test multi-select mode
  - Test chip tapping (onSelectionChanged callback)
  - Test initialSelectedIndices
  - Test chip toggling (select already selected = deselect)
  - Test disabled chips

**Checkpoint**: AppChipGroup complete - filtering interface ready

---

## Phase 11: Polish & Cross-Cutting Concerns

**Purpose**: Final validation, integration, documentation, and cross-component consistency

- [ ] T104 [P] Run code generation: `dart run build_runner build --delete-conflicting-outputs` to regenerate all theme specs
- [ ] T105 [P] Run all tests: `flutter test --exclude-tags=golden` to verify all unit tests pass
- [ ] T106 [P] Run golden tests: `flutter test --tags=golden` to generate/validate all 240+ golden screenshots (all 8 components × 5+ scenarios × 8 themes)
- [ ] T107 [P] Run Widgetbook: Manually verify all 8 components in `widgetbook/lib/stories/navigation/` with all themes (Chrome recommended for Glass effects)
- [ ] T108 [P] Run analysis: `flutter analyze` to catch any linting issues
- [ ] T109 [P] Verify theme editor: Run theme editor app and manually adjust theme parameters, verify all 8 components update instantly without code changes
- [ ] T110 Create integration test in `test/molecules/integration_navigation_test.dart`: Multi-component checkout flow (stepper → tabs → carousel → bottom sheet)
- [ ] T111 Verify accessibility: Run `flutter_semantics_analyzer` on all components for WCAG 2.1 AA compliance
- [ ] T112 Update main export files: Add all 8 components to `lib/ui_kit.dart` (or equivalent) for public API
- [ ] T113 Verify quickstart guide: Run all copy-paste examples from `specs/015-interaction-navigation/quickstart.md` - ensure they compile and work
- [ ] T114 Final review: Verify Constitution compliance per Charter 2.0.0
  - ✅ All components UI-only (no business logic)
  - ✅ No forbidden dependencies
  - ✅ All use AppSurface Primitive rule
  - ✅ All follow Atomic Design hierarchy
  - ✅ All have theme specs via @TailorMixin
  - ✅ All support all 5 visual languages

**Checkpoint**: All components complete, tested, documented, and ready for production use

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - **BLOCKS all components**
- **User Stories (Phases 3-10)**: All depend on Foundational phase completion
  - P1 stories (Phases 3-5): Can proceed in parallel or sequentially
  - P2 stories (Phases 6-7): Can proceed in parallel after P1 OR in parallel from start of Foundational
  - P3 stories (Phases 8-10): Can proceed in parallel from start
- **Polish (Phase 11)**: Depends on all desired components being complete

### User Story Dependencies

| User Story | Component | Dependencies | Can Start |
|-----------|-----------|---|---|
| US1 | AppExpansionPanel | Foundational only | After Phase 2 |
| US2 | AppCarousel | Foundational only | After Phase 2 (parallel to US1) |
| US3 | AppStepper | Foundational only | After Phase 2 (parallel to US1, US2) |
| US4 | AppBottomSheet | Foundational only | After Phase 2 (parallel to US1-3) |
| US5 | AppDrawer/SideSheet | Foundational only | After Phase 2 (parallel to US1-4) |
| US6 | AppTabs | Foundational only | After Phase 2 (parallel to US1-5) |
| US7 | AppBreadcrumb | Foundational only | After Phase 2 (parallel to all above) |
| US8 | AppChipGroup | Foundational only | After Phase 2 (parallel to all) |

**Key Point**: All 8 components are independent - no cross-dependencies between user stories. Once Foundational (Phase 2) is complete, all components can be implemented in parallel.

### Within-Phase Parallelization

**Phase 2 Foundational (8 specs can run in parallel)**:
- T008-T015: All 8 theme specs (all [P])
- T017-T021: All 5 theme implementations (all [P])

**Phase 3 AppExpansionPanel**:
- T023-T024: Component widgets (parallel [P])
- T031: Widgetbook story
- T032: Golden tests
- T033: Unit tests

**Phase 4 AppCarousel**:
- T034-T035: Component widgets (parallel [P])
- T042: Widgetbook story
- T043: Golden tests
- T044: Unit tests

Similar pattern for all remaining phases.

**Phase 11 Polish**:
- T104-T109: Testing and validation (all [P])

### Recommended Execution Strategy: Parallel Teams

**Team 1** (Setup + Foundational):
- Phase 1: All setup tasks
- Phase 2: Split theme spec work across 2-3 devs (each takes 2-3 specs to define)

**After Foundational Complete** (4+ developers):
- Developer A: US1 (AppExpansionPanel) - Phase 3
- Developer B: US2 (AppCarousel) - Phase 4
- Developer C: US3 (AppStepper) - Phase 5
- Developer D: US4 (AppBottomSheet) - Phase 6
- Once T1 done, takes US5 (AppDrawer) - Phase 7
- Once T2 done, takes US6 (AppTabs) - Phase 8
- And so on...

Each developer works independently, commits to own branch, integrates via PR when story complete.

---

## Parallel Example: Complete Phase 3 (AppExpansionPanel)

```bash
# These can run in parallel (different files):
Task: T023 Create AppExpansionPanel widget in lib/src/molecules/expansion_panel/app_expansion_panel.dart
Task: T024 Create ExpansionItem helper widget in lib/src/molecules/expansion_panel/expansion_item.dart

# After above done, in sequence:
Task: T025 Create ExpansionPanelRenderer for theme-specific rendering
Task: T026 Update AppExpansionPanel to use Renderer Pattern

# Then parallel again:
Task: T028 Add Semantics for accessibility
Task: T029 Add Semantics to ExpansionItem
Task: T031 Create Widgetbook story
Task: T032 Create golden tests
Task: T033 Create unit tests
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (1 day)
2. Complete Phase 2: Foundational (2-3 days)
3. Complete Phase 3: User Story 1 (AppExpansionPanel) (1 day)
4. **STOP and VALIDATE**: Demo AppExpansionPanel with all 5 themes
5. Deploy/push to main if ready

**MVP Deliverable**: AppExpansionPanel + 5 themes working, fully tested, golden tests passing

### Incremental Delivery (All 8 Components)

1. Setup + Foundational → Foundation ready
2. Add US1 (AppExpansionPanel) → Test independently → Demo (MVP!)
3. Add US2 (AppCarousel) → Test independently → Demo
4. Add US3 (AppStepper) → Test independently → Demo
5. Add US4 (AppBottomSheet) → Test independently → Demo
6. Add US5 (AppDrawer/SideSheet) → Test independently → Demo
7. Add US6 (AppTabs) → Test independently → Demo
8. Add US7 (AppBreadcrumb) → Test independently → Demo
9. Add US8 (AppChipGroup) → Test independently → Demo
10. Polish phase → Final integration testing

**Each increment**: 1 new component, independent test cycle, additive (no breaking changes to previous components)

### Parallel Team Strategy (4+ Developers)

1. Team (full) completes Setup + Foundational together (3-4 days)
2. Once Foundational done:
   - Dev 1: US1 (AppExpansionPanel)
   - Dev 2: US2 (AppCarousel)
   - Dev 3: US3 (AppStepper)
   - Dev 4: US4 (AppBottomSheet)
3. As devs finish (usually 1-2 days per component):
   - Next dev picks up US5, US6, US7, US8
4. All 8 components complete in ~2-3 weeks with full team

---

## Task Execution Checklist

### Setup Phase (Phase 1)
- [ ] Verify directory structure matches plan.md
- [ ] Confirm build_runner and alchemist in pubspec.yaml
- [ ] All 7 setup tasks complete

### Foundational Phase (Phase 2)
- [ ] All 8 theme specs created with @TailorMixin (T008-T015)
- [ ] All 5 theme implementations updated (T017-T021)
- [ ] Code generation successful: `dart run build_runner build --delete-conflicting-outputs` (T022)
- [ ] No compilation errors after generation

### Each User Story Phase
- [ ] Component widget(s) created (no errors)
- [ ] Theme specs applied and verified
- [ ] Accessibility semantics added
- [ ] Widgetbook story shows component with all themes
- [ ] Golden tests generated and all pass (8 combinations per scenario)
- [ ] Unit tests green, all functionality verified
- [ ] Quickstart example works (copy-paste from quickstart.md)

### Polish Phase (Phase 11)
- [ ] All 240+ golden screenshots generated and reviewed
- [ ] All 8 components visible and correct in Widgetbook
- [ ] Flutter analyze passes (no linting issues)
- [ ] Integration test passes (multi-component flow)
- [ ] Constitution compliance verified
- [ ] All components exported in public API
- [ ] Quickstart guide validated

---

## Notes & Success Criteria

✅ **Tests Passing**: All 71 tasks completed → all components working
✅ **Golden Tests**: 240+ screenshots across all themes → visual consistency verified
✅ **Accessibility**: All components WCAG 2.1 AA compliant → keyboard + screen reader support
✅ **Performance**: 60 FPS on mid-range devices → smooth animations confirmed
✅ **Documentation**: Quickstart examples, Widgetbook stories, API contracts → developers can use immediately
✅ **Theme Support**: All 5 visual languages (Glass, Brutal, Flat, Neumorphic, Pixel) render correctly
✅ **Independent Stories**: Each component works standalone → no cross-dependencies

---

**Total Estimated Time**: 15-21 days with 4 developers (parallel teams), 8-12 weeks with 1 developer (sequential)

**Ready to proceed with Phase 1 Setup**: All prerequisites defined, dependencies clear, success criteria measurable.
