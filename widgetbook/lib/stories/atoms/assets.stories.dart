import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// 1. Import UI Library Barrel File
import 'package:ui_kit_library/ui_kit.dart';

// -----------------------------------------------------------------------------
// UseCase 1: AppIcon (SVG & Font - Tinting)
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'Icon Playground',
  type: AppIcon,
)
Widget buildAppIcon(BuildContext context) {
  final size = context.knobs.double.slider(
    label: 'Size',
    initialValue: 48,
    min: 16,
    max: 128,
  );

  // 1. Use Boolean to control override
  final isCustomColor = context.knobs.boolean(
    label: 'Override Color?',
    initialValue: false,
  );

  // 2. Only read color list when true (no null option needed here)
  final customColor = isCustomColor
      ? context.knobs.object.dropdown<Color>(
          label: 'Color Value',
          options: [
            Colors.blue,
            Colors.red,
            const Color(0xFF0870EA),
          ],
          labelBuilder: (value) =>
              'Color ${value.toARGB32().toRadixString(16)}',
          initialOption: Colors.blue,
        )
      : null;

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcon(
          Assets.icons.search, // Please confirm variable name
          size: size,
          color: customColor, // Passing null means following the theme
        ),
        // ...
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// UseCase 2: ProductImage (PNG/WebP - Dimming)
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'Product Image (Dimming)',
  type: ProductImage,
)
Widget buildProductImage(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placed in a container with a background color for easy comparison
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ProductImage(
              // ⚠️ Please replace with your actual image (e.g., Assets.images.router)
              image: Assets.images.devices.routerMx6200,
              width: context.knobs.double.slider(
                label: 'Width',
                initialValue: 200,
                min: 100,
                max: 400,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Toggle Dark Mode to see the "Dimming" effect.'),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// UseCase 3: ThemeAwareSvg (SVG - Switching)
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'Multi-colored SVG (Switching)',
  type: ThemeAwareSvg,
)
Widget buildThemeAwareSvg(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeAwareSvg(
          // ⚠️ Please replace with two different SVGs to test the switching effect
          lightSvg: Assets.images.imgWiredMoveNodes, // Light mode image
          darkSvg: Assets.images.imgWiredMoveNodes, // Dark mode image
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 16),
        const Text('Switching logic for Multi-colored SVGs'),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// UseCase 4: ThemeAwareImage (PNG/WebP - Switching)
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'Multi-colored PNG (Switching)',
  type: ThemeAwareImage,
)
Widget buildThemeAwareImage(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ThemeAwareImage(
          // ⚠️ Please replace with two different PNGs to test the switching effect (e.g., Banner)
          lightImage: Assets.images.speedtestPowered,
          darkImage: Assets.images.speedtestPowered, // Place dark version here
          width: 200,
        ),
        const SizedBox(height: 16),
        const Text(
            'Switching logic for Raster Images (e.g. Banners with text)'),
      ],
    ),
  );
}
