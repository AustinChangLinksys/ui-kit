import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Toasts',
  type: AppToast,
)
Widget buildAppToast(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppToast(
            type: context.knobs.object.dropdown(
              label: 'Type',
              options: ToastType.values,
              initialOption: ToastType.success,
            ),
            title: context.knobs.string(
                label: 'Title', initialValue: 'Operation Successful'),
            description: context.knobs.string(
                label: 'Description',
                initialValue: 'Your changes have been saved.'),
            onDismiss: () {},
          ),
          const SizedBox(height: 20),
          Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                AppToast.show(
                  context,
                  type: ToastType.info,
                  title: 'Notification',
                  description: 'This is a floating toast message.',
                );
              },
              child: const Text('Show Overlay Toast'),
            );
          }),
        ],
      ),
    ),
  );
}
