import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Handles keyboard shortcuts for the theme editor
class KeyboardShortcuts {
  /// Register keyboard shortcuts for the editor
  static Map<LogicalKeySet, VoidCallback> getShortcuts({
    required VoidCallback onExport,
    required VoidCallback onReset,
    required VoidCallback onToggleBrightness,
  }) {
    return {
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyE): onExport,
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyR): onReset,
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyD): onToggleBrightness,
    };
  }

  /// Get keyboard shortcut descriptions for display
  static const Map<String, String> shortcutDescriptions = {
    'Export': 'Ctrl+E',
    'Reset': 'Ctrl+R',
    'Toggle Brightness': 'Ctrl+D',
  };
}
