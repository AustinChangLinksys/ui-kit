import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Variants',
  type: AppSurface,
)
Widget buildAppSurfaceVariants(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Wrap(
      spacing: 24,
      runSpacing: 24,
      children: [
        _buildSurfaceDemo(context, SurfaceVariant.base, 'Base'),
        _buildSurfaceDemo(context, SurfaceVariant.elevated, 'Elevated'),
        _buildSurfaceDemo(context, SurfaceVariant.highlight, 'Highlight'),
      ],
    ),
  );
}

Widget _buildSurfaceDemo(BuildContext context, SurfaceVariant variant, String label) {
  return AppSurface(
    variant: variant,
    width: 120,
    height: 120,
    child: Center(
      child: Text(label, textAlign: TextAlign.center),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: AppSurface,
)
Widget buildAppSurfaceInteractive(BuildContext context) {
  return Center(
    child: AppSurface(
      variant: SurfaceVariant.base,
      interactive: true,
      onTap: () {},
      width: 200,
      height: 100,
      child: const Center(
        child: Text('Tap Me\n(Animates on Theme Switch)'),
      ),
    ),
  );
}
