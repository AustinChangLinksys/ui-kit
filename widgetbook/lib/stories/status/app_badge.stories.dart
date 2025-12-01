import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Badge',
  type: AppBadge,
)
Widget buildInteractiveBadge(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Beta',
  );

  // 測試顏色覆寫 (Tinting)
  final useCustomColor = context.knobs.boolean(
    label: 'Custom Color',
    initialValue: false,
  );

  final showDelete = context.knobs.boolean(
    label: 'Show Delete',
    initialValue: false,
  );

  return Center(
    child: AppBadge(
      label: label,
      color: useCustomColor ? Colors.red : null,
      onDeleted: showDelete ? () {} : null,
    ),
  );
}

@widgetbook.UseCase(
  name: 'All States (Static)',
  type: AppBadge,
)
Widget buildBadgeStates(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        children: [
          const _Header('Default (Theme Highlight)'),
          Wrap(
            spacing: 16,
            children: [
              const AppBadge(label: 'New'),
              const AppBadge(label: 'v2.0.0'),
              AppBadge(label: 'Dismissible', onDeleted: () {}),
            ],
          ),
          const SizedBox(height: 32),
          const _Header('Custom Colors (Tinted)'),
          Wrap(
            spacing: 16,
            children: [
              const AppBadge(label: 'Success', color: Colors.green),
              const AppBadge(label: 'Warning', color: Colors.orange),
              const AppBadge(label: 'Error', color: Colors.red),
              AppBadge(label: 'Filter: On', color: Colors.blue, onDeleted: () {}),
            ],
          ),
        ],
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  final String text;
  const _Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
      ),
    );
  }
}