import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'page_layout_style.tailor.dart';

/// Theme specification for page layout styling
///
/// This specification defines the visual styling for page layout components
/// including spacing, paddings, borders, and responsive breakpoints.
///
/// Follows UI Kit constitutional compliance by:
/// - Using @TailorMixin for automatic theme extension generation
/// - Providing immutable configuration options
/// - Supporting all 5 visual languages through theme variants
@TailorMixin()
class PageLayoutStyle extends ThemeExtension<PageLayoutStyle> with _$PageLayoutStyleTailorMixin {
  /// Creates a new PageLayoutStyle
  const PageLayoutStyle({
    required this.backgroundColor,
    required this.surfaceColor,
    required this.padding,
    required this.contentPadding,
    required this.safeAreaPadding,
    required this.borderRadius,
    required this.elevation,
    required this.shadowColor,
    required this.maxContentWidth,
    required this.minContentHeight,
    required this.desktopBreakpoint,
    required this.tabletBreakpoint,
  });

  /// Background color for the page
  @override
  final Color backgroundColor;

  /// Surface color for content areas
  @override
  final Color surfaceColor;

  /// Default padding around the page content
  @override
  final EdgeInsets padding;

  /// Padding for the main content area
  @override
  final EdgeInsets contentPadding;

  /// Additional padding for safe area handling
  @override
  final EdgeInsets safeAreaPadding;

  /// Border radius for page surfaces
  @override
  final BorderRadius borderRadius;

  /// Elevation for page surfaces (shadow depth)
  @override
  final double elevation;

  /// Color for drop shadows
  @override
  final Color shadowColor;

  /// Maximum width for content area (responsive layout)
  @override
  final double? maxContentWidth;

  /// Minimum height for content area
  @override
  final double? minContentHeight;

  /// Breakpoint for desktop layout (pixels)
  @override
  final double desktopBreakpoint;

  /// Breakpoint for tablet layout (pixels)
  @override
  final double tabletBreakpoint;

  /// Factory constructor for default page layout style
  factory PageLayoutStyle.defaultStyle({
    required ColorScheme colorScheme,
    double spacing = 16.0,
  }) {
    return PageLayoutStyle(
      backgroundColor: colorScheme.surface,
      surfaceColor: colorScheme.surface,
      padding: EdgeInsets.all(spacing),
      contentPadding: EdgeInsets.symmetric(
        horizontal: spacing,
        vertical: spacing * 0.75,
      ),
      safeAreaPadding: const EdgeInsets.all(8.0),
      borderRadius: BorderRadius.circular(8.0),
      elevation: 0.0,
      shadowColor: colorScheme.shadow,
      maxContentWidth: 1200.0,
      minContentHeight: null,
      desktopBreakpoint: 1024.0,
      tabletBreakpoint: 768.0,
    );
  }

  /// Factory constructor for card-style page layout
  factory PageLayoutStyle.cardStyle({
    required ColorScheme colorScheme,
    double spacing = 16.0,
    double elevation = 2.0,
  }) {
    return PageLayoutStyle(
      backgroundColor: colorScheme.surfaceContainerLowest,
      surfaceColor: colorScheme.surface,
      padding: EdgeInsets.all(spacing),
      contentPadding: EdgeInsets.all(spacing * 1.5),
      safeAreaPadding: const EdgeInsets.all(12.0),
      borderRadius: BorderRadius.circular(16.0),
      elevation: elevation,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.1),
      maxContentWidth: 960.0,
      minContentHeight: 400.0,
      desktopBreakpoint: 1024.0,
      tabletBreakpoint: 768.0,
    );
  }

  /// Factory constructor for full-width page layout
  factory PageLayoutStyle.fullWidth({
    required ColorScheme colorScheme,
    double spacing = 16.0,
  }) {
    return PageLayoutStyle(
      backgroundColor: colorScheme.surface,
      surfaceColor: colorScheme.surface,
      padding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        horizontal: spacing,
        vertical: spacing * 0.5,
      ),
      safeAreaPadding: const EdgeInsets.all(4.0),
      borderRadius: BorderRadius.zero,
      elevation: 0.0,
      shadowColor: colorScheme.shadow,
      maxContentWidth: null,
      minContentHeight: null,
      desktopBreakpoint: 1024.0,
      tabletBreakpoint: 768.0,
    );
  }
}