# Research: Surface Texture Support

**Feature**: `010-surface-textures`
**Status**: Complete

## Decisions & Rationale

### 1. Texture Rendering Technique

- **Decision**: Use `BoxDecoration.image` with `DecorationImage`.
- **Rationale**: `BoxDecoration` natively supports drawing an image on top of the `color` (background color). It also supports `fit`, `repeat` (tiling), and `opacity` (since Flutter 3.0 / late 2.x). This avoids creating an extra `Stack` or `Image` widget, keeping the render tree shallower and performance higher.
- **Alternatives Considered**:
  - *Stack with Image widget*: More widgets, heavier render tree.
  - *CustomPainter*: Too complex for simple tiling/blending.

### 2. Opacity Control

- **Decision**: Use `DecorationImage.opacity`.
- **Rationale**: `DecorationImage` accepts a double `opacity` (0.0 to 1.0). This allows the texture transparency to be controlled independently of the image's own alpha channel.
- **Alternatives Considered**:
  - *Opacity Widget*: Would affect the entire container or require a Stack.
  - *ColorFilter*: Can do opacity but is more expensive/complex to configure for simple alpha.

### 3. Tiling Strategy

- **Decision**: Default to `ImageRepeat.repeat`.
- **Rationale**: Textures (noise, grain, grid) are typically small seamless patterns. Stretching them (`BoxFit.cover`) usually looks pixelated or distorted. Tiling is the standard behavior for "textures".
- **Configuration**: The `fit` property will default to `BoxFit.scaleDown` (or `none`) combined with `repeat`. Actually `DecorationImage` uses `fit` to scale *before* repeating? No, `repeat` usually overrides standard fit behavior or works in tandem.
  - *Refinement*: `DecorationImage` behavior: If `repeat` is set, it tiles. `scale` might be needed? For now, standard tiling is sufficient.

### 4. Theme System Integration

- **Decision**: Add `ImageProvider? texture` and `double textureOpacity` to `SurfaceStyle`.
- **Rationale**: `SurfaceStyle` is the data carrier for all surface visual properties. Adding it here ensures all themes (Glass, Brutal, etc.) can support textures natively.
