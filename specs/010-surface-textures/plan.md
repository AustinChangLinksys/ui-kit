# Implementation Plan: Surface Texture Support

**Branch**: `010-surface-textures` | **Date**: 2025-12-03 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/010-surface-textures/spec.md`

## Summary

Enhance `AppSurface` to support texture overlays. This involves adding `texture` and `textureOpacity` properties to `SurfaceStyle` and updating the `AppSurface` build logic to render these textures using `BoxDecoration`. This enables sophisticated visual styles like "Frosted Glass with Noise" or "Brutalism with Halftone Patterns" while maintaining the Logic-Free/Theme-Driven architecture.

## Technical Context

**Language/Version**: Dart 3.0+ / Flutter 3.10+
**Primary Dependencies**: `flutter` (widgets, painting)
**Storage**: N/A
**Testing**: `flutter_test`, `golden_toolkit` (regression testing)
**Target Platform**: iOS, Android, Web, macOS, Windows
**Project Type**: Flutter Package (UI Library)
**Performance Goals**: Texture rendering must be efficient (using native `BoxDecoration` optimized path).
**Constraints**: Must maintain backward compatibility (surfaces without textures must look identical).

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] **High Cohesion**: Texture logic remains inside `AppSurface` and `SurfaceStyle`.
- [x] **Logic-Free**: Components do not decide *when* to show texture; they just render what the Theme says.
- [x] **Theme-Driven**: Configuration lives in `SurfaceStyle`.
- [x] **Dependency Hygiene**: Uses only Flutter native primitives.
- [x] **No Native Containers**: `AppSurface` is updated, not replaced.

## Project Structure

### Documentation (this feature)

```text
specs/010-surface-textures/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── checklists/
│   └── requirements.md
└── tasks.md             # Phase 2 output (to be created)
```

### Source Code (repository root)

```text
lib/
├── src/
│   ├── atoms/
│   │   └── surfaces/
│   │       └── app_surface.dart       # Update: Add texture rendering logic
│   └── foundation/
│       └── theme/
│           ├── design_system/
│           │   └── specs/
│           │       └── surface_style.dart # Update: Add texture fields
│           └── tokens/
│               └── app_textures.dart      # Create: Standard texture patterns (Grid, Noise, Lines)
```

**Structure Decision**: Modifying existing files in `src/atoms` and `src/foundation` as this is an enhancement to core primitives.

## Complexity Tracking

N/A - No violations.