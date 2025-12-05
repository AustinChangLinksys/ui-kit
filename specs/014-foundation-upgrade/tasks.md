# Tasks: System Foundation Upgrades

**Feature**: System Foundation Upgrades  
**Status**: Pending  
**Branch**: `014-foundation-upgrade`

## Phase 1: Setup
**Goal**: Initialize project structure and dependencies.

- [x] T001 Create directory structure for foundation modules in `lib/src/foundation/` (motion, effects, icons)
- [x] T002 Verify and add dependencies (`theme_tailor`, `flutter_svg`) in `pubspec.yaml`

## Phase 2: Foundational
**Goal**: Prepare the theme system for extensions.
*These tasks are prerequisites for all user stories.*

- [x] T003 Update `lib/src/foundation/theme/design_system/app_design_theme.dart` to ensure it is ready for new property injections (Motion, Effects, Icons)

## Phase 3: User Story 1 - Adaptive Motion System (P1)
**Goal**: Implement a unified motion interface that adapts to the active theme.
**Independent Test**: `AppDesignTheme.of(context).motion` returns correct `MotionSpec` (duration/curve) for Flat, Glass, and Pixel themes.

- [x] T004 [US1] Create `MotionSpec` class in `lib/src/foundation/motion/motion_spec.dart`
- [x] T005 [US1] Create `StepsCurve` class (for Pixel theme) in `lib/src/foundation/motion/steps_curve.dart`
- [x] T006 [US1] Create `AppMotion` abstract interface in `lib/src/foundation/motion/app_motion.dart`
- [x] T007 [P] [US1] Implement `FlatMotion` strategy in `lib/src/foundation/motion/flat_motion.dart`
- [x] T008 [P] [US1] Implement `GlassMotion` strategy in `lib/src/foundation/motion/glass_motion.dart`
- [x] T009 [P] [US1] Implement `PixelMotion` strategy in `lib/src/foundation/motion/pixel_motion.dart`
- [x] T010 [US1] Add `AppMotion` property to `AppDesignTheme` in `lib/src/foundation/theme/design_system/app_design_theme.dart`
- [x] T011 [US1] Update concrete theme styles to include motion implementations in `lib/src/foundation/theme/design_system/styles/` (e.g., `glass_design_theme.dart`, `flat_design_theme.dart`)

## Phase 4: User Story 2 - Global Visual Effects Overlay (P2)
**Goal**: Add global visual textures (Noise, CRT) overlaying the app based on theme.
**Independent Test**: Switching themes toggles the full-screen overlay (Noise for Glass, CRT for Pixel, None for Flat) without blocking interaction.

- [x] T012 [US2] Create `GlobalEffectsType` enum in `lib/src/foundation/effects/global_effects_type.dart`
- [x] T013 [US2] Add `visualEffects` property to `AppDesignTheme` in `lib/src/foundation/theme/design_system/app_design_theme.dart`
- [x] T014 [US2] Create `GlobalEffectsOverlay` widget in `lib/src/foundation/effects/global_effects_overlay.dart` (Initial scaffold with `IgnorePointer`)
- [x] T015 [P] [US2] Implement "Noise" effect logic in `lib/src/foundation/effects/global_effects_overlay.dart`
- [x] T016 [P] [US2] Implement "CRT/Scanline" effect logic in `lib/src/foundation/effects/global_effects_overlay.dart`
- [x] T017 [P] [US2] Implement 'Reduced Motion' check in `lib/src/foundation/effects/global_effects_overlay.dart` to respect user accessibility settings
- [x] T018 [US2] Inject `GlobalEffectsOverlay` into the main app builder in `generative_ui/example/lib/main.dart`
- [x] T019 [US2] Add `GlobalEffectsOverlay` UseCase to Widgetbook in `widgetbook/lib/foundation/effects/global_effects_overlay_usecase.dart`
- [x] T020 [US2] Add Golden Tests for `GlobalEffectsOverlay` in `test/foundation/effects/global_effects_overlay_test.dart` using Safe Mode

## Phase 5: User Story 3 - Style-Adaptive Iconography (P3)
**Goal**: `AppIcon` automatically resolves to the correct asset style based on the theme.
**Independent Test**: `AppIcon` renders different assets/styles when the theme changes (Vector for Flat, Stroke for Glass, Pixelated for Pixel).

- [x] T021 [US3] Create `AppIconStyle` enum in `lib/src/foundation/icons/app_icon_style.dart`
- [x] T022 [US3] Add `iconStyle` property to `AppDesignTheme` in `lib/src/foundation/theme/design_system/app_design_theme.dart`
- [x] T023 [US3] Update `AppIcon` widget to resolve assets using `AppIconStyle` in `lib/src/atoms/icons/app_icon.dart`
- [x] T024 [US3] Add `AppIcon` UseCases (Flat, Glass, Pixel) to Widgetbook in `widgetbook/lib/atoms/icons/app_icon_usecase.dart`
- [x] T025 [US3] Update Golden Tests for `AppIcon` to cover new styles in `test/atoms/icons/app_icon_test.dart`

## Phase 6: Polish & Cross-Cutting
**Goal**: Finalize exports and verify system integrity.

- [x] T026 Export new foundation classes (Motion, Effects, Icons) in `lib/ui_kit.dart`
- [x] T027 Verify "Zero-Touch Policy" compliance (ensure no core logic was broken in existing components)
- [x] T028 Run `flutter test` to ensure no regressions

## Dependencies
1. **Setup & Foundation** (T001-T003) MUST be completed first.
2. **US1 (Motion)** (T004-T011) depends on Foundation.
3. **US2 (Effects)** (T012-T020) depends on Foundation.
4. **US3 (Icons)** (T021-T025) depends on Foundation.

## Parallel Execution Examples
- **Motion Strategies**: `FlatMotion` (T007), `GlassMotion` (T008), and `PixelMotion` (T009) can be implemented simultaneously.
- **Effects Logic**: Noise (T015) and CRT (T016) effects can be developed in parallel.
- **QA Tasks**: Widgetbook (T019, T024) and Golden Tests (T020, T025) can be written by QA engineers in parallel with feature implementation once interfaces are stable.

## Implementation Strategy
- **MVP**: Complete Phase 1, 2, and Phase 3 (US1).
- **Increment 1**: Add Phase 4 (Global Effects) including A11y and QA.
- **Increment 2**: Add Phase 5 (Adaptive Icons) including QA.