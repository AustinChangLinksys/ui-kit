import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/molecules/layout/app_list_tile.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Standard List Tile',
  type: AppListTile,
)
Widget buildAppListTile(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppListTile(
          leading: const Icon(Icons.wifi),
          title: Text(context.knobs
              .string(label: 'Title', initialValue: 'Wi-Fi Settings')),
          subtitle: Text(context.knobs
              .string(label: 'Subtitle', initialValue: 'Connected to Home_5G')),
          trailing: const Icon(Icons.chevron_right),
          selected:
              context.knobs.boolean(label: 'Selected', initialValue: false),
          onTap: () {},
        ),
        const SizedBox(height: 8),
        AppListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Security'),
          trailing: Switch(value: true, onChanged: (_) {}),
          onTap: () {},
        ),
      ],
    ),
  );
}
