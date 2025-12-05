import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Idle State',
  type: OrbitNode,
)
Widget buildIdleState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.clientNormalStyle;
        return Center(
          child: OrbitNode(
            node: const MeshNode(
              id: 'client-1',
              name: 'iPhone',
              type: MeshNodeType.client,
              status: MeshNodeStatus.online,
              parentId: 'extender-1',
              deviceCategory: 'smartphone',
            ),
            style: style,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Client tapped')),
              );
            },
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Expanded State',
  type: OrbitNode,
)
Widget buildExpandedState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.clientNormalStyle;
        return Center(
          child: OrbitNode(
            node: const MeshNode(
              id: 'client-1',
              name: 'MacBook Pro',
              type: MeshNodeType.client,
              status: MeshNodeStatus.online,
              parentId: 'extender-1',
              deviceCategory: 'laptop',
            ),
            style: style,
            isExpanded: true,
            enableAnimation: false,
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Offline State',
  type: OrbitNode,
)
Widget buildOrbitOfflineState(BuildContext context) {
  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.clientOfflineStyle;
        return Center(
          child: OrbitNode(
            node: const MeshNode(
              id: 'client-1',
              name: 'Smart TV',
              type: MeshNodeType.client,
              status: MeshNodeStatus.offline,
              parentId: 'extender-1',
              deviceCategory: 'tv',
            ),
            style: style,
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Orbit Group',
  type: OrbitNodeGroup,
)
Widget buildOrbitGroup(BuildContext context) {
  final clientCount = context.knobs.int.slider(
    label: 'Client Count',
    initialValue: 5,
    min: 1,
    max: 12,
  );

  final clients = List.generate(
    clientCount,
    (i) => MeshNode(
      id: 'client-$i',
      name: 'Device $i',
      type: MeshNodeType.client,
      status: i % 4 == 0 ? MeshNodeStatus.offline : MeshNodeStatus.online,
      parentId: 'extender-1',
      deviceCategory: ['laptop', 'smartphone', 'tablet', 'tv'][i % 4],
    ),
  );

  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        return Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Center parent indicator
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: theme.topologySpec.extenderNormalStyle.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.wifi_tethering,
                    color: theme.topologySpec.extenderNormalStyle.iconColor,
                  ),
                ),
                // Orbiting clients
                OrbitNodeGroup(
                  clients: clients,
                  styleForNode: (node) => theme.topologySpec.nodeStyleFor(
                    node.type,
                    node.status,
                  ),
                  orbitRadius: 90,
                  onNodeTap: (nodeId) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped: $nodeId')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Device Categories',
  type: OrbitNode,
)
Widget buildDeviceCategories(BuildContext context) {
  final categories = [
    'laptop',
    'smartphone',
    'tablet',
    'tv',
    'gaming',
    'speaker',
    'camera',
    'iot',
  ];

  return DesignSystem.init(
    context,
    Builder(
      builder: (context) {
        final theme = Theme.of(context).extension<AppDesignTheme>()!;
        final style = theme.topologySpec.clientNormalStyle;
        return Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: categories.map((category) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrbitNode(
                    node: MeshNode(
                      id: 'client-$category',
                      name: category,
                      type: MeshNodeType.client,
                      status: MeshNodeStatus.online,
                      parentId: 'extender-1',
                      deviceCategory: category,
                    ),
                    style: style,
                    enableAnimation: false,
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    category,
                    variant: AppTextVariant.labelSmall,
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    ),
  );
}
