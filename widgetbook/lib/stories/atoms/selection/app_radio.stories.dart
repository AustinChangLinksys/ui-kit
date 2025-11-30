import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Radio Group',
  type: AppRadio,
)
Widget buildInteractiveRadioGroup(BuildContext context) {
  return Center(
    child: _RadioGroupWrapper(
      isDisabled: context.knobs.boolean(
        label: 'Disabled',
        initialValue: false,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'All States (Static)',
  type: AppRadio,
)
Widget buildRadioStates(BuildContext context) {
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
              AppRadio<int>(
                  value: 1,
                  groupValue: 2,
                  onChanged: (_) {},
                  label: 'Unselected'),
              AppRadio<int>(
                  value: 1,
                  groupValue: 1,
                  onChanged: (_) {},
                  label: 'Selected'),
            ],
          ),
          const SizedBox(height: 32),
          const _Header('Disabled'),
          const Wrap(
            spacing: 24,
            runSpacing: 16,
            children: [
              AppRadio<int>(
                  value: 1,
                  groupValue: 2,
                  onChanged: null,
                  label: 'Disabled (Off)'),
              AppRadio<int>(
                  value: 1,
                  groupValue: 1,
                  onChanged: null,
                  label: 'Disabled (On)'),
            ],
          ),
        ],
      ),
    ),
  );
}

// --- Helpers ---

class _RadioGroupWrapper extends StatefulWidget {
  final bool isDisabled;

  const _RadioGroupWrapper({required this.isDisabled});

  @override
  State<_RadioGroupWrapper> createState() => _RadioGroupWrapperState();
}

class _RadioGroupWrapperState extends State<_RadioGroupWrapper> {
  int _groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppRadio<int>(
          value: 1,
          groupValue: _groupValue,
          label: 'Option A',
          onChanged: widget.isDisabled
              ? null
              : (v) => setState(() => _groupValue = v!),
        ),
        const SizedBox(height: 8),
        AppRadio<int>(
          value: 2,
          groupValue: _groupValue,
          label: 'Option B',
          onChanged: widget.isDisabled
              ? null
              : (v) => setState(() => _groupValue = v!),
        ),
        const SizedBox(height: 8),
        AppRadio<int>(
          value: 3,
          groupValue: _groupValue,
          label: 'Option C',
          onChanged: widget.isDisabled
              ? null
              : (v) => setState(() => _groupValue = v!),
        ),
      ],
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
