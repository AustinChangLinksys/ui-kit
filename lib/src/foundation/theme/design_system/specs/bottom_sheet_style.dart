import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'bottom_sheet_style.tailor.dart';

@TailorMixin()
class BottomSheetStyle extends ThemeExtension<BottomSheetStyle>
    with _$BottomSheetStyleTailorMixin {
  const BottomSheetStyle({
    required this.overlayColor,
    required this.animationDuration,
    required this.animationCurve,
    required this.topBorderRadius,
    required this.dragHandleHeight,
  });

  /// Scrim color when sheet is open
  @override
  final Color overlayColor;

  /// Animation duration for open/close transitions
  @override
  final Duration animationDuration;

  /// Animation curve for open/close transitions
  @override
  final Curve animationCurve;

  /// Border radius for top corners of sheet
  @override
  final double topBorderRadius;

  /// Height of the draggable handle indicator
  @override
  final double dragHandleHeight;
}
