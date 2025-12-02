# Data Model: Live Theme Editor

**Date**: 2025-12-02
**Feature**: Live Theme Editor (006-theme-editor)
**Phase**: 1 (Design)

---

## Overview

The editor manages theme state through a hierarchical model that mirrors the AppDesignTheme structure. All theme adjustments flow through a single source of truth (`ThemeEditorState`) managed by `ThemeEditorController`.

---

## Core Entities

### ThemeEditorState

Represents the complete editor state at any moment.

```dart
class ThemeEditorState {
  /// The current theme being edited
  final AppDesignTheme currentTheme;

  /// Current brightness mode (light or dark)
  final Brightness brightness;

  /// Whether the theme has unsaved changes (UI hint only)
  final bool hasUnsavedChanges;

  /// Identifier for the current theme preset (optional)
  final String? currentPresetName;

  ThemeEditorState({
    required this.currentTheme,
    this.brightness = Brightness.light,
    this.hasUnsavedChanges = false,
    this.currentPresetName,
  });

  /// Create a copy with selective field updates
  ThemeEditorState copyWith({
    AppDesignTheme? currentTheme,
    Brightness? brightness,
    bool? hasUnsavedChanges,
    String? currentPresetName,
  }) { ... }
}
```

**Responsibilities**:
- Encapsulate the current theme and display mode
- Provide immutable snapshot for Provider subscribers
- Support efficient partial updates via `copyWith()`

**Key Relationships**:
- Holds `AppDesignTheme` (from ui_kit_library)
- Holds `Brightness` enum (light/dark mode toggle state)

---

### AppDesignTheme (from ui_kit_library)

This is the primary data structure. The editor does not modify AppDesignTheme directly; instead, it reads and reconstructs it via `copyWith()` calls.

**Expected Structure** (based on spec):
```dart
class AppDesignTheme {
  // Color specs
  final ColorScheme colorScheme;

  // Surface variants
  final SurfaceStyle surfaceBase;
  final SurfaceStyle surfaceElevated;
  final SurfaceStyle surfaceHighlight;

  // Input variants
  final InputStyle inputOutline;
  final InputStyle inputUnderline;
  final InputStyle inputFilled;

  // Global metrics
  final double spacingFactor;
  final Duration animationDuration;

  // Component-specific specs
  final LoaderSpec loaderSpec;
  final ToggleSpec toggleSpec;
  final NavigationSpec navigationSpec;

  // Factory for defaults
  factory AppDesignTheme.light() { ... }
  factory AppDesignTheme.dark() { ... }

  // Copy with selective updates
  AppDesignTheme copyWith({ ... }) { ... }
}
```

**Key Assumptions**:
- All theme classes support `copyWith()` for immutable updates
- Default values are accessible via factory constructors
- Color properties use Flutter's `Color` class

---

### SurfaceStyle

Represents a single surface variant (Base, Elevated, Highlight).

**Expected Structure**:
```dart
class SurfaceStyle {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double blurStrength;
  final Color shadowColor;
  final double shadowOpacity;
  final Offset shadowOffset;

  SurfaceStyle copyWith({ ... }) { ... }
}
```

**Editor Mapping**:
- Each property maps to one `PropertyEditor` widget (DoubleProperty, ColorProperty, etc.)
- Combined surface variants edit the `InputStyle` composite

---

### InputStyle

Represents input field appearance across variants (Outline, Underline, Filled).

**Expected Structure**:
```dart
class InputStyle {
  final SurfaceStyle outlineStyle;
  final SurfaceStyle underlineStyle;
  final SurfaceStyle filledStyle;
  final Color focusOverlayColor;
  final Color errorOverlayColor;

  InputStyle copyWith({ ... }) { ... }
}
```

**Editor Mapping**:
- `InputStyleEditor` displays three `SurfaceStyleEditor` instances (one per variant)
- Focus and error colors get dedicated `ColorProperty` widgets

---

### Preview Context

Represents the viewing context for the preview area.

