import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Normal State',
  type: PulseNode,
)
Widget buildNormalState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.gatewayNormalStyle;
        return Center(
          child: PulseNode(
            node: const MeshNode(
              id: 'gateway-1',
              name: 'Main Router',
              type: MeshNodeType.gateway,
              status: MeshNodeStatus.online,
              load: 0.3,
            ),
            style: style,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gateway tapped')),
              );
            },
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'High Load State',
  type: PulseNode,
)
Widget buildHighLoadState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.gatewayHighLoadStyle;
        return Center(
          child: PulseNode(
            node: const MeshNode(
              id: 'gateway-1',
              name: 'Main Router',
              type: MeshNodeType.gateway,
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
  type: PulseNode,
)
Widget buildOfflineState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.gatewayOfflineStyle;
        return Center(
          child: PulseNode(
            node: const MeshNode(
              id: 'gateway-1',
              name: 'Main Router',
              type: MeshNodeType.gateway,
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
  type: PulseNode,
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
        final style = theme.topologySpec.nodeStyleFor(MeshNodeType.gateway, status);
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PulseNode(
                node: MeshNode(
                  id: 'gateway-1',
                  name: 'Main Router',
                  type: MeshNodeType.gateway,
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
