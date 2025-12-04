import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppSurface Texture Golden Tests', () {
    goldenTest(
      'AppSurface Textures',
      fileName: 'app_surface_texture_render',
      
      // use runAsync to preload all textures
      pumpWidget: (tester, widget) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.create(brightness: Brightness.light),
            home: Scaffold(
              backgroundColor: Colors.white,
              body: widget,
            ),
          ),
        );

        await tester.runAsync(() async {
          final context = tester.element(find.byType(Scaffold));

          // preload all defined textures
          await precacheImage(AppTextureAssets.pixelGrid, context);
          await precacheImage(AppTextureAssets.diagonalLines, context);
          await precacheImage(AppTextureAssets.noise, context);
          await precacheImage(AppTextureAssets.wood, context);
          await precacheImage(AppTextureAssets.metal, context);
          await precacheImage(AppTextureAssets.fabric, context);
          await precacheImage(AppTextureAssets.checkerboard, context);
          await precacheImage(AppTextureAssets.pixelArt, context);
        });

        await tester.pumpAndSettle();
      },
      
      builder: () => GoldenTestGroup(
        columns: 4,
        children: [
          // 1. Pixel Grid
          GoldenTestScenario(
            name: 'Pixel Grid (Dot Pattern)',
            child: AppSurface(
              width: 150,
              height: 150,
              style: SurfaceStyle(
                backgroundColor: Colors.grey.shade200,
                borderColor: Colors.black,
                borderWidth: 2.0,
                contentColor: Colors.black,

                // set texture
                texture: AppTextureAssets.pixelGrid,
                textureOpacity: 0.3,
              ),
              child: const Center(child: Text('Pixel Grid')),
            ),
          ),

          // 2. Diagonal Lines
          GoldenTestScenario(
            name: 'Diagonal Lines',
            child: AppSurface(
              width: 150,
              height: 150,
              style: SurfaceStyle(
                backgroundColor: const Color(0xFFFFF8E1),
                borderColor: Colors.black,
                borderWidth: 2.0,
                contentColor: Colors.black,

                // set texture
                texture: AppTextureAssets.diagonalLines,
                textureOpacity: 0.2,
              ),
              child: const Center(child: Text('Diagonal')),
            ),
          ),

          // 3. Noise
          GoldenTestScenario(
            name: 'Noise (Grain)',
            child: AppSurface(
              width: 150,
              height: 150,
              style: SurfaceStyle(
                backgroundColor: const Color(0xFF222222), // dark background
                borderColor: Colors.white24,
                borderWidth: 1.0,
                contentColor: Colors.white,
                borderRadius: 24.0,

                // set texture
                texture: AppTextureAssets.noise,
                textureOpacity: 0.15, // noise doesn't need to be too strong
              ),
              child: const Center(child: Text('Noise / Glass')),
            ),
          ),

          // 4. Wood Texture
          GoldenTestScenario(
            name: 'Wood Texture',
            child: AppSurface(
              width: 150,
              height: 150,
              style: SurfaceStyle(
                backgroundColor: const Color(0xFF8B4513),
                borderColor: const Color(0xFF654321),
                borderWidth: 2.0,
                contentColor: Colors.white,

                // set texture
                texture: AppTextureAssets.wood,
                textureOpacity: 0.4,
              ),
              child: const Center(child: Text('Wood')),
            ),
          ),

          // 5. Metal Texture
          GoldenTestScenario(
            name: 'Metal Texture',
            child: AppSurface(
              width: 150,
              height: 150,
              style: SurfaceStyle(
                backgroundColor: const Color(0xFFAAAAAA),
                borderColor: const Color(0xFF808080),
                borderWidth: 2.0,
                contentColor: Colors.black,

                // set texture
                texture: AppTextureAssets.metal,
                textureOpacity: 0.3,
              ),
              child: const Center(child: Text('Metal')),
            ),
          ),

          // 6. Fabric Texture
          GoldenTestScenario(
            name: 'Fabric Texture',
            child: AppSurface(
              width: 150,
              height: 150,
              style: SurfaceStyle(
                backgroundColor: const Color(0xFFC8B4A0),
                borderColor: const Color(0xFF8B7355),
                borderWidth: 2.0,
                contentColor: Colors.black,

                // set texture
                texture: AppTextureAssets.fabric,
                textureOpacity: 0.25,
              ),
              child: const Center(child: Text('Fabric')),
            ),
          ),

          // 7. Checkerboard Texture
          GoldenTestScenario(
            name: 'Checkerboard',
            child: AppSurface(
              width: 150,
              height: 150,
              style: SurfaceStyle(
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                borderWidth: 2.0,
                contentColor: Colors.black,

                // set texture
                texture: AppTextureAssets.checkerboard,
                textureOpacity: 0.2,
              ),
              child: const Center(child: Text('Checker')),
            ),
          ),

          // 8. Pixel Art Texture
          GoldenTestScenario(
            name: 'Pixel Art (8-bit)',
            child: AppSurface(
              width: 150,
              height: 150,
              style: SurfaceStyle(
                backgroundColor: const Color(0xFFFFC864),
                borderColor: const Color(0xFF8B7355),
                borderWidth: 2.0,
                contentColor: Colors.black,

                // set texture
                texture: AppTextureAssets.pixelArt,
                textureOpacity: 0.35,
              ),
              child: const Center(child: Text('Pixel Art')),
            ),
          ),
        ],
      ),
    );
  });
}