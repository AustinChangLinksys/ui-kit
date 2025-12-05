import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Low Load State',
  type: LiquidNode,
)
Widget buildLowLoadState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.extenderNormalStyle;
        return Center(
          child: LiquidNode(
            node: const MeshNode(
              id: 'extender-1',
              name: 'Living Room Extender',
              type: MeshNodeType.extender,
              status: MeshNodeStatus.online,
              load: 0.25,
            ),
            style: style,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Extender tapped')),
              );
            },
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Medium Load State',
  type: LiquidNode,
)
Widget buildMediumLoadState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.extenderNormalStyle;
        return Center(
          child: LiquidNode(
            node: const MeshNode(
              id: 'extender-1',
              name: 'Office Extender',
              type: MeshNodeType.extender,
              status: MeshNodeStatus.online,
              load: 0.55,
            ),
            style: style,
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'High Load State',
  type: LiquidNode,
)
Widget buildHighLoadState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.extenderHighLoadStyle;
        return Center(
          child: LiquidNode(
            node: const MeshNode(
              id: 'extender-1',
              name: 'Gaming Room Extender',
              type: MeshNodeType.extender,
              status: MeshNodeStatus.highLoad,
              load: 0.85,
            ),
            style: style,
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Offline State',
  type: LiquidNode,
)
Widget buildOfflineState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.extenderOfflineStyle;
        return Center(
          child: LiquidNode(
            node: const MeshNode(
              id: 'extender-1',
              name: 'Garage Extender',
              type: MeshNodeType.extender,
              status: MeshNodeStatus.offline,
              load: 0.0,
            ),
            style: style,
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive Load',
  type: LiquidNode,
)
Widget buildInteractiveLoad(BuildContext context) {
  final load = context.knobs.double.slider(
    label: 'Load',
    initialValue: 0.5,
    min: 0.0,
    max: 1.0,
  );

  final statusIndex = context.knobs.int.slider(
    label: 'Status (0=online, 1=highLoad, 2=offline)',
    initialValue: 0,
    min: 0,
    max: 2,
  );

  final status = MeshNodeStatus.values[statusIndex];

  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.nodeStyleFor(MeshNodeType.extender, status);
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LiquidNode(
                node: MeshNode(
                  id: 'extender-1',
                  name: 'Test Extender',
                  type: MeshNodeType.extender,
                  status: status,
                  load: load,
                ),
                style: style,
              ),
              const SizedBox(height: 16),
              AppText(
                'Load: ${(load * 100).toInt()}%',
                variant: AppTextVariant.bodySmall,
              ),
              AppText(
                'Status: ${status.name}',
                variant: AppTextVariant.bodySmall,
              ),
            ],
          ),
        );
      },
    ),
  );
}
