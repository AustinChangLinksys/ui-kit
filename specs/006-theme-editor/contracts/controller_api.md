# ThemeEditorController API Contract

**Module**: `editor/lib/controllers/theme_editor_controller.dart`
**Type**: Business Logic Controller (Provider-managed)
**Pattern**: ChangeNotifier with immutable state

---

## Overview

`ThemeEditorController` is the single source of truth for editor state. It manages theme updates, brightness toggling, and code generation. All state mutations flow through this controller; UI widgets subscribe via Provider and Consumer.

---

## State Properties

### currentTheme
```dart
AppDesignTheme get currentTheme
```
- **Type**: `AppDesignTheme`
- **Mutability**: Read-only (updated via methods)
- **Subscribers**: Notified on any theme change

### brightness
```dart
Brightness get brightness
```
- **Type**: `Brightness` (light/dark enum)
- **Mutability**: Read-only (updated via `toggleBrightness()`)
- **Subscribers**: Notified on brightness change

### hasUnsavedChanges
```dart
bool get hasUnsavedChanges
```
- **Type**: `bool`
- **Mutability**: Managed internally (set true on theme change, false on reset/export)
- **Purpose**: UI hint for unsaved state indicator

---

## Core Methods

### updateTheme
```dart
void updateTheme(AppDesignTheme newTheme)
```
- **Description**: Replace entire theme state
- **Parameters**:
  - `newTheme`: Complete AppDesignTheme object
- **Side Effects**:
  - Notifies listeners
  - Sets `hasUnsavedChanges = true`
  - Triggers preview rebuild
- **Performance**: Synchronous; should complete <5ms
- **Example Usage**:
  ```dart
  final updated = currentTheme.copyWith(
    spacingFactor: 1.5,
  );
  updateTheme(updated);
  ```

### updateSurfaceBase
```dart
void updateSurfaceBase(SurfaceStyle style)
```
- **Description**: Update only the Base surface variant
- **Parameters**:
  - `style`: New SurfaceStyle for Base
- **Shortcut For**: `updateTheme(currentTheme.copyWith(surfaceBase: style))`
- **Performance**: Equivalent to updateTheme
- **Example Usage**:
  ```dart
  controller.updateSurfaceBase(
    currentTheme.surfaceBase.copyWith(
      backgroundColor: Color(0xFFFF0000),
    ),
  );
  ```

### updateSurfaceElevated
```dart
void updateSurfaceElevated(SurfaceStyle style)
```
- **Description**: Update only the Elevated surface variant
- **Shortcut For**: `updateTheme(currentTheme.copyWith(surfaceElevated: style))`

### updateSurfaceHighlight
```dart
void updateSurfaceHighlight(SurfaceStyle style)
```
- **Description**: Update only the Highlight surface variant
- **Shortcut For**: `updateTheme(currentTheme.copyWith(surfaceHighlight: style))`

### updateInputStyle
```dart
void updateInputStyle(InputStyle style)
```
- **Description**: Update entire InputStyle (all variants at once)
- **Parameters**:
  - `style`: New InputStyle with Outline, Underline, Filled variants
- **Side Effects**: Notifies listeners; sets unsaved changes
- **Example**: Input Spec Editor calls this once after adjusting all variants

### updateGlobalMetrics
```dart
void updateGlobalMetrics({
  double? spacingFactor,
  Duration? animationDuration,
})
```
- **Description**: Update global metrics in batch
- **Parameters**: Named, optional
- **Side Effects**: Notifies listeners; batches multiple property changes into single rebuild
- **Performance**: Single notifyListeners() call
- **Example Usage**:
  ```dart
  controller.updateGlobalMetrics(
    spacingFactor: 1.2,
    animationDuration: Duration(milliseconds: 300),
  );
  ```

### updateLoaderSpec
```dart
void updateLoaderSpec(LoaderSpec spec)
```
- **Description**: Update LoaderSpec
- **Parameters**: New LoaderSpec object

### updateToggleSpec
```dart
void updateToggleSpec(ToggleSpec spec)
```
- **Description**: Update ToggleSpec

