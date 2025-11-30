import 'package:equatable/equatable.dart';

/// Defines layout-related responsive rules (integrated version)
class LayoutSpec extends Equatable {
  // 1. Breakpoint definition (Breakpoints) - Allows different Themes to fine-tune breakpoints
  final double breakpointMobile; // default: 600
  final double breakpointTablet; // default: 900
  final double breakpointDesktop; // default: 1200

  // 2. Responsive Gutter
  final double gutterMobile;
  final double gutterTablet;
  final double gutterDesktop;

  // 3. Responsive Margin (Page Margin)
  final double marginMobile;
  final double marginTablet;
  final double marginDesktop;

  // 4. Maximum number of columns (Grid System)
  final int maxColumns;

  const LayoutSpec({
    // Default breakpoints (Material standard)
    this.breakpointMobile = 600.0,
    this.breakpointTablet = 900.0,
    this.breakpointDesktop = 1200.0,

    // Default Gutter
    this.gutterMobile = 16.0,
    this.gutterTablet = 24.0,
    this.gutterDesktop = 24.0,

    // Default Margin
    this.marginMobile = 16.0,
    this.marginTablet = 32.0,
    this.marginDesktop = 64.0, // Desktop version usually has more whitespace

    this.maxColumns = 12,
  });

  // --- Core logic: responsive parser ---

  /// Get current Gutter based on screen width
  double gutter(double width) {
    if (width >= breakpointDesktop) return gutterDesktop;
    if (width >= breakpointTablet) return gutterTablet;
    return gutterMobile;
  }

  /// Get current Page Margin based on screen width
  double margin(double width) {
    if (width >= breakpointDesktop) return marginDesktop;
    if (width >= breakpointTablet) return marginTablet;
    return marginMobile;
  }

  /// Determine if current size is mobile
  bool isMobile(double width) => width < breakpointTablet;

  @override
  List<Object?> get props => [
        breakpointMobile,
        breakpointTablet,
        breakpointDesktop,
        gutterMobile,
        gutterTablet,
        gutterDesktop,
        marginMobile,
        marginTablet,
        marginDesktop,
        maxColumns,
      ];
}
