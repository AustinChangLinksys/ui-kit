import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'menu_style.tailor.dart';

/// Theme specification for menu styling
///
/// This specification defines the visual styling for menu components
/// including navigation menus, context menus, and dropdown menus.
///
/// Follows UI Kit constitutional compliance by:
/// - Using @TailorMixin for automatic theme extension generation
/// - Providing immutable configuration options
/// - Supporting all 5 visual languages through theme variants
@TailorMixin()
class AppMenuThemeStyle extends ThemeExtension<AppMenuThemeStyle> with _$AppMenuThemeStyleTailorMixin {
  /// Creates a new AppMenuThemeStyle
  const AppMenuThemeStyle({
    required this.backgroundColor,
    required this.surfaceColor,
    required this.selectedColor,
    required this.hoverColor,
    required this.shadowColor,
    required this.borderColor,
    required this.elevation,
    required this.borderRadius,
    required this.border,
    required this.padding,
    required this.itemPadding,
    required this.itemSpacing,
    required this.itemHeight,
    required this.iconSize,
    required this.titleTextStyle,
    required this.itemTextStyle,
    required this.selectedItemTextStyle,
    required this.maxWidth,
    required this.minWidth,
    required this.dividerColor,
    required this.dividerThickness,
  });

  /// Background color of the menu
  @override
  final Color backgroundColor;

  /// Surface color for menu items
  @override
  final Color surfaceColor;

  /// Color for selected menu items
  @override
  final Color selectedColor;

  /// Color for hovered menu items
  @override
  final Color hoverColor;

  /// Color for drop shadows
  @override
  final Color shadowColor;

  /// Color for borders
  @override
  final Color borderColor;

  /// Elevation (shadow depth) of the menu
  @override
  final double elevation;

  /// Border radius for menu corners
  @override
  final BorderRadius borderRadius;

  /// Border configuration
  @override
  final Border? border;

  /// Padding around menu content
  @override
  final EdgeInsets padding;

  /// Padding for individual menu items
  @override
  final EdgeInsets itemPadding;

  /// Spacing between menu items
  @override
  final double itemSpacing;

  /// Height of menu items
  @override
  final double itemHeight;

  /// Size of menu item icons
  @override
  final double iconSize;

  /// Text style for menu title
  @override
  final TextStyle titleTextStyle;

  /// Text style for menu items
  @override
  final TextStyle itemTextStyle;

  /// Text style for selected menu items
  @override
  final TextStyle selectedItemTextStyle;

  /// Maximum width of the menu
  @override
  final double? maxWidth;

  /// Minimum width of the menu
  @override
  final double? minWidth;

  /// Color for menu dividers
  @override
  final Color dividerColor;

  /// Thickness of menu dividers
  @override
  final double dividerThickness;

  /// Factory constructor for default menu style
  factory AppMenuThemeStyle.defaultStyle({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return AppMenuThemeStyle(
      backgroundColor: colorScheme.surface,
      surfaceColor: colorScheme.surfaceContainer,
      selectedColor: colorScheme.primaryContainer,
      hoverColor: colorScheme.surfaceContainerHigh,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.1),
      borderColor: colorScheme.outline.withValues(alpha: 0.2),
      elevation: 2.0,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: colorScheme.outline.withValues(alpha: 0.2),
        width: 1.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      itemSpacing: 2.0,
      itemHeight: 48.0,
      iconSize: 20.0,
      titleTextStyle: textTheme.titleMedium?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      itemTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14.0,
      ),
      selectedItemTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      ) ?? TextStyle(
        color: colorScheme.onPrimaryContainer,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      maxWidth: 320.0,
      minWidth: 200.0,
      dividerColor: colorScheme.outline.withValues(alpha: 0.2),
      dividerThickness: 1.0,
    );
  }

  /// Factory constructor for compact menu style
  factory AppMenuThemeStyle.compact({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return AppMenuThemeStyle(
      backgroundColor: colorScheme.surface,
      surfaceColor: colorScheme.surfaceContainer,
      selectedColor: colorScheme.primaryContainer,
      hoverColor: colorScheme.surfaceContainerHigh,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.08),
      borderColor: colorScheme.outline.withValues(alpha: 0.15),
      elevation: 1.0,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: colorScheme.outline.withValues(alpha: 0.15),
        width: 0.5,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      itemPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      itemSpacing: 1.0,
      itemHeight: 36.0,
      iconSize: 16.0,
      titleTextStyle: textTheme.titleSmall?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
      itemTextStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurface,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 12.0,
      ),
      selectedItemTextStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      ) ?? TextStyle(
        color: colorScheme.onPrimaryContainer,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
      maxWidth: 240.0,
      minWidth: 160.0,
      dividerColor: colorScheme.outline.withValues(alpha: 0.15),
      dividerThickness: 0.5,
    );
  }

  /// Factory constructor for sidebar menu style
  factory AppMenuThemeStyle.sidebar({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return AppMenuThemeStyle(
      backgroundColor: colorScheme.surfaceContainer,
      surfaceColor: colorScheme.surfaceContainerHigh,
      selectedColor: colorScheme.primaryContainer,
      hoverColor: colorScheme.surfaceContainerHighest,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.05),
      borderColor: colorScheme.outline.withValues(alpha: 0.1),
      elevation: 0.0,
      borderRadius: BorderRadius.zero,
      border: null,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      itemPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      itemSpacing: 4.0,
      itemHeight: 56.0,
      iconSize: 24.0,
      titleTextStyle: textTheme.headlineSmall?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
      itemTextStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16.0,
      ),
      selectedItemTextStyle: textTheme.bodyLarge?.copyWith(
        color: colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w600,
      ) ?? TextStyle(
        color: colorScheme.onPrimaryContainer,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      maxWidth: 280.0,
      minWidth: 240.0,
      dividerColor: colorScheme.outline.withValues(alpha: 0.1),
      dividerThickness: 1.0,
    );
  }

  /// Factory constructor for dropdown menu style
  factory AppMenuThemeStyle.dropdown({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return AppMenuThemeStyle(
      backgroundColor: colorScheme.surface,
      surfaceColor: colorScheme.surfaceContainer,
      selectedColor: colorScheme.secondaryContainer,
      hoverColor: colorScheme.surfaceContainerHigh,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.15),
      borderColor: colorScheme.outline.withValues(alpha: 0.3),
      elevation: 4.0,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: colorScheme.outline.withValues(alpha: 0.3),
        width: 1.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      itemPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      itemSpacing: 0.0,
      itemHeight: 40.0,
      iconSize: 18.0,
      titleTextStyle: textTheme.titleSmall?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      itemTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ) ?? TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14.0,
      ),
      selectedItemTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSecondaryContainer,
        fontWeight: FontWeight.w500,
      ) ?? TextStyle(
        color: colorScheme.onSecondaryContainer,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      maxWidth: 200.0,
      minWidth: 120.0,
      dividerColor: colorScheme.outline.withValues(alpha: 0.2),
      dividerThickness: 0.5,
    );
  }
}