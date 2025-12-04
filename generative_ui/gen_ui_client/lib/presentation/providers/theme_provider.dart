import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/design_language.dart';
import '../../domain/entities/theme_state.dart';

part 'theme_provider.g.dart';

/// Riverpod notifier that manages the application theme state.
///
/// Provides methods to:
/// - Switch design language (Glass, Brutal, Flat, Neumorphic, Pixel)
/// - Change seed color for Material 3 color scheme
/// - Toggle brightness (light/dark mode)
@riverpod
class ThemeController extends _$ThemeController {
  @override
  ThemeState build() => const ThemeState();

  /// Sets the design language and triggers theme rebuild.
  void setDesignLanguage(DesignLanguage language) {
    state = state.copyWith(designLanguage: language);
  }

  /// Sets the seed color for Material 3 color scheme generation.
  void setSeedColor(Color color) {
    state = state.copyWith(seedColor: color);
  }

  /// Sets the brightness mode.
  void setBrightness(Brightness brightness) {
    state = state.copyWith(brightness: brightness);
  }

  /// Toggles between light and dark mode.
  void toggleBrightness() {
    state = state.copyWith(
      brightness: state.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
    );
  }

  /// Resets to default theme state.
  void reset() {
    state = const ThemeState();
  }
}
