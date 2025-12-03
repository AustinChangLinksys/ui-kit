# Quickstart: Using Surface Textures

## Concept

Surfaces now support **Textures**: seamless patterns (noise, grids, dots) overlaid on the background color. This is essential for "Frosted Glass" (noise) or "Brutalism" (halftone) styles.

## Usage

### 1. Defining a Textured Style

In your `AppDesignTheme` factory (e.g., `GlassDesignTheme`):

```dart
import 'package:ui_kit_library/src/foundation/theme/tokens/app_textures.dart';

SurfaceStyle(
  backgroundColor: Colors.black.withValues(alpha: 0.5),
  // Add texture using predefined tokens
  texture: AppTextures.noise, 
  textureOpacity: 0.15, // Subtle grain
  // ... other props
)
```

### 2. Using the Surface

No changes needed in consumption code. `AppSurface` automatically renders the texture if the active theme/variant has one.

```dart
AppSurface(
  variant: SurfaceVariant.base, // If base style has texture, it shows.
  child: Text("Textured Surface"),
)
```

## Assets & Tokens

The library provides 8 standard repeatable textures in `AppTextures`:

### Original Textures
- `AppTextures.pixelGrid`: 4x4 pixel dot grid (Brutalism/Pixel).
- `AppTextures.diagonalLines`: 4x4 diagonal caution lines pattern.
- `AppTextures.noise`: 8x8 monochrome random noise (Frosted Glass).

### New Textures (Extended Library)
- `AppTextures.wood`: 8x8 natural wood grain with wavy lines.
- `AppTextures.metal`: 8x8 brushed metal with diagonal scratches.
- `AppTextures.fabric`: 8x8 woven cloth pattern.
- `AppTextures.checkerboard`: 8x8 black and white checkerboard squares.
- `AppTextures.pixelArt`: 8x8 retro pixel art pattern (8-bit style).

Ensure custom texture assets are:
1. Seamless (repeatable).
2. High contrast (if using opacity to blend).
3. Optimized (WebP/PNG).

## Texture Opacity Reference

Recommended opacity values by use case:
- **Glass Effects**: 0.1 - 0.2 (subtle grain)
- **Fabric/Woven**: 0.2 - 0.3 (visible texture)
- **Metal**: 0.25 - 0.4 (scratches visible)
- **Wood**: 0.3 - 0.5 (wood grain prominent)
- **Pixel Art**: 0.3 - 0.4 (retro effect)
