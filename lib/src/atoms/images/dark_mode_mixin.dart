import 'package:flutter/material.dart';
import 'dark_mode_strategy.dart';

/// Mixin providing shared dark mode adaptation logic for image components.
///
/// Used by [AppImage] and [AppSvg] to apply consistent dark mode handling.
mixin DarkModeAdaptation {
  /// Whether dark mode filter should be applied.
  ///
  /// Returns `true` when:
  /// - Current theme is dark mode
  /// - No dark variant is provided (hasVariant is false)
  /// - Strategy is not [DarkModeStrategy.none] OR custom filter is provided
  bool shouldApplyDarkFilter({
    required BuildContext context,
    required bool hasVariant,
    required DarkModeStrategy strategy,
    required ColorFilter? customFilter,
  }) {
    if (hasVariant) return false;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!isDark) return false;

    return strategy != DarkModeStrategy.none || customFilter != null;
  }

  /// Wraps the [child] widget with [ColorFiltered] if dark mode filter should be applied.
  ///
  /// Priority:
  /// 1. [customFilter] if provided
  /// 2. Filter from [strategy]
  /// 3. Returns [child] unchanged if no filter needed
  Widget applyDarkModeFilter({
    required BuildContext context,
    required Widget child,
    required bool hasVariant,
    required DarkModeStrategy strategy,
    required ColorFilter? customFilter,
  }) {
    if (!shouldApplyDarkFilter(
      context: context,
      hasVariant: hasVariant,
      strategy: strategy,
      customFilter: customFilter,
    )) {
      return child;
    }

    final filter = customFilter ?? getColorFilterForStrategy(strategy);
    if (filter == null) return child;

    return ColorFiltered(
      colorFilter: filter,
      child: child,
    );
  }

  /// Check if currently in dark mode.
  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
