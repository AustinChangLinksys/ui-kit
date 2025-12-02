// test/test_utils/test_theme_matrix.dart

import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Defines the standard matrix of 8 Design Styles for Golden Tests.
/// (4 Design Languages * 2 Brightness Modes)
final Map<String, ThemeData> kTestThemeMatrix = {
  // 1. Glass
  'Glass_Light': AppTheme.create(
    brightness: Brightness.light,
    designThemeBuilder: (s) => GlassDesignTheme.light(s),
  ),
  'Glass_Dark': AppTheme.create(
    brightness: Brightness.dark,
    designThemeBuilder: (s) => GlassDesignTheme.dark(s),
  ),

  // 2. Brutal
  'Brutal_Light': AppTheme.create(
    brightness: Brightness.light,
    designThemeBuilder: (s) => BrutalDesignTheme.light(s),
  ),
  'Brutal_Dark': AppTheme.create(
    brightness: Brightness.dark,
    designThemeBuilder: (s) => BrutalDesignTheme.dark(s),
  ),

  // 3. Flat
  'Flat_Light': AppTheme.create(
    brightness: Brightness.light,
    designThemeBuilder: (s) => FlatDesignTheme.light(s),
  ),
  'Flat_Dark': AppTheme.create(
    brightness: Brightness.dark,
    designThemeBuilder: (s) => FlatDesignTheme.dark(s),
  ),

  // 4. Neumorphic
  'Neumorphic_Light': AppTheme.create(
    brightness: Brightness.light,
    designThemeBuilder: (s) => NeumorphicDesignTheme.light(s),
  ),
  'Neumorphic_Dark': AppTheme.create(
    brightness: Brightness.dark,
    designThemeBuilder: (s) => NeumorphicDesignTheme.dark(s),
  ),

  // 5. Pixel
  'Pixel_Light': AppTheme.create(
    brightness: Brightness.light,
    designThemeBuilder: (s) => PixelDesignTheme.light(s),
  ),
  'Pixel_Dark': AppTheme.create(
    brightness: Brightness.dark,
    designThemeBuilder: (s) => PixelDesignTheme.dark(s),
  ),
};