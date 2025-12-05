import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

@UseCase(name: 'Divider', type: AppDivider)
Widget buildDividerUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      children: [
        AppText.bodyLarge('Horizontal Divider'),
        const SizedBox(height: 8),
        const AppDivider(),
        const SizedBox(height: 24),
        AppText.bodyLarge('Vertical Divider (Height 50)'),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.bodyMedium('Left'),
              const AppDivider(axis: Axis.vertical),
              AppText.bodyMedium('Right'),
            ],
          ),
        ),
      ],
    ),
  );
}
