# Quickstart Guide: Mesh Network Topology View

**Feature**: 016-mesh-topology-view
**Date**: 2025-12-05
**Phase**: 1 - Usage Guide

## Overview

The Mesh Network Topology View transforms network device management into an intuitive visual experience. Users can instantly understand network health through organic animations without reading technical data.

## Installation

The component is part of the UI Kit library. Use one of the built-in theme factories:

```dart
// In your theme configuration - use AppTheme.create with a design theme
final theme = AppTheme.create(
  brightness: Brightness.light,
  designThemeBuilder: (scheme) => GlassDesignTheme.light(scheme),
);

// Use in MaterialApp
MaterialApp(
  theme: theme,
  home: MyApp(),
)
```

## Basic Usage

### Minimal Example

```dart
import 'package:ui_kit_library/ui_kit.dart';

class NetworkScreen extends StatelessWidget {
  final MeshTopology topology;

  const NetworkScreen({super.key, required this.topology});

  @override
  Widget build(BuildContext context) {
    return AppTopology(
      topology: topology,
      onNodeTap: (nodeId) {
        final node = topology.nodeById(nodeId);
        if (node != null) {
          showModalBottomSheet(
            context: context,
            builder: (_) => DeviceDetailSheet(node: node),
          );
        }
      },
    );
  }
}
```

### Creating Topology Data

```dart
// Create a sample mesh network
final sampleTopology = MeshTopology(
  nodes: [
    // Gateway (root)
    MeshNode(
      id: 'gateway-1',
      name: 'Main Router',
      type: MeshNodeType.gateway,
      status: MeshNodeStatus.online,
      load: 0.3,
    ),
    // Extenders
    MeshNode(
      id: 'extender-1',
      name: 'Living Room',
      type: MeshNodeType.extender,
      status: MeshNodeStatus.online,
      parentId: 'gateway-1',
      load: 0.6,
    ),
    MeshNode(
      id: 'extender-2',
      name: 'Bedroom',
      type: MeshNodeType.extender,
      status: MeshNodeStatus.highLoad,
      parentId: 'gateway-1',
      load: 0.85,
    ),
    // Clients
    MeshNode(
      id: 'client-1',
      name: 'iPhone',
      type: MeshNodeType.client,
      status: MeshNodeStatus.online,
      parentId: 'extender-1',
      deviceCategory: 'smartphone',
      iconData: Icons.phone_iphone,
    ),
    MeshNode(
      id: 'client-2',
      name: 'MacBook',
      type: MeshNodeType.client,
      status: MeshNodeStatus.online,
      parentId: 'extender-1',
      deviceCategory: 'laptop',
      iconData: Icons.laptop_mac,
    ),
    MeshNode(
      id: 'client-3',
      name: 'Smart TV',
      type: MeshNodeType.client,
      status: MeshNodeStatus.offline,
      parentId: 'extender-2',
      deviceCategory: 'entertainment',
      iconData: Icons.tv,
    ),
  ],
  links: [
    // Gateway to Extenders
    MeshLink(
      sourceId: 'gateway-1',
      targetId: 'extender-1',
      connectionType: ConnectionType.ethernet,
    ),
    MeshLink(
      sourceId: 'gateway-1',
      targetId: 'extender-2',
      connectionType: ConnectionType.wifi,
      rssi: -55,  // Medium signal
      throughput: 450.0,
    ),
    // Extenders to Clients
    MeshLink(
      sourceId: 'extender-1',
      targetId: 'client-1',
      connectionType: ConnectionType.wifi,
      rssi: -45,  // Strong signal
      throughput: 800.0,
    ),
    MeshLink(
      sourceId: 'extender-1',
      targetId: 'client-2',
      connectionType: ConnectionType.wifi,
      rssi: -48,  // Strong signal
      throughput: 650.0,
    ),
    MeshLink(
      sourceId: 'extender-2',
      targetId: 'client-3',
      connectionType: ConnectionType.wifi,
      rssi: -75,  // Weak signal
      throughput: 50.0,
    ),
  ],
  lastUpdated: DateTime.now(),
);
```

