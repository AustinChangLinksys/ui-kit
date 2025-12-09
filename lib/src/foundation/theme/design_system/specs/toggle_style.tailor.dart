// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toggle_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ToggleStyleTailorMixin on ThemeExtension<ToggleStyle> {
  ToggleContentType get activeType;
  ToggleContentType get inactiveType;
  String? get activeText;
  String? get inactiveText;
  IconData? get activeIcon;
  IconData? get inactiveIcon;
  SurfaceStyle? get activeTrackStyle;
  SurfaceStyle? get inactiveTrackStyle;
  SurfaceStyle? get thumbStyle;

  @override
  ToggleStyle copyWith({
    ToggleContentType? activeType,
    ToggleContentType? inactiveType,
    String? activeText,
    String? inactiveText,
    IconData? activeIcon,
    IconData? inactiveIcon,
    SurfaceStyle? activeTrackStyle,
    SurfaceStyle? inactiveTrackStyle,
    SurfaceStyle? thumbStyle,
  }) {
    return ToggleStyle(
      activeType: activeType ?? this.activeType,
      inactiveType: inactiveType ?? this.inactiveType,
      activeText: activeText ?? this.activeText,
      inactiveText: inactiveText ?? this.inactiveText,
      activeIcon: activeIcon ?? this.activeIcon,
      inactiveIcon: inactiveIcon ?? this.inactiveIcon,
      activeTrackStyle: activeTrackStyle ?? this.activeTrackStyle,
      inactiveTrackStyle: inactiveTrackStyle ?? this.inactiveTrackStyle,
      thumbStyle: thumbStyle ?? this.thumbStyle,
    );
  }

  @override
  ToggleStyle lerp(covariant ThemeExtension<ToggleStyle>? other, double t) {
    if (other is! ToggleStyle) return this as ToggleStyle;
    return ToggleStyle(
      activeType: t < 0.5 ? activeType : other.activeType,
      inactiveType: t < 0.5 ? inactiveType : other.inactiveType,
      activeText: t < 0.5 ? activeText : other.activeText,
      inactiveText: t < 0.5 ? inactiveText : other.inactiveText,
      activeIcon: t < 0.5 ? activeIcon : other.activeIcon,
      inactiveIcon: t < 0.5 ? inactiveIcon : other.inactiveIcon,
      activeTrackStyle: t < 0.5 ? activeTrackStyle : other.activeTrackStyle,
      inactiveTrackStyle:
          t < 0.5 ? inactiveTrackStyle : other.inactiveTrackStyle,
      thumbStyle: t < 0.5 ? thumbStyle : other.thumbStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToggleStyle &&
            const DeepCollectionEquality()
                .equals(activeType, other.activeType) &&
            const DeepCollectionEquality()
                .equals(inactiveType, other.inactiveType) &&
            const DeepCollectionEquality()
                .equals(activeText, other.activeText) &&
            const DeepCollectionEquality()
                .equals(inactiveText, other.inactiveText) &&
            const DeepCollectionEquality()
                .equals(activeIcon, other.activeIcon) &&
            const DeepCollectionEquality()
                .equals(inactiveIcon, other.inactiveIcon) &&
            const DeepCollectionEquality()
                .equals(activeTrackStyle, other.activeTrackStyle) &&
            const DeepCollectionEquality()
                .equals(inactiveTrackStyle, other.inactiveTrackStyle) &&
            const DeepCollectionEquality()
                .equals(thumbStyle, other.thumbStyle));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(activeType),
      const DeepCollectionEquality().hash(inactiveType),
      const DeepCollectionEquality().hash(activeText),
      const DeepCollectionEquality().hash(inactiveText),
      const DeepCollectionEquality().hash(activeIcon),
      const DeepCollectionEquality().hash(inactiveIcon),
      const DeepCollectionEquality().hash(activeTrackStyle),
      const DeepCollectionEquality().hash(inactiveTrackStyle),
      const DeepCollectionEquality().hash(thumbStyle),
    );
  }
}

extension ToggleStyleBuildContextProps on BuildContext {
  ToggleStyle get toggleStyle => Theme.of(this).extension<ToggleStyle>()!;

  /// Content type for active state.
  ToggleContentType get activeType => toggleStyle.activeType;

  /// Content type for inactive state.
  ToggleContentType get inactiveType => toggleStyle.inactiveType;

  /// Text displayed when active (if activeType is text).
  String? get activeText => toggleStyle.activeText;

  /// Text displayed when inactive (if inactiveType is text).
  String? get inactiveText => toggleStyle.inactiveText;

  /// Icon displayed when active (if activeType is icon).
  IconData? get activeIcon => toggleStyle.activeIcon;

  /// Icon displayed when inactive (if inactiveType is icon).
  IconData? get inactiveIcon => toggleStyle.inactiveIcon;

  /// Track style when toggle is active.
  SurfaceStyle? get activeTrackStyle => toggleStyle.activeTrackStyle;

  /// Track style when toggle is inactive.
  SurfaceStyle? get inactiveTrackStyle => toggleStyle.inactiveTrackStyle;

  /// Thumb style for the toggle.
  SurfaceStyle? get thumbStyle => toggleStyle.thumbStyle;
}
