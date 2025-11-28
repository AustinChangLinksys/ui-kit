import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// 1. 引入 UI Library Barrel File
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

  // 1. 改用 Boolean 控制是否覆寫
  final isCustomColor = context.knobs.boolean(
    label: 'Override Color?',
    initialValue: false,
  );

  // 2. 只有在 true 時才讀取顏色列表 (這裡就不需要 null 選項了)
  final customColor = isCustomColor
      ? context.knobs.list<Color>(
          label: 'Color Value',
          options: [
            Colors.blue,
            Colors.red,
            const Color(0xFF0870EA),
          ],
          labelBuilder: (value) => 'Color ${value.value.toRadixString(16)}',
          initialOption: Colors.blue,
        )
      : null;

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcon(
          Assets.icons.search, // 請確認變數名
          size: size,
          color: customColor, // 傳入 null 代表跟隨主題
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
          // 放在一個有背景色的容器中，方便觀察對比
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ProductImage(
              // ⚠️ 請替換為你實際的圖片 (例如 Assets.images.router)
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
          // ⚠️ 請替換為兩張不同的 SVG 以測試切換效果
          lightSvg: Assets.images.imgWiredMoveNodes, // 淺色模式圖
          darkSvg: Assets.images.imgWiredMoveNodes, // 深色模式圖
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
          // ⚠️ 請替換為兩張不同的 PNG 以測試切換效果 (例如 Banner)
          lightImage: Assets.images.speedtestPowered,
          darkImage: Assets.images.speedtestPowered, // 這裡放 dark version
          width: 200,
        ),
        const SizedBox(height: 16),
        const Text(
            'Switching logic for Raster Images (e.g. Banners with text)'),
      ],
    ),
  );
}
