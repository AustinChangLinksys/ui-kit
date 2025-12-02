import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'controllers/theme_editor_controller.dart';
import 'pages/live_editor_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeEditorController(),
      child: Consumer<ThemeEditorController>(
        builder: (context, themeController, _) {
          return MaterialApp(
            title: 'Live Theme Editor',
            theme: AppTheme.create(
              brightness: Brightness.light, // Editor UI always light
            ),
            home: const LiveEditorPage(),
          );
        },
      ),
    );
  }
}
