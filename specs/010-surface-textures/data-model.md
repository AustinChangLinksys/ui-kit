# Data Model: Surface Texture Support

**Feature**: `010-surface-textures`

## Entities

### SurfaceStyle

The configuration object for surface appearance.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `texture` | `ImageProvider?` | `null` | The texture image to overlay on the background. |
| `textureOpacity` | `double` | `1.0` | Opacity of the texture (0.0 - 1.0). |

**Validation Rules**:
- `textureOpacity` must be between 0.0 and 1.0 inclusive (though Dart types don't enforce ranges, this is a logical constraint).

## State Transitions

None. `SurfaceStyle` is immutable configuration.
