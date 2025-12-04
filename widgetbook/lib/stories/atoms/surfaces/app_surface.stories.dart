import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Variants',
  type: AppSurface,
)
Widget buildAppSurfaceVariants(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _buildSurfaceDemo(context, SurfaceVariant.base, 'Base'),
        _buildSurfaceDemo(context, SurfaceVariant.elevated, 'Elevated'),
        _buildSurfaceDemo(context, SurfaceVariant.highlight, 'Highlight'),
      ],
    ),
  );
}

Widget _buildSurfaceDemo(BuildContext context, SurfaceVariant variant, String label) {
  return AppSurface(
    variant: variant,
    width: 120,
    height: 120,
    child: Center(
      child: Text(label, textAlign: TextAlign.center),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: AppSurface,
)
Widget buildAppSurfaceInteractive(BuildContext context) {
  return Center(
    child: AppSurface(
      variant: SurfaceVariant.base,
      interactive: true,
      onTap: () {},
      width: 200,
      height: 100,
      child: const Center(
        child: Text('Tap Me\n(Animates on Theme Switch)'),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Textures',
  type: AppSurface,
)
Widget buildAppSurfaceTextures(BuildContext context) {
  final textureOpacity = context.knobs.double.slider(
    label: 'Texture Opacity',
    initialValue: 0.3,
    min: 0.0,
    max: 1.0,
  );

  final selectedTexture = context.knobs.object.dropdown<String>(
    label: 'Select Texture',
    initialOption: 'Pixel Grid',
    options: [
      'Pixel Grid',
      'Diagonal Lines',
      'Noise',
      'Wood',
      'Metal',
      'Fabric',
      'Checkerboard',
      'Pixel Art',
      'None',
    ],
  );

  final textureMap = {
    'Pixel Grid': AppTextureAssets.pixelGrid,
    'Diagonal Lines': AppTextureAssets.diagonalLines,
    'Noise': AppTextureAssets.noise,
    'Wood': AppTextureAssets.wood,
    'Metal': AppTextureAssets.metal,
    'Fabric': AppTextureAssets.fabric,
    'Checkerboard': AppTextureAssets.checkerboard,
    'Pixel Art': AppTextureAssets.pixelArt,
    'None': null,
  };

  return Center(
    child: AppSurface(
      variant: SurfaceVariant.base,
      style: SurfaceStyle(
        backgroundColor: Colors.grey.shade200,
        borderColor: Colors.grey.shade300,
        contentColor: Colors.black,
        texture: textureMap[selectedTexture],
        textureOpacity: textureOpacity,
      ),
      width: 200,
      height: 200,
      child: const Center(
        child: Text('Textured Surface'),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'All Textures Gallery',
  type: AppSurface,
)
Widget buildAppSurfaceTextureGallery(BuildContext context) {
  final textureOpacity = context.knobs.double.slider(
    label: 'Texture Opacity',
    initialValue: 0.3,
    min: 0.0,
    max: 1.0,
  );

  final textures = [
    ('Pixel Grid', AppTextureAssets.pixelGrid, Colors.grey.shade200),
    ('Diagonal Lines', AppTextureAssets.diagonalLines, const Color(0xFFFFF8E1)),
    ('Noise', AppTextureAssets.noise, const Color(0xFF222222)),
    ('Wood', AppTextureAssets.wood, const Color(0xFF8B4513)),
    ('Metal', AppTextureAssets.metal, const Color(0xFFAAAAAA)),
    ('Fabric', AppTextureAssets.fabric, const Color(0xFFC8B4A0)),
    ('Checkerboard', AppTextureAssets.checkerboard, Colors.white),
    ('Pixel Art', AppTextureAssets.pixelArt, const Color(0xFFFFC864)),
  ];

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (final (name, texture, bgColor) in textures)
          AppSurface(
            width: 150,
            height: 150,
            style: SurfaceStyle(
              backgroundColor: bgColor,
              borderColor: Colors.grey.shade400,
              borderWidth: 2.0,
              contentColor: Colors.black,
              texture: texture,
              textureOpacity: textureOpacity,
            ),
            child: Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
      ],
    ),
  );
}
