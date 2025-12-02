# UI Component API Contract

**Module**: `editor/lib/widgets/`
**Type**: Widget interface definitions
**Pattern**: Reusable, single-responsibility components

---

## Property Editor Components (Atomic)

### DoubleProperty

**File**: `property_editors/double_property.dart`

**Purpose**: Edit numeric (double) values with slider + keyboard input

**Signature**:
```dart
class DoubleProperty extends StatefulWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final int divisions; // For slider discretization (optional)

  const DoubleProperty({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
  });

  @override
  State<DoubleProperty> createState() => _DoublePropertyState();
}
```

**UI Layout**:
```
┌──────────────────────────┐
│ Label              Value  │  ← Row (label + current value display)
├──────────────────────────┤
│ [========●───────────]   │  ← Slider
├──────────────────────────┤
│ [Value: _______ ]        │  ← TextFormField for precise input
└──────────────────────────┘
```

**Interactions**:
- Dragging slider → calls `onChanged(newValue)`
- Typing in text field → calls `onChanged(parsedValue)` on enter/blur
- Both update each other (debouncing recommended)

**Validation**:
- Clamp input to [min, max]
- Non-numeric input in text field → revert to current value

---

### ColorProperty

**File**: `property_editors/color_property.dart`

**Purpose**: Edit Color values with picker

**Signature**:
```dart
class ColorProperty extends StatefulWidget {
  final String label;
  final Color value;
  final ValueChanged<Color> onChanged;

  const ColorProperty({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<ColorProperty> createState() => _ColorPropertyState();
}
```

**UI Layout**:
```
┌──────────────────────────┐
│ Label        [████████]  │  ← Colored square (current color)
└──────────────────────────┘
```

**Interactions**:
- Tap colored square → open `ColorPickerDialog` (flex_color_picker)
- Select color in picker → calls `onChanged(newColor)`
- Picker displays hex input for manual entry

---

### BoolProperty

**File**: `property_editors/bool_property.dart`

**Purpose**: Edit boolean values

**Signature**:
```dart
class BoolProperty extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const BoolProperty({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) { ... }
}
```

**UI Layout**:
```
┌──────────────────────────┐
│ Label             [O  ]  │  ← SwitchListTile
└──────────────────────────┘
```

**Interactions**:
- Tap toggle → calls `onChanged(!value)`

---

### EnumProperty<T>

**File**: `property_editors/enum_property.dart`

**Purpose**: Edit enum values via dropdown

**Signature**:
```dart
class EnumProperty<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> values;
  final ValueChanged<T> onChanged;
  final String Function(T)? labelBuilder; // Custom label per enum value

  const EnumProperty({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) { ... }
}
```

**UI Layout**:
```
┌──────────────────────────┐
│ Label        [Value ▼]   │  ← DropdownButton
└──────────────────────────┘
```

**Interactions**:
- Tap dropdown → list values
- Select value → calls `onChanged(newValue)`

---

## Spec Editor Components (Composite)

### SurfaceStyleEditor

**File**: `spec_editors/surface_style_editor.dart`

**Purpose**: Edit a single SurfaceStyle (Base, Elevated, or Highlight)

**Signature**:
```dart
class SurfaceStyleEditor extends StatelessWidget {
  final String title; // "Base", "Elevated", "Highlight"
  final SurfaceStyle style;
  final ValueChanged<SurfaceStyle> onChanged;
  final bool isExpanded; // Initial expansion state (optional)

  const SurfaceStyleEditor({
    required this.title,
    required this.style,
    required this.onChanged,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) { ... }
}
```

**UI Layout**:
```
┌─────────────────────────────────────────┐
│ ▼ Base Surface                          │  ← ExpansionTile (header)
├─────────────────────────────────────────┤
│ Background Color    [████████]          │  ← ColorProperty
│ Border Color        [████████]          │  ← ColorProperty
│ Border Width        [========○─]        │  ← DoubleProperty (0-10)
│ Border Radius       [======○───]        │  ← DoubleProperty (0-100)
│ Blur Strength       [=====○────]        │  ← DoubleProperty (0-50)
│ Shadow Color        [████████]          │  ← ColorProperty
│ Shadow Opacity      [======○───]        │  ← DoubleProperty (0-1)
└─────────────────────────────────────────┘
```

**Behavior**:
- All child property editors are independent
- Any property change → calls `onChanged()` with updated SurfaceStyle
- Uses `copyWith()` on SurfaceStyle for immutable updates

---

### InputStyleEditor

**File**: `spec_editors/input_style_editor.dart`

**Purpose**: Edit InputStyle (all variants: Outline, Underline, Filled)

**Signature**:
```dart
class InputStyleEditor extends StatelessWidget {
  final InputStyle style;
  final ValueChanged<InputStyle> onChanged;

  const InputStyleEditor({
    required this.style,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) { ... }
}
```

**UI Layout**:
```
┌─────────────────────────────────────────┐
│ ▼ Outline Variant                       │
├─────────────────────────────────────────┤
│ [SurfaceStyleEditor for outline]        │
│                                          │
│ ▼ Underline Variant                     │
├─────────────────────────────────────────┤
│ [SurfaceStyleEditor for underline]      │
│                                          │
│ ▼ Filled Variant                        │
├─────────────────────────────────────────┤
│ [SurfaceStyleEditor for filled]         │
│                                          │
│ Focus Overlay Color    [████████]       │  ← ColorProperty
│ Error Overlay Color    [████████]       │  ← ColorProperty
└─────────────────────────────────────────┘
```

