/// Mesh Network Topology Visualization Components.
///
/// Provides widgets for visualizing mesh network topology with:
/// - Gateway, Extender, and Client device nodes
/// - Connection quality visualization
/// - Responsive view switching (Tree View for mobile, Graph View for desktop)
/// - Multiple layout algorithms (Concentric, Horizontal)
///
/// ## Quick Start
///
/// ```dart
/// import 'package:ui_kit_library/src/organisms/topology/topology.dart';
///
/// AppTopology(
///   topology: MeshTopology(
///     nodes: [
///       MeshNode(id: 'gw', name: 'Gateway', type: MeshNodeType.gateway),
///       MeshNode(id: 'ext', name: 'Extender', type: MeshNodeType.extender, parentId: 'gw'),
///     ],
///     links: [
///       MeshLink(sourceId: 'gw', targetId: 'ext', connectionType: ConnectionType.ethernet),
///     ],
///   ),
///   onNodeTap: (nodeId) => print('Tapped $nodeId'),
/// )
/// ```
///
/// ## Architecture
///
/// ```
/// topology/
/// ├── models/          # Data models (MeshNode, MeshLink, MeshTopology)
/// ├── types/           # Type definitions (NodeMenuBuilder, ClientVisibility)
/// ├── nodes/           # Node widgets (PulseNode, LiquidNode, OrbitNode)
/// ├── views/           # View widgets (GraphView, TreeView)
/// ├── layouts/         # Layout algorithms (Concentric, Horizontal)
/// ├── links/           # Link rendering
/// ├── app_topology.dart  # Main entry point widget
/// └── topology.dart    # Barrel file (this file)
/// ```
library topology;

// Main entry point
export 'app_topology.dart' show AppTopology;

// Types and enums
export 'types/topology_types.dart';

// Data models
export 'models/models.dart';

// Node widgets
export 'nodes/nodes.dart';

// View widgets
export 'views/views.dart';

// Layout algorithms
export 'layouts/layouts.dart';

// Link rendering
export 'links/links.dart';
