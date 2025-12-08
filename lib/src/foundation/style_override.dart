import 'package:flutter/widgets.dart';

import 'theme/design_system/specs/shared/animation_spec.dart';
import 'theme/design_system/specs/shared/overlay_spec.dart';
import 'theme/design_system/specs/shared/state_color_spec.dart';

/// InheritedWidget for providing subtree-level spec overrides.
///
/// Allows local customization of shared specs without modifying
/// the global theme or creating theme variants.
///
/// ## Usage
///
/// Wrap a subtree to override specs for all descendants:
///
/// ```dart
/// StyleOverride(
///   animationSpec: AnimationSpec.fast,
///   child: MyPage(),
/// )
/// ```
///
/// ## Resolution Priority
///
/// Components should resolve specs in this order:
/// 1. Component parameter (e.g., `animationOverride`)
/// 2. StyleOverride ancestor (`StyleOverride.maybeOf(context)`)
/// 3. Theme default (`theme.componentStyle.animation`)
class StyleOverride extends InheritedWidget {
  /// Creates a style override widget.
  ///
  /// At least one override should be provided, otherwise this widget
  /// has no effect.
  const StyleOverride({
    super.key,
    required super.child,
    this.animationSpec,
    this.stateColorSpec,
    this.overlaySpec,
  });

  /// Override for animation timing specs.
  ///
  /// When provided, descendant components can use this instead of
  /// their theme default animation timing.
  final AnimationSpec? animationSpec;

  /// Override for state color specs.
  ///
  /// When provided, descendant components can use this instead of
  /// their theme default state colors.
  final StateColorSpec? stateColorSpec;

  /// Override for overlay specs.
  ///
  /// When provided, descendant components can use this instead of
  /// their theme default overlay configuration.
  final OverlaySpec? overlaySpec;

  /// Get the nearest StyleOverride ancestor, or null if none exists.
  ///
  /// Use this when an override is optional:
  /// ```dart
  /// final override = StyleOverride.maybeOf(context);
  /// final animation = override?.animationSpec ?? theme.defaultAnimation;
  /// ```
  static StyleOverride? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StyleOverride>();
  }

  /// Get the nearest StyleOverride ancestor.
  ///
  /// Throws if no StyleOverride is found in the widget tree.
  /// Use [maybeOf] if the override is optional.
  static StyleOverride of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No StyleOverride found in context');
    return result!;
  }

  /// Resolve a specific spec type from the override chain.
  ///
  /// Returns null if no override exists for that type.
  ///
  /// Example:
  /// ```dart
  /// final animation = StyleOverride.resolveSpec<AnimationSpec>(context);
  /// ```
  static T? resolveSpec<T>(BuildContext context) {
    final override = maybeOf(context);
    if (override == null) return null;

    if (T == AnimationSpec) return override.animationSpec as T?;
    if (T == StateColorSpec) return override.stateColorSpec as T?;
    if (T == OverlaySpec) return override.overlaySpec as T?;

    return null;
  }

  @override
  bool updateShouldNotify(StyleOverride oldWidget) {
    return animationSpec != oldWidget.animationSpec ||
        stateColorSpec != oldWidget.stateColorSpec ||
        overlaySpec != oldWidget.overlaySpec;
  }
}
