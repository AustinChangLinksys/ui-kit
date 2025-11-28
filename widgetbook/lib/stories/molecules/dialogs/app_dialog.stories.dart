import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Standard Dialog',
  type: AppDialog,
)
Widget buildAppDialog(BuildContext context) {
  final titleText =
      context.knobs.string(label: 'Title', initialValue: 'Confirm Action');
  final contentText = context.knobs.string(
      label: 'Content',
      initialValue:
          'Are you sure you want to proceed? This action cannot be undone.');
  final showActions =
      context.knobs.boolean(label: 'Show Actions', initialValue: true);

  return Center(
    child: AppDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: showActions
          ? [
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {},
                child: const Text('Confirm'),
              ),
            ]
          : null,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Dialog Demo (Popup)',
  type: AppDialog,
)
Widget buildAppDialogPopup(BuildContext context) {
  // 1. 捕捉當前 Context 的 Theme
  final theme = Theme.of(context);
  
  // Knobs
  final titleText = context.knobs.string(label: 'Title', initialValue: 'Popup Dialog');
  final contentText = context.knobs.string(label: 'Content', initialValue: 'This dialog uses the active design theme.');

  return Center(
    child: FilledButton(
      onPressed: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'Dismiss',
          pageBuilder: (context, anim1, anim2) {
            return Theme(
              data: theme,
              child: AppDialog(
                title: Text(titleText),
                content: Text(contentText),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const Text('Show Dialog'),
    ),
  );
}
