import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

@UseCase(
  name: 'AppPinInput',
  type: AppPinInput,
)
Widget appPinInputUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: AppPinInput(
        length: 6,
        obscureText: context.knobs.boolean(label: 'Obscure Text'),
        errorText: context.knobs.stringOrNull(label: 'Error Text'),
        onCompleted: (pin) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PIN Entered: $pin')),
          );
        },
      ),
    ),
  );
}
