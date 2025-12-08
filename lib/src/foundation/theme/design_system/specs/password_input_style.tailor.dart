// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_input_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$PasswordInputStyleTailorMixin on ThemeExtension<PasswordInputStyle> {
  IconData get validIcon;
  IconData get pendingIcon;
  TextStyle get ruleTextStyle;
  bool get showRuleListBackground;
  Color get validColor;
  Color get pendingColor;

  @override
  PasswordInputStyle copyWith({
    IconData? validIcon,
    IconData? pendingIcon,
    TextStyle? ruleTextStyle,
    bool? showRuleListBackground,
    Color? validColor,
    Color? pendingColor,
  }) {
    return PasswordInputStyle(
      validIcon: validIcon ?? this.validIcon,
      pendingIcon: pendingIcon ?? this.pendingIcon,
      ruleTextStyle: ruleTextStyle ?? this.ruleTextStyle,
      showRuleListBackground:
          showRuleListBackground ?? this.showRuleListBackground,
      validColor: validColor ?? this.validColor,
      pendingColor: pendingColor ?? this.pendingColor,
    );
  }

  @override
  PasswordInputStyle lerp(
      covariant ThemeExtension<PasswordInputStyle>? other, double t) {
    if (other is! PasswordInputStyle) return this as PasswordInputStyle;
    return PasswordInputStyle(
      validIcon: t < 0.5 ? validIcon : other.validIcon,
      pendingIcon: t < 0.5 ? pendingIcon : other.pendingIcon,
      ruleTextStyle: TextStyle.lerp(ruleTextStyle, other.ruleTextStyle, t)!,
      showRuleListBackground:
          t < 0.5 ? showRuleListBackground : other.showRuleListBackground,
      validColor: Color.lerp(validColor, other.validColor, t)!,
      pendingColor: Color.lerp(pendingColor, other.pendingColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PasswordInputStyle &&
            const DeepCollectionEquality().equals(validIcon, other.validIcon) &&
            const DeepCollectionEquality()
                .equals(pendingIcon, other.pendingIcon) &&
            const DeepCollectionEquality()
                .equals(ruleTextStyle, other.ruleTextStyle) &&
            const DeepCollectionEquality()
                .equals(showRuleListBackground, other.showRuleListBackground) &&
            const DeepCollectionEquality()
                .equals(validColor, other.validColor) &&
            const DeepCollectionEquality()
                .equals(pendingColor, other.pendingColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(validIcon),
      const DeepCollectionEquality().hash(pendingIcon),
      const DeepCollectionEquality().hash(ruleTextStyle),
      const DeepCollectionEquality().hash(showRuleListBackground),
      const DeepCollectionEquality().hash(validColor),
      const DeepCollectionEquality().hash(pendingColor),
    );
  }
}

extension PasswordInputStyleBuildContextProps on BuildContext {
  PasswordInputStyle get passwordInputStyle =>
      Theme.of(this).extension<PasswordInputStyle>()!;
  IconData get validIcon => passwordInputStyle.validIcon;
  IconData get pendingIcon => passwordInputStyle.pendingIcon;
  TextStyle get ruleTextStyle => passwordInputStyle.ruleTextStyle;
  bool get showRuleListBackground => passwordInputStyle.showRuleListBackground;
  Color get validColor => passwordInputStyle.validColor;
  Color get pendingColor => passwordInputStyle.pendingColor;
}
