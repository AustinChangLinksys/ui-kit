import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'shared/shared_specs.dart';

part 'navigation_style.tailor.dart';

/// Style specification for navigation components (AppNavigationBar, AppNavigationRail).
///
/// Composes [AnimationSpec] for transition timing and [StateColorSpec] for
/// selected/unselected item colors.
///
/// Example:
/// ```dart
/// NavigationStyle(
///   height: 80.0,
///   isFloating: true,
///   animation: AnimationSpec.standard,
///   itemColors: StateColorSpec(
///     active: Colors.blue,
///     inactive: Colors.grey,
///   ),
/// )
/// ```
@TailorMixin()
class NavigationStyle extends ThemeExtension<NavigationStyle>
    with _$NavigationStyleTailorMixin {
  const NavigationStyle({
    required this.height,
    required this.isFloating,
    required this.floatingMargin,
    required this.itemSpacing,
    required this.animation,
    required this.itemColors,
  });

  /// Height of the navigation bar
  @override
  final double height;

  /// Whether the navigation bar floats above content (Glass style)
  @override
  final bool isFloating;

  /// Margin around floating navigation bar
  @override
  final double floatingMargin;

  /// Spacing between navigation items
  @override
  final double itemSpacing;

  /// Animation timing for navigation transitions
  @override
  final AnimationSpec animation;

  /// Colors for navigation items (selected/unselected states)
  @override
  final StateColorSpec itemColors;

  // --- Backward Compatibility Getters ---

  /// @deprecated Use [animation.duration] instead
  @override
  Duration get animationDuration => animation.duration;

  /// @deprecated Use [animation.curve] instead
  @override
  Curve get animationCurve => animation.curve;

  /// @deprecated Use [itemColors.active] instead
  @override
  Color get selectedColor => itemColors.active;

  /// @deprecated Use [itemColors.inactive] instead
  @override
  Color get unselectedColor => itemColors.inactive;
}
