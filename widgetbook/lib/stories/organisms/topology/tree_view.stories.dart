import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Creates a hierarchical sample topology with multiple levels.
MeshTopology _createHierarchicalTopology() {
  return MeshTopology(
    nodes: const [
      MeshNode(
        id: 'gateway',
        name: 'Main Gateway',
        type: MeshNodeType.gateway,
        status: MeshNodeStatus.online,
        load: 0.25,
      ),
      // Level 1 extenders
      MeshNode(
        id: 'ext-1',
        name: 'Living Room',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: MeshNodeStatus.online,
        load: 0.45,
      ),
      MeshNode(
        id: 'ext-2',
        name: 'Office',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: MeshNodeStatus.highLoad,
        load: 0.85,
      ),
      MeshNode(
        id: 'ext-3',
        name: 'Garage',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: MeshNodeStatus.offline,
        load: 0.0,
      ),
      // Level 2 extender (daisy chain)
      MeshNode(
        id: 'ext-1-1',
        name: 'Bedroom',
        type: MeshNodeType.extender,
        parentId: 'ext-1',
        status: MeshNodeStatus.online,
        load: 0.30,
      ),
      // Clients
      MeshNode(
        id: 'client-1',
        name: 'iPhone 15',
        type: MeshNodeType.client,
        parentId: 'gateway',
        status: MeshNodeStatus.online,
        deviceCategory: 'smartphone',
      ),
      MeshNode(
        id: 'client-2',
        name: 'MacBook Pro',
        type: MeshNodeType.client,
        parentId: 'ext-1',
        status: MeshNodeStatus.online,
        deviceCategory: 'laptop',
      ),
      MeshNode(
        id: 'client-3',
        name: 'Smart TV',
        type: MeshNodeType.client,
        parentId: 'ext-2',
        status: MeshNodeStatus.online,
        deviceCategory: 'tv',
      ),
      MeshNode(
        id: 'client-4',
        name: 'Gaming PC',
        type: MeshNodeType.client,
        parentId: 'ext-2',
        status: MeshNodeStatus.offline,
        deviceCategory: 'gaming',
      ),
      MeshNode(
        id: 'client-5',
        name: 'iPad',
        type: MeshNodeType.client,
        parentId: 'ext-1-1',
        status: MeshNodeStatus.online,
        deviceCategory: 'tablet',
      ),
    ],
    links: const [
      MeshLink(
          sourceId: 'gateway',
          targetId: 'ext-1',
          connectionType: ConnectionType.ethernet),
      MeshLink(
          sourceId: 'gateway',
          targetId: 'ext-2',
          connectionType: ConnectionType.wifi,
          rssi: -55),
      MeshLink(
          sourceId: 'gateway',
          targetId: 'ext-3',
          connectionType: ConnectionType.wifi,
          rssi: -80),
      MeshLink(
          sourceId: 'ext-1',
          targetId: 'ext-1-1',
          connectionType: ConnectionType.wifi,
          rssi: -60),
      MeshLink(
          sourceId: 'gateway',
          targetId: 'client-1',
          connectionType: ConnectionType.wifi,
          rssi: -45),
      MeshLink(
          sourceId: 'ext-1',
          targetId: 'client-2',
          connectionType: ConnectionType.wifi,
          rssi: -52),
      MeshLink(
          sourceId: 'ext-2',
          targetId: 'client-3',
          connectionType: ConnectionType.wifi,
          rssi: -58),
      MeshLink(
          sourceId: 'ext-2',
          targetId: 'client-4',
          connectionType: ConnectionType.wifi,
          rssi: -70),
      MeshLink(
          sourceId: 'ext-1-1',
          targetId: 'client-5',
          connectionType: ConnectionType.wifi,
          rssi: -48),
    ],
    lastUpdated: DateTime.now(),
  );
}

@widgetbook.UseCase(
  name: 'Basic Tree',
  type: TopologyTreeView,
)
Widget buildBasicTree(BuildContext context) {
  return DesignSystem.init(
    context,
    TopologyTreeView(
      topology: _createHierarchicalTopology(),
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped: $nodeId')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Context Menu',
  type: TopologyTreeView,
)
Widget buildWithContextMenu(BuildContext context) {
  return DesignSystem.init(
    context,
    TopologyTreeView(
      topology: _createHierarchicalTopology(),
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped: $nodeId')),
        );
      },
      nodeMenuBuilder: (context, node) {
        final items = <AppPopupMenuItem<String>>[
          const AppPopupMenuItem(
            value: 'details',
            label: 'View Details',
            icon: Icons.info_outline,
          ),
        ];

        if (!node.isGateway) {
          items.add(const AppPopupMenuItem(
            value: 'rename',
            label: 'Rename',
            icon: Icons.edit,
          ));
        }

        if (node.isExtender) {
          items.add(const AppPopupMenuItem(
            value: 'restart',
            label: 'Restart',
            icon: Icons.restart_alt,
          ));
        }

        if (node.isClient) {
          items.add(const AppPopupMenuItem(
            value: 'disconnect',
            label: 'Disconnect',
            icon: Icons.link_off,
          ));
        }

        return items;
      },
      onNodeMenuSelected: (nodeId, action) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Action "$action" on node: $nodeId')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Deep Hierarchy',
  type: TopologyTreeView,
)
Widget buildDeepHierarchy(BuildContext context) {
  final depth = context.knobs.int.slider(
    label: 'Depth',
    initialValue: 4,
    min: 2,
    max: 6,
  );

  // Generate deep daisy chain
  final nodes = <MeshNode>[
    const MeshNode(
      id: 'gateway',
      name: 'Gateway',
      type: MeshNodeType.gateway,
      status: MeshNodeStatus.online,
      load: 0.2,
    ),
  ];

  final links = <MeshLink>[];
  String parentId = 'gateway';

  for (var i = 1; i < depth; i++) {
    final extId = 'ext-$i';
    nodes.add(MeshNode(
      id: extId,
      name: 'Extender Level $i',
      type: MeshNodeType.extender,
      parentId: parentId,
      status: i % 3 == 0 ? MeshNodeStatus.highLoad : MeshNodeStatus.online,
      load: (i * 0.15).clamp(0.0, 0.9),
    ));
    links.add(MeshLink(
      sourceId: parentId,
      targetId: extId,
      connectionType: i == 1 ? ConnectionType.ethernet : ConnectionType.wifi,
      rssi: i == 1 ? null : -45 - (i * 5),
    ));

    // Add a client to each extender
    final clientId = 'client-$i';
    nodes.add(MeshNode(
      id: clientId,
      name: 'Device $i',
      type: MeshNodeType.client,
      parentId: extId,
      status: MeshNodeStatus.online,
      deviceCategory: ['laptop', 'smartphone', 'tablet', 'tv'][i % 4],
    ));
    links.add(MeshLink(
      sourceId: extId,
      targetId: clientId,
      connectionType: ConnectionType.wifi,
      rssi: -50 - (i * 3),
    ));

    parentId = extId;
  }

  return DesignSystem.init(
    context,
    TopologyTreeView(
      topology: MeshTopology(
        nodes: nodes,
        links: links,
        lastUpdated: DateTime.now(),
      ),
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped: $nodeId')),
        );
      },
    ),
  );
}
