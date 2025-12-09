---
description: Generate a complete Design Theme implementation extending AppDesignTheme.
---

## User Input

```text
$ARGUMENTS
```

You **MUST** parse the user input for:
- **Theme name** (e.g., `Cyberpunk`, `Vintage`, `Corporate`)
- **Style characteristics** (optional description)

If missing theme name, ask the user.

## Goal

Generate a complete Design Theme that:
1. Extends `AppDesignTheme` with full compliance
2. Implements all required style specs
3. Registers with `CustomDesignTheme`
4. Provides both light and dark variants

## Operating Constraints

**Constitution 7.2**: New styles MUST fully implement `AppDesignTheme` and `AppColorScheme`.

**Constitution 4.3**: Must define distinct rendering strategy following one of the 5 paradigms or create a new one.

**NO GUESSING POLICY**:
- **NEVER** assume theme characteristics without explicit user input
- **NEVER** choose colors, animations, or effects based on assumptions
- **ALWAYS** ask the user about style characteristics before generating

**AMBIGUITY RESOLUTION**:
When encountering any of these situations, **STOP immediately and ask the user**:
1. Theme name is missing
2. Base paradigm (Flat/Glass/Brutal/Pixel/Neumorphic) is not specified or clear
3. Primary color or color palette is not defined
4. Animation style preference is unclear
5. Border and shadow preferences are not specified
6. Any special visual effects requirements are ambiguous

## Theme Paradigm Reference

| Paradigm | Key Characteristics | Animation | Borders | Shadows |
|----------|---------------------|-----------|---------|---------|
| Flat | Solid colors, standard radii | Standard (250ms) | Subtle | Minimal |
| Glass | Opacity, blur, glow | Slow (500ms) | None | Glow |
| Brutal | Bold borders, high contrast | Fast (150ms) | Thick (2-4px) | Offset |
| Pixel | Aliased, retro | Instant (0ms) | Aliased | None |
| Neumorphic | Embossed, double shadows | Standard | Rounded | Light+Dark |

## Execution Steps

### 1. Define Theme Characteristics

Ask or infer:

| Aspect | Question |
|--------|----------|
| Base Paradigm | Which existing style is closest? (for reference) |
| Primary Use | What's the brand/mood? |
| Animation | Smooth, snappy, or instant? |
| Borders | Visible, subtle, or none? |
| Shadows | Glow, drop, embossed, or none? |
| Special Effects | Any unique visual treatments? |

### 2. Generate Theme File

