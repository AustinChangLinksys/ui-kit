import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.WidgetbookComponent(
  name: 'ExpansionPanel',
  category: 'Navigation',
  description: 'Collapsible panel component for organizing content into expandable sections',
  isFullWidth: false,
)
Widget expansionPanelStory(BuildContext context) {
  final panelCount = context.knobs.slider(
    label: 'Number of panels',
    initialValue: 3,
    min: 1,
    max: 5,
  ).toInt();

  final allowMultipleOpen = context.knobs.boolean(
    label: 'Allow multiple open',
    initialValue: true,
  );

  final contentType = context.knobs.options(
    label: 'Content type',
    options: [
      Option(label: 'Text only', value: 'text'),
      Option(label: 'Text with icons', value: 'icons'),
      Option(label: 'Long content', value: 'long'),
    ],
  );

  final panels = List.generate(
    panelCount,
    (index) => ExpansionPanelItem(
      headerTitle: 'Panel ${index + 1}',
      content: _buildContent(contentType),
    ),
  );

  return Center(
    child: SizedBox(
      width: 400,
      child: SingleChildScrollView(
        child: AppExpansionPanel(
          panels: panels,
          allowMultipleOpen: allowMultipleOpen,
          onPanelToggled: (index) {
            // ignore: avoid_print
            print('Panel $index toggled');
          },
        ),
      ),
    ),
  );
}

Widget _buildContent(String type) {
  switch (type) {
    case 'text':
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: AppText(
          'This is the expanded content for the panel. You can add any widget here.',
          variant: AppTextVariant.bodyMedium,
        ),
      );
    case 'icons':
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 12),
                AppText(
                  'Feature is enabled',
                  variant: AppTextVariant.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.info_outline),
                const SizedBox(width: 12),
                Expanded(
                  child: AppText(
                    'Additional information about this panel configuration',
                    variant: AppTextVariant.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    case 'long':
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppText(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. '
          'Nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit. '
          'In voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
          variant: AppTextVariant.bodySmall,
        ),
      );
    default:
      return const AppText('Content');
  }
}
