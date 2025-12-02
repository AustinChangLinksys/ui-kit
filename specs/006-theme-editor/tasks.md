# Tasks: Live Theme Editor

**Input**: Design documents from `/specs/006-theme-editor/`
**Prerequisites**: plan.md ✅, spec.md ✅, data-model.md ✅, contracts/ ✅, research.md ✅, quickstart.md ✅

**Organization**: Tasks are grouped by user story priority (P1 → P2 → P3) to enable independent implementation and incremental delivery.

**Implementation Strategy**: MVP first - complete Phases 1-2 + US1, test independently, then proceed to P2 and P3 stories.

---

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies on incomplete tasks)
- **[Story]**: Which user story (US1, US2, US3, US4, US5) - REQUIRED for user story phases
- Include exact file paths in all descriptions

## Path Conventions

- **Editor project**: `editor/` directory at repository root
- **Lib code**: `editor/lib/`
- **Tests**: `editor/test/`
- **Web resources**: `editor/web/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

**Checkpoint**: Editor project created, dependencies installed, basic structure in place

- [x] T001 Create Flutter Web project at `editor/` using `flutter create -t app --platforms web editor`
- [x] T002 [P] Configure `editor/pubspec.yaml` with dependencies: Provider ^6.0.0, flex_color_picker ^3.0.0, gap ^3.0.0, ui_kit_library (path: ../)
- [x] T003 [P] Create main.dart entry point in `editor/lib/main.dart` with app initialization
- [x] T004 [P] Create app.dart root widget in `editor/lib/app.dart` with MaterialApp setup
- [x] T005 [P] Create directory structure: `editor/lib/{pages,models,controllers,widgets/{property_editors,spec_editors},utils}`
- [x] T006 [P] Create theme_editor_state.dart model in `editor/lib/models/theme_editor_state.dart` with AppDesignTheme, Brightness, hasUnsavedChanges fields
- [x] T007 Verify Dashboard Hero Demo is available from ui_kit_library (check export from ui_kit_library/lib/ui_kit.dart)
  - If Demo is not available: Create minimal showcase widget in `editor/lib/widgets/demo_showcase.dart` displaying representative UI Kit components (buttons, cards, inputs, navigation)
- [x] T008 [P] Configure web/index.html with proper base href for GitHub Pages deployment

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core state management and infrastructure that ALL user stories depend on

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

**Checkpoint**: State management working, controller can update theme and notify listeners, basic integration tests pass

- [x] T009 Implement ThemeEditorController in `editor/lib/controllers/theme_editor_controller.dart`
  - Constructor initializing currentTheme and brightness
  - Properties: `currentTheme`, `brightness`, `hasUnsavedChanges` (as getters with notifyListeners)
  - Methods: `updateTheme()`, `toggleBrightness()`, `reset()`
  - Extend ChangeNotifier for Provider integration
- [x] T010 [P] Implement color_utils.dart in `editor/lib/utils/color_utils.dart`
  - `colorToHex(Color color)` → String in format `0xAARRGGBB`
  - `hexToColor(String hex)` → Color object
  - Test with standard hex formats (with/without 0x prefix, 6-digit and 8-digit variants)
- [ ] T011 [P] Implement basic code_generator.dart in `editor/lib/utils/code_generator.dart`
  - Skeleton `generateDartCode(AppDesignTheme theme)` → String
  - Serialize AppDesignTheme to Dart constructor format
  - Test with simple theme values
- [x] T012 Create ChangeNotifierProvider integration in main.dart wrapping LiveEditorPage
- [x] T013 [P] Create preview_area.dart in `editor/lib/widgets/preview_area.dart`
  - Accept theme, brightness, isMobileWidth parameters
  - Wrap Dashboard Hero Demo in Theme widget
  - Handle extreme parameter values gracefully (no crashes)
  - Test: Render with sample theme
- [x] T014 [P] Create base property editors skeleton in `editor/lib/widgets/property_editors/`
  - Create double_property.dart with Slider + TextFormField layout (no logic yet)
  - Create color_property.dart with color indicator button (opens color picker dialog, no logic yet)
  - Create bool_property.dart with SwitchListTile
  - Create enum_property.dart with DropdownButton
- [x] T015 [P] Create error handling utility in `editor/lib/utils/error_handler.dart`
  - Safe preview rendering (catch errors from Dashboard Hero Demo, show error message)
  - Test: Verify preview doesn't crash with broken component
- [x] T016 Test Phase 2 completeness: Controller updates trigger Provider notifications, preview renders without crashing

---

## Phase 3: User Story 1 - Real-time Theme Parameter Tuning (Priority: P1) 🎯 MVP

**Goal**: Core WYSIWYG value - adjust theme parameters and see instant preview updates (< 16ms)

**Independent Test**: Adjust border radius slider → preview updates instantly with new radius visible on all cards

### Tests for User Story 1

> **Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T017 [P] [US1] Integration test: Adjust single parameter and verify preview update in `editor/test/integration/theme_update_test.dart`
- [ ] T018 [P] [US1] Performance test: Measure time from slider adjustment to preview visual update in `editor/test/integration/performance_test.dart`

### Implementation for User Story 1

- [x] T019 [US1] Implement DoubleProperty widget in `editor/lib/widgets/property_editors/double_property.dart`
  - Slider onChange → calls controller method
  - TextFormField for precise input
  - Clamp values to min/max
  - Test: Drag slider and verify onChanged callback fires
- [x] T020 [US1] Implement ColorProperty widget in `editor/lib/widgets/property_editors/color_property.dart`
  - Show color indicator button
  - Tap button → open ColorPickerDialog (using flex_color_picker with palette support enabled)
  - Support hex input and palette selection in picker (FR-012 compliance)
  - Dialog returns Color → calls onChanged
  - Test: Select color via hex input and palette, verify callback with correct Color
- [x] T021 [P] [US1] Add updateSurfaceBase, updateSurfaceElevated, updateSurfaceHighlight methods to ThemeEditorController
  - These call updateTheme() with copyWith() on specific surface
  - Ensure notifyListeners() is called for all subscribers
- [x] T022 [P] [US1] Add updateInputStyle method to ThemeEditorController
  - Handles updating InputStyle (Outline, Underline, Filled all together)
- [x] T023 [US1] Create SurfaceStyleEditor in `editor/lib/widgets/spec_editors/surface_style_editor.dart`
  - Wrapped in ExpansionTile with title ("Base", "Elevated", "Highlight")
  - Contains: ColorProperty (backgroundColor, borderColor), DoubleProperty (borderWidth, borderRadius, blurStrength, shadowOpacity)
  - onChange callbacks update surface and call onChanged callback
  - Test: Edit all properties and verify they're captured in updated SurfaceStyle
- [x] T024 [US1] Create ControlPanel skeleton in `editor/lib/widgets/control_panel.dart`
  - Top toolbar with placeholder buttons (Dark Mode, Reset, Export)
  - ListView containing SurfaceStyleEditor for Base variant only (other variants come later)
  - Pass theme and callbacks to child widgets
- [x] T025 [US1] Create LiveEditorPage in `editor/lib/pages/live_editor_page.dart`
  - Split layout: PreviewArea (flex: 3) + ControlPanel (flex: 1) using Row
  - Use Consumer<ThemeEditorController> to subscribe to theme changes
  - Pass theme, brightness, callbacks from controller to child widgets
  - Test: Layout renders, preview and control panel visible
- [x] T026 [US1] Wire up SurfaceStyleEditor changes to ThemeEditorController in ControlPanel
  - onSurfaceBaseChanged → controller.updateSurfaceBase()
  - Verify preview updates immediately when slider is dragged
- [x] T027 [US1] Test User Story 1: Drag border radius slider and visually verify all cards update instantly

**Checkpoint**: User Story 1 MVP complete. Single parameter adjustments work with instant preview updates. Ready to demo.

---

## Phase 4: User Story 2 - Control Panel for Spec-Based Parameter Editing (Priority: P1)

**Goal**: Fully organized, discoverable control panel with all spec editors grouped by type

**Independent Test**: Open control panel → find Surface, Input, Global Metrics sections → edit all properties in Surface Base → export code shows all changes

### Tests for User Story 2

- [ ] T028 [P] [US2] Integration test: Open all spec editor sections and verify they're present in `editor/test/integration/control_panel_test.dart`
- [ ] T029 [P] [US2] Integration test: Edit all properties in one Surface variant and verify code export includes changes in `editor/test/integration/export_test.dart`
- [ ] T029b [P] [US2] Integration test: Expand all control panel sections simultaneously and verify scrolling works in `editor/test/integration/overflow_test.dart`

### Implementation for User Story 2

- [x] T030 [US2] Create InputStyleEditor in `editor/lib/widgets/spec_editors/input_style_editor.dart`
  - Three nested SurfaceStyleEditors (Outline, Underline, Filled variants)
  - ColorProperty for focusOverlayColor and errorOverlayColor
  - onChange reassembles InputStyle and calls onChanged callback
  - Test: Edit one input variant color and verify all three variants update independently
- [x] T031 [P] [US2] Create GlobalMetricsEditor in `editor/lib/widgets/spec_editors/global_metrics_editor.dart`
  - DoubleProperty for spacingFactor (0.5-2.0)
  - DoubleProperty for animationDuration (100-500ms)
  - onChange calls callback with record/tuple of both values
- [x] T032 [P] [US2] Create LoaderSpecEditor in `editor/lib/widgets/spec_editors/loader_spec_editor.dart` (skeleton)
  - Map LoaderSpec properties to property editors
  - Use same pattern as SurfaceStyleEditor
- [x] T033 [P] [US2] Create ToggleSpecEditor in `editor/lib/widgets/spec_editors/toggle_spec_editor.dart` (skeleton)
  - Map ToggleSpec properties to property editors
- [x] T034 [P] [US2] Create NavigationSpecEditor in `editor/lib/widgets/spec_editors/navigation_spec_editor.dart` (skeleton)
  - Map NavigationSpec properties to property editors
- [x] T035 [US2] Add updateInputStyle, updateGlobalMetrics, updateLoaderSpec, updateToggleSpec, updateNavigationSpec to ThemeEditorController
  - Each calls updateTheme() with copyWith() and notifyListeners()
- [x] T036 [US2] Update ControlPanel to display all spec editors
  - Add InputStyleEditor, GlobalMetricsEditor, LoaderSpecEditor, ToggleSpecEditor, NavigationSpecEditor to ListView
  - Wire up all onChanged callbacks to controller methods
  - Ensure scrolling if content exceeds viewport
- [x] T037 [US2] Implement overflow handling for control panel in `editor/lib/widgets/control_panel.dart`
  - If control panel content exceeds available height, enable ListView scrolling
  - Test: With many specs expanded, verify content is scrollable and all editors remain accessible
  - Edge case (from spec): Handle users with many custom specs via scrolling
- [ ] T038 [US2] Test User Story 2: Open each spec editor section, adjust properties, verify code export captures all changes

**Checkpoint**: User Story 2 complete. All spec editors present and functional. Control panel is fully discoverable and organized by spec type.

---

## Phase 5: User Story 3 - Dark Mode and Responsive Simulation (Priority: P1)

**Goal**: Support light/dark theme variants and mobile/desktop responsive preview

**Independent Test**: Toggle dark mode → preview switches instantly. Click mobile width → navigation changes from rail to bar.

### Tests for User Story 3

- [ ] T038 [P] [US3] Integration test: Toggle dark mode and verify preview theme changes in `editor/test/integration/dark_mode_test.dart`
- [ ] T039 [P] [US3] Integration test: Toggle mobile/desktop width and verify navigation component switches in `editor/test/integration/responsive_test.dart`

### Implementation for User Story 3

- [x] T040 [US3] Add brightness toggle support to PreviewArea
  - Accept brightness parameter
  - Conditional: Render Dashboard Hero Demo with light or dark theme based on brightness
  - Test: Pass different brightness values and verify theme switches
- [x] T041 [US3] Add responsive width support to PreviewArea
  - Accept isMobileWidth boolean
  - Constrain preview width: mobile (~380dp) or desktop (full width)
  - Test: Pass different widths and verify preview resizes
- [x] T042 [US3] Create toolbar buttons in ControlPanel
  - Dark Mode toggle button: calls onDarkModeToggle() callback
  - Mobile Width button: calls onMobileWidth() callback
  - Desktop Width button: calls onDesktopWidth() callback
  - Test: Click buttons and verify callbacks fire
- [x] T043 [US3] Wire up toolbar buttons to ThemeEditorController
  - toggleBrightness() called by Dark Mode toggle
  - New properties: isMobileWidth (boolean, default true for testing purposes)
  - Notify listeners on brightness or width change
- [x] T044 [US3] Update LiveEditorPage to manage and pass isMobileWidth state
  - Store isMobileWidth as state
  - Pass to PreviewArea
  - Pass width toggle callbacks from ControlPanel to LiveEditorPage
- [x] T045 [US3] Test User Story 3: Dark mode toggle works, mobile/desktop width buttons work, navigation component switches

**Checkpoint**: User Story 3 complete. Light/dark modes work, mobile/desktop simulation works, theme adjustments persist across mode switches.

---

## Phase 6: User Story 4 - Export Theme as Dart Code (Priority: P2)

**Goal**: Generate production-ready Dart code that can be copied directly into projects

**Independent Test**: Adjust 5+ parameters, click Export, copy code, paste into Dart file, compile → app matches editor preview

### Tests for User Story 4

- [ ] T046 [P] [US4] Unit test: Code generator produces valid Dart syntax for all property types in `editor/test/unit/code_generator_test.dart`
- [ ] T047 [P] [US4] Integration test: Export code matches adjusted theme parameters in `editor/test/integration/export_validation_test.dart`

### Implementation for User Story 4

- [ ] T048 [US4] Complete code_generator.dart implementation in `editor/lib/utils/code_generator.dart`
  - Convert all SurfaceStyle properties to Dart (colors as hex, doubles as literals, etc.)
  - Convert InputStyle to nested SurfaceStyle constructors
  - Convert all theme properties to AppDesignTheme constructor format
  - Validate output is syntactically valid Dart
  - Test with simple theme, verify code is valid
- [ ] T049 [US4] Add generateCode() method to ThemeEditorController
  - Calls code_generator.generateDartCode(currentTheme)
  - Returns String with complete constructor
- [ ] T050 [US4] Create ExportPanel widget in `editor/lib/widgets/export_panel.dart`
  - Display generated code in scrollable text widget
  - Copy to clipboard button
  - Show code in monospace font, syntax highlighted if possible
  - Test: Generate code and verify it's readable
- [ ] T051 [US4] Add Export button to ControlPanel toolbar
  - Click → open dialog/bottom sheet with ExportPanel
  - Show code and copy button
  - Test: Click export and verify code appears
- [ ] T052 [US4] Test User Story 4: Adjust multiple parameters, export code, verify syntax and content

**Checkpoint**: User Story 4 complete. Export button works, generates valid code, users can copy and use.

---

## Phase 7: User Story 5 - Reset to Default Theme (Priority: P3)

**Goal**: Convenience feature to quickly revert to baseline theme

**Independent Test**: Adjust parameters, click Reset, all values revert within 1 second, preview shows baseline theme

### Tests for User Story 5

- [ ] T053 [P] [US5] Integration test: Click reset and verify all properties return to defaults in `editor/test/integration/reset_test.dart`

### Implementation for User Story 5

- [ ] T054 [US5] Implement reset() method in ThemeEditorController in `editor/lib/controllers/theme_editor_controller.dart`
  - Load default theme values (from documented factory methods)
  - Set brightness to Brightness.light
  - Set hasUnsavedChanges to false
  - notifyListeners()
  - Performance requirement: Must complete within 1 second (synchronous in-memory operation, no async)
  - Test: Measure reset execution time and verify < 1000ms
- [ ] T055 [US5] Add Reset button to ControlPanel toolbar
  - Click → calls controller.reset()
  - Test: Click and verify theme reverts
- [ ] T056 [US5] Test User Story 5: Adjust parameters, click reset, verify all values and preview revert

**Checkpoint**: User Story 5 complete. Reset button functional. All P1 and P3 user stories working.

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Improvements affecting multiple stories, refinements, and final validation

**Checkpoint**: Full feature complete, tested, documented, ready for deployment

- [ ] T057 [P] Run `flutter test` in editor/ directory and ensure all unit tests pass
- [ ] T058 [P] Run `flutter test --integration` (if integration tests present) and ensure all pass
- [ ] T059 [P] Build web release: `flutter build web --release --base-href /ui_kit/editor/` from editor/
- [ ] T060 [P] Verify web build artifacts are created in `editor/build/web/`
- [ ] T061 Performance profiling: Use Flutter DevTools to verify theme updates are <16ms (run multiple times with different parameter counts)
- [ ] T062 Test edge cases:
  - Extreme parameter values (radius 500, blur 1000) → preview handles gracefully
  - Rapid slider adjustments → no lag or crashes
  - Export code → paste into blank Dart file → parses as valid Dart
- [ ] T063 [P] Code cleanup:
  - Remove console logs and debug print statements
  - Verify no analyzer warnings: `flutter analyze`
  - Run formatter: `dart format lib/`
- [ ] T064 Documentation review:
  - Verify quickstart.md matches actual implementation
  - Test all steps in quickstart on clean environment
  - Update any paths or dependencies that changed
- [ ] T065 [P] Offline functionality test:
  - Load editor in browser
  - Disconnect network
  - Verify all features still work (theme editing, export, etc.)
- [ ] T066 Error handling verification:
  - If Dashboard Hero Demo has errors, editor shows friendly error message (doesn't crash)
  - Invalid hex color input → handled gracefully
  - Extreme parameter values → preview renders without crashing
- [ ] T067 Accessibility check:
  - Theme editor keyboard navigable (can tab through controls)
  - Color indicator has label for screen readers
  - Preview maintains contrast ratios in both light and dark modes
- [ ] T068 [P] Final integration test: Full workflow from clean start
  - Open editor
  - Adjust 10+ parameters
  - Switch dark mode
  - Toggle mobile width
  - Reset
  - Export
  - Verify no crashes, all features work

---

## Phase 9: CI/CD & Deployment Setup

**Purpose**: Automate building and deploying editor to GitHub Pages

**Checkpoint**: Editor automatically builds and deploys on main branch updates

- [ ] T069 Create/update GitHub Actions workflow in `.github/workflows/` to build editor alongside Widgetbook
  - Build command: `cd editor && flutter build web --release --base-href /ui_kit/editor/`
  - Output to `gh-pages` branch in `editor/` subdirectory
  - Ensure editor builds are versioned together with Widgetbook
- [ ] T070 [P] Verify GitHub Pages is configured to serve from `gh-pages` branch
- [ ] T071 [P] Test CI/CD: Push to main branch and verify editor builds and deploys successfully
- [ ] T072 Verify deployed editor is accessible at `https://<org>/<repo>/editor/`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Phase 8)**: Depends on all desired user stories being complete
- **CI/CD & Deployment (Phase 9)**: Can start after Phase 8

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Phase 2 - No dependencies on other stories
- **User Story 2 (P1)**: Can start after Phase 2 - Builds on US1 but independently testable
- **User Story 3 (P1)**: Can start after Phase 2 - Builds on US1/US2 but independently testable
- **User Story 4 (P2)**: Can start after Phase 2 - Builds on all US1, US2, US3
- **User Story 5 (P3)**: Can start after Phase 2 - Completely independent
- **Polish (Phase 8)**: Requires at least US1 done; ideally all stories done

