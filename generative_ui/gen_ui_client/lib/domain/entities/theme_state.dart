import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'design_language.dart';

/// Immutable state representing the current theme configuration.
///
/// Combines design language selection with Material 3 seed color
/// and brightness preferences.
class ThemeState extends Equatable {
  /// The active design language (visual style).
  final DesignLanguage designLanguage;

  /// The seed color for Material 3 color scheme generation.
  final Color seedColor;

  /// The brightness mode (light or dark).
  final Brightness brightness;

  /// Creates a new theme state with the given configuration.
  ///
  /// Defaults to Glass design language, blue seed color, and light mode.
  const ThemeState({
    this.designLanguage = DesignLanguage.glass,
    this.seedColor = const Color(0xFF2196F3), // Blue
    this.brightness = Brightness.light,
  });

  /// Creates a copy of this state with the given fields replaced.
  ThemeState copyWith({
    DesignLanguage? designLanguage,
    Color? seedColor,
    Brightness? brightness,
  }) {
    return ThemeState(
      designLanguage: designLanguage ?? this.designLanguage,
      seedColor: seedColor ?? this.seedColor,
      brightness: brightness ?? this.brightness,
    );
  }

  /// Whether the current brightness is dark mode.
  bool get isDarkMode => brightness == Brightness.dark;

  @override
  List<Object?> get props => [designLanguage, seedColor, brightness];

  @override
  String toString() =>
      'ThemeState(designLanguage: ${designLanguage.shortName}, '
      'seedColor: #${seedColor.toARGB32().toRadixString(16).padLeft(8, '0')}, '
      'brightness: ${brightness.name})';
}
