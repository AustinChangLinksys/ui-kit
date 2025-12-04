import 'package:equatable/equatable.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/surface_style.dart';

/// Defines visual properties for PopupMenu container and items.
/// Named AppMenuStyle to avoid conflict with Flutter's MenuStyle.
class AppMenuStyle extends Equatable {
  /// Popup container background, border, shadow.
  final SurfaceStyle containerStyle;

  /// Default menu item appearance.
  final SurfaceStyle itemStyle;

  /// Hovered/focused item appearance.
  final SurfaceStyle itemHoverStyle;

  /// Destructive action item (error color).
  final SurfaceStyle destructiveItemStyle;

  /// Minimum item height (48.0 for a11y).
  final double itemHeight;

  /// Horizontal padding inside items.
  final double itemHorizontalPadding;

  /// Leading icon size.
  final double iconSize;

  /// Gap between icon and label.
  final double iconLabelSpacing;

  const AppMenuStyle({
    required this.containerStyle,
    required this.itemStyle,
    required this.itemHoverStyle,
    required this.destructiveItemStyle,
    this.itemHeight = 48.0,
    this.itemHorizontalPadding = 16.0,
    this.iconSize = 24.0,
    this.iconLabelSpacing = 12.0,
  });

  AppMenuStyle copyWith({
    SurfaceStyle? containerStyle,
    SurfaceStyle? itemStyle,
    SurfaceStyle? itemHoverStyle,
    SurfaceStyle? destructiveItemStyle,
    double? itemHeight,
    double? itemHorizontalPadding,
    double? iconSize,
    double? iconLabelSpacing,
  }) {
    return AppMenuStyle(
      containerStyle: containerStyle ?? this.containerStyle,
      itemStyle: itemStyle ?? this.itemStyle,
      itemHoverStyle: itemHoverStyle ?? this.itemHoverStyle,
      destructiveItemStyle: destructiveItemStyle ?? this.destructiveItemStyle,
      itemHeight: itemHeight ?? this.itemHeight,
      itemHorizontalPadding:
          itemHorizontalPadding ?? this.itemHorizontalPadding,
      iconSize: iconSize ?? this.iconSize,
      iconLabelSpacing: iconLabelSpacing ?? this.iconLabelSpacing,
    );
  }

  static AppMenuStyle lerp(AppMenuStyle a, AppMenuStyle b, double t) {
    return AppMenuStyle(
      containerStyle: a.containerStyle,
      itemStyle: a.itemStyle,
      itemHoverStyle: a.itemHoverStyle,
      destructiveItemStyle: a.destructiveItemStyle,
      itemHeight: _lerpDouble(a.itemHeight, b.itemHeight, t),
      itemHorizontalPadding:
          _lerpDouble(a.itemHorizontalPadding, b.itemHorizontalPadding, t),
      iconSize: _lerpDouble(a.iconSize, b.iconSize, t),
      iconLabelSpacing: _lerpDouble(a.iconLabelSpacing, b.iconLabelSpacing, t),
    );
  }

  @override
  List<Object?> get props => [
        containerStyle,
        itemStyle,
        itemHoverStyle,
        destructiveItemStyle,
        itemHeight,
        itemHorizontalPadding,
        iconSize,
        iconLabelSpacing,
      ];
}

double _lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}
