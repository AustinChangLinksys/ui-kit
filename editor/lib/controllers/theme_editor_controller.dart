import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../utils/code_generator.dart';

/// Controller for managing theme editor state
/// Extends ChangeNotifier for Provider integration
class ThemeEditorController extends ChangeNotifier {
  // Maintain separate themes for light and dark modes
  late AppDesignTheme _lightTheme;
  late AppDesignTheme _darkTheme;
  late Brightness _brightness;
  bool _hasUnsavedChanges = false;

  /// Constructor initializing with default themes
  ThemeEditorController({AppDesignTheme? initialTheme, Brightness initialBrightness = Brightness.light}) {
    // Initialize both themes
    // If initialTheme is provided, we try to infer the other mode or just reset it
    // For MVP simplicity, we'll initialize defaults for both, then override the current one if provided.
    
    final seedColor = const Color(0xFF0870EA);
    
    _lightTheme = GlassDesignTheme.light(ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ));
    
    _darkTheme = GlassDesignTheme.dark(ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ));

    _brightness = initialBrightness;

    if (initialTheme != null) {
      if (_brightness == Brightness.light) {
        _lightTheme = initialTheme;
      } else {
        _darkTheme = initialTheme;
      }
    }
  }

  // Getters
  AppDesignTheme get currentTheme => _brightness == Brightness.light ? _lightTheme : _darkTheme;
  Brightness get brightness => _brightness;
  bool get hasUnsavedChanges => _hasUnsavedChanges;

  // Helpers to set current theme
  void _setCurrentTheme(AppDesignTheme theme) {
    if (_brightness == Brightness.light) {
      _lightTheme = theme;
    } else {
      _darkTheme = theme;
    }
  }

  /// Update entire theme
  void updateTheme(AppDesignTheme newTheme) {
    _setCurrentTheme(newTheme);
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Surface Base variant
  void updateSurfaceBase(SurfaceStyle style) {
    _setCurrentTheme(currentTheme.copyWith(surfaceBase: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Surface Elevated variant
  void updateSurfaceElevated(SurfaceStyle style) {
    _setCurrentTheme(currentTheme.copyWith(surfaceElevated: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Surface Highlight variant
  void updateSurfaceHighlight(SurfaceStyle style) {
    _setCurrentTheme(currentTheme.copyWith(surfaceHighlight: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Input Style
  void updateInputStyle(InputStyle style) {
    _setCurrentTheme(currentTheme.copyWith(inputStyle: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Global Metrics (Applies to BOTH themes)
  void updateGlobalMetrics({
    double? spacingFactor,
    Duration? animationDuration,
    double? buttonHeight,
  }) {
    // Helper to update a theme
    AppDesignTheme updateSingleTheme(AppDesignTheme theme) {
      final newAnimation = animationDuration != null
          ? AnimationSpec(
              duration: animationDuration,
              curve: theme.animation.curve,
            )
          : null;
          
      return theme.copyWith(
        spacingFactor: spacingFactor,
        animation: newAnimation,
        buttonHeight: buttonHeight,
      );
    }

    // Update both
    _lightTheme = updateSingleTheme(_lightTheme);
    _darkTheme = updateSingleTheme(_darkTheme);
    
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  // ... existing methods ...

  /// Update Skeleton Spec
  void updateSkeletonStyle(dynamic style) {
    _setCurrentTheme(currentTheme.copyWith(skeletonStyle: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Toast Spec
  void updateToastStyle(dynamic style) {
    _setCurrentTheme(currentTheme.copyWith(toastStyle: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Divider Spec
  void updateDividerStyle(dynamic style) {
    _setCurrentTheme(currentTheme.copyWith(dividerStyle: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Toggle brightness between light and dark
  void toggleBrightness() {
    _brightness = _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    // No need to copy properties; each theme maintains its own state.
    // Global metrics are kept in sync by updateGlobalMetrics.
    notifyListeners();
  }

  // Available presets
  static const List<String> availablePresets = [
    'Glass',
    'Flat',
    'Brutal',
    'Neumorphic',
    'Pixel',
  ];

  String _currentPreset = 'Glass';
  String get currentPreset => _currentPreset;

  // ... existing methods ...

  Color _seedColor = const Color(0xFF0870EA);
  Color get seedColor => _seedColor;

  // Color overrides
  Color? _primaryOverride;
  Color? _secondaryOverride;
  Color? _tertiaryOverride;
  Color? _errorOverride;
  Color? _surfaceOverride;
  Color? _outlineOverride;

  // Getters for overrides
  Color? get primaryOverride => _primaryOverride;
  Color? get secondaryOverride => _secondaryOverride;
  Color? get tertiaryOverride => _tertiaryOverride;
  Color? get errorOverride => _errorOverride;
  Color? get surfaceOverride => _surfaceOverride;
  Color? get outlineOverride => _outlineOverride;

  /// Get current computed ColorScheme (Light) for UI display
  ColorScheme get currentLightScheme => createColorScheme(Brightness.light);

  /// Update Seed Color
  void updateSeedColor(Color newSeed) {
    _seedColor = newSeed;
    // Reload preset with new seed (resets structure, keeps existing overrides if we want? 
    // Usually changing seed resets scheme. Let's keep overrides or reset them? 
    // If I customized Primary, then changed Seed, maybe I want to keep my custom Primary.
    // Let's keep overrides.)
    loadPreset(_currentPreset);
  }

  /// Update specific color override and immediately apply without full preset reload
  /// This ensures color changes are reflected in preview while preserving other customizations
  void updateColorOverride({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? error,
    Color? surface,
    Color? outline,
  }) {
    if (primary != null) _primaryOverride = primary;
    if (secondary != null) _secondaryOverride = secondary;
    if (tertiary != null) _tertiaryOverride = tertiary;
    if (error != null) _errorOverride = error;
    if (surface != null) _surfaceOverride = surface;
    if (outline != null) _outlineOverride = outline;

    // Apply color scheme without resetting theme structure
    _applyColorSchemeToCurrentTheme();
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Apply updated color scheme to current theme without resetting theme structure
  /// This preserves all surface styles and other customizations while updating colors
  void _applyColorSchemeToCurrentTheme() {
    final lightScheme = createColorScheme(Brightness.light);
    final darkScheme = createColorScheme(Brightness.dark);

    switch (_currentPreset) {
      case 'Flat':
        _lightTheme = FlatDesignTheme.light(lightScheme);
        _darkTheme = FlatDesignTheme.dark(darkScheme);
        break;
      case 'Brutal':
        _lightTheme = BrutalDesignTheme.light(lightScheme);
        _darkTheme = BrutalDesignTheme.dark(darkScheme);
        break;
      case 'Neumorphic':
        _lightTheme = NeumorphicDesignTheme.light(lightScheme);
        _darkTheme = NeumorphicDesignTheme.dark(darkScheme);
        break;
      case 'Pixel':
        _lightTheme = PixelDesignTheme.light(lightScheme);
        _darkTheme = PixelDesignTheme.dark(darkScheme);
        break;
      case 'Glass':
      default:
        _lightTheme = GlassDesignTheme.light(lightScheme);
        _darkTheme = GlassDesignTheme.dark(darkScheme);
        break;
    }
  }

  /// Create ColorScheme with current overrides
  ColorScheme createColorScheme(Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
      primary: _primaryOverride,
      secondary: _secondaryOverride,
      tertiary: _tertiaryOverride,
      error: _errorOverride,
      surface: _surfaceOverride,
      outline: _outlineOverride,
    );
  }

  /// Load a preset theme
  void loadPreset(String presetName) {
    // Create schemes with overrides
    final lightScheme = createColorScheme(Brightness.light);
    final darkScheme = createColorScheme(Brightness.dark);
    
    switch (presetName) {
      case 'Flat':
        _lightTheme = FlatDesignTheme.light(lightScheme);
        _darkTheme = FlatDesignTheme.dark(darkScheme);
        break;
      case 'Brutal':
        _lightTheme = BrutalDesignTheme.light(lightScheme);
        _darkTheme = BrutalDesignTheme.dark(darkScheme);
        break;
      case 'Neumorphic':
        _lightTheme = NeumorphicDesignTheme.light(lightScheme);
        _darkTheme = NeumorphicDesignTheme.dark(darkScheme);
        break;
      case 'Pixel':
        _lightTheme = PixelDesignTheme.light(lightScheme);
        _darkTheme = PixelDesignTheme.dark(darkScheme);
        break;
      case 'Glass':
      default:
        _lightTheme = GlassDesignTheme.light(lightScheme);
        _darkTheme = GlassDesignTheme.dark(darkScheme);
        break;
    }
    
    _currentPreset = presetName;
    _hasUnsavedChanges = false;
    notifyListeners();
  }

  /// Reset to default theme (reloads current preset)
  void reset() {
    _seedColor = const Color(0xFF0870EA);
    _primaryOverride = null;
    _secondaryOverride = null;
    _tertiaryOverride = null;
    _errorOverride = null;
    _surfaceOverride = null;
    _outlineOverride = null;
    loadPreset(_currentPreset);
  }

  /// Update Loader Spec
  void updateLoaderSpec(LoaderStyle style) {
    _setCurrentTheme(currentTheme.copyWith(loaderStyle: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Toggle Spec
  void updateToggleSpec(dynamic style) {
    _setCurrentTheme(currentTheme.copyWith(toggleStyle: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Navigation Spec
  void updateNavigationSpec(dynamic style) {
    _setCurrentTheme(currentTheme.copyWith(navigationStyle: style));
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Generate Dart code for current theme
  String generateCode() {
    return generateDartCode(currentTheme);
  }
}