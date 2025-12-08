import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'password_input_style.tailor.dart';

@TailorMixin()
class PasswordInputStyle extends ThemeExtension<PasswordInputStyle> with _$PasswordInputStyleTailorMixin {
  @override
  final IconData validIcon;     // Check / [x]
  @override
  final IconData pendingIcon;   // Circle / [ ]
  @override
  final TextStyle ruleTextStyle;
  @override
  final bool showRuleListBackground; // Glass (Pane)
  @override
  final Color validColor;       // signalStrong
  @override
  final Color pendingColor;

  PasswordInputStyle({
    required this.validIcon,
    required this.pendingIcon,
    required this.ruleTextStyle,
    required this.showRuleListBackground,
    required this.validColor,
    required this.pendingColor,
  });
}
