import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';

extension AppDesignThemeUtils on AppDesignTheme {
  /// Resolves the content color for a given [SurfaceVariant].
  ///
  /// This mimics the logic used internally by [AppSurface] to determine
  /// which style variant is active.
  Color resolveContentColor(SurfaceVariant variant) {
    return switch (variant) {
      SurfaceVariant.base => surfaceBase.contentColor,
      SurfaceVariant.elevated => surfaceElevated.contentColor,
      SurfaceVariant.highlight => surfaceHighlight.contentColor,
    };
  }
}
