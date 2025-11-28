import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Standard',
  type: AppCard,
)
Widget buildAppCard(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'App Card');
  final description = context.knobs.string(
      label: 'Description',
      initialValue:
          'This card automatically adapts to the active design system (Glass or Brutal).');
  final showOnTap =
      context.knobs.boolean(label: 'Show OnTap Effect', initialValue: false);
  final cardWidth = context.knobs.doubleOrNull
      .slider(label: 'Width', min: 100, max: 400, initialValue: null);
  final cardHeight = context.knobs.doubleOrNull
      .slider(label: 'Height', min: 50, max: 300, initialValue: null);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: AppCard(
      onTap: showOnTap ? () {} : null,
      width: cardWidth,
      height: cardHeight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              description,
            ),
          ],
        ),
      ),
    ),
  );
}
