import 'package:flutter/material.dart';

/// Dialog for confirming theme reset action
class ResetConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ResetConfirmationDialog({
    required this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reset Theme to Default?'),
      content: const Text(
        'This action will reset all theme customizations to their default values. '
        'This cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.tonal(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
