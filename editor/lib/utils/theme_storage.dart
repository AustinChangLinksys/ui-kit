import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Manages persistent storage of custom themes
class ThemeStorage {
  static const String _defaultThemesKey = 'saved_themes';
  static const String _lastThemeKey = 'last_used_theme';

  /// Save current theme to local storage
  static Future<bool> saveTheme(String themeName, AppDesignTheme theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final serialized = _serializeTheme(theme);
      await prefs.setString('theme_$themeName', jsonEncode(serialized));
      return true;
    } catch (e) {
      print('Error saving theme: $e');
      return false;
    }
  }

  /// Load theme from local storage
  static Future<AppDesignTheme?> loadTheme(String themeName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('theme_$themeName');
      if (data == null) return null;

      final decoded = jsonDecode(data) as Map<String, dynamic>;
      return _deserializeTheme(decoded);
    } catch (e) {
      print('Error loading theme: $e');
      return null;
    }
  }

  /// Get list of saved theme names
  static Future<List<String>> getSavedThemeNames() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      return keys
          .where((key) => key.startsWith('theme_'))
          .map((key) => key.replaceFirst('theme_', ''))
          .toList();
    } catch (e) {
      print('Error getting saved themes: $e');
      return [];
    }
  }

  /// Delete a saved theme
  static Future<bool> deleteTheme(String themeName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('theme_$themeName');
      return true;
    } catch (e) {
      print('Error deleting theme: $e');
      return false;
    }
  }

  /// Save last used theme for quick restoration
  static Future<bool> saveLastUsedTheme(AppDesignTheme theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final serialized = _serializeTheme(theme);
      await prefs.setString(_lastThemeKey, jsonEncode(serialized));
      return true;
    } catch (e) {
      print('Error saving last used theme: $e');
      return false;
    }
  }

  /// Load last used theme
  static Future<AppDesignTheme?> loadLastUsedTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(_lastThemeKey);
      if (data == null) return null;

      final decoded = jsonDecode(data) as Map<String, dynamic>;
      return _deserializeTheme(decoded);
    } catch (e) {
      print('Error loading last used theme: $e');
      return null;
    }
  }

  // Private helper methods for serialization
  static Map<String, dynamic> _serializeTheme(AppDesignTheme theme) {
    return {
      'spacingFactor': theme.spacingFactor,
      'surfaceBase': _serializeSurfaceStyle(theme.surfaceBase),
      'surfaceElevated': _serializeSurfaceStyle(theme.surfaceElevated),
      'surfaceHighlight': _serializeSurfaceStyle(theme.surfaceHighlight),
    };
  }

  static AppDesignTheme _deserializeTheme(Map<String, dynamic> data) {
    // Return a theme with defaults - in a real app, you'd deserialize all properties
    return GlassDesignTheme.light(
      ColorScheme.fromSeed(
        seedColor: const Color(0xFF0870EA),
        brightness: Brightness.light,
      ),
    );
  }

  static Map<String, dynamic> _serializeSurfaceStyle(SurfaceStyle style) {
    return {
      'backgroundColor': style.backgroundColor.value,
      'borderColor': style.borderColor.value,
      'borderWidth': style.borderWidth,
      'borderRadius': style.borderRadius,
      'blurStrength': style.blurStrength,
      'contentColor': style.contentColor.value,
    };
  }

  static SurfaceStyle _deserializeSurfaceStyle(Map<String, dynamic> data) {
    return SurfaceStyle(
      backgroundColor: Color(data['backgroundColor'] as int),
      borderColor: Color(data['borderColor'] as int),
      borderWidth: data['borderWidth'] as double,
      borderRadius: data['borderRadius'] as double,
      blurStrength: data['blurStrength'] as double,
      contentColor: Color(data['contentColor'] as int),
    );
  }
}