**Behavior**:
- Three nested SurfaceStyleEditors
- Each updates its respective variant within the InputStyle
- Focus/Error colors at the bottom

---

### GlobalMetricsEditor

**File**: `spec_editors/global_metrics_editor.dart`

**Purpose**: Edit spacing and animation speed

**Signature**:
```dart
class GlobalMetricsEditor extends StatelessWidget {
  final double spacingFactor;
  final Duration animationDuration;
  final ValueChanged<({double spacing, Duration animation})> onChanged;

  const GlobalMetricsEditor({
    required this.spacingFactor,
    required this.animationDuration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) { ... }
}
```

**UI Layout**:
```
┌─────────────────────────────────────────┐
│ Spacing Factor       [====○─────────]   │  ← DoubleProperty (0.5-2.0)
│ Animation Duration   [========○──]     │  ← DoubleProperty (100-500ms)
└─────────────────────────────────────────┘
```

**Behavior**:
- Both properties are independent
- Any change → calls onChanged with record/tuple of both values

---

### LoaderSpecEditor, ToggleSpecEditor, NavigationSpecEditor

**Pattern**: Similar to SurfaceStyleEditor, composed of property editors specific to each spec type

**File Locations**:
- `spec_editors/loader_spec_editor.dart`
- `spec_editors/toggle_spec_editor.dart`
- `spec_editors/navigation_spec_editor.dart`

**Behavior**: Each accepts the respective spec object and calls `onChanged()` with updated value

---

## Main Layout Components

### PreviewArea

**File**: `preview_area.dart`

**Purpose**: Render Dashboard Hero Demo with current theme

**Signature**:
```dart
class PreviewArea extends StatelessWidget {
  final AppDesignTheme theme;
  final Brightness brightness;
  final bool isMobileWidth;

  const PreviewArea({
    required this.theme,
    required this.brightness,
    required this.isMobileWidth,
  });

  @override
  Widget build(BuildContext context) { ... }
}
```

**Behavior**:
- Wraps DashboardPage/DashboardHeroDemo in a `Theme` widget with current theme data
- Renders at mobile or desktop width based on `isMobileWidth`
- All changes reflect instantly via Theme context changes

---

### ControlPanel

**File**: `control_panel.dart`

**Purpose**: Organize spec editors + toolbar

**Signature**:
```dart
class ControlPanel extends StatelessWidget {
  final AppDesignTheme theme;
  final Brightness brightness;
  final VoidCallback onDarkModeToggle;
  final VoidCallback onReset;
  final VoidCallback onExport;
  // Callbacks for each spec update
  final ValueChanged<SurfaceStyle> onSurfaceBaseChanged;
  final ValueChanged<InputStyle> onInputStyleChanged;
  // ... etc for other specs

  const ControlPanel({
    required this.theme,
    required this.brightness,
    required this.onDarkModeToggle,
    required this.onReset,
    required this.onExport,
    // ... all callbacks
  });

  @override
  Widget build(BuildContext context) { ... }
}
```

**UI Layout**:
```
┌─────────────────────────────────────────┐
│ [🌙 Dark Mode] [↻ Reset] [↻ Export]    │  ← Toolbar buttons
├─────────────────────────────────────────┤
│ • SurfaceStyleEditor (Base)             │
│ • SurfaceStyleEditor (Elevated)         │  ← ListView of spec editors
│ • SurfaceStyleEditor (Highlight)        │
│ • InputStyleEditor                      │
│ • GlobalMetricsEditor                   │
│ • LoaderSpecEditor                      │
│ • ToggleSpecEditor                      │
│ • NavigationSpecEditor                  │
└─────────────────────────────────────────┘
```

**Behavior**:
- Toolbar at top (sticky if possible)
- Scrollable list of spec editors below
- Clicking buttons delegates to callbacks (handled by LiveEditorPage)

---

### LiveEditorPage

**File**: `pages/live_editor_page.dart`

**Purpose**: Main layout combining preview and control panel

**Signature**:
```dart
class LiveEditorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { ... }
}
```

**UI Layout**:
```
┌──────────────────────────┬──────────────────────────┐
│                          │                          │
│   PreviewArea (flex: 3)   │  ControlPanel (flex: 1)  │
│   [Theme preview]        │  [Spec editors]          │
│                          │                          │
│                          │                          │
│                          │                          │
│                          │                          │
└──────────────────────────┴──────────────────────────┘
```

**Behavior**:
- Uses `Consumer<ThemeEditorController>` to subscribe to state changes
- Updates PreviewArea when theme changes
- Passes callbacks to ControlPanel that delegate to controller methods
- Responsive: switches to Column layout on mobile (if needed)

---

## Interaction Flow Example

```
User adjusts "Border Radius" slider
       ↓
DoubleProperty.onChanged(16.0)
       ↓
SurfaceStyleEditor.onChanged(updatedSurfaceStyle)
       ↓
ControlPanel.onSurfaceBaseChanged(updatedSurfaceStyle)
       ↓
LiveEditorPage.build() calls controller.updateSurfaceBase()
       ↓
ThemeEditorController.updateSurfaceBase() notifies listeners
       ↓
Consumer<ThemeEditorController> rebuilds LiveEditorPage
       ↓
PreviewArea receives new theme via builder
       ↓
Dashboard Hero Demo renders with new border radius
       ↓
✅ Preview updates (target: <16ms from slider drag to visual change)
```

---

**Status**: ✅ READY FOR IMPLEMENTATION
