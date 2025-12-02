# Phase 0: Research & Validation

**Date**: 2025-12-02
**Feature**: Live Theme Editor (006-theme-editor)
**Status**: Preliminary (awaiting detailed research execution)

---

## Research Topics & Findings

### 1. Provider State Management Pattern in Flutter Web

**Question**: How to structure Provider for efficient rebuilds in responsive layouts?

**Initial Assessment**:
- **Provider** (`provider` package) is the Flutter community standard for state management
- **Advantages**: Simple, predictable, integrates well with Flutter's widget tree, minimal boilerplate
- **Web-Specific Considerations**:
  - No async storage layer needed (Web has localStorage via dart:web if needed, but not required per offline design)
  - Hot reload support for iterative development
  - WASM compilation fully supported

**Recommended Approach**:
- Use `ChangeNotifierProvider` for `ThemeEditorController`
- Controller holds theme state and exposes methods (`updateTheme()`, `reset()`, `generateCode()`)
- Consumer widgets subscribe only to the specific parts they need via `Selector` to minimize rebuilds
- Property editors use `Consumer` to rebuild only when their specific value changes

**Alternatives Considered**:
- **Riverpod**: More sophisticated but overkill for single-app editor; learning curve not justified
- **GetX**: Popular in mobile but heavier-weight; Provider is more Flutter-idiomatic
- **BLoC**: Excellent for large apps; too complex for this tool-scoped feature

**Decision**: Use **Provider** with `ChangeNotifierProvider` + `Selector` pattern for efficient rebuilds.

---

### 2. DashboardPage Integration & Export

**Question**: Can Dashboard Hero Demo be embedded directly in the editor preview?

**Initial Assessment**:
- The specification assumes `DashboardPage` exists and is embeddable
- **Critical check needed**: Verify that DashboardPage is:
  1. Exported from `ui_kit_library` (check `lib/ui_kit.dart` export statements)
  2. Widget-based (not reliant on Navigator/Routing in ways that conflict with embedding)
  3. Accepts theme via InheritedWidget/Theme.of(context)

**Verification Steps**:
1. Search `ui_kit_library` for `DashboardPage` class definition
2. Check if it's exported at package level
3. Verify it only consumes theme via `Theme.of(context)` and not via static singletons
4. If modifications needed, document required changes

**Preliminary Decision**: Assume DashboardPage is embeddable; if verification fails, create a wrapper widget that adapts it for embedding.

**Risk**: If DashboardPage has hard dependencies on routing or static state, alternative is to build a minimal "demo showcase" widget within the editor itself that displays representative components.

---

### 3. Color Picker Integration (flex_color_picker)

**Question**: How to integrate flex_color_picker for real-time performance in Flutter Web?

**Initial Assessment**:
- **flex_color_picker** is a mature, feature-rich color picker (Hex input, palette selection, format conversion)
- **Integration Pattern**: Typically opened in a dialog; user confirms selection → callback updates state
- **Web Performance**:
  - Color picker itself is just UI; no heavy computation
  - Real-time updates via Provider should handle color changes without perceptible lag
  - Concern: Multiple rapid color changes might trigger excessive rebuilds; mitigation: use `Selector` to only rebuild affected widgets

**Recommended Usage**:
```dart
// In ColorProperty widget
ElevatedButton(
  onPressed: () => showDialog(
    context: context,
    builder: (context) => ColorPickerDialog(
      color: currentColor,
      onColorChanged: (newColor) => onChanged(newColor),
    ),
  ),
  child: Text('Pick Color'),
)
```

**Dependency Check**: `flex_color_picker: ^3.0.0` is stable and well-maintained. Add to `editor/pubspec.yaml`.

**Decision**: Use **flex_color_picker** for color picker UI with dialog-based interaction to avoid inline picker complexity.

---

### 4. Dart Code Generation from Theme Objects

**Question**: How to serialize AppDesignTheme to production-ready Dart code?

**Initial Assessment**:
- **Challenge**: Convert complex nested objects (Color, SurfaceStyle, etc.) to Dart string representation
- **Color Serialization**:
  - Flutter `Color` objects have `.value` property (int), but outputting `Color(0xFFFF0000)` is more readable
  - Decision: Create helper `colorToHex()` that converts Color → hex string, output as `Color(0xFFRRGGBB)`

**Code Generation Strategy**:
1. **Template-Based Approach**: Define a Dart code template string with placeholders
2. **Interpolation**: Replace placeholders with values from current `AppDesignTheme`
3. **Validation**: Run the generated string through a syntax checker (optional but recommended)

**Example Output**:
```dart
AppDesignTheme(
  spacingFactor: 1.2,
  surfaceBase: SurfaceStyle(
    backgroundColor: Color(0xFFFFFFFF),
    borderRadius: 12.0,
    // ...
  ),
  // ...
)
```

**Implementation Location**: `utils/code_generator.dart` as a standalone module
- Input: `AppDesignTheme` object + metadata
- Output: Valid Dart string

**Risk**: Complex nested objects might require custom `copyWith` or `toJson` methods on theme classes. Verify AppDesignTheme supports `copyWith` before implementation.

**Decision**: Implement string-based code generation with Dart string interpolation; validate output syntax.

---

### 5. Flutter Web Performance & 16ms Target

**Question**: How to achieve 16ms (60fps) real-time updates in Flutter Web?

**Initial Assessment**:
- **16ms target** = 60fps, standard for fluid UI interactions
- **Flutter Web Considerations**:
  - Compiled to WASM for modern browsers
  - Performance typically excellent for Dart code
  - Bottleneck usually in rendering, not logic

**Performance Optimization Strategy**:
1. **Provider Selector Pattern**: Only rebuild widgets that depend on changed values
2. **Efficient Theme Rebuilds**: Use `Theme` widget at top level; all descendants consume via `Theme.of(context)`
3. **Avoid Unnecessary Repaints**: Use `const` constructors where applicable; memoize static elements
4. **Profiling**: Use Flutter DevTools (available in web) to identify hot paths

**Monitoring**:
- Frame rate indicator during development
- Performance timeline in browser DevTools
- Manual testing on target devices/browsers

**Contingency**: If 16ms not achievable with current approach:
1. Debounce slider updates (batch multiple changes into single rebuild)
2. Implement frame scheduling (only update on frame boundaries)
3. Profile and optimize hot paths

**Decision**: Implement with Selector pattern first; profile and optimize if needed. Acceptable worst-case (if not achievable): 33ms (30fps) still feels smooth.

---

## Research Completion Checklist

- [ ] Verify DashboardPage availability & embeddability
- [ ] Confirm flex_color_picker web compatibility
- [ ] Test Provider pattern with nested theme updates
- [ ] Prototype code generation for single simple type (e.g., double)
- [ ] Performance baseline: measure first render time and simple update time
- [ ] Review AppDesignTheme class structure for serialization requirements

## Recommended Next Steps

1. **Detailed Research** (next phase/dedicated task):
   - Execute verification steps for DashboardPage
   - Build minimal prototypes for Provider and code generator
   - Performance profiling on target browser/device

2. **Adjustments Based on Research**:
   - If verification fails, update data model and contracts accordingly
   - If performance concerns arise, document mitigation strategies

3. **Phase 1 Readiness**:
   - Complete research checklist
   - Document findings in updated `research.md`
   - Proceed to Phase 1 (data-model.md, contracts/, quickstart.md)

---

**Status**: ✅ READY FOR PHASE 1 DESIGN (pending detailed verification of assumptions listed in checklist)
