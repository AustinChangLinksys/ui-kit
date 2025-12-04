import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Standard Dialog',
  type: AppDialog,
)
Widget buildAppDialog(BuildContext context) {
  final titleText = context.knobs.string(
    label: 'Title',
    initialValue: 'Confirm Action',
  );
  final contentText = context.knobs.string(
    label: 'Content',
    initialValue: 'Are you sure you want to proceed? This action cannot be undone.',
  );
  final showActions = context.knobs.boolean(
    label: 'Show Actions',
    initialValue: true,
  );
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: false,
  );

  return Center(
    child: AppDialog(
      icon: showIcon ? Icons.warning_amber_rounded : null,
      titleText: titleText,
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
  name: 'Dialog with Icon',
  type: AppDialog,
)
Widget buildAppDialogWithIcon(BuildContext context) {
  final iconOption = context.knobs.list<IconData>(
    label: 'Icon',
    options: [
      Icons.warning_amber_rounded,
      Icons.info_outline,
      Icons.check_circle_outline,
      Icons.error_outline,
    ],
    labelBuilder: (icon) {
      if (icon == Icons.warning_amber_rounded) return 'Warning';
      if (icon == Icons.info_outline) return 'Info';
      if (icon == Icons.check_circle_outline) return 'Success';
      return 'Error';
    },
  );

  return Center(
    child: AppDialog(
      icon: iconOption,
      titleText: 'Dialog with Icon',
      content: const Text('This dialog displays an icon above the title.'),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {},
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Dialog Demo (Popup)',
  type: AppDialog,
)
Widget buildAppDialogPopup(BuildContext context) {
  final titleText = context.knobs.string(
    label: 'Title',
    initialValue: 'Popup Dialog',
  );
  final contentText = context.knobs.string(
    label: 'Content',
    initialValue: 'This dialog uses the active design theme with backdrop blur for Glass mode.',
  );
  final isDestructive = context.knobs.boolean(
    label: 'Destructive Action',
    initialValue: false,
  );

  return Center(
    child: FilledButton(
      onPressed: () {
        showAppDialog(
          context: context,
          builder: (dialogContext) {
            // Theme is now automatically propagated by showAppDialog
            final dialogTheme = Theme.of(dialogContext);
            return AppDialog(
              titleText: titleText,
              content: Text(contentText),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  style: isDestructive
                      ? TextButton.styleFrom(
                          foregroundColor: dialogTheme.colorScheme.error,
                        )
                      : null,
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(isDestructive ? 'Delete' : 'Confirm'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('Show Dialog'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Confirm Dialog Helper',
  type: AppDialog,
)
Widget buildConfirmDialogHelper(BuildContext context) {
  final isDestructive = context.knobs.boolean(
    label: 'Destructive',
    initialValue: true,
  );

  return Center(
    child: FilledButton(
      onPressed: () async {
        final result = await showAppConfirmDialog(
          context: context,
          title: isDestructive ? 'Delete Item?' : 'Confirm Action',
          message: isDestructive
              ? 'This action cannot be undone. Are you sure you want to delete this item?'
              : 'Are you sure you want to proceed with this action?',
          confirmLabel: isDestructive ? 'Delete' : 'Confirm',
          cancelLabel: 'Cancel',
          isDestructive: isDestructive,
          icon: isDestructive ? Icons.delete_outline : Icons.help_outline,
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result == true ? 'Confirmed!' : 'Cancelled'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: const Text('Show Confirm Dialog'),
    ),
  );
}
