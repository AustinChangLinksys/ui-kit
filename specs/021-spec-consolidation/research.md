# Research: Theme Spec Consolidation

**Feature**: 021-spec-consolidation
**Date**: 2025-12-08
**Status**: Complete

## Research Questions

### RQ-001: Can @TailorMixin handle nested spec composition?

**Decision**: Yes, @TailorMixin supports nested types with proper lerp and copyWith generation.

**Rationale**:
- theme_tailor package (v3.0.0+) generates lerp methods for nested ThemeExtension types
- When a field is another @TailorMixin type, the generated code calls that type's lerp method
- For non-ThemeExtension nested types (like AnimationSpec as a value object), we need to handle lerp manually or make it a ThemeExtension

**Alternatives Considered**:
1. Manual lerp implementation for all specs - Rejected: violates Constitution 4.5 (Theme Tailor mandate)
2. Flat property duplication - Rejected: doesn't solve the duplication problem
3. Make shared specs ThemeExtensions themselves - **Selected**: cleanest integration with theme_tailor

**Evidence**:
```dart
// Verified pattern from existing codebase
@TailorMixin()
class ToggleStyle extends ThemeExtension<ToggleStyle> {
  final SurfaceStyle? activeTrackStyle; // Nested Equatable works
}
```

---

### RQ-002: How should shared specs handle the @TailorMixin vs Equatable decision?

**Decision**: Shared specs that are composed into component styles should be ThemeExtension-based with @TailorMixin to get automatic lerp support. Value objects that are fundamental building blocks remain Equatable.

**Rationale**:
- ThemeExtension provides automatic lerp for theme transitions
- Equatable is simpler but requires manual lerp
- Shared specs like AnimationSpec will benefit from animated transitions between themes

**Classification**:

| Spec | Pattern | Reason |
|------|---------|--------|
| AnimationSpec | @TailorMixin | Needs lerp for duration/curve interpolation |
| StateColorSpec | @TailorMixin | Needs lerp for color transitions |
| OverlaySpec | @TailorMixin | Contains AnimationSpec, needs lerp |
| SurfaceStyle | Equatable | Foundational, composed everywhere, lerp handled by consumers |
| InteractionSpec | Equatable | Simple value object, no interpolation needed |

---

### RQ-003: What is the best pattern for local style overrides?

**Decision**: Use InheritedWidget with nullable override fields + component-level optional parameters.

**Rationale**:
- InheritedWidget is Flutter's standard pattern for subtree configuration
- Nullable fields allow partial overrides (only override what you need)
- Component parameters provide escape hatch for one-off overrides
- Both patterns are composition-friendly, no inheritance

**Alternatives Considered**:
1. Theme nesting (wrap subtree in new Theme) - Rejected: heavy, requires full theme definition
2. Provider/Riverpod - Rejected: forbidden dependencies per Constitution 2.2
3. Global state - Rejected: violates Constitution 10 (No Global State)
4. InheritedWidget + component params - **Selected**: standard Flutter, lightweight, composable

**Implementation Pattern**:
```dart
// Layer 1: Subtree override
class StyleOverride extends InheritedWidget {
  final AnimationSpec? animationSpec;
  final StateColorSpec? stateColorSpec;
  final OverlaySpec? overlaySpec;

  static T? resolve<T>(BuildContext context) { ... }
}

// Layer 2: Component override
class AppBottomSheet extends StatelessWidget {
  final AnimationSpec? animationOverride; // Takes precedence

  AnimationSpec _resolveAnimation(BuildContext context) {
    // Priority: component param > StyleOverride > theme
    return animationOverride
        ?? StyleOverride.maybeOf(context)?.animationSpec
        ?? theme.sheetStyle.animation;
  }
}
```

---

### RQ-004: How to handle backward compatibility for merged styles?

**Decision**: Deprecate old style classes, provide typedef redirects, support one minor version.

**Rationale**:
- Breaking internal APIs is acceptable per spec assumptions
- Deprecation warnings guide migration
- Typedef preserves type compatibility for existing code

**Migration Path**:
```dart
// bottom_sheet_style.dart (deprecated)
@Deprecated('Use SheetStyle with SheetDirection.bottom instead')
typedef BottomSheetStyle = SheetStyle;

// side_sheet_style.dart (deprecated)
@Deprecated('Use SheetStyle with SheetDirection.side instead')
typedef SideSheetStyle = SheetStyle;
```

**Alternatives Considered**:
1. Keep separate styles forever - Rejected: doesn't solve duplication
2. Hard break with no migration - Rejected: too disruptive
3. Deprecation + typedef - **Selected**: smooth migration path

---

### RQ-005: What presets should shared specs provide?

**Decision**: Provide commonly used configurations as static constants.

**Rationale**:
- Reduces boilerplate in theme definitions
- Documents recommended values
- Aligns with Constitution 5.1 motion system (fast/medium/slow)

**AnimationSpec Presets**:
| Preset | Duration | Curve | Use Case |
|--------|----------|-------|----------|
| `instant` | 0ms | linear | Pixel theme, immediate feedback |
| `fast` | 150ms | easeOut | Quick micro-interactions |
| `standard` | 300ms | easeInOut | Default animations |
| `slow` | 500ms | easeOutExpo | Glass theme, floating effects |

**StateColorSpec**: No presets - colors are always theme-specific

**OverlaySpec Presets**:
| Preset | Scrim | Blur | Animation | Use Case |
|--------|-------|------|-----------|----------|
| `standard` | black54 | 0 | standard | Flat/Brutal themes |
| `glass` | black26 | 10 | slow | Glass theme overlays |
| `pixel` | black87 | 0 | instant | Pixel theme (no blur) |

---

### RQ-006: How should the resolve() method work for StateColorSpec?

**Decision**: Simple priority-based resolution with explicit parameters.

**Rationale**:
- Clear precedence: error > disabled > active/inactive
- No hidden state or context dependency
- Matches existing toggle/tab patterns in codebase

**API Design**:
```dart
class StateColorSpec {
  final Color active;
  final Color inactive;
  final Color? disabled;
  final Color? error;

  Color resolve({
    required bool isActive,
    bool isDisabled = false,
    bool hasError = false,
  }) {
    if (hasError && error != null) return error!;
    if (isDisabled) return disabled ?? inactive;
    return isActive ? active : inactive;
  }
}
```

---

## Technology Decisions Summary

| Decision | Choice | Constitution Reference |
|----------|--------|----------------------|
| Spec pattern | @TailorMixin for shared specs | Section 4.5 |
| Override mechanism | InheritedWidget | Section 10 (no global state) |
| Deprecation strategy | typedef + @Deprecated | N/A (internal API) |
| Preset naming | fast/standard/slow | Section 5.1 (motion tokens) |
| Value objects | Keep Equatable for SurfaceStyle, InteractionSpec | Section 6.2 (simple components) |

## Open Questions Resolved

All research questions have been answered. No NEEDS CLARIFICATION items remain.
