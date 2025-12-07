# Tasks: Legacy Components Migration

**Branch**: `019-legacy-migration`
**Spec**: `specs/019-legacy-migration/spec.md`

## Phase 1: Setup

Goal: Initialize the feature branch and prepare shared configuration.

- [ ] T001 Create feature directory `lib/src/molecules/slide_action`
- [ ] T002 Create feature directory `lib/src/organisms/expandable_fab`
- [ ] T003 Create feature directory `lib/src/organisms/gauge`
- [ ] T004 Create Theme Extension file `lib/src/foundation/theme/styles/slide_action_style.dart`
- [ ] T005 Create Theme Extension file `lib/src/foundation/theme/styles/expandable_fab_style.dart`
- [ ] T006 Create Theme Extension file `lib/src/foundation/theme/styles/gauge_style.dart`
- [ ] T007 Register new ThemeExtensions in `lib/src/foundation/theme/design_system/app_design_theme.dart` (Add to `AppDesignTheme` class and factory)

## Phase 2: Foundational

Goal: Implement the Data Models and Theme Extensions required by all components.

- [ ] T008 Implement `SlideActionItem` data model and `SlideActionVariant` enum in `lib/src/molecules/slide_action/slide_action_item.dart`
- [ ] T009 Implement `SlideActionStyle` ThemeExtension in `lib/src/foundation/theme/styles/slide_action_style.dart` with `theme_tailor` annotation
- [ ] T010 Implement `ExpandableFabStyle` ThemeExtension and `FabAnimationType` enum in `lib/src/foundation/theme/styles/expandable_fab_style.dart`
- [ ] T011 Implement `GaugeStyle` ThemeExtension, `GaugeRenderType` and `GaugeCapType` enums in `lib/src/foundation/theme/styles/gauge_style.dart`
- [ ] T012 Run `dart run build_runner build` to generate Tailor mixins
- [ ] T013 Update `FlatDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart` to populate new extensions
- [ ] T014 Update `GlassDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart` to populate new extensions
- [ ] T015 Update `PixelDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart` to populate new extensions
- [ ] T016 Update `NeumorphicDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart` to populate new extensions
- [ ] T017 Update `BrutalDesignTheme` factory in `lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart` to populate new extensions

## Phase 3: User Story 1 (Slide Action)

Goal: Implement `AppSlideAction` molecule.

- [ ] T018 [US1] Create `AppSlideAction` widget skeleton in `lib/src/molecules/slide_action/app_slide_action.dart`
- [ ] T019 [US1] Implement Horizontal Drag Gesture and Velocity detection in `lib/src/molecules/slide_action/app_slide_action.dart`
- [ ] T020 [US1] Implement Threshold Snapping logic (Open/Close state) using `AnimationController` in `lib/src/molecules/slide_action/app_slide_action.dart`
- [ ] T021 [US1] Implement Rendering of Action Items (Background + Icons) based on `SlideActionStyle` in `lib/src/molecules/slide_action/app_slide_action.dart`
- [ ] T022 [US1] Integrate `AppFeedback.onTap` for action clicks in `lib/src/molecules/slide_action/app_slide_action.dart`
- [ ] T023 [US1] Add `AppSlideAction` UseCase to Widgetbook in `widgetbook/lib/stories/molecules/slide_action/slide_action_stories.dart`
- [ ] T024 [US1] Create Golden Test for SlideAction in `test/molecules/slide_action/app_slide_action_golden_test.dart` (Verify Pixel Snap, Neumorphic Shadow using Safe Mode protocol)

## Phase 4: User Story 2 (Expandable FAB)

Goal: Implement `AppExpandableFab` organism.

