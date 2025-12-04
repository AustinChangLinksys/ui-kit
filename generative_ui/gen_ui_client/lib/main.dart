import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/theme_factories.dart';
import 'domain/entities/design_language.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/views/architect_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: 'assets/.env');
  } catch (e) {
    debugPrint('Warning: Could not load .env file: $e');
    debugPrint('Using mock generator instead.');
  }

  runApp(
    const ProviderScope(
      child: GenUiClientApp(),
    ),
  );
}

/// Main application widget with theme-aware MaterialApp.
class GenUiClientApp extends ConsumerWidget {
  const GenUiClientApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);

    return MaterialApp(
      title: 'Layout Architect',
      theme: ThemeFactories.createThemeData(
        language: themeState.designLanguage,
        brightness: Brightness.light,
        seedColor: themeState.seedColor,
      ),
      darkTheme: ThemeFactories.createThemeData(
        language: themeState.designLanguage,
        brightness: Brightness.dark,
        seedColor: themeState.seedColor,
      ),
      themeMode: themeState.brightness == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const ArchitectView(),
    );
  }
}

/// Extension to get the icon for a design language.
extension DesignLanguageIconExt on DesignLanguage {
  IconData get icon {
    switch (this) {
      case DesignLanguage.glass:
        return Icons.blur_on;
      case DesignLanguage.brutal:
        return Icons.square_outlined;
      case DesignLanguage.flat:
        return Icons.layers_outlined;
      case DesignLanguage.neumorphic:
        return Icons.lens_blur;
      case DesignLanguage.pixel:
        return Icons.grid_on;
    }
  }
}
