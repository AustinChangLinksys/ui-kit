import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

import 'effects/global_effects_overlay.dart';

/// The global configuration entry point for the Unified Design System.
///
/// Use the [init] method to initialize all necessary Overlay and Theme dependencies.
class DesignSystem {
  // Private constructor to prevent instantiation
  DesignSystem._();

  /// Initializes the global configuration for the Design System.
  ///
  /// Mount this method to [MaterialApp.builder] or [WidgetsApp.builder].
  /// It automatically injects:
  /// - [Portal] for overlay management (tooltips, menus, etc.)
  /// - [GlobalEffectsOverlay] for theme-specific visual effects (noise, CRT, etc.)
  ///
  /// Example:
  /// ```dart
  /// MaterialApp(
  ///   builder: DesignSystem.init,
  ///   theme: ThemeData(
  ///     extensions: [GlassDesignTheme.light()],
  ///   ),
  ///   home: HomePage(),
  /// );
  /// ```
  ///
  /// The visual effects are automatically determined by the current theme's
  /// [GlobalEffectsType] setting. For example:
  /// - Glass theme: Film grain noise overlay
  /// - Pixel theme: CRT monitor effect
  /// - Other themes: No overlay effect
  static Widget init(BuildContext context, Widget? child) {
    final widget = child ?? const SizedBox.shrink();

    return Portal(
      child: GlobalEffectsOverlay(
        child: widget,
      ),
    );
  }

  /// Initializes the Design System with a custom noise seed.
  ///
  /// Use this variant when you need consistent noise patterns across
  /// app restarts or for testing purposes.
  ///
  /// Example:
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => DesignSystem.initWithSeed(
  ///     context,
  ///     child,
  ///     noiseSeed: 12345,
  ///   ),
  ///   home: HomePage(),
  /// );
  /// ```
  static Widget initWithSeed(
    BuildContext context,
    Widget? child, {
    required int noiseSeed,
  }) {
    final widget = child ?? const SizedBox.shrink();

    return Portal(
      child: GlobalEffectsOverlay(
        noiseSeed: noiseSeed,
        child: widget,
      ),
    );
  }
}
