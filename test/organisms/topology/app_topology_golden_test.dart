import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/organisms/topology/app_topology.dart';
import 'package:ui_kit_library/src/organisms/topology/models/mesh_node.dart';
import 'package:ui_kit_library/src/organisms/topology/models/mesh_link.dart';
import 'package:ui_kit_library/src/organisms/topology/models/mesh_topology.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/topology_style.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Sample topology for testing with multi-level hierarchy.
MeshTopology _createSampleTopology() {
  return MeshTopology(
    nodes: const [
      // Level 0: Gateway
      MeshNode(
        id: 'gateway-1',
        name: 'Main Router',
        type: MeshNodeType.gateway,
        status: MeshNodeStatus.online,
        load: 0.35,
      ),
      // Level 1: Extenders connected to Gateway
      MeshNode(
        id: 'extender-1',
        name: 'Living Room',
        type: MeshNodeType.extender,
        parentId: 'gateway-1',
        status: MeshNodeStatus.online,
        load: 0.45,
      ),
      MeshNode(
        id: 'extender-2',
        name: 'Office',
        type: MeshNodeType.extender,
        parentId: 'gateway-1',
        status: MeshNodeStatus.highLoad,
        load: 0.82,
      ),
      MeshNode(
        id: 'extender-3',
        name: 'Garage',
        type: MeshNodeType.extender,
        parentId: 'gateway-1',
        status: MeshNodeStatus.offline,
        load: 0.0,
      ),
      // Level 2: Clients connected to Extenders
      MeshNode(
        id: 'client-1',
        name: 'MacBook Pro',
        type: MeshNodeType.client,
        parentId: 'extender-1',
        status: MeshNodeStatus.online,
        deviceCategory: 'laptop',
      ),
      MeshNode(
        id: 'client-2',
        name: 'Smart TV',
        type: MeshNodeType.client,
        parentId: 'extender-1',
        status: MeshNodeStatus.online,
        deviceCategory: 'tv',
      ),
      MeshNode(
        id: 'client-3',
        name: 'iPhone',
        type: MeshNodeType.client,
        parentId: 'extender-2',
        status: MeshNodeStatus.online,
        deviceCategory: 'smartphone',
      ),
      MeshNode(
        id: 'client-4',
        name: 'IoT Sensor',
        type: MeshNodeType.client,
        parentId: 'extender-3',
        status: MeshNodeStatus.offline,
        deviceCategory: 'iot',
      ),
    ],
    links: const [
      MeshLink(
        sourceId: 'gateway-1',
        targetId: 'extender-1',
        connectionType: ConnectionType.ethernet,
      ),
      MeshLink(
        sourceId: 'gateway-1',
        targetId: 'extender-2',
        connectionType: ConnectionType.wifi,
        rssi: -55,
      ),
      MeshLink(
        sourceId: 'gateway-1',
        targetId: 'extender-3',
        connectionType: ConnectionType.wifi,
        rssi: -78,
      ),
      MeshLink(
        sourceId: 'extender-1',
        targetId: 'client-1',
        connectionType: ConnectionType.wifi,
        rssi: -45,
      ),
      MeshLink(
        sourceId: 'extender-1',
        targetId: 'client-2',
        connectionType: ConnectionType.wifi,
        rssi: -50,
      ),
      MeshLink(
        sourceId: 'extender-2',
        targetId: 'client-3',
        connectionType: ConnectionType.wifi,
        rssi: -60,
      ),
      MeshLink(
        sourceId: 'extender-3',
        targetId: 'client-4',
        connectionType: ConnectionType.wifi,
        rssi: -85,
      ),
    ],
    lastUpdated: DateTime(2024, 1, 1),
  );
}

