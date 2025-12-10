# Data Model: Unified Button System Architecture

**Feature**: 022-button-system-unified
**Date**: 2025-12-09
**Purpose**: Define entities, relationships, and validation rules for the unified button system

## Core Entities

### ButtonStyleVariant (Enum)

**Purpose**: Defines the three visual style variants for buttons

**Values**:
- `filled` - Solid background with theme-appropriate color
- `outline` - Transparent background with visible border
- `text` - No background or border, text-only appearance

**Validation Rules**:
- Must be one of the three defined values
- Cannot be null when creating button instances
- Used as key for resolving variant-specific styles from ButtonStyle

**Relationships**:
- Referenced by AppButton and AppIconButton for style selection
- Maps to specific surface and color configurations in ButtonStyle
- Combined with SurfaceVariant for final style resolution

---

### AppButtonIconPosition (Enum)

**Purpose**: Defines icon placement relative to button text

**Values**:
- `leading` - Icon appears before (left of) text
- `trailing` - Icon appears after (right of) text

**Validation Rules**:
- Must be one of the two defined values
- Only applicable to AppButton (not AppIconButton)
- Defaults to `leading` when not specified

**Relationships**:
- Used exclusively by AppButton for layout decisions
- Affects Row children ordering in button build method
- Independent of ButtonStyleVariant selection

---

### ButtonStyle (ThemeExtension)

**Purpose**: Unified theme extension containing all button styling information

**Fields**:
```dart
// Filled variant styles
final ButtonSurfaceStates filledSurfaces;
final StateColorSpec filledContentColors;

// Outline variant styles
final ButtonSurfaceStates outlineSurfaces;
final StateColorSpec outlineContentColors;

// Text variant styles
final ButtonSurfaceStates textSurfaces;
final StateColorSpec textContentColors;

// Shared properties
final ButtonTextStyles textStyles;
final ButtonSizeSpec sizeSpec;
final InteractionSpec interaction;
```

**Validation Rules**:
- All fields must be non-null (enforces Constitutional Zero Internal Defaults)
- Must be registered as ThemeExtension in AppDesignTheme
- Surface states must provide enabled, disabled, hovered, pressed styles
- Content colors must support full state resolution

**Relationships**:
- Composes StateColorSpec for state-based color management
- Composes ButtonSurfaceStates for variant-specific surface styling
- Used by both AppButton and AppIconButton for style resolution
- Replaced previous ButtonStyle, IconButtonStyle, TextButtonStyle classes

---

### ButtonSurfaceStates (ThemeExtension)

**Purpose**: State-aware surface definitions for button appearances

**Fields**:
```dart
final SurfaceStyle enabled;   // Default interactive state
final SurfaceStyle disabled;  // Non-interactive state
final SurfaceStyle hovered;   // Mouse hover state
final SurfaceStyle pressed;   // Active press state
```

**Methods**:
```dart
SurfaceStyle resolve({
  required bool isEnabled,
  bool isHovered = false,
  bool isPressed = false,
});
```

**Validation Rules**:
- All SurfaceStyle fields must be non-null
- Resolution follows priority: disabled → pressed → hovered → enabled
- SurfaceStyles must be compatible with AppSurface requirements

**Relationships**:
- Three instances per ButtonStyle (filled, outline, text variants)
- Resolves to SurfaceStyle consumed by AppSurface
- Must align with InteractionSpec for consistent behavior

---

### ButtonSizeSpec (ThemeExtension)

**Purpose**: Size specifications for consistent button dimensions across variants

**Fields**:
```dart
final double smallHeight;     // Height for AppButtonSize.small
final double mediumHeight;    // Height for AppButtonSize.medium
final double largeHeight;     // Height for AppButtonSize.large
final EdgeInsets smallPadding;    // Horizontal padding for small
final EdgeInsets mediumPadding;   // Horizontal padding for medium
final EdgeInsets largePadding;    // Horizontal padding for large
final double iconSpacing;         // Space between icon and text
```

**Methods**:
```dart
double getHeight(AppButtonSize size);
EdgeInsets getPadding(AppButtonSize size);
```

**Validation Rules**:
- All dimensions must be positive values
- Height ratios should maintain visual hierarchy (small < medium < large)
- Padding must provide sufficient touch targets (44px minimum)
- Icon spacing must be consistent with design system tokens

**Relationships**:
- Shared across all button variants and types
- Referenced by both AppButton and AppIconButton
- Must coordinate with ButtonTextStyles for proper visual balance

---

### ButtonTextStyles (ThemeExtension)

**Purpose**: Typography specifications for different button sizes

**Fields**:
```dart
final TextStyle small;    // Typography for AppButtonSize.small
final TextStyle medium;   // Typography for AppButtonSize.medium
final TextStyle large;    // Typography for AppButtonSize.large
```

