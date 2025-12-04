import 'package:equatable/equatable.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/divider_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/surface_style.dart';

/// Defines visual properties for AppBar and SliverAppBar components.
class AppBarStyle extends Equatable {
  /// Background, border, shadow for main AppBar container.
  final SurfaceStyle containerStyle;

  /// Style for bottom area (TabBar container).
  final SurfaceStyle? bottomContainerStyle;

  /// Bottom divider (hairline for Flat, thick for Pixel).
  final DividerStyle dividerStyle;

  /// Standard AppBar height.
  final double height;

  /// Minimum height when SliverAppBar collapsed.
  final double collapsedHeight;

  /// Maximum height when SliverAppBar expanded.
  final double expandedHeight;

  /// Blur sigma for Glass mode flexibleSpace overlay (0 for non-Glass).
  final double flexibleSpaceBlur;

  const AppBarStyle({
    required this.containerStyle,
    this.bottomContainerStyle,
    required this.dividerStyle,
    this.height = 56.0,
    this.collapsedHeight = 56.0,
    this.expandedHeight = 200.0,
    this.flexibleSpaceBlur = 0.0,
  });

  AppBarStyle copyWith({
    SurfaceStyle? containerStyle,
    SurfaceStyle? bottomContainerStyle,
    DividerStyle? dividerStyle,
    double? height,
    double? collapsedHeight,
    double? expandedHeight,
    double? flexibleSpaceBlur,
  }) {
    return AppBarStyle(
      containerStyle: containerStyle ?? this.containerStyle,
      bottomContainerStyle: bottomContainerStyle ?? this.bottomContainerStyle,
      dividerStyle: dividerStyle ?? this.dividerStyle,
      height: height ?? this.height,
      collapsedHeight: collapsedHeight ?? this.collapsedHeight,
      expandedHeight: expandedHeight ?? this.expandedHeight,
      flexibleSpaceBlur: flexibleSpaceBlur ?? this.flexibleSpaceBlur,
    );
  }

  static AppBarStyle lerp(AppBarStyle a, AppBarStyle b, double t) {
    return AppBarStyle(
      containerStyle: a.containerStyle,
      bottomContainerStyle: a.bottomContainerStyle,
      dividerStyle: a.dividerStyle,
      height: lerpDouble(a.height, b.height, t) ?? a.height,
      collapsedHeight:
          lerpDouble(a.collapsedHeight, b.collapsedHeight, t) ?? a.collapsedHeight,
      expandedHeight:
          lerpDouble(a.expandedHeight, b.expandedHeight, t) ?? a.expandedHeight,
      flexibleSpaceBlur:
          lerpDouble(a.flexibleSpaceBlur, b.flexibleSpaceBlur, t) ?? a.flexibleSpaceBlur,
    );
  }

  @override
  List<Object?> get props => [
        containerStyle,
        bottomContainerStyle,
        dividerStyle,
        height,
        collapsedHeight,
        expandedHeight,
        flexibleSpaceBlur,
      ];
}

double? lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}
