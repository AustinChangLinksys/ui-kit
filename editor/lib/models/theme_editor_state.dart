import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Represents the complete editor state for theme editing
class ThemeEditorState {
  /// The current theme being edited
  final AppDesignTheme currentTheme;

  /// Current brightness mode (light or dark)
  final Brightness brightness;

  /// Whether the theme has unsaved changes
  final bool hasUnsavedChanges;

  /// Optional identifier for the current theme preset
  final String? currentPresetName;

  ThemeEditorState({
    required this.currentTheme,
    this.brightness = Brightness.light,
    this.hasUnsavedChanges = false,
    this.currentPresetName,
  });

  /// Create a copy with selective field updates
  ThemeEditorState copyWith({
    AppDesignTheme? currentTheme,
    Brightness? brightness,
    bool? hasUnsavedChanges,
    String? currentPresetName,
  }) {
    return ThemeEditorState(
      currentTheme: currentTheme ?? this.currentTheme,
      brightness: brightness ?? this.brightness,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
      currentPresetName: currentPresetName ?? this.currentPresetName,
    );
  }
}
