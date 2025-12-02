# Quickstart: Live Theme Editor

**Version**: 1.0
**Date**: 2025-12-02
**Target Audience**: Developers implementing or testing the Live Theme Editor

---

## Prerequisites

- Flutter SDK latest version installed
- `flutter doctor` shows no critical issues
- Web development enabled: `flutter config --enable-web`
- Repository cloned locally

---

## Getting Started (Local Development)

### 1. Clone & Navigate

```bash
cd ~/path/to/ui_kit/repository
cd editor
```

### 2. Install Dependencies

```bash
flutter pub get
```

**What this does**:
- Fetches Flutter Web dependencies
- Links the parent `ui_kit_library` as a local path dependency
- Installs Provider, flex_color_picker, gap, and other dev dependencies

**Troubleshooting**:
- If `ui_kit_library` path fails: Verify `pubspec.yaml` has correct relative path: `path: ../`
- If flex_color_picker fails: Verify version in `pubspec.yaml` (should be `^3.0.0` or compatible)

### 3. Run the Editor

```bash
flutter run -d web
```

**First Run** (will compile WASM):
- Takes 1-2 minutes on first build
- Subsequent runs are much faster (hot reload)

**Output**:
- Editor should open in default browser at `http://localhost:1234` (or similar)
- You'll see the Live Theme Editor split-screen layout:
  - Left: Dashboard Hero Demo (current theme)
  - Right: Control panel with spec editors

---

## Basic Workflow: Edit a Theme Parameter

### Scenario: Change Border Radius

1. **Locate Control Panel**
   - On the right side, find the "Surface" section
   - Expand "Base Surface" by clicking it

2. **Find Border Radius Control**
   - You'll see a slider labeled "Border Radius"
   - Current value shown to the right

3. **Adjust the Slider**
   - Drag the slider to ~20.0
   - Watch the preview on the left update instantly
   - Cards and buttons should display with rounded corners

4. **Or Type Precise Value**
   - Below the slider, find the text input
   - Type `20` and press Enter
   - Slider updates to match

5. **Verify Preview Update**
   - All cards in the Dashboard Hero Demo should have the new radius
   - Update should feel instant (no lag)

---

## Workflow: Test Dark Mode

### Scenario: Verify Color Scheme in Dark Mode

1. **Toggle Dark Mode**
   - In the Control Panel toolbar (top-right), click the moon icon (🌙)
   - Entire preview should switch to dark theme instantly
   - All pending adjustments (e.g., new radius) should persist

2. **Adjust Colors in Dark Mode**
   - Find "Surface Base" section
   - Click the "Background Color" property (colored square)
   - Color picker opens
   - Select a new color using the picker or hex input
   - Preview updates instantly

3. **Switch Back to Light Mode**
   - Click the moon icon again to toggle
   - Your color adjustments should remain (both light and dark modes updated)

---

## Workflow: Export Generated Code

### Scenario: Get Dart Code to Paste into Project

1. **Make Adjustments**
   - In the Control Panel, adjust several parameters:
     - Border radius: 16
     - Spacing factor: 1.1
     - Primary color: #6200EE

2. **Click Export Button**
   - In the Control Panel toolbar, click the "↻ Export" button
   - A code panel opens showing generated Dart code

3. **Copy the Code**
   - Select all text in the export panel (Ctrl+A or Cmd+A)
   - Copy to clipboard (Ctrl+C or Cmd+C)

4. **Paste into Project**
   - Open `lib/theme/theme_factory.dart` (or equivalent) in your project
   - Replace the existing theme constructor with the exported code
   - Build/run your app
   - **Expected**: Your app's theme should exactly match what you saw in the editor

---

## Workflow: Reset to Defaults

### Scenario: Start Over with Default Theme

1. **Click Reset Button**
   - In the Control Panel toolbar, click "↻ Reset"
   - All parameters revert to documented defaults
   - Preview updates instantly

2. **Verify**
   - All spec editors show default values
   - "Unsaved Changes" indicator (if present) clears

---

## Responsive Testing: Mobile vs. Desktop

### Scenario: Verify Theme on Mobile Width

1. **Look for Width Toggle Buttons**
   - In the Control Panel toolbar (next to Dark Mode), find width buttons
   - Buttons labeled "📱 Mobile" and "🖥️ Desktop" (or similar)

2. **Click "Mobile"**
   - Preview area narrows to mobile width (~380dp)
   - Navigation component should change:
     - Desktop: `AppNavigationRail` (vertical sidebar)
     - Mobile: `AppNavigationBar` (bottom navigation)

