import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// 1. 引入我們的 UI Library
import 'package:ui_kit_library/ui_kit.dart';

// 2. 引入自動生成的目錄
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        ViewportAddon(Viewports.all),
        
        // 定義所有 8 種主題組合 (Style x Brightness)
        // 這確保了切換主題時，Flutter 的 Theme 機制能正確運作
        MaterialThemeAddon(
          themes: [
            // --- Glass ---
            WidgetbookTheme(
              name: 'Glass Light',
              data: AppTheme.create(
                brightness: Brightness.light,
                seedColor: const Color(0xFF0870EA),
                designSystem: const GlassDesignTheme.light(),
              ),
            ),
            WidgetbookTheme(
              name: 'Glass Dark',
              data: AppTheme.create(
                brightness: Brightness.dark,
                seedColor: const Color(0xFF0870EA),
                designSystem: const GlassDesignTheme.dark(),
              ),
            ),
            // --- Brutal ---
            WidgetbookTheme(
              name: 'Brutal Light',
              data: AppTheme.create(
                brightness: Brightness.light,
                seedColor: const Color(0xFFFFDE59),
                designSystem: const BrutalDesignTheme.light(),
              ),
            ),
            WidgetbookTheme(
              name: 'Brutal Dark',
              data: AppTheme.create(
                brightness: Brightness.dark,
                seedColor: const Color(0xFF4A148C),
                designSystem: const BrutalDesignTheme.dark(),
              ),
            ),
            // --- Flat ---
            WidgetbookTheme(
              name: 'Flat Light',
              data: AppTheme.create(
                brightness: Brightness.light,
                seedColor: const Color(0xFF0870EA),
                designSystem: const FlatDesignTheme.light(),
              ),
            ),
            WidgetbookTheme(
              name: 'Flat Dark',
              data: AppTheme.create(
                brightness: Brightness.dark,
                seedColor: const Color(0xFF0870EA),
                designSystem: const FlatDesignTheme.dark(),
              ),
            ),
            // --- Neumorphic ---
            WidgetbookTheme(
              name: 'Neu Light',
              data: AppTheme.create(
                brightness: Brightness.light,
                seedColor: const Color(0xFFE0E5EC), // Neu base color
                designSystem: const NeumorphicDesignTheme.light(),
              ),
            ),
            WidgetbookTheme(
              name: 'Neu Dark',
              data: AppTheme.create(
                brightness: Brightness.dark,
                seedColor: const Color(0xFF2D2D2D), // Neu dark base
                designSystem: const NeumorphicDesignTheme.dark(),
              ),
            ),
          ],
        ),

        // C. 字體縮放 (Text Scale)
        TextScaleAddon(
          scales: [1.0, 1.5, 2.0],
          initialScale: 1.0,
        ),
      ],
      appBuilder: (context, child) {
        // 直接使用 ThemeAddon 注入的主題
        // 這時候 Theme.of(context) 已經是上面選中的那個 WidgetbookTheme 了
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          home: Scaffold(
            // 根據當前主題的 Brightness 動態調整背景
            // 這樣才能看清楚玻璃或 Neumorphism 的效果
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? const Color(0xFFF0F2F5)
                : const Color(0xFF121212),
            body: Center(child: child),
          ),
        );
      },
    );
  }
}
