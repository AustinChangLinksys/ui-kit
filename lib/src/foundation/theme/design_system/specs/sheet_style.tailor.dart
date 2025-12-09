// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sheet_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SheetStyleTailorMixin on ThemeExtension<SheetStyle> {
  OverlaySpec get overlay;
  double get borderRadius;
  double? get width;
  double get dragHandleHeight;
  bool get enableDithering;

  @override
  SheetStyle copyWith({
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

  @override
  SheetStyle lerp(covariant ThemeExtension<SheetStyle>? other, double t) {
    if (other is! SheetStyle) return this as SheetStyle;
    return SheetStyle(
      overlay: overlay.lerp(other.overlay, t),
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      width: t < 0.5 ? width : other.width,
      dragHandleHeight: t < 0.5 ? dragHandleHeight : other.dragHandleHeight,
      enableDithering: t < 0.5 ? enableDithering : other.enableDithering,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SheetStyle &&
            const DeepCollectionEquality().equals(overlay, other.overlay) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality().equals(width, other.width) &&
            const DeepCollectionEquality()
                .equals(dragHandleHeight, other.dragHandleHeight) &&
            const DeepCollectionEquality()
                .equals(enableDithering, other.enableDithering));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(overlay),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(dragHandleHeight),
      const DeepCollectionEquality().hash(enableDithering),
    );
  }
}

extension SheetStyleBuildContextProps on BuildContext {
  SheetStyle get sheetStyle => Theme.of(this).extension<SheetStyle>()!;

  /// Overlay appearance (scrim color, blur, animation timing)
  OverlaySpec get overlay => sheetStyle.overlay;

  /// Border radius for sheet corners
  /// - Bottom sheets: top corners only
  /// - Side sheets: opposite side corners
  double get borderRadius => sheetStyle.borderRadius;

  /// Sheet width for side sheets (null = full width for bottom sheets)
  double? get width => sheetStyle.width;

  /// Height of the draggable handle indicator (bottom sheets only)
  double get dragHandleHeight => sheetStyle.dragHandleHeight;

  /// Enable dithering texture pattern (Pixel theme)
  bool get enableDithering => sheetStyle.enableDithering;
}
