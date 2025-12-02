# Live Theme Editor - Development Guide

## Overview

The Live Theme Editor is an interactive web-based tool for designing and previewing custom UI Kit themes in real-time.

## Features

### Phase 1-5 (Completed)
- ✅ Theme Editor setup and project structure
- ✅ Real-time theme customization and preview
- ✅ Surface variants editing (Base, Elevated, Highlight)
- ✅ Control panel with spec editors for:
  - Input fields (Outline, Underline, Filled variants)
  - Toggle switches
  - Navigation
  - Loader/Feedback components
- ✅ Dark mode and responsive preview (mobile/desktop width simulation)

### Phase 6 (Completed)
- ✅ Theme code generation and export
- ✅ Copy-to-clipboard functionality
- ✅ Production-ready Dart code export

### Phase 7 (Completed)
- ✅ Reset confirmation dialog
- ✅ Protection against accidental resets

### Phase 8 (Completed)
- ✅ Theme storage utilities for persistence
- ✅ Keyboard shortcuts (Ctrl+E, Ctrl+R, Ctrl+D)
- ✅ Enhanced UI polish with visual separators

### Phase 9 (Completed)
- ✅ CI/CD pipeline with GitHub Actions
- ✅ Automated testing and builds
- ✅ Build artifact management

## Project Structure

```
editor/
├── lib/
│   ├── main.dart                          # Application entry point
│   ├── pages/
│   │   └── live_editor_page.dart         # Main editor page (desktop/mobile layouts)
│   ├── controllers/
│   │   └── theme_editor_controller.dart  # State management with Provider
│   ├── widgets/
│   │   ├── control_panel.dart            # Editor control panel
│   │   ├── preview_area.dart             # Live theme preview
│   │   ├── export_dialog.dart            # Code export dialog
│   │   ├── reset_confirmation_dialog.dart # Reset confirmation UI
│   │   └── spec_editors/
│   │       ├── surface_style_editor.dart
│   │       ├── input_style_editor.dart
│   │       ├── toggle_spec_editor.dart
│   │       ├── navigation_spec_editor.dart
│   │       ├── global_metrics_editor.dart
│   │       └── loader_spec_editor.dart
│   ├── utils/
│   │   ├── code_generator.dart           # Dart code generation
│   │   ├── theme_storage.dart            # Persistent theme storage
│   │   └── keyboard_shortcuts.dart       # Keyboard shortcut definitions
│   └── models/
│       └── [Model definitions]
├── build/
│   └── web/                              # Built web application
├── test/                                  # Unit and widget tests
├── pubspec.yaml                          # Flutter dependencies
├── web/                                  # Web-specific assets
├── DEVELOPMENT.md                        # This file
└── README.md                             # User guide
```

## Getting Started

### Prerequisites
- Flutter SDK 3.24.0 or later
- Dart SDK (bundled with Flutter)
- Web browser (Chrome, Firefox, Safari, Edge)

### Setup

1. **Install dependencies:**
   ```bash
   cd editor
   flutter pub get
   ```

2. **Run the development server:**
   ```bash
   flutter run -d chrome
   ```

3. **Build for production:**
   ```bash
   flutter build web --release
   ```

## Architecture

### State Management
The editor uses **Provider** for reactive state management:

```dart
// Access theme state
Consumer<ThemeEditorController>(
  builder: (context, themeController, _) {
    final theme = themeController.currentTheme;
  },
)
```

### Component Hierarchy
```
LiveEditorPage
├── ControlPanel (left side)
│   ├── Theme Editor Header (Export, Reset buttons)
│   ├── Surface Style Editors
│   ├── Input Style Editor
│   ├── Toggle Style Editor
│   ├── Navigation Style Editor
│   └── Global Metrics Editor
└── PreviewArea (right side)
    ├── Theme Provider
    └── _DashboardHeroDemo
        ├── Color Palette Preview
        ├── Typography Preview
        ├── Surface Variants Preview
        └── Components Preview
```

## Key Workflows

### Editing a Theme Property

1. User modifies a property in a spec editor (e.g., surface color)
2. Spec editor calls `onChanged` callback with updated style
3. Controller updates its `_currentTheme` via `copyWith()`
4. `notifyListeners()` triggers UI rebuild
5. Preview area receives updated theme via Consumer
6. PreviewArea and all preview widgets rebuild with new values

Example flow for updating InputStyle:
```dart
// In InputStyleEditor
void _handleOutlineStyleChanged(SurfaceStyle style) {
  final updated = _currentInputStyle.copyWith(outlineStyle: style);
  setState(() { _currentInputStyle = updated; });
  widget.onChanged(updated);  // Callback to parent
}

// In ControlPanel
InputStyleEditor(
  inputStyle: themeController.currentTheme.inputStyle,
  onChanged: (style) => themeController.updateInputStyle(style),
)

// In ThemeEditorController
void updateInputStyle(InputStyle style) {
  _currentTheme = _currentTheme.copyWith(inputStyle: style);
  _hasUnsavedChanges = true;
  notifyListeners();  // Triggers preview update
}
```

### Exporting Theme Code