3. **Test Colors**
   - Adjust a color while in mobile view
   - Verify preview updates and looks good at mobile width

4. **Switch to Desktop**
   - Click "Desktop"
   - Preview widens
   - Navigation switches back to rail

---

## Troubleshooting

### Issue: Editor Loads but Preview is Blank

**Cause**: Dashboard Hero Demo not found or has errors

**Solution**:
1. Check browser console for errors (F12 → Console)
2. Verify `ui_kit_library` is correctly linked in `pubspec.yaml`
3. Verify Dashboard Hero Demo is exported from `ui_kit_library` (check `lib/ui_kit.dart`)
4. If still blank, build ui_kit in debug mode: `flutter build lib` (from parent directory)

### Issue: Slider Changes Don't Update Preview

**Cause**: Provider subscription or theme update not working

**Solution**:
1. Check browser console for Dart runtime errors
2. Verify `ThemeEditorController` is instantiated with `ChangeNotifierProvider`
3. Check that `Consumer<ThemeEditorController>` is present in widget tree
4. Try hot reload (press `r` in terminal running `flutter run`)

### Issue: Export Code Contains Invalid Dart Syntax

**Cause**: Color serialization or nested object stringification issue

**Solution**:
1. Manually check the code for obvious syntax errors
2. Verify Color values are in hex format `Color(0xAARRGGBB)`
3. Report the specific invalid syntax (file issue with example)

### Issue: Performance Lag (Updates Take >100ms)

**Cause**: Browser rendering slow or Flutter/Dart code inefficient

**Solution**:
1. Open browser DevTools (F12) → Performance tab
2. Record profile while dragging slider
3. Check where time is spent (Dart logic vs. rendering)
4. For Dart-side: Verify `Selector` is used to minimize rebuilds
5. For rendering: Check that preview doesn't have excessive redraws

---

## Development Tips

### Enable Verbose Logging

```bash
flutter run -d web -v
```

Helpful for debugging build issues or understanding performance.

### Use Flutter DevTools

```bash
flutter pub global activate devtools
devtools
```

Then open the app and connect to DevTools for profiling and debugging.

### Edit Code and Hot Reload

```bash
# Terminal is still running from `flutter run -d web`
# Edit a Dart file, save
# Press 'r' to hot reload
# Changes appear instantly (no full rebuild)
```

### Profile with DevTools

- Open DevTools (shows URL when app loads)
- Timeline tab → record while adjusting theme
- Verify update times are <16ms

---

## File Structure Reference

```
editor/
├── lib/
│   ├── main.dart                      # App entry point
│   ├── app.dart                       # Root widget setup
│   ├── pages/
│   │   └── live_editor_page.dart      # Main split-screen layout
│   ├── controllers/
│   │   └── theme_editor_controller.dart  # State management
│   ├── widgets/
│   │   ├── preview_area.dart
│   │   ├── control_panel.dart
│   │   ├── property_editors/          # DoubleProperty, ColorProperty, etc.
│   │   └── spec_editors/              # SurfaceStyleEditor, InputStyleEditor, etc.
│   └── utils/
│       ├── code_generator.dart        # Dart code export
│       └── color_utils.dart           # Color formatting
├── pubspec.yaml                       # Dependencies
└── web/
    └── index.html                     # Web entry point
```

---

## Testing Checklist

Before shipping, verify:

- [ ] Preview updates within 16ms of slider/color adjustment
- [ ] Dark mode toggle switches instantly
- [ ] Mobile/Desktop width buttons trigger navigation component changes
- [ ] Reset reverts all parameters within 1 second
- [ ] Export generates valid Dart code
- [ ] Exported code can be pasted and compiled without errors
- [ ] Exported code produces identical visual output
- [ ] All spec editors (Surface, Input, Global, Loader, Toggle, Navigation) are present
- [ ] Control panel scrolls if content exceeds viewport
- [ ] No console errors in browser DevTools
- [ ] App loads in <3 seconds on broadband connection

---

## Next Steps

After verifying basic functionality:

1. **Run Full Test Suite**: `flutter test` (if tests are implemented)
2. **Build for Web**: `flutter build web --release` (production build)
3. **Deploy**: Follow CI/CD instructions for deploying to GitHub Pages

---

## Support

For issues or questions:
1. Check the main spec: `/specs/006-theme-editor/spec.md`
2. Review implementation plan: `/specs/006-theme-editor/plan.md`
3. Check data model: `/specs/006-theme-editor/data-model.md`
4. Review API contracts: `/specs/006-theme-editor/contracts/`

---

**Last Updated**: 2025-12-02
**Status**: Draft (ready for refinement after Phase 2 task definition)
