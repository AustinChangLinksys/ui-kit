# Feature Tasks: App Unified Color System

**Feature**: Unified Color System (017-unified-color-system)  
**Phase**: Foundation Layer Refactoring  
**Status**: Completed

## Dependencies

- **Phase 1**: Setup - 0 dependencies
- **Phase 2**: Foundational - Depends on Phase 1
- **Phase 3**: User Story 1 (Seamless Material Updates) - Depends on Phase 2
- **Phase 4**: User Story 2 (Specific Style Overrides) - Depends on Phase 3 (Extends Factory)
- **Phase 5**: User Story 3 (Dark Mode Adaptation) - Depends on Phase 3 (Factory Logic)
- **Phase 6**: Integration - Depends on all stories
- **Phase 7**: Extend to All Themes - Depends on Phase 6

## Implementation Strategy

- **MVP Scope**: Implement `AppColorScheme`, `AppThemeConfig`, and `AppColorFactory` with basic "Waterfall" logic (User Story 1).
- **Incremental Delivery**: 
  1.  Create Data Models and Config (Phase 2).
  2.  Implement Factory with basic seamless propagation (Phase 3).
  3.  Add override capability (Phase 4).
  4.  Add Dark Mode logic (Phase 5).
  5.  Integrate Neumorphic (Phase 6).
  6.  Integrate Glass, Brutal, Flat, Pixel (Phase 7).
- **Testing Strategy**: Unit tests for Factory logic are critical. Widget tests are less relevant as this is a logic-heavy feature.

---

## Phase 1: Setup & Infrastructure

**Goal**: Ensure environment is ready for code generation and new dependencies.

- [x] T001 Verify and update `pubspec.yaml` with `theme_tailor_annotations: ^2.0.0`, `build_runner`, and `theme_tailor`
- [x] T002 Run `flutter pub get` to ensure all dependencies are installed

---

## Phase 2: Foundational (Blocking)

**Goal**: Implement the core Data Models (`AppColorScheme`, `AppThemeConfig`) required by all stories.

- [x] T003 [P] Create `lib/src/foundation/theme/app_color_scheme.dart` with `AppColorScheme` class annotated with `@TailorMixin` and defining all Standard/Semantic fields
- [x] T004 [P] Create `lib/src/foundation/theme/app_theme_config.dart` with `AppThemeConfig` class defining all input fields (seed, Material overrides, Style overrides)
- [x] T005 Run `flutter pub run build_runner build` to generate `app_color_scheme.tailor.dart`
- [x] T006 [P] Create `lib/src/foundation/theme/app_color_factory.dart` skeleton class (empty `generateNeumorphic` method)

---

## Phase 3: User Story 1 - Seamless Material Updates (P1)

**Goal**: Implement the "Waterfall" generation logic where Style colors derive from Material overrides.

**Independent Test**: `test/foundation/app_color_factory_test.dart` - Verify `primary` override changes `glowColor`.

- [x] T007 [US1] Create `test/foundation/app_color_factory_test.dart` with test case: `test('Material override propagates to derived style colors', ...)`
- [x] T008 [US1] Implement `Step 1: Base Scheme Generation` in `AppColorFactory.generateNeumorphic` using `ColorScheme.fromSeed` and `AppThemeConfig` overrides
- [x] T009 [US1] Implement `Step 2: Style Logic Calculation` in `AppColorFactory.generateNeumorphic` to derive default style colors (Glow, Signal) from the *generated* Base Scheme
- [x] T010 [US1] Implement `Step 3: Assembly` in `AppColorFactory.generateNeumorphic` returning `AppColorScheme` (ignoring explicit style overrides for now)
- [x] T011 [US1] Verify T007 test passes (seamless propagation working)

---

## Phase 4: User Story 2 - Specific Style Overrides (P1)

**Goal**: Allow specific Style overrides to take precedence over calculated values.

**Independent Test**: `test/foundation/app_color_factory_test.dart` - Verify `customSignalStrong` overrides calculated value.

- [x] T012 [US2] Add test case to `test/foundation/app_color_factory_test.dart`: `test('Explicit style override takes precedence over calculated value', ...)`
- [x] T013 [US2] Update `AppColorFactory.generateNeumorphic` to use `config.customX` values if present, falling back to calculated values
- [x] T014 [US2] Verify T012 test passes

---

## Phase 5: User Story 3 - Dark Mode Adaptation (P2)

**Goal**: Ensure logic correctly inverts or adapts for Dark Mode.

**Independent Test**: `test/foundation/app_color_factory_test.dart` - Verify `highContrastBorder` changes luminosity based on brightness.

- [x] T015 [US3] Add test case to `test/foundation/app_color_factory_test.dart`: `test('High contrast border adapts to brightness', ...)`
- [x] T016 [US3] Update `AppColorFactory.generateNeumorphic` to check `config.brightness` and switch logic for `highContrastBorder` (and `styleShadow`, `subtleBorder`)
- [x] T017 [US3] Verify T015 test passes

---

## Phase 6: Integration & Polish (Neumorphic)

**Goal**: Integrate with the actual Theme system and clean up.

- [x] T018 Update `lib/ui_kit.dart` to export new files
- [x] T019 Update `lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart` to use `AppColorFactory`
- [x] T020 Run `flutter analyze` and fix any linting errors
- [x] T021 Run all tests in `test/foundation/` to ensure no regressions

---

## Phase 7: Extend to All Themes

**Goal**: Apply the `AppColorFactory` and `AppColorScheme` pattern to the remaining design styles.

- [x] T022 [P] Implement `AppColorFactory.generateGlass` and integrate into `GlassDesignTheme`
- [x] T023 [P] Implement `AppColorFactory.generateBrutal` and integrate into `BrutalDesignTheme`
- [x] T024 [P] Implement `AppColorFactory.generateFlat` and integrate into `FlatDesignTheme`
- [x] T025 [P] Implement `AppColorFactory.generatePixel` and integrate into `PixelDesignTheme`
- [x] T026 Update `AppColorFactory` unit tests to cover basic generation for new themes (at least ensuring they run without error)
- [x] T027 Run full test suite to ensure no regression across all themes