# Technical Implementation Plan: App Unified Color System

**Phase:** Foundation Layer Refactoring
**Goal:** Implement `AppColorScheme` & `AppColorFactory`
**Tools:** `theme_tailor`, `build_runner`

## 1\. Technical Context

### Missing Information (Needs Clarification)
*   **None:** The specification provides complete details on the architectural model (Dependency Injection, Factory Pattern), color generation logic (Waterfall: Base -> Style), and the exact data model structure (Standard & Semantic Layers). No further research is required.

### Technology Choices
*   **Theme Extension Generation:** `theme_tailor` (v2.0.0+) is mandated by the project constitution for generating strongly-typed theme extensions.
*   **Code Generation:** `build_runner` is the standard tool for executing `theme_tailor`.
*   **Color Handling:** Flutter's native `Color` and `ColorScheme` classes will be used as the base. `Color.alphaBlend` will be used for harmonization logic.

## 2\. Constitution Compliance Check

### Compliance Analysis
*   **[1. Vision & Scope] High Cohesion:** The plan centralizes color logic into `AppColorFactory`, removing it from individual widgets or scattered helpers.
*   **[2.1 Physical Isolation] Independent Package:** The implementation remains within `lib/ui_kit`, respecting the library boundary.
*   **[3.1 Inversion of Control] Theme as Configuration:** `AppThemeConfig` acts as the configuration injection, determining the "How" of color generation.
*   **[3.2 Data-Driven Strategy] Spec over Logic:** `AppColorScheme` is a data carrier; consumers (Widgets) read values, they don't calculate them.
*   **[4.1 Single Source of Truth] AppDesignTheme:** `AppColorScheme` will be integrated into `AppDesignTheme` (or accessed via standard extension pattern), serving as the sole source for colors.
*   **[4.4 Automation] Theme Tailor:** The plan explicitly uses `@TailorMixin` for `AppColorScheme`.
*   **[12.2 Golden Tests] Test Isolation:** The verification checklist implies testing, though specific Golden Test updates will be part of the execution (implied by "Verification Checklist").

### Gate Evaluation
*   **Gate Passed:** The plan aligns perfectly with the constitution's architectural and styling principles.

## 3\. Phase 0: Research & Prototypes (Skipped)

*   **Skipped:** No "NEEDS CLARIFICATION" items were identified. The requirements are well-defined.

## 4\. Phase 1: Design & Contracts

### Data Model (`data-model.md`)
See section 2 of the original plan output for the `AppColorScheme` class definition. It defines the schema for the unified color system.

### API Contracts
The "API" here is the internal Dart API exposed by the `ui_kit` library to the app.
*   **Configuration API:** `AppThemeConfig` (Inputs: Seed, Overrides).
*   **Consumption API:** `AppColorScheme` (Outputs: Material Colors, Style Colors).
*   **Factory API:** `AppColorFactory` (Static method: `generateNeumorphic(config)`).

### Quickstart (`quickstart.md`)
*(Self-contained within the implementation steps below)*
1.  Define `AppThemeConfig`.
2.  Call `AppColorFactory.generateNeumorphic(config)`.
3.  Inject resulting `AppColorScheme` into `ThemeData` via `extensions`.
4.  Access via `Theme.of(context).extension<AppColorScheme>()`.

## 5\. Implementation Steps

### Step 1: Environment & Base Infrastructure
1.  **Update Dependencies:** Verify `pubspec.yaml` has `theme_tailor_annotations: ^2.0.0`, `build_runner`, `theme_tailor`.
2.  **Create Data Model:** Implement `AppColorScheme` in `lib/src/foundation/theme/app_color_scheme.dart` with all fields defined in spec (Standard + Semantic layers).
    *   **UPDATE:** Model now includes ALL Material 3 color properties (Containers, Inverse, etc.).
    *   Annotate with `@TailorMixin()`.
    *   Include `toMaterialScheme()` helper.
3.  **Generate Code:** Run `flutter pub run build_runner build`.

### Step 2: Logic Core
1.  **Create Config:** Implement `AppThemeConfig` in `lib/src/foundation/theme/app_theme_config.dart` to hold inputs.
2.  **Create Factory:** Implement `AppColorFactory` in `lib/src/foundation/theme/app_color_factory.dart`.
    *   Implement `generateNeumorphic` logic:
        *   **Phase 1:** `ColorScheme.fromSeed` (incorporating Material overrides).
        *   **Phase 2:** Calculate semantic colors (Signal, Overlay, Glow) using `Color.alphaBlend` based on Phase 1 results.
        *   **Phase 3:** Apply Style overrides from Config.
    *   **UPDATE:** Added factories for `generateGlass`, `generateBrutal`, `generateFlat`, and `generatePixel`.

### Step 3: Integration
1.  **Update Theme:** Modify `NeumorphicDesignTheme` (or `AppDesignTheme` base) to accept/utilize `AppColorScheme`.
    *   Add `fromConfig` factory constructor.
    *   Add `_raw` factory for direct injection.
    *   **UPDATE:** Applied same integration pattern to `GlassDesignTheme`, `BrutalDesignTheme`, `FlatDesignTheme`, and `PixelDesignTheme`.
2.  **Export:** Ensure new files are exported in `lib/ui_kit.dart` (or appropriate barrel file).

### Step 4: Verification
1.  **Unit Tests:** Create `test/foundation/app_color_factory_test.dart`.
    *   Test **Seed Propagation:** `seed: Blue` -> `signalStrong` is greenish-blue.
    *   Test **Material Override:** `primary: Red` -> `glowColor` is reddish.
    *   Test **Style Override:** `customSignalStrong: Yellow` -> `signalStrong` is Yellow.
    *   Test **Dark Mode:** `brightness: dark` -> `highContrastBorder` is light.
    *   **UPDATE:** Verified generation across all theme styles without error.

## 6\. Artifacts

*   **Specs:** `specs/017-unified-color-system/spec.md`
*   **Plan:** `specs/017-unified-color-system/plan.md`
*   **Checklist:** `specs/017-unified-color-system/checklists/requirements.md`

## 7\. Implemented Changes Summary

*   **Full Material 3 Support:** `AppColorScheme` now includes all Material 3 color tokens (e.g., `primaryContainer`, `onSurfaceVariant`, `inverseSurface`), ensuring full compatibility with modern Flutter widgets.
*   **Multi-Theme Support:** `AppColorFactory` now supports 5 distinct generation strategies:
    *   `generateNeumorphic`: Soft, extruded surfaces.
    *   `generateGlass`: Translucent, blurred backgrounds.
    *   `generateBrutal`: High contrast, thick borders, hard shadows.
    *   `generateFlat`: Minimalist, clean lines, no shadows.
    *   `generatePixel`: Retro, grid-aligned, dithered textures.
*   **Unified Integration:** All `*DesignTheme` classes now implement `fromConfig(AppThemeConfig)` and `_raw(AppColorScheme)` factories, standardizing how themes are built from the color system.