```dart
class PreviewContext {
  /// Light or Dark mode
  final Brightness brightness;

  /// Mobile width (~380dp) or Desktop width (>800dp)
  final bool isMobileWidth;

  /// Computed preview width in logical pixels
  double get previewWidth => isMobileWidth ? 380 : 1200;
}
```

**Editor Usage**:
- Toggle buttons control `brightness` and `isMobileWidth`
- Preview area uses `PreviewContext` to render Dashboard Hero Demo at appropriate size/theme

---

## State Flow Diagram

```
User adjusts slider/picker
       ↓
PropertyEditor calls onChanged()
       ↓
ControlPanel updates Controller
       ↓
ThemeEditorController.updateSurfaceBase(...) called
       ↓
Controller notifies listeners (Provider)
       ↓
LiveEditorPage rebuilds via Consumer
       ↓
PreviewArea receives new theme
       ↓
Dashboard Hero Demo renders with updated theme
       ↓
✅ Preview updates (target: <16ms)
```

---

## Data Immutability Strategy

**Principle**: All state updates are immutable. No direct mutations.

**Example - Color Update**:
```dart
// ❌ DON'T
controller.currentTheme.surfaceBase.backgroundColor = Color(0xFFFF0000);

// ✅ DO
final updatedBase = controller.currentTheme.surfaceBase.copyWith(
  backgroundColor: Color(0xFFFF0000),
);
final updatedTheme = controller.currentTheme.copyWith(
  surfaceBase: updatedBase,
);
controller.updateTheme(updatedTheme);
```

**Benefits**:
- Predictable state transitions
- Enables time-travel debugging
- Efficient Provider change detection

---

## Serialization Requirements

### For Code Export

The code generator must convert the following types:

| Type | Export Format | Example |
|------|---------------|---------|
| `Color` | Hex constructor | `Color(0xFFFF5733)` |
| `double` | Numeric literal | `12.5` |
| `bool` | Boolean literal | `true` / `false` |
| `Duration` | Constructor | `Duration(milliseconds: 300)` |
| `Offset` | Constructor | `Offset(2.0, 2.0)` |
| `SurfaceStyle` | Constructor | `SurfaceStyle(backgroundColor: Color(...), ...)` |
| `AppDesignTheme` | Constructor | `AppDesignTheme(spacingFactor: 1.0, ...)` |

**Implementation**: Create `color_utils.dart` with:
```dart
String colorToHex(Color color) => '0x${color.value.toRadixString(16).toUpperCase().padLeft(8, '0')}';
```

---

## Default Values

All properties must have documented defaults for the Reset function.

**Proposed Default Theme** (Glass or Flat style):
- `spacingFactor`: 1.0
- `blurStrength`: 10.0
- `borderRadius`: 12.0
- `primaryColor`: `Color(0xFF6200EE)` (Material Purple)
- `surfaceColor`: `Color(0xFFFAFAFA)`
- `animationDuration`: `Duration(milliseconds: 200)`

**Action**: Verify defaults from existing `ThemeFactory` in ui_kit_library and document in this section.

---

## Validation Rules

None of the theme properties require strict validation. The spec explicitly allows extreme values (e.g., radius 200, blur 1000) and expects graceful handling in preview.

**Exception**: Color values should normalize to valid Color objects (hex parsing must handle 0xAARRGGBB format).

---

## Relationships & Dependencies

```
ThemeEditorState
├── AppDesignTheme (from ui_kit_library)
│   ├── SurfaceStyle (x3: Base, Elevated, Highlight)
│   ├── InputStyle
│   ├── LoaderSpec
│   ├── ToggleSpec
│   └── NavigationSpec
├── Brightness enum
└── hasUnsavedChanges (UI state)

PreviewContext
├── Brightness
└── isMobileWidth (bool)
```

---

## Evolutionary Considerations

**Future Extensions**:
- Preset save/load (would add `presetStorage` to state)
- Multi-theme comparison (would add `referenceTheme` to state)
- Undo/redo (would add `history: List<ThemeEditorState>`)
- Custom color palettes (would add `userPalettes: List<ColorPalette>`)

**Current Scope**: Intentionally minimal; avoid pre-engineering for hypothetical features.

---

**Status**: ✅ READY FOR CONTRACTS DEFINITION