**Validation Rules**:
- Must use tokens from appTextTheme (Constitutional typography requirements)
- Cannot contain hardcoded fontSize, fontFamily, or fontWeight
- Should use copyWith() pattern for theme-specific customizations
- Font sizes must coordinate with ButtonSizeSpec heights

**Relationships**:
- Used by AppButton for text rendering
- Must harmonize with ButtonSizeSpec for balanced appearance
- Follows Constitutional typography token mapping requirements

---

## Entity Relationships

### Primary Composition Hierarchy

```
AppButton / AppIconButton
├── ButtonStyleVariant (enum selection)
├── SurfaceVariant (semantic emphasis)
└── ButtonStyle (from theme)
    ├── filledSurfaces/outlineSurfaces/textSurfaces → ButtonSurfaceStates
    │   └── resolve() → SurfaceStyle (consumed by AppSurface)
    ├── filledContentColors/outlineContentColors/textContentColors → StateColorSpec
    │   └── resolve() → Color (for text/icon rendering)
    ├── textStyles → ButtonTextStyles
    │   └── small/medium/large → TextStyle
    ├── sizeSpec → ButtonSizeSpec
    │   ├── getHeight() → double
    │   └── getPadding() → EdgeInsets
    └── interaction → InteractionSpec (shared with other components)
```

### Resolution Flow

1. **Component Construction**: AppButton/AppIconButton created with variant and emphasis
2. **Style Lookup**: ButtonStyle retrieved from AppDesignTheme
3. **Variant Resolution**: Appropriate surfaces/colors selected based on ButtonStyleVariant
4. **State Resolution**: Current interaction state determines final surface and color
5. **Size Resolution**: AppButtonSize determines dimensions and typography
6. **Rendering**: Resolved styles applied via AppSurface and text widgets

### Named Constructor Mappings

| Constructor | ButtonStyleVariant | SurfaceVariant | Purpose |
|-------------|-------------------|----------------|---------|
| `primary()` | `filled` | `highlight` | Highest priority actions |
| `primaryOutline()` | `outline` | `highlight` | Primary actions, lighter visual weight |
| `secondary()` | `filled` | `tonal` | Secondary actions |
| `secondaryOutline()` | `outline` | `tonal` | Cancel/back actions |
| `tertiary()` | `filled` | `base` | Tertiary actions |
| `text()` | `text` | `base` | Minimal visual weight |
| `danger()` | `filled` | `accent` | Destructive actions |
| `dangerOutline()` | `outline` | `accent` | Lighter destructive actions |

## Validation Rules

### Cross-Entity Constraints

1. **Theme Completeness**: All five themes (Glass, Brutal, Flat, Neumorphic, Pixel) must provide complete ButtonStyle implementations
2. **State Consistency**: All StateColorSpec instances must support the same state combinations
3. **Size Proportionality**: ButtonSizeSpec dimensions must maintain consistent ratios across themes
4. **Typography Harmony**: ButtonTextStyles must use Constitutional typography tokens exclusively
5. **Accessibility Compliance**: All resolved button sizes must meet minimum touch target requirements

### Integration Constraints

1. **AppSurface Compatibility**: All ButtonSurfaceStates must resolve to valid SurfaceStyle instances
2. **StateColorSpec Resolution**: Color resolution must follow priority order: error → disabled → pressed → hovered → active/inactive
3. **Theme Extension Registration**: ButtonStyle must be properly registered in AppDesignTheme
4. **Backward Compatibility**: Existing button configurations must resolve to identical visual results

### Performance Constraints

1. **Const Construction**: Named constructors must be compile-time constants where possible
2. **Resolution Caching**: Style resolution should avoid expensive computations per frame
3. **Memory Efficiency**: Shared specs should be reused across button instances
4. **Theme Switching**: Style updates must complete within 100ms for theme changes

## Migration Considerations

### Deprecated Entities (Removed)

- `ButtonStyle` (old, separate from IconButtonStyle/TextButtonStyle)
- `IconButtonStyle` (consolidated into unified ButtonStyle)
- `TextButtonStyle` (consolidated into unified ButtonStyle)

### Backward Compatibility Entities (Preserved)

- `AppButtonSize` enum (unchanged)
- `SurfaceVariant` enum (unchanged, used for semantic emphasis)
- Existing AppButton/AppIconButton constructor signatures (preserved)

### New Entities (Added)

- `ButtonStyleVariant` enum
- `AppButtonIconPosition` enum
- Unified `ButtonStyle` ThemeExtension
- `ButtonSurfaceStates` ThemeExtension
- `ButtonTextStyles` ThemeExtension
- `ButtonSizeSpec` ThemeExtension

This data model ensures type safety, Constitutional compliance, and seamless integration with the existing design system while providing the foundation for both simplified named constructors and advanced customization capabilities.