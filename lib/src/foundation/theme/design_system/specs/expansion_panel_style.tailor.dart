// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expansion_panel_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ExpansionPanelStyleTailorMixin on ThemeExtension<ExpansionPanelStyle> {
  Color get headerColor;
  Color get expandedBackgroundColor;
  Color get headerTextColor;
  IconData get expandIcon;
  AnimationSpec get animation;
  Duration get animationDuration;

  @override
  ExpansionPanelStyle copyWith({
    Color? headerColor,
    Color? expandedBackgroundColor,
    Color? headerTextColor,
    IconData? expandIcon,
    AnimationSpec? animation,
    Duration? animationDuration,
  }) {
    return ExpansionPanelStyle(
      headerColor: headerColor ?? this.headerColor,
      expandedBackgroundColor:
          expandedBackgroundColor ?? this.expandedBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      expandIcon: expandIcon ?? this.expandIcon,
      animation: animation ?? this.animation,
    );
  }

  @override
  ExpansionPanelStyle lerp(
      covariant ThemeExtension<ExpansionPanelStyle>? other, double t) {
    if (other is! ExpansionPanelStyle) return this as ExpansionPanelStyle;
    return ExpansionPanelStyle(
      headerColor: Color.lerp(headerColor, other.headerColor, t)!,
      expandedBackgroundColor: Color.lerp(
          expandedBackgroundColor, other.expandedBackgroundColor, t)!,
      headerTextColor: Color.lerp(headerTextColor, other.headerTextColor, t)!,
      expandIcon: t < 0.5 ? expandIcon : other.expandIcon,
      animation: animation.lerp(other.animation, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExpansionPanelStyle &&
            const DeepCollectionEquality()
                .equals(headerColor, other.headerColor) &&
            const DeepCollectionEquality().equals(
                expandedBackgroundColor, other.expandedBackgroundColor) &&
            const DeepCollectionEquality()
                .equals(headerTextColor, other.headerTextColor) &&
            const DeepCollectionEquality()
                .equals(expandIcon, other.expandIcon) &&
            const DeepCollectionEquality().equals(animation, other.animation) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(headerColor),
      const DeepCollectionEquality().hash(expandedBackgroundColor),
      const DeepCollectionEquality().hash(headerTextColor),
      const DeepCollectionEquality().hash(expandIcon),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(animationDuration),
    );
  }
}

extension ExpansionPanelStyleBuildContextProps on BuildContext {
  ExpansionPanelStyle get expansionPanelStyle =>
      Theme.of(this).extension<ExpansionPanelStyle>()!;

  /// Background color of panel headers
  Color get headerColor => expansionPanelStyle.headerColor;

  /// Background color when panel is expanded
  Color get expandedBackgroundColor =>
      expansionPanelStyle.expandedBackgroundColor;

  /// Text color of header text
  Color get headerTextColor => expansionPanelStyle.headerTextColor;

  /// Icon used for expand/collapse indicator
  IconData get expandIcon => expansionPanelStyle.expandIcon;

  /// Animation timing for expand/collapse
  AnimationSpec get animation => expansionPanelStyle.animation;
  Duration get animationDuration => expansionPanelStyle.animationDuration;
}