Create `lib/src/foundation/theme/design_system/styles/{theme_snake}_design_theme.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart'
    as shared;

class {ThemeName}DesignTheme extends AppDesignTheme {
  // ============================================
  // Factory 1: Create from Config (for remote theming)
  // ============================================
  factory {ThemeName}DesignTheme.fromConfig(AppThemeConfig config) {
    final colors = AppColorFactory.generate{ThemeName}(config);
    return {ThemeName}DesignTheme._raw(colors);
  }

  // ============================================
  // Factory 2: Raw Mode (AppColorScheme driven)
  // ============================================
  factory {ThemeName}DesignTheme._raw(AppColorScheme colors) {
    return {ThemeName}DesignTheme._(
      // ==========================================
      // Core Surfaces (Constitution 6.1)
      // ==========================================
      surfaceBase: SurfaceStyle(
        backgroundColor: colors.styleBackground,
        borderColor: colors.subtleBorder,
        borderWidth: 1.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: colors.surfaceContainerLow,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: [
          BoxShadow(
            color: colors.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        blurStrength: 0.0,
        contentColor: colors.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: colors.primary,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: colors.onPrimary,
        interaction: const InteractionSpec(
          pressedScale: 0.98,
          pressedOpacity: 0.9,
          hoverOpacity: 0.95,
          pressedOffset: Offset.zero,
        ),
      ),
      surfaceSecondary: SurfaceStyle(
        backgroundColor: colors.secondaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: colors.onSecondaryContainer,
      ),
      surfaceTertiary: SurfaceStyle(
        backgroundColor: colors.tertiaryContainer,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: colors.onTertiaryContainer,
      ),

      // ==========================================
      // Global Settings
      // ==========================================
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      ),
      spacingFactor: 1.0,
      buttonHeight: 48.0,
      motion: const FlatMotion(),  // Or custom motion class
      visualEffects: GlobalEffectsType.none,
      iconStyle: AppIconStyle.vectorFilled,

      // ==========================================
      // Component Styles
      // (Copy from flat_design_theme.dart as base,
      //  then customize for your theme)
      // ==========================================

      // ... all required component styles ...
    );
  }

  // ============================================
  // Private Constructor
  // ============================================
  const {ThemeName}DesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.surfaceSecondary,
    required super.surfaceTertiary,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
    // ... all required parameters ...
  });

  // ============================================
  // Light Factory
  // ============================================
  factory {ThemeName}DesignTheme.light([ColorScheme? scheme]) {
    scheme ??= ColorScheme.fromSeed(
      seedColor: Colors.{primaryColor},  // Theme primary
      brightness: Brightness.light,
    );
    // ... implementation ...
  }

  // ============================================
  // Dark Factory
  // ============================================
  factory {ThemeName}DesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= ColorScheme.fromSeed(
      seedColor: Colors.{primaryColor},
      brightness: Brightness.dark,
    );
    // ... implementation ...
  }
}
```

### 3. Add Color Factory Method

Add to `lib/src/foundation/theme/tokens/app_color_factory.dart`:

```dart
static AppColorScheme generate{ThemeName}(AppThemeConfig config) {
  // Generate colors based on config
  // Use config.seedColor or defaults
}
```

### 4. Register with CustomDesignTheme

Update `lib/src/foundation/theme/design_system/styles/custom_design_theme.dart`:

```dart
static const List<String> availableStyles = [
  'glass',
  'flat',
  'brutal',
  'neumorphic',
  'pixel',
  '{theme_lower}',  // Add new theme
];

static AppDesignTheme fromConfig({
  required String style,
  required AppThemeConfig config,
}) {
  return switch (style.toLowerCase()) {
    // ... existing cases ...
    '{theme_lower}' => {ThemeName}DesignTheme.fromConfig(config),
    _ => FlatDesignTheme.fromConfig(config),
  };
}
```

### 5. Update Exports

Add to `lib/ui_kit.dart`:

```dart
export 'src/foundation/theme/design_system/styles/{theme_snake}_design_theme.dart';
```

### 6. Output Summary

```markdown
## Design Theme Generated: {ThemeName}DesignTheme

### Files Created/Modified
- [x] `lib/src/foundation/theme/design_system/styles/{theme_snake}_design_theme.dart`
- [ ] Update `custom_design_theme.dart` (registration)
- [ ] Update `app_color_factory.dart` (color generation)
- [ ] Update `lib/ui_kit.dart` (export)

### Theme Characteristics
| Aspect | Value |
|--------|-------|
| Base Paradigm | {paradigm} |
| Animation | {animation_preset} |
| Border Style | {border_style} |
| Shadow Style | {shadow_style} |

### Testing Checklist
- [ ] Light mode renders correctly
- [ ] Dark mode renders correctly
- [ ] All component styles are defined
- [ ] Golden tests pass across all components

### Next Steps
1. Complete all component style definitions
2. Run `flutter analyze` to verify
3. Test with Theme Editor
4. Generate golden tests for new theme
```

## Example Usage

```
/uikit.theme Cyberpunk - Neon colors, dark backgrounds, glow effects
/uikit.theme Corporate - Clean, professional, blue palette
/uikit.theme Vintage - Warm colors, rounded corners, soft shadows
```

## Context

$ARGUMENTS
