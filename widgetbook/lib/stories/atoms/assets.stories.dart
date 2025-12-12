import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:ui_kit_library/ui_kit.dart';

// =============================================================================
// AppIcon Stories (Kept from original assets.stories.dart)
// =============================================================================

@widgetbook.UseCase(
  name: 'Icon Playground',
  type: AppIcon,
)
Widget buildAppIcon(BuildContext context) {
  final size = context.knobs.double.slider(
    label: 'Size',
    initialValue: 48,
    min: 16,
    max: 128,
  );

  final isCustomColor = context.knobs.boolean(
    label: 'Override Color?',
    initialValue: false,
  );

  final customColor = isCustomColor
      ? context.knobs.object.dropdown<Color>(
          label: 'Color Value',
          options: [
            Colors.blue,
            Colors.red,
            const Color(0xFF0870EA),
          ],
          labelBuilder: (value) =>
              'Color ${value.toARGB32().toRadixString(16)}',
          initialOption: Colors.blue,
        )
      : null;

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcon(
          Assets.icons.search,
          size: size,
          color: customColor,
        ),
      ],
    ),
  );
}
