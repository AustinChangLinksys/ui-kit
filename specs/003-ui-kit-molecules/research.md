# Research: Unified UI Kit Molecules

**Feature**: Unified UI Kit Molecules (`003-ui-kit-molecules`)
**Date**: 2025-11-29

## Implementation Decisions

### 1. AppButton Sizing Strategy

**Decision**: Define `buttonHeight` properties in `AppDesignTheme` (and its extensions) rather than hardcoding values in the widget.
**Rationale**: Supports the **Data-Driven Strategy**. A "Brutal" theme might want 56px chunky buttons, while a "Glass" theme might prefer 44px.
**Alternatives Considered**:
- Hardcoding constants: Violates theming flexibility.
- Passing height as a prop: Reduces consistency; buttons should look uniform by default.

### 2. AppTextField Focus Visuals

**Decision**: Use a `FocusNode` combined with `ListenableBuilder` (or `AnimatedBuilder`) to drive the `AppSurface`'s state.
**Rationale**: `AppSurface` is the root visual primitive. The native `TextField`'s `InputDecoration` border handling often conflicts with custom surface rendering (shadows, blurs). By lifting the visual state to the wrapping `AppSurface`, we decouple logic from the native widget's limited styling capabilities.
**Implementation Detail**:
```dart
return ListenableBuilder(
  listenable: _focusNode,
  builder: (context, _) {
    return AppSurface(
      variant: _focusNode.hasFocus ? SurfaceVariant.highlight : SurfaceVariant.base,
      // ...
    );
  }
);
```

### 3. Golden Test Architecture (Alchemist)

**Decision**: Use `GoldenTestScenario` for each state (Normal, Hover, Pressed, Disabled) and wrap the entire group in a Theme Matrix runner.
**Rationale**: Ensures strict adherence to FR-018 (Light/Dark modes).
**Matrix**:
- **Axis X**: States (Normal, Disabled, Loading, Error)
- **Axis Y**: Themes (Light Glass, Dark Glass, Light Brutal, Dark Brutal)
- **Text Scale**: Run a separate pass or scenario for 1.5x scale to verify overflow (FR-12.2).

### 4. AppNavigationBar Layout Adaptation

**Decision**: Use a `NavigationBarSpec` class in the theme to define layout behavior (`isFloating`, `height`, `blurStrength`).
**Rationale**: Avoids `if (theme is Glass)` checks. The component simply reads `theme.navBarSpec.isFloating` to decide whether to apply `padding` and `borderRadius`.

## Resolved Clarifications

(From Spec Phase)
- **Focus**: Manual FocusNode listener confirmed.
- **Nav Limit**: Strict limit of 5 items (Assertion).
- **Avatar Crop**: Center-crop for non-square images.
- **Slider Steps**: Support `divisions` for discrete steps.
- **Button Height**: Fixed height driven by theme.