/// Large topology with many nodes for stress testing.
MeshTopology _createLargeTopology() {
  final nodes = <MeshNode>[
    const MeshNode(
      id: 'gateway',
      name: 'Gateway',
      type: MeshNodeType.gateway,
      status: MeshNodeStatus.online,
      load: 0.4,
    ),
  ];

  final links = <MeshLink>[];

  // Add 4 extenders
  for (var i = 1; i <= 4; i++) {
    nodes.add(MeshNode(
      id: 'ext-$i',
      name: 'Extender $i',
      type: MeshNodeType.extender,
      parentId: 'gateway',
      status: i == 4 ? MeshNodeStatus.offline : MeshNodeStatus.online,
      load: 0.3 + (i * 0.15),
    ));
    links.add(MeshLink(
      sourceId: 'gateway',
      targetId: 'ext-$i',
      connectionType: i == 1 ? ConnectionType.ethernet : ConnectionType.wifi,
      rssi: i == 1 ? null : -40 - (i * 10),
    ));
  }

  // Add 3 clients per extender
  var clientId = 1;
  for (var extId = 1; extId <= 4; extId++) {
    for (var c = 0; c < 3; c++) {
      final isOffline = extId == 4;
      nodes.add(MeshNode(
        id: 'client-$clientId',
        name: 'Device $clientId',
        type: MeshNodeType.client,
        parentId: 'ext-$extId',
        status: isOffline ? MeshNodeStatus.offline : MeshNodeStatus.online,
        deviceCategory: ['laptop', 'smartphone', 'tv'][c],
      ));
      links.add(MeshLink(
        sourceId: 'ext-$extId',
        targetId: 'client-$clientId',
        connectionType: ConnectionType.wifi,
        rssi: -45 - (c * 10),
      ));
      clientId++;
    }
  }

  return MeshTopology(
    nodes: nodes,
    links: links,
    lastUpdated: DateTime(2024, 1, 1),
  );
}

/// Custom content builder showing device info.
Widget _richContentBuilder(
  BuildContext context,
  MeshNode node,
  NodeStyle style,
  bool isOffline,
) {
  final textColor = isOffline ? Colors.grey : style.iconColor;
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            node.iconData ?? Icons.device_hub,
            size: style.size * 0.2,
            color: textColor,
          ),
          Text(
            node.name,
            style: TextStyle(
              fontSize: 6,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          if (node.isGateway || node.isExtender)
            Text(
              '192.168.1.${node.id.hashCode.abs() % 255}',
              style: TextStyle(fontSize: 5, color: textColor.withValues(alpha: 0.8)),
            ),
          if (node.isExtender)
            Text(
              '${(node.load * 100).toInt()}%',
              style: TextStyle(
                fontSize: 5,
                color: node.load > 0.7 ? Colors.red : Colors.green,
              ),
            ),
        ],
      ),
    ),
  );
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppTopology Golden Tests', () {
    // T047: Tree View mode with multi-level hierarchy
    goldenTest(
      'AppTopology - Tree View',
      fileName: 'app_topology_tree_view',
      builder: () => buildThemeMatrix(
        name: 'Tree View',
        width: 400,
        height: 500,
        child: AppTopology(
          topology: _createSampleTopology(),
          viewMode: TopologyViewMode.tree,
          enableAnimation: false,
        ),
      ),
    );

    // T048: Graph View mode
    goldenTest(
      'AppTopology - Graph View',
      fileName: 'app_topology_graph_view',
      builder: () => buildThemeMatrix(
        name: 'Graph View',
        width: 800,
        height: 400,
        child: AppTopology(
          topology: _createSampleTopology(),
          viewMode: TopologyViewMode.graph,
          enableAnimation: false,
        ),
      ),
    );

    // Additional: Loading state
    goldenTest(
      'AppTopology - Loading State',
      fileName: 'app_topology_loading',
      builder: () => buildThemeMatrix(
        name: 'Loading',
        width: 400,
        height: 200,
        child: const AppTopology(
          topology: null,
          enableAnimation: false,
        ),
      ),
    );

    // Additional: Empty state
    goldenTest(
      'AppTopology - Empty State',
      fileName: 'app_topology_empty',
      builder: () => buildThemeMatrix(
        name: 'Empty',
        width: 400,
        height: 200,
        child: AppTopology(
          topology: MeshTopology.empty(),
          enableAnimation: false,
        ),
      ),
    );

    // Large topology with many nodes
    goldenTest(
      'AppTopology - Large Graph',
      fileName: 'app_topology_large_graph',
      builder: () => buildThemeMatrix(
        name: 'Large Graph',
        width: 600,
        height: 500,
        child: AppTopology(
          topology: _createLargeTopology(),
          viewMode: TopologyViewMode.graph,
          enableAnimation: false,
        ),
      ),
    );

    // Custom content with rich info
    goldenTest(
      'AppTopology - Custom Content Graph',
      fileName: 'app_topology_custom_content_graph',
      builder: () => buildThemeMatrix(
        name: 'Custom Content Graph',
        width: 600,
        height: 500,
        child: AppTopology(
          topology: _createSampleTopology(),
          viewMode: TopologyViewMode.graph,
          enableAnimation: false,
          nodeContentBuilder: _richContentBuilder,
        ),
      ),
    );

    // Custom content Tree View
    goldenTest(
      'AppTopology - Custom Content Tree',
      fileName: 'app_topology_custom_content_tree',
      builder: () => buildThemeMatrix(
        name: 'Custom Content Tree',
        width: 400,
        height: 500,
        child: AppTopology(
          topology: _createSampleTopology(),
          viewMode: TopologyViewMode.tree,
          enableAnimation: false,
          nodeContentBuilder: _richContentBuilder,
        ),
      ),
    );

    // Daisy chain topology: Gateway → Ext1 → Ext2 → Ext3
    goldenTest(
      'AppTopology - Daisy Chain',
      fileName: 'app_topology_daisy_chain',
      builder: () => buildThemeMatrix(
        name: 'Daisy Chain',
        width: 700,
        height: 400,
        child: AppTopology(
          topology: _createDaisyChainTopology(),
          viewMode: TopologyViewMode.graph,
          enableAnimation: false,
          nodeContentBuilder: _richContentBuilder,
        ),
      ),
    );

    // Many clients (5 per extender) - test client positioning
    goldenTest(
      'AppTopology - Many Clients',
      fileName: 'app_topology_many_clients',
      builder: () => buildThemeMatrix(
        name: 'Many Clients',
        width: 600,
        height: 500,
        child: AppTopology(
          topology: _createManyClientsTopology(),
          viewMode: TopologyViewMode.graph,
          enableAnimation: false,
        ),
      ),
    );

    // Collapsed clients - show badge only
    goldenTest(
      'AppTopology - Collapsed Clients',
      fileName: 'app_topology_collapsed_clients',
      builder: () => buildThemeMatrix(
        name: 'Collapsed Clients',
        width: 500,
        height: 400,
        child: AppTopology(
          topology: _createManyClientsTopology(),
          viewMode: TopologyViewMode.graph,
          enableAnimation: false,
          clientVisibility: ClientVisibility.collapsed,
        ),
      ),
    );

    // Horizontal layout for daisy chain topology
    goldenTest(
      'AppTopology - Horizontal Layout',
      fileName: 'app_topology_horizontal_layout',
      builder: () => buildThemeMatrix(
        name: 'Horizontal Layout',
        width: 800,
        height: 400,
        child: AppTopology(
          topology: _createDaisyChainTopology(),
          viewMode: TopologyViewMode.graph,
          enableAnimation: false,
          layoutMode: LayoutRecommendation.horizontal,
        ),
      ),
    );

    // Horizontal layout with collapsed clients
    goldenTest(
      'AppTopology - Horizontal Collapsed',
      fileName: 'app_topology_horizontal_collapsed',
      builder: () => buildThemeMatrix(
        name: 'Horizontal Collapsed',
        width: 700,
        height: 350,
        child: AppTopology(
          topology: _createDaisyChainTopology(),
          viewMode: TopologyViewMode.graph,
          enableAnimation: false,
          layoutMode: LayoutRecommendation.horizontal,
          clientVisibility: ClientVisibility.collapsed,
        ),
      ),
    );
  });
}

