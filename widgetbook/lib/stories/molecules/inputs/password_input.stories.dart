import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

@UseCase(
  name: 'AppPasswordInput',
  type: AppPasswordInput,
)
Widget appPasswordInputUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: AppPasswordInput(
        label: 'Password',
        hint: 'Enter secure password',
        rulesHeader: 'Password requirements:',
        showRulesOnlyOnError: context.knobs.boolean(label: 'Show Rules Only On Error'),
        initiallyObscured: context.knobs.boolean(label: 'Initially Obscured', initialValue: true),
        rules: [
          AppPasswordRule(
            label: 'At least 8 characters',
            validate: (v) => v.length >= 8,
          ),
          AppPasswordRule(
            label: 'Contains a number',
            validate: (v) => RegExp(r'[0-9]').hasMatch(v),
          ),
          AppPasswordRule(
            label: 'Contains a special character',
            validate: (v) => RegExp(r'[!@#\$%^&*]').hasMatch(v),
          ),
        ],
        onSubmitted: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Submitted')),
          );
        },
      ),
    ),
  );
}
