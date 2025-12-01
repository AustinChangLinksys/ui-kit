import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Interactive Form Field',
  type: AppTextFormField,
)
Widget buildAppTextFormField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Center(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextFormField(
              hintText: context.knobs.string(label: 'Hint', initialValue: 'Enter something...'),
              enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Form.of(context).validate();
                },
                child: const Text('Validate'),
              );
            }),
          ],
        ),
      ),
    ),
  );
}