- [ ] T025 [US2] Create `AppExpandableFab` widget skeleton in `lib/src/organisms/expandable_fab/app_expandable_fab.dart`
- [ ] T026 [US2] Implement Overlay/Barrier logic using `OverlayEntry` in `lib/src/organisms/expandable_fab/app_expandable_fab.dart` (Ensure background interaction is blocked)
- [ ] T027 [US2] Implement Primary Toggle Button with Icon Rotation in `lib/src/organisms/expandable_fab/app_expandable_fab.dart`
- [ ] T028 [US2] Implement Satellite Actions Layout logic (Fan-out vs Float vs GridSnap) based on `ExpandableFabStyle.type` in `lib/src/organisms/expandable_fab/app_expandable_fab.dart`
- [ ] T029 [US2] Implement Scrim Rendering (Blur vs Dither vs Solid) based on `ExpandableFabStyle` in `lib/src/organisms/expandable_fab/app_expandable_fab.dart`
- [ ] T030 [US2] Add `AppExpandableFab` UseCase to Widgetbook in `widgetbook/lib/stories/organisms/expandable_fab/expandable_fab_stories.dart`
- [ ] T031 [US2] Create Golden Test for ExpandableFab in `test/organisms/expandable_fab/app_expandable_fab_golden_test.dart` (Verify Glass Blur, Pixel Grid using Safe Mode protocol)

## Phase 5: User Story 3 (Gauge)

Goal: Implement `AppGauge` organism.

- [ ] T032 [US3] Create `AppGauge` widget skeleton in `lib/src/organisms/gauge/app_gauge.dart`
- [ ] T033 [US3] Create `GaugePainter` class for CustomPainter logic in `lib/src/organisms/gauge/gauge_painter.dart`
- [ ] T034 [US3] Implement `GaugeRenderType.gradient` logic (SweepGradient) in `lib/src/organisms/gauge/gauge_painter.dart`
- [ ] T035 [US3] Implement `GaugeRenderType.segmented` logic (Discrete blocks) in `lib/src/organisms/gauge/gauge_painter.dart`
- [ ] T036 [US3] Implement `GaugeRenderType.solid` logic (Stroke) in `lib/src/organisms/gauge/gauge_painter.dart`
- [ ] T037 [US3] Implement `GaugeCapType` logic (Comet, Round, Butt, Bead) in `lib/src/organisms/gauge/gauge_painter.dart`
- [ ] T038 [US3] Connect `AppGauge` widget to `GaugePainter` and `AnimationController` (driven by `GaugeStyle`) in `lib/src/organisms/gauge/app_gauge.dart`
- [ ] T038b [US3] Implement and verify `customSignalStrong` override logic in `AppGauge` (Respects `AppThemeConfig` overrides)
- [ ] T039 [US3] Add `AppGauge` UseCase to Widgetbook in `widgetbook/lib/stories/organisms/gauge/gauge_stories.dart`
- [ ] T040 [US3] Create Golden Test for Gauge in `test/organisms/gauge/app_gauge_golden_test.dart` (Verify Comet Tail, Segmented Blocks using Safe Mode protocol)

## Phase 6: Polish & Deprecation

Goal: Deprecate legacy components and finalize testing.

- [ ] T041 Deprecate `AppSlideActionContainer` in `lib/src/molecules/slide_action_container.dart` (Add `@deprecated` annotation)
- [ ] T042 Deprecate `ExpandableFab` in `lib/src/organisms/expandable_fab.dart` (Add `@deprecated` annotation)
- [ ] T043 Deprecate `AnimatedMeter` in `lib/src/organisms/animated_meter.dart` (Add `@deprecated` annotation)
- [ ] T044 Run `flutter test --update-goldens` to generate all new golden files
- [ ] T045 Verify all tests pass with `flutter test`

## Dependencies

- Phase 1 & 2 blocks all User Stories (US1, US2, US3)
- User Stories (US1, US2, US3) can be implemented in parallel
- Phase 6 blocks completion

## Implementation Strategy

1.  **MVP**: Complete Phase 1 & 2 to establish the styling foundation.
2.  **Incremental**: Implement one component at a time (SlideAction -> FAB -> Gauge).
3.  **Parallel**: Multiple developers can work on US1, US2, and US3 simultaneously after Phase 2 is complete.