## Full-Featured Example

### With Device Management (Tree View)

```dart
class NetworkManagementScreen extends StatefulWidget {
  const NetworkManagementScreen({super.key});

  @override
  State<NetworkManagementScreen> createState() => _NetworkManagementScreenState();
}

class _NetworkManagementScreenState extends State<NetworkManagementScreen> {
  MeshTopology? _topology;

  @override
  void initState() {
    super.initState();
    _loadTopology();
  }

  Future<void> _loadTopology() async {
    // Fetch from your API
    final data = await networkApi.getTopology();
    setState(() {
      _topology = data;
    });
  }

  Future<void> _handleMenuAction(String nodeId, String action) async {
    final node = _topology?.nodeById(nodeId);
    if (node == null) return;

    switch (action) {
      case 'rename':
        await _showRenameDialog(node);
      case 'restart':
        await _handleRestart(node);
      case 'details':
        _showNodeDetails(node);
    }
  }

  Future<void> _showRenameDialog(MeshNode node) async {
    // Show rename dialog and handle rename
    final newName = await showDialog<String>(
      context: context,
      builder: (_) => RenameDialog(currentName: node.name),
    );
    if (newName != null) {
      await networkApi.renameDevice(node.id, newName);
      await _loadTopology();
    }
  }

  Future<void> _handleRestart(MeshNode node) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AppDialog(
        title: 'Restart ${node.name}?',
        content: 'This will temporarily disconnect all devices connected to this extender.',
        actions: [
          AppButton(
            label: 'Cancel',
            onPressed: () => Navigator.pop(context, false),
          ),
          AppButton(
            label: 'Restart',
            variant: ButtonVariant.primary,
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await networkApi.restartExtender(node.id);
      await _loadTopology();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network')),
      body: AppTopology(
        topology: _topology,  // null shows loading state
        onNodeTap: (nodeId) {
          final node = _topology?.nodeById(nodeId);
          if (node != null) _showNodeDetails(node);
        },
        nodeMenuBuilder: (context, node) {
          return [
            AppPopupMenuItem(value: 'details', label: 'Details', icon: Icons.info),
            if (!node.isGateway)
              AppPopupMenuItem(value: 'rename', label: 'Rename', icon: Icons.edit),
            if (node.isExtender)
              AppPopupMenuItem(value: 'restart', label: 'Restart', icon: Icons.restart_alt),
          ];
        },
        onNodeMenuSelected: _handleMenuAction,
      ),
    );
  }

  void _showNodeDetails(MeshNode node) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        builder: (_, controller) => DeviceDetailsSheet(
          node: node,
          scrollController: controller,
        ),
      ),
    );
  }
}
```

### Forced View Mode

```dart
// Always show Graph View (e.g., for dashboard)
AppTopology(
  topology: topology,
  viewMode: TopologyViewMode.graph,
  onNodeTap: (nodeId) => handleNodeTap(nodeId),
)

// Always show Tree View (e.g., for management screen)
AppTopology(
  topology: topology,
  viewMode: TopologyViewMode.tree,
  onNodeTap: (nodeId) => handleNodeTap(nodeId),
  nodeMenuBuilder: (context, node) => [
    AppPopupMenuItem(value: 'details', label: 'Details', icon: Icons.info),
    if (node.isExtender)
      AppPopupMenuItem(value: 'restart', label: 'Restart', icon: Icons.restart_alt),
  ],
  onNodeMenuSelected: handleMenuAction,
)
```

## Visual States

### Node Status Mapping

| Status | Gateway (Pulse) | Extender (Liquid) | Client (Orbit) |
|--------|-----------------|-------------------|----------------|
| online | Slow breathing, cyan glow | Low water, blue | Normal orbit |
| highLoad | Fast breathing, orange glow | High water, red turbulent | N/A |
| offline | No animation, gray | Empty, gray | Gray, continues orbit |

