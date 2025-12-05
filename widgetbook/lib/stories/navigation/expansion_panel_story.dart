import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Single Panel',
  type: AppExpansionPanel,
)
Widget buildSinglePanel(BuildContext context) {
  const panels = [
    ExpansionPanelItem(
      headerTitle: 'General Settings',
      content: Text('Configure general application settings'),
    ),
  ];

  return DesignSystem.init(
    context,
    const Padding(
      padding: EdgeInsets.all(16),
      child: AppExpansionPanel(panels: panels),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multiple Panels',
  type: AppExpansionPanel,
)
Widget buildMultiplePanels(BuildContext context) {
  final panelCount = context.knobs.int.slider(
    label: 'Panel Count',
    initialValue: 3,
    min: 2,
    max: 5,
  );

  final panels = List.generate(
    panelCount,
    (i) => ExpansionPanelItem(
      headerTitle: 'Panel ${i + 1}',
      content: Text('Content for panel ${i + 1}'),
    ),
  );

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppExpansionPanel(panels: panels),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Long Content',
  type: AppExpansionPanel,
)
Widget buildLongContent(BuildContext context) {
  final panels = [
    const ExpansionPanelItem(
      headerTitle: 'Privacy Policy',
      content: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris. '
        'Nisi ut aliquip ex ea commodo consequat.',
      ),
    ),
  ];

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppExpansionPanel(panels: panels),
    ),
  );
}
