# Research: GenUI Phase 4 - Client Refactoring & Layout Architect

**Date**: 2025-12-04
**Status**: Complete

## Research Tasks

### RT-001: State Management for Multi-Source State

**Context**: gen_ui_client needs to manage theme state (design language, seed color, brightness), conversation state (messages, loading), and code generation state (formatted output).

**Decision**: Riverpod (flutter_riverpod ^2.4.9)

**Rationale**:
- Supports multiple independent providers without prop drilling
- Compile-time safety with riverpod_annotation code generation
- ref.watch enables reactive rebuilds when any state source changes
- Family providers allow parameterized state (e.g., per-component code gen)

**Alternatives Considered**:
- **StatefulWidget + InheritedWidget**: Rejected - too much boilerplate for 3+ state sources, manual rebuild logic
- **Bloc**: Rejected - overkill for this use case, adds event/state ceremony
- **Provider**: Rejected - Riverpod is the modern evolution with better testing and no context dependency

### RT-002: Code Generation Formatting

**Context**: Generated Dart code needs proper formatting for readability and copy-paste usability.

**Decision**: dart_style ^2.3.0

**Rationale**:
- Official Dart formatting package
- Same formatter used by `dart format` CLI
- Handles indentation, line wrapping, trailing commas automatically
- Graceful fallback if formatting fails (return unformatted code)

**Alternatives Considered**:
- **Manual string formatting**: Rejected - error-prone, inconsistent results
- **External CLI call**: Rejected - async overhead, platform-specific issues

### RT-003: Code Highlighting Display

**Context**: Code tab needs syntax highlighting for Dart code.

**Decision**: flutter_highlight ^0.7.0

**Rationale**:
- Pure Dart implementation (no native dependencies)
- Supports Dart/Flutter syntax
- Multiple themes available (github, dracula, etc.)
- Integrates easily with Flutter widgets

**Alternatives Considered**:
- **flutter_code_editor**: Rejected - full editor overkill for read-only display
- **Custom RichText**: Rejected - too much work to implement proper tokenization

### RT-004: Theme Architecture Pattern

**Context**: Need to combine UI Kit's AppDesignTheme with Material's ColorScheme.fromSeed for seed color support.

**Decision**: Layered Theme Provider
```
ThemeController (Riverpod Notifier)
├── designLanguage: DesignLanguage (Glass, Brutal, Flat, Neumorphic, Pixel)
├── seedColor: Color
└── brightness: Brightness

Outputs:
├── ThemeData (Material theme with ColorScheme.fromSeed)
└── AppDesignTheme (from UI Kit factory)
```

**Rationale**:
- Single source of truth for all theme-related state
- Changing seedColor rebuilds both Material colors AND propagates to AppDesignTheme consumers
- DesignLanguage enum maps to UI Kit theme factories (GlassDesignTheme, BrutalDesignTheme, etc.)

**Alternatives Considered**:
- **Separate providers for Material/AppDesignTheme**: Rejected - synchronization issues
- **Context-only (no state management)**: Rejected - no reactive updates on seed change

### RT-005: Registry Fallback Strategy

**Context**: When AI requests an unregistered component, need graceful degradation.

**Decision**: Styled AppSurface with error message

**Rationale**:
- Maintains visual consistency with current theme
- Clear error indication without breaking conversation flow
- Logs warning for debugging
- Pattern: `AppSurface(variant: SurfaceVariant.base, child: AppText.body("Unknown: $componentName"))`

**Alternatives Considered**:
- **Throw exception**: Rejected - breaks user experience
- **Return SizedBox.shrink()**: Rejected - silent failure, confusing
- **Generic Container**: Rejected - violates Constitution 5.1 (AppSurface primitive)

### RT-006: Component Registration Pattern

**Context**: Need to register 31 UI Kit components with consistent factory signatures.

**Decision**: Typedef + Static Map
```dart
typedef ComponentBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props, {
  void Function(Map<String, dynamic>)? onAction,
});

class UiKitComponentRegistry {
  static final Map<String, ComponentBuilder> _builders = {...};

  static Widget build(String name, BuildContext ctx, Map props, {onAction}) {
    final builder = _builders[name];
    if (builder == null) return _buildErrorFallback(name, ctx);
    return builder(ctx, props, onAction: onAction);
  }
}
```

**Rationale**:
- Type-safe factory function signature
- Consistent onAction callback for all interactive components
- Centralized fallback handling
- Easy to test (mock registry)

**Alternatives Considered**:
- **Reflection/mirrors**: Rejected - not available in Flutter AOT
- **Code generation**: Rejected - adds build step complexity for 31 components
- **Individual factory classes**: Rejected - too much boilerplate

### RT-007: Layout JSON Schema

**Context**: Need standardized JSON structure for AI-generated layouts.

**Decision**: Nested component tree with type/props/children
```json
{
  "type": "Column",
  "props": { "mainAxisAlignment": "center" },
  "children": [
    {
      "type": "AppButton",
      "props": { "label": "Click Me", "variant": "highlight" }
    }
  ]
}
```

**Rationale**:
- Matches Flutter's widget tree concept
- Easy to traverse recursively for both rendering and code gen
- Props map directly to component constructor parameters
- Children array for layout components (Column, Row, Card)

**Alternatives Considered**:
- **Flat list with parent references**: Rejected - harder to traverse
- **DSL syntax**: Rejected - requires parser, AI may not follow format

## Dependencies Verification

| Package | Version | Purpose | Verified |
|---------|---------|---------|----------|
| flutter_riverpod | ^2.4.9 | State management | ✅ |
| riverpod_annotation | ^2.3.3 | Code gen for providers | ✅ |
| equatable | ^2.0.5 | Value equality | ✅ |
| json_annotation | ^4.8.1 | JSON serialization | ✅ |
| dart_style | ^2.3.0 | Code formatting | ✅ |
| flutter_highlight | ^0.7.0 | Syntax highlighting | ✅ |
| ui_kit_library | path | UI components | ✅ |
| generative_ui | path | LLM integration | ✅ |

## Open Questions Resolved

1. **Q: Should code gen be synchronous or async?**
   A: Synchronous - dart_style.format() is fast enough for typical layouts (<100ms)

2. **Q: How to handle theme-specific props in code gen?**
   A: Omit theme-specific values - generated code should work with any theme

3. **Q: Should we support component composition in registry?**
   A: Yes - children array in JSON, recursive render/codegen

## Next Steps

Proceed to Phase 1: Data Model and Contracts
