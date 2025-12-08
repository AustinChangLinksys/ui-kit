import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'shared/overlay_spec.dart';

part 'sheet_style.tailor.dart';

/// Direction discriminator for sheet positioning.
enum SheetDirection {
  /// Sheet slides from bottom of screen
  bottom,

  /// Sheet slides from side (left or right)
  side,
}

/// Unified style for both bottom sheets and side sheets.
///
/// Replaces deprecated [BottomSheetStyle] and [SideSheetStyle].
/// Composes [OverlaySpec] for overlay appearance and animation.
///
/// Example:
/// ```dart
/// SheetStyle(
///   overlay: OverlaySpec.glass,
///   borderRadius: 24.0,
///   width: 320.0,
/// )
/// ```
@TailorMixin()
class SheetStyle extends ThemeExtension<SheetStyle> with _$SheetStyleTailorMixin {
  const SheetStyle({
    required this.overlay,
    required this.borderRadius,
    this.width,
    this.dragHandleHeight = 4.0,
    this.enableDithering = false,
  });

  /// Overlay appearance (scrim color, blur, animation timing)
  @override
  final OverlaySpec overlay;

  /// Border radius for sheet corners
  /// - Bottom sheets: top corners only
  /// - Side sheets: opposite side corners
  @override
  final double borderRadius;

  /// Sheet width for side sheets (null = full width for bottom sheets)
  @override
  final double? width;

  /// Height of the draggable handle indicator (bottom sheets only)
  @override
  final double dragHandleHeight;

  /// Enable dithering texture pattern (Pixel theme)
  @override
  final bool enableDithering;

  /// Create a new instance with specified values overridden.
  SheetStyle withOverride({
    OverlaySpec? overlay,
    double? borderRadius,
    double? width,
    double? dragHandleHeight,
    bool? enableDithering,
  }) {
    return SheetStyle(
      overlay: overlay ?? this.overlay,
      borderRadius: borderRadius ?? this.borderRadius,
      width: width ?? this.width,
      dragHandleHeight: dragHandleHeight ?? this.dragHandleHeight,
      enableDithering: enableDithering ?? this.enableDithering,
    );
  }
}
