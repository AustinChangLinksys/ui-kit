import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'bottom_bar_style.tailor.dart';

/// Theme specification for bottom bar styling
///
/// This specification defines the visual styling for bottom action bar components
/// including colors, button styles, spacing, and visual effects.
///
/// Follows UI Kit constitutional compliance by:
/// - Using @TailorMixin for automatic theme extension generation
/// - Providing immutable configuration options
/// - Supporting all 5 visual languages through theme variants
@TailorMixin()
class BottomBarStyle extends ThemeExtension<BottomBarStyle> with _$BottomBarStyleTailorMixin {
  /// Creates a new BottomBarStyle
  const BottomBarStyle({
    required this.backgroundColor,
    required this.surfaceColor,
    required this.shadowColor,
    required this.borderColor,
    required this.elevation,
    required this.height,
    required this.padding,
    required this.buttonSpacing,
    required this.borderRadius,
    required this.border,
    required this.buttonHeight,
    required this.buttonMinWidth,
    required this.primaryButtonStyle,
    required this.secondaryButtonStyle,
    required this.destructiveButtonStyle,
    required this.disabledButtonStyle,
  });

  /// Background color of the bottom bar
  @override
  final Color backgroundColor;

  /// Surface color for elevated elements
  @override
  final Color surfaceColor;

  /// Color for drop shadows
  @override
  final Color shadowColor;

  /// Color for borders
  @override
  final Color borderColor;

  /// Elevation (shadow depth) of the bottom bar
  @override
  final double elevation;

  /// Height of the bottom bar
  @override
  final double height;

  /// Padding around bottom bar content
  @override
  final EdgeInsets padding;

  /// Spacing between buttons
  @override
  final double buttonSpacing;

  /// Border radius for bottom bar corners
  @override
  final BorderRadius borderRadius;

  /// Border configuration
  @override
  final Border? border;

  /// Height of buttons in the bottom bar
  @override
  final double buttonHeight;

  /// Minimum width for buttons
  @override
  final double buttonMinWidth;

  /// Style for primary action buttons
  @override
  final ButtonStyle primaryButtonStyle;

  /// Style for secondary action buttons
  @override
  final ButtonStyle secondaryButtonStyle;

  /// Style for destructive action buttons
  @override
  final ButtonStyle destructiveButtonStyle;

  /// Style for disabled buttons
  @override
  final ButtonStyle disabledButtonStyle;

  /// Factory constructor for default bottom bar style
  factory BottomBarStyle.defaultStyle({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return BottomBarStyle(
      backgroundColor: colorScheme.surface,
      surfaceColor: colorScheme.surfaceContainer,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.1),
      borderColor: colorScheme.outline.withValues(alpha: 0.2),
      elevation: 2.0,
      height: 72.0,
      padding: const EdgeInsets.all(16.0),
      buttonSpacing: 12.0,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(8.0),
      ),
      border: Border(
        top: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      buttonHeight: 40.0,
      buttonMinWidth: 100.0,
      primaryButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      secondaryButtonStyle: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      destructiveButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onError,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      disabledButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
        foregroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  /// Factory constructor for floating bottom bar style
  factory BottomBarStyle.floating({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return BottomBarStyle(
      backgroundColor: colorScheme.surfaceContainer,
      surfaceColor: colorScheme.surfaceContainerHigh,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.15),
      borderColor: colorScheme.outline.withValues(alpha: 0.1),
      elevation: 6.0,
      height: 68.0,
      padding: const EdgeInsets.all(12.0),
      buttonSpacing: 8.0,
      borderRadius: BorderRadius.circular(16.0),
      border: null,
      buttonHeight: 44.0,
      buttonMinWidth: 120.0,
      primaryButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      secondaryButtonStyle: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      destructiveButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.errorContainer,
        foregroundColor: colorScheme.onErrorContainer,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      disabledButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onSurface.withValues(alpha: 0.08),
        foregroundColor: colorScheme.onSurface.withValues(alpha: 0.32),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  /// Factory constructor for compact bottom bar style
  factory BottomBarStyle.compact({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return BottomBarStyle(
      backgroundColor: colorScheme.surface,
      surfaceColor: colorScheme.surfaceContainer,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.05),
      borderColor: colorScheme.outline.withValues(alpha: 0.15),
      elevation: 1.0,
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      buttonSpacing: 8.0,
      borderRadius: BorderRadius.zero,
      border: Border(
        top: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      buttonHeight: 36.0,
      buttonMinWidth: 80.0,
      primaryButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      secondaryButtonStyle: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      destructiveButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onError,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      disabledButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onSurface.withValues(alpha: 0.10),
        foregroundColor: colorScheme.onSurface.withValues(alpha: 0.36),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }

  /// Factory constructor for prominent bottom bar style
  factory BottomBarStyle.prominent({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return BottomBarStyle(
      backgroundColor: colorScheme.primaryContainer,
      surfaceColor: colorScheme.primaryContainer,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.2),
      borderColor: colorScheme.outline.withValues(alpha: 0.3),
      elevation: 4.0,
      height: 80.0,
      padding: const EdgeInsets.all(20.0),
      buttonSpacing: 16.0,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16.0),
      ),
      border: null,
      buttonHeight: 48.0,
      buttonMinWidth: 140.0,
      primaryButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      secondaryButtonStyle: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.onPrimaryContainer,
        side: BorderSide(color: colorScheme.onPrimaryContainer.withValues(alpha: 0.5)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      destructiveButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.error,
        foregroundColor: colorScheme.onError,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      disabledButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onPrimaryContainer.withValues(alpha: 0.12),
        foregroundColor: colorScheme.onPrimaryContainer.withValues(alpha: 0.38),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}