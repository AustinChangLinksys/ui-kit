import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

@UseCase(
  name: 'AppRangeInput',
  type: AppRangeInput,
)
Widget appRangeInputUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: AppRangeInput(
        startLabel: 'Min',
        endLabel: 'Max',
        errorText: context.knobs.stringOrNull(label: 'Error Text'),
        validator: (start, end) {
          if (start.isEmpty || end.isEmpty) return null;
          final s = int.tryParse(start);
          final e = int.tryParse(end);
          if (s != null && e != null && s > e) {
            return 'Min cannot be greater than Max';
          }
          return null;
        },
      ),
    ),
  );
}
