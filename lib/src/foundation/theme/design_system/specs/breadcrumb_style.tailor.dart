// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'breadcrumb_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BreadcrumbStyleTailorMixin on ThemeExtension<BreadcrumbStyle> {
  StateColorSpec get linkColors;
  Color get separatorColor;
  String get separatorText;
  TextStyle get itemTextStyle;
  Color get activeLinkColor;
  Color get inactiveLinkColor;

  @override
  BreadcrumbStyle copyWith({
    StateColorSpec? linkColors,
    Color? separatorColor,
    String? separatorText,
    TextStyle? itemTextStyle,
    Color? activeLinkColor,
    Color? inactiveLinkColor,
  }) {
    return BreadcrumbStyle(
      linkColors: linkColors ?? this.linkColors,
      separatorColor: separatorColor ?? this.separatorColor,
      separatorText: separatorText ?? this.separatorText,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
    );
  }

  @override
  BreadcrumbStyle lerp(
      covariant ThemeExtension<BreadcrumbStyle>? other, double t) {
    if (other is! BreadcrumbStyle) return this as BreadcrumbStyle;
    return BreadcrumbStyle(
      linkColors: linkColors.lerp(other.linkColors, t),
      separatorColor: Color.lerp(separatorColor, other.separatorColor, t)!,
      separatorText: t < 0.5 ? separatorText : other.separatorText,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BreadcrumbStyle &&
            const DeepCollectionEquality()
                .equals(linkColors, other.linkColors) &&
            const DeepCollectionEquality()
                .equals(separatorColor, other.separatorColor) &&
            const DeepCollectionEquality()
                .equals(separatorText, other.separatorText) &&
            const DeepCollectionEquality()
                .equals(itemTextStyle, other.itemTextStyle) &&
            const DeepCollectionEquality()
                .equals(activeLinkColor, other.activeLinkColor) &&
            const DeepCollectionEquality()
                .equals(inactiveLinkColor, other.inactiveLinkColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(linkColors),
      const DeepCollectionEquality().hash(separatorColor),
      const DeepCollectionEquality().hash(separatorText),
      const DeepCollectionEquality().hash(itemTextStyle),
      const DeepCollectionEquality().hash(activeLinkColor),
      const DeepCollectionEquality().hash(inactiveLinkColor),
    );
  }
}

extension BreadcrumbStyleBuildContextProps on BuildContext {
  BreadcrumbStyle get breadcrumbStyle =>
      Theme.of(this).extension<BreadcrumbStyle>()!;

  /// State-based colors for breadcrumb links.
  /// Use [linkColors.resolve(isActive: isTappable)] to get the appropriate color.
  /// - active: tappable items (parent links)
  /// - inactive: current location (non-tappable)
  StateColorSpec get linkColors => breadcrumbStyle.linkColors;

  /// Color of separator characters
  Color get separatorColor => breadcrumbStyle.separatorColor;

  /// Separator text between items (/, >, |, etc.)
  String get separatorText => breadcrumbStyle.separatorText;

  /// Text style for breadcrumb items
  TextStyle get itemTextStyle => breadcrumbStyle.itemTextStyle;
  Color get activeLinkColor => breadcrumbStyle.activeLinkColor;
  Color get inactiveLinkColor => breadcrumbStyle.inactiveLinkColor;
}
