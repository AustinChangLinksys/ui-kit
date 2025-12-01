import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

/// The global configuration entry point for the Unified Design System.
///
/// Use the [init] method to initialize all necessary Overlay and Theme dependencies.
class DesignSystem {
  // Private constructor to prevent instantiation
  DesignSystem._();

  /// Initializes the global configuration for the Design System.
  ///
  /// Mount this method to [MaterialApp.builder] or [WidgetsApp.builder].
  /// It automatically injects [Portal] and any other future global widgets 
  /// (such as ScreenUtil, ToastOverlay, etc.) required by the system.
  ///
  /// Example:
  /// ```dart
  /// MaterialApp(
  ///   builder: DesignSystem.init,
  ///   home: HomePage(),
  /// );
  /// ```
  static Widget init(BuildContext context, Widget? child) {
    // Provide a fallback widget if child is null (rare, but prevents crashes)
    final widget = child ?? const SizedBox.shrink();

    // Wrap with necessary global providers/overlays
    return Portal(
      child: widget,
    );
  }
}