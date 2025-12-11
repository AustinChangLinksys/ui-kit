import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

class _PasswordInputStoryState extends StatefulWidget {
  const _PasswordInputStoryState();

  @override
  _PasswordInputStoryStateState createState() => _PasswordInputStoryStateState();
}

class _PasswordInputStoryStateState extends State<_PasswordInputStoryState> {
  final TextEditingController _controller = TextEditingController();
  String _currentText = '';
  int _changeCount = 0;
  int _submitCount = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _getErrorText(String text) {
    final showErrors = context.knobs.boolean(label: 'Show Error Text', initialValue: false);
    if (!showErrors) return null;

    if (text.isEmpty) return null;
    if (text.length < 3) return 'Too short (minimum 3 characters)';
    if (text.length > 20) return 'Too long (maximum 20 characters)';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final showRulesOnlyOnError = context.knobs.boolean(label: 'Show Rules Only On Error');
    final initiallyObscured = context.knobs.boolean(label: 'Initially Obscured', initialValue: true);
    final enableShowHideToggle = context.knobs.boolean(label: 'Enable Show/Hide Toggle', initialValue: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Password Input
        AppPasswordInput(
          controller: _controller,
          label: 'Password',
          hint: 'Enter secure password',
          errorText: _getErrorText(_currentText),
          rulesHeader: 'Password requirements:',
          showRulesOnlyOnError: showRulesOnlyOnError,
          initiallyObscured: initiallyObscured,
          enableShowHideToggle: enableShowHideToggle,
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
          onChanged: (value) {
            setState(() {
              _currentText = value;
              _changeCount++;
            });
          },
          onSubmitted: (value) {
            setState(() {
              _submitCount++;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password Submitted: $value')),
            );
          },
        ),

        // Status Information
        AppGap.md(),
        AppText.bodySmall('Status Information:'),
        AppGap.xs(),
        AppText.bodySmall('Current text: "$_currentText"'),
        AppText.bodySmall('Length: ${_currentText.length}'),
        AppText.bodySmall('onChange count: $_changeCount'),
        AppText.bodySmall('onSubmit count: $_submitCount'),

        // Additional Examples
        AppGap.lg(),
        AppText.bodyMedium('Additional Examples:'),
        AppGap.sm(),

        // Without validation rules
        AppPasswordInput(
          label: 'Simple Password',
          hint: 'No validation rules',
          enableShowHideToggle: enableShowHideToggle,
          onChanged: (value) {
            // For demonstration purposes only
            debugPrint('Simple password changed: $value');
          },
        ),

        AppGap.md(),

        // With error text but no rules
        AppPasswordInput(
          label: 'Password with Error',
          hint: 'Shows error state',
          errorText: 'This is an example error message',
          enableShowHideToggle: enableShowHideToggle,
        ),

        AppGap.md(),

        // Disabled toggle
        AppPasswordInput(
          label: 'Always Hidden',
          hint: 'No show/hide toggle',
          enableShowHideToggle: false,
          rules: [
            AppPasswordRule(
              label: 'Must contain "secret"',
              validate: (v) => v.toLowerCase().contains('secret'),
            ),
          ],
        ),
      ],
    );
  }
}

@UseCase(
  name: 'AppPasswordInput',
  type: AppPasswordInput,
)
Widget appPasswordInputUseCase(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: SizedBox(
        width: 400,
        child: _PasswordInputStoryState(),
      ),
    ),
  );
}
