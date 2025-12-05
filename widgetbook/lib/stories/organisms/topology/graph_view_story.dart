import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Creates a star topology (all extenders connected to gateway).
MeshTopology _createStarTopology() {
  return MeshTopology(
    nodes: const [
      MeshNode(
        id: 'gateway',
        name: 'Main Gateway',
        type: MeshNodeType.gateway,
        status: MeshNodeStatus.online,
        load: 0.30,
      ),
      MeshNode(
        id: 'ext-1',
        name: 'Living Room',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: MeshNodeStatus.online,
        load: 0.40,
      ),
      MeshNode(
        id: 'ext-2',
        name: 'Office',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: MeshNodeStatus.highLoad,
        load: 0.82,
      ),
      MeshNode(
        id: 'ext-3',
        name: 'Bedroom',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: MeshNodeStatus.online,
        load: 0.25,
      ),
      MeshNode(
        id: 'ext-4',
        name: 'Garage',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: MeshNodeStatus.offline,
        load: 0.0,
      ),
      // Clients
      MeshNode(id: 'c1', name: 'iPhone', type: MeshNodeType.client, parentId: 'ext-1', status: MeshNodeStatus.online, deviceCategory: 'smartphone'),
      MeshNode(id: 'c2', name: 'MacBook', type: MeshNodeType.client, parentId: 'ext-1', status: MeshNodeStatus.online, deviceCategory: 'laptop'),
      MeshNode(id: 'c3', name: 'iMac', type: MeshNodeType.client, parentId: 'ext-2', status: MeshNodeStatus.online, deviceCategory: 'laptop'),
      MeshNode(id: 'c4', name: 'Smart TV', type: MeshNodeType.client, parentId: 'ext-3', status: MeshNodeStatus.online, deviceCategory: 'tv'),
    ],
    links: const [
      MeshLink(sourceId: 'gateway', targetId: 'ext-1', connectionType: ConnectionType.ethernet),
      MeshLink(sourceId: 'gateway', targetId: 'ext-2', connectionType: ConnectionType.wifi, rssi: -52),
      MeshLink(sourceId: 'gateway', targetId: 'ext-3', connectionType: ConnectionType.wifi, rssi: -60),
      MeshLink(sourceId: 'gateway', targetId: 'ext-4', connectionType: ConnectionType.wifi, rssi: -78),
      MeshLink(sourceId: 'ext-1', targetId: 'c1', connectionType: ConnectionType.wifi, rssi: -45),
      MeshLink(sourceId: 'ext-1', targetId: 'c2', connectionType: ConnectionType.wifi, rssi: -50),
      MeshLink(sourceId: 'ext-2', targetId: 'c3', connectionType: ConnectionType.wifi, rssi: -55),
      MeshLink(sourceId: 'ext-3', targetId: 'c4', connectionType: ConnectionType.wifi, rssi: -48),
    ],
    lastUpdated: DateTime.now(),
  );
}

/// Creates a daisy chain topology.
MeshTopology _createDaisyChainTopology() {
  return MeshTopology(
    nodes: const [
      MeshNode(id: 'gateway', name: 'Gateway', type: MeshNodeType.gateway, status: MeshNodeStatus.online, load: 0.25),
      MeshNode(id: 'ext-1', name: 'Ext 1', type: MeshNodeType.extender, parentId: 'gateway', status: MeshNodeStatus.online, load: 0.35),
      MeshNode(id: 'ext-2', name: 'Ext 2', type: MeshNodeType.extender, parentId: 'ext-1', status: MeshNodeStatus.online, load: 0.45),
      MeshNode(id: 'ext-3', name: 'Ext 3', type: MeshNodeType.extender, parentId: 'ext-2', status: MeshNodeStatus.highLoad, load: 0.80),
      MeshNode(id: 'c1', name: 'Laptop', type: MeshNodeType.client, parentId: 'ext-1', status: MeshNodeStatus.online, deviceCategory: 'laptop'),
      MeshNode(id: 'c2', name: 'Phone', type: MeshNodeType.client, parentId: 'ext-2', status: MeshNodeStatus.online, deviceCategory: 'smartphone'),
      MeshNode(id: 'c3', name: 'TV', type: MeshNodeType.client, parentId: 'ext-3', status: MeshNodeStatus.online, deviceCategory: 'tv'),
    ],
    links: const [
      MeshLink(sourceId: 'gateway', targetId: 'ext-1', connectionType: ConnectionType.ethernet),
      MeshLink(sourceId: 'ext-1', targetId: 'ext-2', connectionType: ConnectionType.wifi, rssi: -55),
      MeshLink(sourceId: 'ext-2', targetId: 'ext-3', connectionType: ConnectionType.wifi, rssi: -65),
      MeshLink(sourceId: 'ext-1', targetId: 'c1', connectionType: ConnectionType.wifi, rssi: -48),
      MeshLink(sourceId: 'ext-2', targetId: 'c2', connectionType: ConnectionType.wifi, rssi: -52),
      MeshLink(sourceId: 'ext-3', targetId: 'c3', connectionType: ConnectionType.wifi, rssi: -58),
    ],
    lastUpdated: DateTime.now(),
  );
}

