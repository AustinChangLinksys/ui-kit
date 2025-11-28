# Research Notes: Unified Design System

## Decision: Theme Tailor for Code Generation

**Context**: We need to generate `ThemeExtension` classes (`copyWith`, `lerp`) for `AppDesignTheme`.
**Decision**: Use `theme_tailor` (specifically `@TailorMixin` as per the updated Constitution).
**Rationale**: 
- Reduces boilerplate significantly.
- Ensures type-safe `lerp` (linear interpolation) which is critical for smooth theme switching animations.
- Already integrated into the project.

## Decision: AnimationSpec in Theme

**Context**: Different design languages have different "physics" (e.g., Glass is slow/smooth, Brutal is fast/snappy).
**Decision**: Embed `AnimationSpec` (duration + curve) directly into `AppDesignTheme`.
**Rationale**: This allows `AppSurface` (via implicit animations like `AnimatedContainer`) to automatically adapt its motion feel without manual configuration in every component.

## Decision: Spacing Factor

**Context**: Brutalism often requires more breathing room (whitespace) than Flat design.
**Decision**: Add `double spacingFactor` to `AppDesignTheme`.
**Rationale**: Allows components to scale their padding/margins relative to the active design language (e.g., `padding: EdgeInsets.all(16 * theme.spacingFactor)`).

## Decision: Orthogonal Theme Switching

**Context**: We want to switch "Design Language" (Glass/Brutal) independently of "Theme Mode" (Light/Dark).
**Decision**: Use a custom Widgetbook Knob for "Design Language" and standard Addon for "Theme Mode".
**Rationale**: This avoids a combinatorial explosion of options in the single Theme Addon list (e.g., "Glass Light", "Glass Dark", "Brutal Light"... x4 styles = 8 options). It provides a cleaner UX for testing permutations.