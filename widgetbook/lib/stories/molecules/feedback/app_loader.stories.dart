import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Loading Indicators',
  type: AppLoader,
)
Widget buildAppLoader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppLoader(
            variant: context.knobs.object.dropdown(
              label: 'Variant',
              options: LoaderVariant.values,
              initialOption: LoaderVariant.circular,
            ),
            value: context.knobs.boolean(label: 'Indeterminate', initialValue: true)
                ? null
                : context.knobs.double.slider(
                    label: 'Progress', initialValue: 0.7, min: 0, max: 1),
            label: context.knobs.string(label: 'Label', initialValue: 'Loading...'),
          ),
        ],
      ),
    ),
  );
}