### updateNavigationSpec
```dart
void updateNavigationSpec(NavigationSpec spec)
```
- **Description**: Update NavigationSpec

### toggleBrightness
```dart
void toggleBrightness()
```
- **Description**: Switch between Light and Dark modes
- **Parameters**: None
- **Side Effects**:
  - Toggles `brightness` enum
  - Notifies listeners
  - Does NOT change theme parameters (adjustments persist across mode switch)
- **Performance**: Synchronous; <1ms
- **Example**: Dark Mode toggle button calls this

### reset
```dart
void reset()
```
- **Description**: Revert all theme parameters to documented defaults
- **Parameters**: None
- **Side Effects**:
  - Resets `currentTheme` to default theme
  - Sets `brightness = Brightness.light`
  - Sets `hasUnsavedChanges = false`
  - Notifies listeners
- **Performance**: Should complete within 1 second
- **Example**: Reset button calls this

---

## Code Export

### generateCode
```dart
String generateCode()
```
- **Description**: Serialize current theme to production-ready Dart code
- **Returns**: Valid Dart code as string (single `AppDesignTheme(...)` constructor)
- **Format**:
  ```dart
  AppDesignTheme(
    spacingFactor: 1.0,
    surfaceBase: SurfaceStyle(
      backgroundColor: Color(0xFFFFFFFF),
      borderRadius: 12.0,
      borderColor: Color(0xFFEEEEEE),
      borderWidth: 1.0,
      blurStrength: 0.0,
      shadowColor: Color(0xFF000000),
      shadowOpacity: 0.1,
      shadowOffset: Offset(0, 2),
    ),
    // ... other properties
  )
  ```
- **Properties Included**: All non-default properties (or all properties for clarity)
- **Color Format**: Hex with alpha channel (0xAARRGGBB)
- **Performance**: Should complete <100ms
- **Error Handling**: Returns valid code even if theme contains edge values

### Signature
```dart
// Helper method (private)
String _colorToHex(Color color) => '0x${color.value.toRadixString(16).toUpperCase().padLeft(8, '0')}';
```

---

## Initialization

### Constructor
```dart
ThemeEditorController({
  AppDesignTheme? initialTheme,
  Brightness initialBrightness = Brightness.light,
})
```
- **Parameters**:
  - `initialTheme`: Starting theme (defaults to Glass or Flat theme from factory)
  - `initialBrightness`: Starting brightness mode
- **Behavior**: Sets up state and prepares for Provider integration

---

## Provider Integration

### Usage Pattern
```dart
// In main.dart or app setup
ChangeNotifierProvider(
  create: (_) => ThemeEditorController(),
  child: MyApp(),
)

// In widget
Consumer<ThemeEditorController>(
  builder: (context, controller, _) {
    return Text('Theme: ${controller.currentTheme.spacingFactor}');
  },
)

// For efficient partial rebuilds
Selector<ThemeEditorController, Color>(
  selector: (_, controller) => controller.currentTheme.surfaceBase.backgroundColor,
  builder: (context, backgroundColor, _) {
    return Container(color: backgroundColor);
  },
)
```

---

## Performance Constraints

| Operation | Target | Rationale |
|-----------|--------|-----------|
| updateTheme() | <5ms | Real-time updates (16ms frame budget) |
| toggleBrightness() | <1ms | Trivial enum toggle |
| reset() | <1s (1000ms) | One-time action, acceptable to be slower |
| generateCode() | <100ms | Export is not real-time, user can wait |

---

## Error Handling

**Current Design**: No explicit error handling. Assumes valid AppDesignTheme objects and valid state transitions.

**Exceptions** (if needed in future):
- Invalid theme object → throw `StateError`
- Invalid property values → gracefully handle (spec allows edge values)

---

## State Persistence (Future)

**Not in MVP**: localStorage/session storage for saving/restoring editor state not implemented initially. If added:
```dart
Future<void> saveSession() async { ... }
Future<void> loadSession() async { ... }
```

---

**Status**: ✅ READY FOR IMPLEMENTATION
