import 'package:flutter/material.dart';
import 'layout_extensions.dart';

/// A responsive layout widget that adapts its child based on screen size.
///
/// This widget provides a clean API for responsive design with automatic
/// fallback behavior. If no tablet layout is provided, it will use the
/// desktop layout for tablet screens.
///
/// Example usage:
/// ```dart
/// AppResponsiveLayout(
///   mobile: MobileWidget(),
///   desktop: DesktopWidget(),
///   // tablet is optional - will use desktop if not provided
/// )
/// ```
class AppResponsiveLayout extends StatelessWidget {
  /// Widget to show on mobile screens (required)
  final Widget mobile;

  /// Widget to show on desktop screens (required)
  final Widget desktop;

  /// Widget to show on tablet screens (optional)
  /// If not provided, will use [desktop] widget for tablet screens
  final Widget? tablet;

  const AppResponsiveLayout({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return context.responsive<Widget>(
      mobile: mobile,
      tablet: tablet ?? desktop, // Use desktop as fallback for tablet
      desktop: desktop,
    );
  }
}