### Within Each User Story

- Tests (T### entries) → Models/Core Implementation → Integration
- Each user story should be independently completable and testable

### Parallel Opportunities

**During Phase 1 (Setup)**:
- T002, T003, T004, T005, T006, T008 marked [P] can run in parallel

**During Phase 2 (Foundational)**:
- T010, T011 marked [P] can run in parallel (color_utils and code_generator)
- T013, T014, T015 marked [P] can run in parallel (preview_area, property_editors, error_handler)

**During User Stories (Phase 3+)**:
- Once Foundational is complete, all 5 user stories can start in parallel
- Within User Story 2: LoaderSpecEditor, ToggleSpecEditor, NavigationSpecEditor (T032, T033, T034) marked [P]
- Multiple developers can work on different stories simultaneously

**During Phase 8 (Polish)**:
- T057, T058, T059, T060 marked [P] can run in parallel
- T063, T065, T067 marked [P] can run in parallel

### Parallel Execution Example: All User Stories After Phase 2

```
Developer A: US1 (T019-T027)
Developer B: US2 (T030-T037)
Developer C: US3 (T040-T045)
Developer D: US4 (T048-T052)
Developer E: US5 (T054-T056)

All complete and integrate independently → Phase 8 Polish together
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

**Time to working MVP**: ~1-2 days per developer

1. Complete Phase 1: Setup (T001-T008) - 2-3 hours
2. Complete Phase 2: Foundational (T009-T016) - 4-6 hours
3. Complete Phase 3: User Story 1 (T017-T027) - 6-8 hours
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy to GitHub Pages or demo to team

**Total MVP time**: ~1 day focused work

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo (+ P1 complete)
4. Add User Story 3 → Test independently → Deploy/Demo (all P1 complete)
5. Add User Story 4 → Test independently → Deploy/Demo (+ P2)
6. Add User Story 5 → Test independently → Deploy/Demo (all P3)
7. Each story adds value without breaking previous stories

### Parallel Team Strategy (5 developers)

1. All team members: Complete Setup + Foundational together (2-3 hours)
2. Once Foundational is done (Phase 2 complete):
   - Developer A: User Story 1 (T019-T027) - 6-8 hours
   - Developer B: User Story 2 (T030-T037) - 6-8 hours
   - Developer C: User Story 3 (T040-T045) - 4-6 hours
   - Developer D: User Story 4 (T048-T052) - 4-6 hours
   - Developer E: User Story 5 (T054-T056) - 2-3 hours
3. Stories complete in parallel → integrate during Phase 8 Polish
4. All together: Phase 8 Polish & Phase 9 CI/CD

**Total parallel time**: ~4-5 hours (Setup + Foundational) + ~8 hours (longest story) = ~13 hours wall-clock time

---

## Task Checklist Format Validation

**ALL tasks follow strict format**:
- ✅ Checkbox: `- [ ]`
- ✅ Task ID: Sequential (T001, T002, ... T072)
- ✅ [P] markers: Only when parallelizable
- ✅ [Story] labels: [US1], [US2], etc. for user story phases only
- ✅ File paths: All tasks include specific file paths in descriptions

---

## Notes

- [P] tasks = different files, no dependencies on incomplete tasks within same phase
- [Story] label maps task to specific user story for traceability
- Each user story (Phase 3-7) should be independently completable and testable
- Tests (when present) should be written and FAIL before implementation (TDD approach)
- Commit after each task or logical group (every 2-3 tasks)
- Stop at any checkpoint to validate story independently before moving to next
- Each phase has a "Checkpoint" note indicating when that phase is complete and ready for next phase
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence

---

## Summary

**Total Tasks**: 72 (including tests, setup, polish, and CI/CD)

**Tasks per Priority**:
- Phase 1 (Setup): 8 tasks
- Phase 2 (Foundational): 8 tasks
- Phase 3 (US1 - P1): 10 tasks
- Phase 4 (US2 - P1): 8 tasks
- Phase 5 (US3 - P1): 6 tasks
- Phase 6 (US4 - P2): 5 tasks
- Phase 7 (US5 - P3): 3 tasks
- Phase 8 (Polish): 12 tasks
- Phase 9 (CI/CD): 4 tasks

**MVP Scope** (recommended first release): Phases 1, 2, 3 (US1 only) = 26 tasks

**Full Feature Scope**: All 9 phases = 72 tasks

**Parallel Opportunities**: ~40% of tasks marked [P] can run in parallel

**Implementation Path**: MVP first (1-2 days) → Incremental delivery (1 week) → Full feature with CI/CD (1-2 weeks for 1 dev, ~1 week for 5 devs)

---

**Status**: ✅ READY FOR IMPLEMENTATION

Each task is specific enough for LLM or human execution. Begin with Phase 1, validate after each phase, proceed incrementally.
