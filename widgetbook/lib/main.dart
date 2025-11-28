import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


// 2. 引入自動生成的目錄
import 'main.directories.g.dart';

// 3. 引入自定義的 Addon
import 'addons/design_system_addon.dart';

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
        
        // --- 1. 標準主題模式切換 (Light/Dark) ---
        // 僅提供 Light 和 Dark 兩種基礎 ThemeData，不包含 Design System Extension
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: ThemeData.light()),
            WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
          ],
        ),

        // --- 2. 自定義設計系統 Addon ---
        // 用於切換 Design Language (Glass/Brutal/Flat/Neumorphic) 和 Seed Color
        DesignSystemAddon(),

        // --- 3. 字體縮放 (Text Scale) ---
        TextScaleAddon(
          min: 1.0,
          max: 2.0,
          initialScale: 1.0,
        ),
      ],
// 這是我們將要替換掉的 AppThemeWrapper
// class AppThemeWrapper extends StatelessWidget {
//   final Widget child;
//   const AppThemeWrapper({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     // ... 之前的邏輯 ...
//   }
// }
//
// 最終的 appBuilder
      appBuilder: (context, child) {
        // 現在 Theme 已經由 DesignSystemAddon.buildUseCase 注入了
        // child 已經被包裹在一個 MaterialApp 裡
        // 所以我們只需要直接回傳 child
        return child;
      },
    );
  }
}