### Link Visual Mapping

```dart
// The component automatically maps RSSI to colors:
// > -50 dBm  → Green (strong)
// -50 to -70 → Yellow (medium)
// < -70 dBm  → Red (weak)
// null       → Gray (unknown)

// Ethernet links are always solid (no signal quality)
```

## Handling Edge Cases

### Loading State

```dart
// Pass null topology to show loading skeleton
AppTopology(
  topology: null,  // Shows loading indicator automatically
)
```

### Empty Network State

```dart
// When topology has no nodes, shows empty state
AppTopology(
  topology: MeshTopology.empty(),  // Shows default empty state
)
```

### Custom Empty State

```dart
AppTopology(
  topology: emptyTopology,
  emptyStateWidget: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.wifi_off, size: 64),
      SizedBox(height: 16),
      Text('No network devices found'),
      SizedBox(height: 8),
      AppButton(
        label: 'Refresh',
        onPressed: _loadTopology,
      ),
    ],
  ),
)
```

### Large Networks (50+ Clients)

Clients are automatically clustered when count exceeds threshold (default: 20):

```dart
// Clusters show count badge and expand on tap
// No configuration needed - handled automatically
```

## Testing Tips

### Golden Tests

```dart
void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  goldenTest(
    'AppTopology - Graph View Normal',
    fileName: 'app_topology_graph_normal',
    builder: () => buildThemeMatrix(
      name: 'Graph Normal',
      width: 600.0,
      height: 400.0,
      child: TickerMode(
        enabled: false,  // Freeze animations
        child: AppTopology(
          topology: sampleTopology,
          viewMode: TopologyViewMode.graph,
        ),
      ),
    ),
  );
}
```

### Widget Tests

```dart
testWidgets('AppTopology switches view at 600px', (tester) async {
  // Start with mobile width
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1.0;

  final theme = AppTheme.create(
    brightness: Brightness.light,
    designThemeBuilder: (s) => FlatDesignTheme.light(s),
  );

  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Scaffold(
        body: AppTopology(topology: sampleTopology),
      ),
    ),
  );

  expect(find.byType(TopologyTreeView), findsOneWidget);
  expect(find.byType(TopologyGraphView), findsNothing);

  // Resize to desktop
  tester.view.physicalSize = const Size(800, 600);
  await tester.pumpAndSettle();

  expect(find.byType(TopologyTreeView), findsNothing);
  expect(find.byType(TopologyGraphView), findsOneWidget);
});
```

## Accessibility

The component includes built-in accessibility support:

```dart
// Semantic labels are automatically applied:
// "Gateway Main Router, online"
// "Extender Living Room, 60% load, online"
// "Device iPhone, online"

// Touch targets meet minimum size requirements (44x44 iOS, 48x48 Android)

// Reduced motion is respected:
// Set MediaQuery.disableAnimations to true for static rendering
```

## Troubleshooting

### Theme Not Found Error

```
FlutterError: AppDesignTheme not found in context
```

**Solution**: Use one of the built-in theme factories that include all required specs:

```dart
final theme = AppTheme.create(
  brightness: Brightness.light,
  designThemeBuilder: (scheme) => FlatDesignTheme.light(scheme),
  // or GlassDesignTheme.light(scheme)
  // or BrutalDesignTheme.light(scheme)
  // or NeumorphicDesignTheme.light(scheme)
  // or PixelDesignTheme.light(scheme)
);

MaterialApp(
  theme: theme,
  home: MyApp(),
)
```

### Animations Causing Test Timeout

**Solution**: Wrap in `TickerMode(enabled: false)`:

```dart
TickerMode(
  enabled: false,
  child: AppTopology(topology: topology),
)
```

### Pan/Zoom Not Working

**Solution**: Ensure the parent allows unbounded height or provide constraints:

```dart
SizedBox(
  height: 400,
  child: AppTopology(
    topology: topology,
    viewMode: TopologyViewMode.graph,
  ),
)
```
