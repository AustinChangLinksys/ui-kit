import 'package:ui_kit_library/ui_kit.dart';

/// Unified entry point for creating themes from configuration.
///
/// Supports all built-in styles with full customization via [AppThemeConfig].
/// This provides a single entry point for remote/dynamic theme configuration.
///
/// Example:
/// ```dart
/// // From style name and config
/// final theme = CustomDesignTheme.fromConfig(
///   style: 'glass',
///   config: AppThemeConfig(seedColor: Colors.blue),
/// );
///
/// // From complete JSON (includes style)
/// final theme = CustomDesignTheme.fromJson({
///   'style': 'glass',
///   'brightness': 'dark',
///   'seedColor': '#2196F3',
/// });
/// ```
class CustomDesignTheme {
  CustomDesignTheme._();

  /// Available style names for [fromConfig] and [fromJson].
  static const List<String> availableStyles = [
    'glass',
    'flat',
    'brutal',
    'neumorphic',
    'pixel',
  ];

  /// Create a theme from style name and configuration.
  ///
  /// [style] - One of: 'glass', 'flat', 'brutal', 'neumorphic', 'pixel'
  /// [config] - Theme configuration (can be from JSON via [AppThemeConfig.fromJson])
  ///
  /// Returns [FlatDesignTheme] as default if style is not recognized.
  static AppDesignTheme fromConfig({
    required String style,
    required AppThemeConfig config,
  }) {
    return switch (style.toLowerCase()) {
      'glass' => GlassDesignTheme.fromConfig(config),
      'flat' => FlatDesignTheme.fromConfig(config),
      'brutal' => BrutalDesignTheme.fromConfig(config),
      'neumorphic' => NeumorphicDesignTheme.fromConfig(config),
      'pixel' => PixelDesignTheme.fromConfig(config),
      _ => FlatDesignTheme.fromConfig(config),
    };
  }

  /// Create a theme from JSON map.
  ///
  /// Expected JSON structure:
  /// ```json
  /// {
  ///   "style": "glass",
  ///   "brightness": "light",
  ///   "seedColor": "#6750A4",
  ///   "primary": "#2196F3",
  ///   "secondary": "#FF9800",
  ///   "customSignalStrong": "#4CAF50",
  ///   ...
  /// }
  /// ```
  ///
  /// The [style] field determines which design theme to use.
  /// All other fields are passed to [AppThemeConfig.fromJson].
  ///
  /// Returns [FlatDesignTheme] as default if style is missing or not recognized.
  static AppDesignTheme fromJson(Map<String, dynamic> json) {
    final style = json['style'] as String? ?? 'flat';
    final config = AppThemeConfig.fromJson(json);
    return fromConfig(style: style, config: config);
  }
}
