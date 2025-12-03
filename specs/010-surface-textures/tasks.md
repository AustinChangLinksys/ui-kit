# Tasks: Surface Texture Support

**Feature Branch**: `010-surface-textures`
**Spec**: [spec.md](spec.md)
**Status**: Pending

## Dependencies

- Phase 1 (Setup) -> Phase 2 (Foundational) -> Phase 3 (User Stories) -> Phase 7 (Polish)
- User Stories are generally independent, but sharing the common `AppSurface` implementation.

## Phase 1: Setup

**Goal**: Prepare the codebase with necessary data structures and assets.

- [x] T001 Create `AppTextures` token class with standard patterns in `lib/src/foundation/theme/tokens/app_textures.dart` (Verify existing)
- [x] T002 Update `SurfaceStyle` to include texture fields in `lib/src/foundation/theme/design_system/specs/surface_style.dart`

## Phase 2: Foundational

**Goal**: Implement the core rendering logic in the primitive component.

- [x] T003 [US1] Update `AppSurface` to render texture via `BoxDecoration` in `lib/src/atoms/surfaces/app_surface.dart`
- [x] T004 [US1] Implement visual regression test for texture rendering in `test/atoms/surfaces/app_surface_golden_test.dart` (MUST follow Constitution Appendix B: Safe Mode Protocol)

## Phase 3: User Story 1 - Apply Texture to Surface (Priority: P1)

**Goal**: Ensure textures can be applied and are visible.

**Independent Test**: Verify texture overlays background color.

- [x] T005 [US1] Add "Texture" knob to Widgetbook story in `widgetbook/lib/atoms/surfaces/surface.story.dart`
- [x] T006 [US1] Verify backward compatibility (no texture = no change) in `test/atoms/surfaces/app_surface_test.dart`
- [x] T016 [US1] Verify graceful degradation on texture load failure in `test/atoms/surfaces/app_surface_test.dart` (Edge Case)

## Phase 4: User Story 2 - Control Texture Opacity (Priority: P1)

**Goal**: enable opacity control for textures.

**Independent Test**: Verify texture transparency changes with opacity value.

- [x] T007 [US2] Verify `AppSurface` applies `textureOpacity` correctly in `lib/src/atoms/surfaces/app_surface.dart` (Should be covered by T003, this is verification)
- [x] T008 [US2] Add opacity control knob to Widgetbook in `widgetbook/lib/atoms/surfaces/surface.story.dart`

## Phase 5: User Story 3 - Seamless Pattern Tiling (Priority: P2)

**Goal**: Ensure textures repeat instead of stretch.

**Independent Test**: Small texture fills large surface.

- [x] T009 [US3] Verify `ImageRepeat.repeat` is used in `lib/src/atoms/surfaces/app_surface.dart`
- [x] T010 [US3] Create golden test for tiled rendering in `test/atoms/surfaces/app_surface_golden_test.dart` (MUST follow Constitution Appendix B: Safe Mode Protocol)

## Phase 6: User Story 4 - Retro/Pixel Theme Support (Priority: P2)

**Goal**: Enable tokenized texture usage.

**Independent Test**: `AppTextures.pixelGrid` renders correctly.

- [x] T011 [US4] Create example usage in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart` (or new `PixelDesignTheme` if appropriate, using Glass for demo)
- [x] T012 [US4] Verify `AppTextures` tokens render correctly in Widgetbook

## Phase 7: Polish & Cross-Cutting

**Goal**: Documentation and final cleanup.

- [x] T013 Update `quickstart.md` with new examples if needed
- [x] T014 Final review of `AppSurface` code for performance optimization (const constructors, etc.)
- [x] T015 Run all tests and ensure 100% pass rate

## Implementation Strategy

1.  **MVP**: Complete Phases 1 & 2 to get texture rendering working.
2.  **Verification**: Use Widgetbook (Phases 3 & 4) to visually verify.
3.  **Expansion**: Add tokens and specific theme support (Phase 6).
