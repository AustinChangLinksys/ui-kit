import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/surface_style.dart'; // Import SurfaceStyle
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme_utils.dart'; // Import for resolveContentColor

extension SurfaceStyleUtils on AppDesignTheme {
  /// Resolves the correct [SurfaceStyle] based on a [SurfaceVariant].
  ///
  /// This is typically used by internal components that need to map a high-level
  /// variant to a concrete style definition from the theme.
  SurfaceStyle resolveSurfaceStyle(SurfaceVariant variant) {
    return switch (variant) {
      SurfaceVariant.base => surfaceBase,
      SurfaceVariant.elevated => surfaceElevated,
      SurfaceVariant.highlight => surfaceHighlight,
    };
  }
}