1. User clicks export icon
2. ThemeEditorController.generateCode() called
3. CodeGenerator serializes entire AppDesignTheme to Dart code
4. ExportDialog displays generated code
5. User can copy to clipboard with one click

### Reset with Confirmation

1. User clicks reset icon
2. ResetConfirmationDialog appears
3. If user confirms, ThemeEditorController.reset() called
4. Theme reverts to GlassDesignTheme.light() with default values
5. `hasUnsavedChanges` flag reset to false

## Code Generation

The CodeGenerator produces production-ready Dart code that can be directly integrated into projects:

```dart
// Generated code example
import 'package:ui_kit_library/ui_kit.dart';
import 'package:flutter/material.dart';

final customTheme = GlassDesignTheme.light(
  ColorScheme.fromSeed(
    seedColor: const Color(0xFF0870EA),
    brightness: Brightness.light,
  ),
).copyWith(
  spacingFactor: 1.0,
  surfaceBase: SurfaceStyle(
    backgroundColor: Color(0xFFFFFFFF),
    borderColor: Color(0xFF000000),
    // ... more properties
  ),
  // ... more theme properties
);
```

## Type Safety

All style classes use immutable patterns with `copyWith()` methods:

```dart
// BadPractice - Mutable updates
theme.surfaceBase.backgroundColor = Colors.red;

// GoodPractice - Immutable updates
final updated = theme.surfaceBase.copyWith(
  backgroundColor: Colors.red,
);
```

This ensures:
- Predictable state changes
- Easier debugging and undo/redo support
- Proper Provider notifications
- Type safety at compile time

## UI Kit Integration

The preview uses **only UI Kit library components**:
- ✅ AppText with AppTextVariant
- ✅ AppButton with SurfaceVariant
- ✅ AppSwitch
- ✅ AppCard
- ✅ AppSurface
- ✅ AppGap with semantic sizes (.xs(), .md(), .xl())
- ✅ AppTextFormField

This ensures the preview accurately represents how themes will look in production apps.

## Testing

### Manual Testing
1. Launch the app and verify all editors work
2. Change a property and confirm preview updates
3. Export code and verify it compiles
4. Toggle brightness and mobile width
5. Test reset with confirmation dialog

### Automated Testing (CI/CD)
See `.github/workflows/theme_editor_ci.yml` for automated:
- Flutter analysis
- Web build compilation
- Artifact management

## Performance Considerations

### Optimization Strategies
1. **Consumer-based rebuilds**: Only widgets listening to theme changes rebuild
2. **Semantic AppGap**: Uses theme.spacingFactor for consistent, responsive spacing
3. **Theme Provider**: Single point of truth for theme state
4. **Lazy evaluation**: Preview components built on-demand

### Build Optimization
- Tree-shaken Material Icons (99.2% reduction)
- Tree-shaken Cupertino Icons (99.4% reduction)
- Release build optimizations with `--release` flag

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| Ctrl+E | Export theme code |
| Ctrl+R | Reset to default |
| Ctrl+D | Toggle brightness |

(Defined in `utils/keyboard_shortcuts.dart`)

## Theme Storage

Themes can be persisted using SharedPreferences:

```dart
// Save theme
await ThemeStorage.saveTheme('my_theme', themeController.currentTheme);

// Load theme
final theme = await ThemeStorage.loadTheme('my_theme');

// Get all saved themes
final themes = await ThemeStorage.getSavedThemeNames();

// Save last used theme for quick restoration
await ThemeStorage.saveLastUsedTheme(themeController.currentTheme);
```

## Debugging

### Enable Debug Output
```dart
// In theme_editor_controller.dart
void updateTheme(AppDesignTheme newTheme) {
  print('Theme updated: $newTheme');
  _currentTheme = newTheme;
  notifyListeners();
}
```

### DevTools Inspector
```bash
flutter pub global activate devtools
devtools
```

Then open `http://localhost:9100` in browser.

## Common Issues and Solutions

### Issue: Preview doesn't update
**Solution**: Ensure `notifyListeners()` is called in controller methods

### Issue: Export code doesn't compile
**Solution**: Verify all style properties are properly serialized in CodeGenerator

### Issue: Mobile width toggle doesn't work
**Solution**: Check PreviewArea receives correct `previewWidth` parameter

## Future Enhancements

- [ ] Theme history/undo-redo
- [ ] Multiple theme comparison view
- [ ] Custom color picker integration
- [ ] Theme sharing/collaboration features
- [ ] Animation preview for transitions
- [ ] Accessibility testing suite
- [ ] Performance profiling tools

## Contributing

1. Create feature branch: `git checkout -b feature/your-feature`
2. Make changes following the architecture patterns
3. Run `flutter analyze` to check code quality
4. Build and test: `flutter build web --release`
5. Commit with descriptive messages
6. Push and create PR

## CI/CD Pipeline

The GitHub Actions workflow (`theme_editor_ci.yml`) automatically:
1. Runs on push to main/develop
2. Runs on pull requests
3. Installs Flutter dependencies
4. Analyzes code for issues
5. Builds web version
6. Uploads build artifacts
7. Deploys to production on main branch push

## License

Part of the UI Kit Library project.

## Support

For issues, questions, or suggestions, please contact the development team.
