import 'package:flutter/material.dart';

class AppThemeConfig {
  final Brightness brightness;
  final Color? seedColor;

  // --- 1. Material Overrides (High Priority) ---
  final Color? primary;
  final Color? secondary;
  final Color? tertiary;
  final Color? surface;
  final Color? error;

  // --- 2. Style Overrides (High Priority) ---
  final Color? customSemanticSuccess;
  final Color? customSemanticWarning;
  final Color? customSemanticDanger;
  final Color? customOverlayColor;
  final Color? customGlowColor;
  final Color? customHighContrastBorder;

  // Add other style overrides as needed per spec if they become requirements
  // For now, keeping to the core ones defined in plan/spec

  const AppThemeConfig({
    this.brightness = Brightness.light,
    this.seedColor,
    this.primary,
    this.secondary,
    this.tertiary,
    this.surface,
    this.error,
    this.customSemanticSuccess,
    this.customSemanticWarning,
    this.customSemanticDanger,
    this.customOverlayColor,
    this.customGlowColor,
    this.customHighContrastBorder,
  });

  factory AppThemeConfig.fromJson(Map<String, dynamic> json) {
    Color? parseColor(dynamic value) {
      if (value is int) return Color(value);
      if (value is String) {
        try {
          final hex = value.replaceAll('#', '');
          if (hex.length == 6) {
            return Color(int.parse('FF$hex', radix: 16));
          } else if (hex.length == 8) {
            return Color(int.parse(hex, radix: 16));
          }
        } catch (_) {}
      }
      return null;
    }

    return AppThemeConfig(
      brightness:
          json['brightness'] == 'dark' ? Brightness.dark : Brightness.light,
      seedColor: parseColor(json['seedColor']),
      primary: parseColor(json['primary']),
      secondary: parseColor(json['secondary']),
      tertiary: parseColor(json['tertiary']),
      surface: parseColor(json['surface']),
      error: parseColor(json['error']),
      customSemanticSuccess: parseColor(json['customSemanticSuccess']),
      customSemanticWarning: parseColor(json['customSemanticWarning']),
      customSemanticDanger: parseColor(json['customSemanticDanger']),
      customOverlayColor: parseColor(json['customOverlayColor']),
      customGlowColor: parseColor(json['customGlowColor']),
      customHighContrastBorder: parseColor(json['customHighContrastBorder']),
    );
  }
}
