# Password Input Contracts

```dart
import 'package:flutter/widgets.dart';
import 'package:theme_tailor/theme_tailor.dart';

part 'password_input_style.tailor.dart';

@TailorMixin()
class PasswordInputStyle extends ThemeExtension<PasswordInputStyle> with _$PasswordInputStyleTailorMixin {
  final IconData validIcon;     // Check / [x]
  final IconData pendingIcon;   // Circle / [ ]
  final TextStyle ruleTextStyle;
  final bool showRuleListBackground; // Glass (Pane)
  final Color validColor;       // signalStrong
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

class AppPasswordRule {
  final String label;
  final bool Function(String value) validate;

  const AppPasswordRule({required this.label, required this.validate});
}

class AppPasswordInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final List<AppPasswordRule>? rules;
  final String? rulesHeader;
  final bool showRulesOnlyOnError;
  final bool initiallyObscured;
  final ValueChanged<String>? onSubmitted;

  const AppPasswordInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.rules,
    this.rulesHeader,
    this.showRulesOnlyOnError = false,
    this.initiallyObscured = true,
    this.onSubmitted,
  });
}
```