@widgetbook.UseCase(
  name: 'Star Topology (Concentric)',
  type: TopologyGraphView,
)
Widget buildStarTopology(BuildContext context) {
  return DesignSystem.init(
    context,
    TopologyGraphView(
      topology: _createStarTopology(),
      layoutMode: LayoutRecommendation.concentric,
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped: $nodeId')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Daisy Chain (Horizontal)',
  type: TopologyGraphView,
)
Widget buildDaisyChain(BuildContext context) {
  return DesignSystem.init(
    context,
    TopologyGraphView(
      topology: _createDaisyChainTopology(),
      layoutMode: LayoutRecommendation.horizontal,
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped: $nodeId')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Auto Layout Detection',
  type: TopologyGraphView,
)
Widget buildAutoLayout(BuildContext context) {
  final useDaisyChain = context.knobs.boolean(
    label: 'Use Daisy Chain Topology',
    initialValue: false,
  );

  final topology = useDaisyChain ? _createDaisyChainTopology() : _createStarTopology();

  return DesignSystem.init(
    context,
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText(
            useDaisyChain
                ? 'Daisy Chain → Horizontal Layout'
                : 'Star → Concentric Layout',
            variant: AppTextVariant.bodySmall,
          ),
        ),
        Expanded(
          child: TopologyGraphView(
            topology: topology,
            layoutMode: LayoutRecommendation.auto,
            onNodeTap: (nodeId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped: $nodeId')),
              );
            },
          ),
        ),
      ],
    ),
  );
}

/// Creates a topology with many clients for clustered mode demo.
MeshTopology _createManyClientsTopology() {
  final nodes = <MeshNode>[
    const MeshNode(
      id: 'gateway',
      name: 'Main Gateway',
      type: MeshNodeType.gateway,
      status: MeshNodeStatus.online,
      load: 0.30,
    ),
    const MeshNode(
      id: 'ext-1',
      name: 'Living Room',
      type: MeshNodeType.extender,
      parentId: 'gateway',
      status: MeshNodeStatus.online,
      load: 0.40,
    ),
  ];

  final links = <MeshLink>[
    const MeshLink(
      sourceId: 'gateway',
      targetId: 'ext-1',
      connectionType: ConnectionType.ethernet,
    ),
  ];

  // Add 25 clients to extender (exceeds default threshold of 20)
  final categories = ['smartphone', 'laptop', 'tablet', 'tv', 'iot'];
  for (var i = 0; i < 25; i++) {
    nodes.add(MeshNode(
      id: 'client-$i',
      name: 'Device $i',
      type: MeshNodeType.client,
      parentId: 'ext-1',
      status: MeshNodeStatus.online,
      deviceCategory: categories[i % 5],
    ));
    links.add(MeshLink(
      sourceId: 'ext-1',
      targetId: 'client-$i',
      connectionType: ConnectionType.wifi,
      rssi: -50 - (i % 20),
    ));
  }

  return MeshTopology(
    nodes: nodes,
    links: links,
    lastUpdated: DateTime.now(),
  );
}

@widgetbook.UseCase(
  name: 'Client Visibility Modes',
  type: TopologyGraphView,
)
Widget buildClientVisibility(BuildContext context) {
  final visibilityIndex = context.knobs.int.slider(
    label: 'Visibility (0=always, 1=onHover, 2=collapsed, 3=clustered)',
    initialValue: 0,
    min: 0,
    max: 3,
  );

  final visibility = ClientVisibility.values[visibilityIndex];

  // Use topology with many clients for clustered mode demo
  final topology = visibility == ClientVisibility.clustered
      ? _createManyClientsTopology()
      : _createStarTopology();

  return DesignSystem.init(
    context,
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText(
            'Client Visibility: ${visibility.name}',
            variant: AppTextVariant.bodySmall,
          ),
        ),
        Expanded(
          child: TopologyGraphView(
            topology: topology,
            clientVisibility: visibility,
            onNodeTap: (nodeId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped: $nodeId')),
              );
            },
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Context Menu',
  type: TopologyGraphView,
)
Widget buildWithMenu(BuildContext context) {
  return DesignSystem.init(
    context,
    TopologyGraphView(
      topology: _createStarTopology(),
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped: $nodeId')),
        );
      },
      nodeMenuBuilder: (context, node) {
        return [
          const AppPopupMenuItem(value: 'details', label: 'Details', icon: Icons.info),
          if (node.isExtender)
            const AppPopupMenuItem(value: 'restart', label: 'Restart', icon: Icons.restart_alt),
          if (node.isClient)
            const AppPopupMenuItem(value: 'disconnect', label: 'Disconnect', icon: Icons.link_off),
        ];
      },
      onNodeMenuSelected: (nodeId, action) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$action on $nodeId')),
        );
      },
    ),
  );
}
