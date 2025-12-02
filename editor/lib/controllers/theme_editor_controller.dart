import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../utils/code_generator.dart';

/// Controller for managing theme editor state
/// Extends ChangeNotifier for Provider integration
class ThemeEditorController extends ChangeNotifier {
  late AppDesignTheme _currentTheme;
  late Brightness _brightness;
  bool _hasUnsavedChanges = false;

  /// Constructor initializing with default theme
  ThemeEditorController({AppDesignTheme? initialTheme, Brightness initialBrightness = Brightness.light}) {
    _currentTheme = initialTheme ?? GlassDesignTheme.light(ColorScheme.fromSeed(
      seedColor: const Color(0xFF0870EA),
      brightness: Brightness.light,
    ));
    _brightness = initialBrightness;
  }

  // Getters
  AppDesignTheme get currentTheme => _currentTheme;
  Brightness get brightness => _brightness;
  bool get hasUnsavedChanges => _hasUnsavedChanges;

  /// Update entire theme
  void updateTheme(AppDesignTheme newTheme) {
    _currentTheme = newTheme;
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Surface Base variant
  void updateSurfaceBase(SurfaceStyle style) {
    final updated = _currentTheme.copyWith(surfaceBase: style);
    _currentTheme = updated;
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Surface Elevated variant
  void updateSurfaceElevated(SurfaceStyle style) {
    final updated = _currentTheme.copyWith(surfaceElevated: style);
    _currentTheme = updated;
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Surface Highlight variant
  void updateSurfaceHighlight(SurfaceStyle style) {
    final updated = _currentTheme.copyWith(surfaceHighlight: style);
    _currentTheme = updated;
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Input Style
  void updateInputStyle(InputStyle style) {
    final updated = _currentTheme.copyWith(inputStyle: style);
    _currentTheme = updated;
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Global Metrics
  void updateGlobalMetrics({double? spacingFactor, Duration? animationDuration}) {
    if (spacingFactor != null || animationDuration != null) {
      // Build new animation with updated duration, keeping existing curve
      final newAnimation = animationDuration != null
          ? (_currentTheme.animation as dynamic).copyWith(duration: animationDuration)
          : null;

      final updated = _currentTheme.copyWith(
        spacingFactor: spacingFactor,
        animation: newAnimation,
      );
      _currentTheme = updated;
      _hasUnsavedChanges = true;
      notifyListeners();
    }
  }

  /// Toggle brightness between light and dark
  void toggleBrightness() {
    _brightness = _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  /// Reset to default theme
  void reset() {
    _currentTheme = GlassDesignTheme.light(ColorScheme.fromSeed(
      seedColor: const Color(0xFF0870EA),
      brightness: Brightness.light,
    ));
    _brightness = Brightness.light;
    _hasUnsavedChanges = false;
    notifyListeners();
  }

  /// Update Loader Spec
  void updateLoaderSpec(LoaderStyle style) {
    final updated = _currentTheme.copyWith(loaderStyle: style);
    _currentTheme = updated;
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Toggle Spec
  void updateToggleSpec(dynamic style) {
    final updated = _currentTheme.copyWith(toggleStyle: style);
    _currentTheme = updated;
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Update Navigation Spec
  void updateNavigationSpec(dynamic style) {
    final updated = _currentTheme.copyWith(navigationStyle: style);
    _currentTheme = updated;
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  /// Generate Dart code for current theme
  String generateCode() {
    return CodeGenerator.generateDartCode(_currentTheme);
  }
}
