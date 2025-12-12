import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_bar_style.tailor.dart';

/// Theme specification for app bar styling
///
/// This specification defines the visual styling for app bar components
/// including colors, typography, spacing, and visual effects.
///
/// Follows UI Kit constitutional compliance by:
/// - Using @TailorMixin for automatic theme extension generation
/// - Providing immutable configuration options
/// - Supporting all 5 visual languages through theme variants
@TailorMixin()
class AppBarStyle extends ThemeExtension<AppBarStyle> with _$AppBarStyleTailorMixin {
  /// Creates a new AppBarStyle
  const AppBarStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.surfaceColor,
    required this.shadowColor,
    required this.elevation,
    required this.height,
    required this.titleTextStyle,
    required this.actionIconSize,
    required this.leadingIconSize,
    required this.contentPadding,
    required this.actionSpacing,
    required this.borderRadius,
    required this.border,
    required this.centerTitle,
    required this.titleSpacing,
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.flexibleSpaceBlur,
    required this.containerStyle,
    required this.dividerStyle,
  });

  /// Background color of the app bar
  @override
  final Color backgroundColor;

  /// Foreground color for text and icons
  @override
  final Color foregroundColor;

  /// Surface color for elevated elements
  @override
  final Color surfaceColor;

  /// Color for drop shadows
  @override
  final Color shadowColor;

  /// Elevation (shadow depth) of the app bar
  @override
  final double elevation;

  /// Height of the app bar
  @override
  final double height;

  /// Text style for the title
  @override
  final TextStyle titleTextStyle;

  /// Size of action icons
  @override
  final double actionIconSize;

  /// Size of leading icon (back button, menu, etc.)
  @override
  final double leadingIconSize;

  /// Padding around app bar content
  @override
  final EdgeInsets contentPadding;

  /// Spacing between action items
  @override
  final double actionSpacing;

  /// Border radius for app bar corners
  @override
  final BorderRadius borderRadius;

  /// Border configuration
  @override
  final Border? border;

  /// Whether to center the title
  @override
  final bool centerTitle;

  /// Spacing around the title
  @override
  final double titleSpacing;

  /// Height of the app bar when collapsed (for sliver app bars)
  @override
  final double collapsedHeight;

  /// Height of the app bar when expanded (for sliver app bars)
  @override
  final double expandedHeight;

  /// Blur radius for flexible space background
  @override
  final double flexibleSpaceBlur;

  /// Style configuration for the app bar container
  @override
  final BoxDecoration containerStyle;

  /// Style configuration for divider elements
  @override
  final BoxDecoration? dividerStyle;

  /// Factory constructor for default app bar style
  factory AppBarStyle.defaultStyle({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return AppBarStyle(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceColor: colorScheme.surfaceContainerHigh,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.1),
      elevation: 0.0,
      height: 56.0,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      actionIconSize: 24.0,
      leadingIconSize: 24.0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      actionSpacing: 8.0,
      borderRadius: BorderRadius.zero,
      border: null,
      centerTitle: false,
      titleSpacing: 16.0,
      collapsedHeight: 56.0,
      expandedHeight: 120.0,
      flexibleSpaceBlur: 0.0,
      containerStyle: BoxDecoration(
        color: colorScheme.surface,
      ),
      dividerStyle: null,
    );
  }

  /// Factory constructor for elevated app bar style
  factory AppBarStyle.elevated({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    double elevation = 4.0,
  }) {
    return AppBarStyle(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceColor: colorScheme.surfaceContainerHigh,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.2),
      elevation: elevation,
      height: 56.0,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      actionIconSize: 24.0,
      leadingIconSize: 24.0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      actionSpacing: 8.0,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(8.0),
      ),
      border: Border(
        bottom: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      centerTitle: false,
      titleSpacing: 16.0,
      collapsedHeight: 56.0,
      expandedHeight: 120.0,
      flexibleSpaceBlur: 2.0,
      containerStyle: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.2),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation),
          ),
        ],
      ),
      dividerStyle: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1.0,
          ),
        ),
      ),
    );
  }

  /// Factory constructor for compact app bar style
  factory AppBarStyle.compact({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return AppBarStyle(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceColor: colorScheme.surfaceContainer,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.05),
      elevation: 0.0,
      height: 48.0,
      titleTextStyle: textTheme.titleMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      actionIconSize: 20.0,
      leadingIconSize: 20.0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      actionSpacing: 6.0,
      borderRadius: BorderRadius.zero,
      border: null,
      centerTitle: false,
      titleSpacing: 12.0,
      collapsedHeight: 48.0,
      expandedHeight: 96.0,
      flexibleSpaceBlur: 0.0,
      containerStyle: BoxDecoration(
        color: colorScheme.surface,
      ),
      dividerStyle: null,
    );
  }

  /// Factory constructor for prominent app bar style
  factory AppBarStyle.prominent({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return AppBarStyle(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      surfaceColor: colorScheme.primaryContainer,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.15),
      elevation: 2.0,
      height: 64.0,
      titleTextStyle: textTheme.headlineSmall?.copyWith(
        color: colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ) ?? TextStyle(
        color: colorScheme.onPrimaryContainer,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
      ),
      actionIconSize: 28.0,
      leadingIconSize: 28.0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      actionSpacing: 12.0,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(12.0),
      ),
      border: null,
      centerTitle: true,
      titleSpacing: 20.0,
      collapsedHeight: 64.0,
      expandedHeight: 160.0,
      flexibleSpaceBlur: 4.0,
      containerStyle: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.15),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      dividerStyle: null,
    );
  }
}