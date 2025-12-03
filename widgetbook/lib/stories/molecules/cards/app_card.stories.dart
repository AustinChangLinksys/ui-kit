import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Playground',
  type: AppCard,
)
Widget buildAppCard(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'App Card');
  final description = context.knobs.string(
      label: 'Description',
      initialValue:
          'Cards automatically adapt to the active design system and switch between Base and Tonal surfaces.');
  final showOnTap =
      context.knobs.boolean(label: 'Show OnTap Effect', initialValue: false);
  // ✨ New: Selection state toggle
  final isSelected = context.knobs.boolean(
    label: 'Is Selected',
    initialValue: false,
  );
  final cardWidth = context.knobs.doubleOrNull
      .slider(label: 'Width', min: 100, max: 400, initialValue: 300);
  final cardHeight = context.knobs.doubleOrNull
      .slider(label: 'Height', min: 50, max: 300, initialValue: null);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: AppCard(
      onTap: showOnTap ? () {} : null,
      width: cardWidth,
      height: cardHeight,
      // ✨ New: Pass selection state
      isSelected: isSelected,
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
            const SizedBox(height: 12),
            Chip(
              label: Text(
                isSelected ? '✅ Selected (Tonal)' : '⭕ Unselected (Base)',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multi-Select Grid',
  type: AppCard,
)
Widget buildCardMultiSelect(BuildContext context) {
  return _MultiSelectCardGrid();
}

class _MultiSelectCardGrid extends StatefulWidget {
  @override
  State<_MultiSelectCardGrid> createState() => _MultiSelectCardGridState();
}

class _MultiSelectCardGridState extends State<_MultiSelectCardGrid> {
  final selectedCards = <int>{0};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          final isSelected = selectedCards.contains(index);
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedCards.remove(index);
                } else {
                  selectedCards.add(index);
                }
              });
            },
            child: AppCard(
              isSelected: isSelected,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.devices,
                    size: 32,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Device ${index + 1}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
