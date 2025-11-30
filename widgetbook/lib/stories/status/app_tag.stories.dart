import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Tag',
  type: AppTag,
)
Widget buildInteractiveTag(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: '#Flutter',
  );

  // Tag 常見場景：分類顏色
  final colorOption = context.knobs.list<Color?>(
    label: 'Color',
    options: [null, Colors.orange, Colors.purple, Colors.teal],
    labelBuilder: (color) {
      if (color == null) return 'Default (Base)';
      if (color == Colors.orange) return 'Orange';
      if (color == Colors.purple) return 'Purple';
      return 'Teal';
    },
    initialOption: null,
  );

  final isInteractive = context.knobs.boolean(
    label: 'OnTap',
    initialValue: true,
  );

  final showDelete = context.knobs.boolean(
    label: 'OnDeleted',
    initialValue: false,
  );

  return Center(
    child: AppTag(
      label: label,
      color: colorOption,
      onTap: isInteractive ? () {} : null,
      onDeleted: showDelete ? () {} : null,
    ),
  );
}

@widgetbook.UseCase(
  name: 'All States (Static)',
  type: AppTag,
)
Widget buildTagStates(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        children: [
          _Header('Default (Base Style)'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const AppTag(label: '#DesignSystem'),
              const AppTag(label: '#UI'),
              AppTag(label: 'Clear All', onDeleted: () {}),
            ],
          ),
          const SizedBox(height: 32),
          _Header('Colored Tags (Hashtags)'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const AppTag(label: '#Bug', color: Colors.red),
              const AppTag(label: '#Feature', color: Colors.blue),
              const AppTag(label: '#Documentation', color: Colors.purple),
            ],
          ),
          const SizedBox(height: 32),
          _Header('Interactive Filters'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppTag(label: 'Price: Low-High', onTap: () {}),
              AppTag(label: 'Brand: Apple', color: Colors.black, onDeleted: () {}),
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