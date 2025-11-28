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
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: AppTheme.create(
                brightness: Brightness.light,
                seedColor: const Color(0xFF0870EA),
              ),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: AppTheme.create(
                brightness: Brightness.dark,
                seedColor: const Color(0xFF0870EA),
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          home: Scaffold(
            body: Center(child: child),
          ),
        );
      },
    );
  }
}