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
  final Color? customSignalStrong;
  final Color? customSignalWeak;
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
    this.customSignalStrong,
    this.customSignalWeak,
    this.customOverlayColor,
    this.customGlowColor,
    this.customHighContrastBorder,
  });
}
