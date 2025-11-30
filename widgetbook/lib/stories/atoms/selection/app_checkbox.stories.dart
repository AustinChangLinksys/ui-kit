import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Checkbox',
  type: AppCheckbox,
)
Widget buildInteractiveCheckbox(BuildContext context) {
  return Center(
    child: _CheckboxWrapper(
      initialValue: context.knobs.boolean(
        label: 'Initial Value',
        initialValue: false,
      ),
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'Accept Terms & Conditions',
      ),
      isDisabled: context.knobs.boolean(
        label: 'Disabled',
        initialValue: false,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'All States (Static)',
  type: AppCheckbox,
)
Widget buildCheckboxStates(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        children: [
          const _Header('Active'),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              AppCheckbox(value: false, onChanged: (_) {}, label: 'Unchecked'),
              AppCheckbox(value: true, onChanged: (_) {}, label: 'Checked'),
            ],
          ),
          const SizedBox(height: 32),
          const _Header('Disabled'),
          const Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              AppCheckbox(
                  value: false, onChanged: null, label: 'Disabled (Off)'),
              AppCheckbox(
                  value: true, onChanged: null, label: 'Disabled (On)'),
            ],
          ),
        ],
      ),
    ),
  );
}

// --- Helpers ---

class _CheckboxWrapper extends StatefulWidget {
  final bool initialValue;
  final String label;
  final bool isDisabled;

  const _CheckboxWrapper({
    required this.initialValue,
    required this.label,
    required this.isDisabled,
  });

  @override
  State<_CheckboxWrapper> createState() => _CheckboxWrapperState();
}

class _CheckboxWrapperState extends State<_CheckboxWrapper> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant _CheckboxWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCheckbox(
      value: _value,
      label: widget.label,
      onChanged:
          widget.isDisabled ? null : (v) => setState(() => _value = v ?? false),
    );
  }
}

class _Header extends StatelessWidget {
  final String text;
  const _Header(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}