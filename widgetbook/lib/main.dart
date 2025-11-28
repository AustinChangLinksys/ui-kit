import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


// 2. Import auto-generated directories
import 'main.directories.g.dart';

// 3. Import custom Addon
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
        
        // --- 1. Standard Theme Mode Toggle (Light/Dark) ---
        // Provides only Light and Dark base ThemeDatas, without Design System Extension
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: ThemeData.light()),
            WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
          ],
        ),

        // --- 2. Custom Design System Addon ---
        // Used to switch Design Language (Glass/Brutal/Flat/Neumorphic) and Seed Color
        DesignSystemAddon(),

        // --- 3. Text Scale ---
        TextScaleAddon(
          min: 1.0,
          max: 2.0,
          initialScale: 1.0,
        ),
      ],
// This is the AppThemeWrapper we are going to replace
// class AppThemeWrapper extends StatelessWidget {
//   final Widget child;
//   const AppThemeWrapper({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     // ... previous logic ...
//   }
// }
//
// Final appBuilder
      appBuilder: (context, child) {
        // The Theme is now injected by DesignSystemAddon.buildUseCase
        // The child is already wrapped in a MaterialApp
        // So we just need to return the child directly
        return child;
      },
    );
  }
}