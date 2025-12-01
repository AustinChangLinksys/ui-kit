import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Dropdown Selection',
  type: AppDropdown,
)
Widget buildAppDropdown(BuildContext context) {
  final selectedOption = context.knobs.object.dropdown<String>(
    label: 'Selected Value',
    options: ['None', 'Option 1', 'Option 2'],
    initialOption: 'None',
  );

  return Portal(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: AppDropdown<String>(
          hint: context.knobs
              .string(label: 'Hint', initialValue: 'Select an option'),
          items: const [
            'Option 1',
            'Option 2',
            'Option 3',
            'Long Option Text That Might Overflow'
          ],
          value: selectedOption == 'None' ? null : selectedOption,
          onChanged: (value) {},
        ),
      ),
    ),
  );
}