/// Topology with many clients (5 per extender) to test client positioning.
MeshTopology _createManyClientsTopology() {
  final nodes = <MeshNode>[
    const MeshNode(
      id: 'gateway',
      name: 'Gateway',
      type: MeshNodeType.gateway,
      status: MeshNodeStatus.online,
      load: 0.30,
    ),
    const MeshNode(
      id: 'ext-1',
      name: 'Extender 1',
      type: MeshNodeType.extender,
      parentId: 'gateway',
      status: MeshNodeStatus.online,
      load: 0.50,
    ),
    const MeshNode(
      id: 'ext-2',
      name: 'Extender 2',
      type: MeshNodeType.extender,
      parentId: 'ext-1', // Daisy chain
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
    const MeshLink(
      sourceId: 'ext-1',
      targetId: 'ext-2',
      connectionType: ConnectionType.wifi,
      rssi: -55,
    ),
  ];

  // Add 5 clients to Extender 1
  for (var i = 1; i <= 5; i++) {
    nodes.add(MeshNode(
      id: 'ext1-client-$i',
      name: 'Device $i',
      type: MeshNodeType.client,
      parentId: 'ext-1',
      status: MeshNodeStatus.online,
      deviceCategory: ['laptop', 'smartphone', 'tv', 'tablet', 'other'][i - 1],
    ));
    links.add(MeshLink(
      sourceId: 'ext-1',
      targetId: 'ext1-client-$i',
      connectionType: ConnectionType.wifi,
      rssi: -40 - (i * 5),
    ));
  }

  // Add 5 clients to Extender 2
  for (var i = 1; i <= 5; i++) {
    nodes.add(MeshNode(
      id: 'ext2-client-$i',
      name: 'Device ${i + 5}',
      type: MeshNodeType.client,
      parentId: 'ext-2',
      status: MeshNodeStatus.online,
      deviceCategory: ['laptop', 'smartphone', 'tv', 'tablet', 'other'][i - 1],
    ));
    links.add(MeshLink(
      sourceId: 'ext-2',
      targetId: 'ext2-client-$i',
      connectionType: ConnectionType.wifi,
      rssi: -45 - (i * 5),
    ));
  }

  return MeshTopology(
    nodes: nodes,
    links: links,
    lastUpdated: DateTime(2024, 1, 1),
  );
}

/// Daisy chain topology: extenders connected in series.
/// Gateway → Ext1 → Ext2 → Ext3, each with clients.
MeshTopology _createDaisyChainTopology() {
  return MeshTopology(
    nodes: const [
      // Gateway at center
      MeshNode(
        id: 'gateway',
        name: 'Main Router',
        type: MeshNodeType.gateway,
        status: MeshNodeStatus.online,
        load: 0.25,
      ),
      // Extender 1 - directly connected to gateway
      MeshNode(
        id: 'ext-1',
        name: 'Living Room',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: MeshNodeStatus.online,
        load: 0.40,
      ),
      // Extender 2 - daisy chained to Ext1
      MeshNode(
        id: 'ext-2',
        name: 'Hallway',
        type: MeshNodeType.extender,
        parentId: 'ext-1', // Connected to Ext1, not Gateway!
        status: MeshNodeStatus.online,
        load: 0.55,
      ),
      // Extender 3 - daisy chained to Ext2
      MeshNode(
        id: 'ext-3',
        name: 'Garage',
        type: MeshNodeType.extender,
        parentId: 'ext-2', // Connected to Ext2, not Gateway!
        status: MeshNodeStatus.online,
        load: 0.30,
      ),
      // Clients for Ext1
      MeshNode(
        id: 'client-1',
        name: 'TV',
        type: MeshNodeType.client,
        parentId: 'ext-1',
        status: MeshNodeStatus.online,
        deviceCategory: 'tv',
      ),
      MeshNode(
        id: 'client-2',
        name: 'Laptop',
        type: MeshNodeType.client,
        parentId: 'ext-1',
        status: MeshNodeStatus.online,
        deviceCategory: 'laptop',
      ),
      // Clients for Ext2
      MeshNode(
        id: 'client-3',
        name: 'Phone',
        type: MeshNodeType.client,
        parentId: 'ext-2',
        status: MeshNodeStatus.online,
        deviceCategory: 'smartphone',
      ),
      // Clients for Ext3 (garage devices)
      MeshNode(
        id: 'client-4',
        name: 'Sensor',
        type: MeshNodeType.client,
        parentId: 'ext-3',
        status: MeshNodeStatus.online,
        deviceCategory: 'other',
      ),
      MeshNode(
        id: 'client-5',
        name: 'Camera',
        type: MeshNodeType.client,
        parentId: 'ext-3',
        status: MeshNodeStatus.online,
        deviceCategory: 'other',
      ),
    ],
    links: const [
      // Gateway to Ext1 (Ethernet)
      MeshLink(
        sourceId: 'gateway',
        targetId: 'ext-1',
        connectionType: ConnectionType.ethernet,
      ),
      // Ext1 to Ext2 (WiFi backhaul)
      MeshLink(
        sourceId: 'ext-1',
        targetId: 'ext-2',
        connectionType: ConnectionType.wifi,
        rssi: -55,
      ),
      // Ext2 to Ext3 (WiFi backhaul)
      MeshLink(
        sourceId: 'ext-2',
        targetId: 'ext-3',
        connectionType: ConnectionType.wifi,
        rssi: -65,
      ),
      // Client connections
      MeshLink(sourceId: 'ext-1', targetId: 'client-1', connectionType: ConnectionType.wifi, rssi: -45),
      MeshLink(sourceId: 'ext-1', targetId: 'client-2', connectionType: ConnectionType.wifi, rssi: -50),
      MeshLink(sourceId: 'ext-2', targetId: 'client-3', connectionType: ConnectionType.wifi, rssi: -55),
      MeshLink(sourceId: 'ext-3', targetId: 'client-4', connectionType: ConnectionType.wifi, rssi: -60),
      MeshLink(sourceId: 'ext-3', targetId: 'client-5', connectionType: ConnectionType.wifi, rssi: -65),
    ],
    lastUpdated: DateTime(2024, 1, 1),
  );
}
