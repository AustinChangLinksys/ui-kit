# Widget API Contracts: Mesh Network Topology View

**Feature**: 016-mesh-topology-view
**Date**: 2025-12-05
**Phase**: 1 - API Contracts

## AppTopology Widget

### Public API

```dart
/// Mesh network topology visualization component.
///
/// Automatically switches between Tree View (mobile) and Graph View (desktop)
/// based on viewport width at 600px breakpoint.
class AppTopology extends StatelessWidget {
  //============================================================
  // REQUIRED PARAMETERS
  //============================================================

  /// The mesh network data to visualize.
  ///
  /// Must contain exactly one gateway node.
  /// Supports 0-8 extenders and 0-50 clients.
  final MeshTopology topology;

  //============================================================
  // OPTIONAL CALLBACKS
  //============================================================

  /// Called when a node is tapped.
  ///
  /// Provides the tapped [MeshNode] for detail display.
  /// Works in both Tree and Graph views.
  final ValueChanged<MeshNode>? onNodeTap;

  /// Called when a node rename is requested.
  ///
  /// Tree View only. Provides the node and new name.
  /// Graph View ignores this callback.
  final void Function(MeshNode node, String newName)? onNodeRename;

  /// Called when an extender restart is requested.
  ///
  /// Tree View only. Only applicable to extender nodes.
  /// Consumer is responsible for showing confirmation dialog.
  final ValueChanged<MeshNode>? onExtenderRestart;

  //============================================================
  // OPTIONAL CONFIGURATION
  //============================================================

  /// Override automatic view mode selection.
  ///
  /// - [TopologyViewMode.auto]: Switch at 600px breakpoint (default)
  /// - [TopologyViewMode.tree]: Always show Tree View
  /// - [TopologyViewMode.graph]: Always show Graph View
  final TopologyViewMode viewMode;

  /// Whether to show loading skeleton when topology is empty.
  ///
  /// Defaults to true. Set to false to show empty state instead.
  final bool showLoadingSkeleton;

  /// Custom empty state widget.
  ///
  /// Displayed when [topology.nodes] is empty and [showLoadingSkeleton] is false.
  final Widget? emptyStateWidget;

  //============================================================
  // CONSTRUCTOR
  //============================================================

  const AppTopology({
    super.key,
    required this.topology,
    this.onNodeTap,
    this.onNodeRename,
    this.onExtenderRestart,
    this.viewMode = TopologyViewMode.auto,
    this.showLoadingSkeleton = true,
    this.emptyStateWidget,
  });
}
```

### Usage Examples

```dart
// Basic usage
AppTopology(
  topology: meshData,
  onNodeTap: (node) => showNodeDetails(context, node),
)

// With full management callbacks (Tree View)
AppTopology(
  topology: meshData,
  viewMode: TopologyViewMode.tree,
  onNodeTap: (node) => showNodeDetails(context, node),
  onNodeRename: (node, newName) => viewModel.renameDevice(node.id, newName),
  onExtenderRestart: (node) => viewModel.restartExtender(node.id),
)

// Force Graph View with custom empty state
AppTopology(
  topology: meshData,
  viewMode: TopologyViewMode.graph,
  showLoadingSkeleton: false,
  emptyStateWidget: Center(child: Text('No devices found')),
)
```

---

## PulseNode Widget (Internal)

### Public API

```dart
/// Gateway node with breathing animation.
///
/// Internal component - not exported in public API.
/// Used by [TopologyGraphView] and [TopologyTreeView].
class PulseNode extends StatefulWidget {
  /// The gateway node data.
  final MeshNode node;

  /// Visual style from theme.
  final NodeStyle style;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Animation parameters.
  final Duration breathingPeriod;

  const PulseNode({
    super.key,
    required this.node,
    required this.style,
    this.onTap,
    this.breathingPeriod = const Duration(seconds: 4),
  }) : assert(node.type == MeshNodeType.gateway);
}
```

### Animation Behavior

| Status | Breathing Period | Glow | Color |
|--------|------------------|------|-------|
| online | 4 seconds | Active | Normal |
| highLoad | 1 second | Intense | Warning |
| offline | None (static) | None | Grayscale |

---

## LiquidNode Widget (Internal)

### Public API

```dart
/// Extender node with liquid level animation.
///
/// Internal component - not exported in public API.
class LiquidNode extends StatefulWidget {
  /// The extender node data.
  final MeshNode node;

  /// Visual style from theme.
  final NodeStyle style;

  /// Tap callback.
  final VoidCallback? onTap;

  const LiquidNode({
    super.key,
    required this.node,
    required this.style,
    this.onTap,
  }) : assert(node.type == MeshNodeType.extender);
}
```

### Animation Behavior

| Load Level | Water Height | Wave Amplitude | Color |
|------------|--------------|----------------|-------|
| 0.0 - 0.3 | 30% | Low | Blue (calm) |
| 0.3 - 0.7 | 30-70% | Medium | Blue-Yellow |
| 0.7 - 1.0 | 70-100% | High + Turbulence | Orange-Red |

---

## OrbitNode Widget (Internal)

### Public API

```dart
/// Client node with orbital animation.
///
/// Internal component - not exported in public API.
class OrbitNode extends StatefulWidget {
  /// The client node data.
  final MeshNode node;

  /// Visual style from theme.
  final NodeStyle style;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Current orbit angle (0.0 to 2*pi).
  /// Controlled by parent [TopologyGraphView].
  final double orbitAngle;

  /// Radius of orbit around parent node.
  final double orbitRadius;

  /// Whether orbit is paused (e.g., on hover).
  final bool isPaused;

  /// Whether details are expanded (hover state).
  final bool isExpanded;

  const OrbitNode({
    super.key,
    required this.node,
    required this.style,
    this.onTap,
    required this.orbitAngle,
    required this.orbitRadius,
    this.isPaused = false,
    this.isExpanded = false,
  }) : assert(node.type == MeshNodeType.client);
}
```

---

## TopologyTreeView Widget (Internal)

### Public API

```dart
/// Tree view for mobile topology display.
///
/// Internal component - not exported in public API.
class TopologyTreeView extends StatelessWidget {
  /// The mesh network data.
  final MeshTopology topology;

  /// Spec from theme.
  final TopologySpec spec;

  /// Callbacks passed through from AppTopology.
  final ValueChanged<MeshNode>? onNodeTap;
  final void Function(MeshNode, String)? onNodeRename;
  final ValueChanged<MeshNode>? onExtenderRestart;

  const TopologyTreeView({
    super.key,
    required this.topology,
    required this.spec,
    this.onNodeTap,
    this.onNodeRename,
    this.onExtenderRestart,
  });
}
```

---

## TopologyGraphView Widget (Internal)

### Public API

```dart
/// Graph view for desktop topology display.
///
/// Internal component - not exported in public API.
class TopologyGraphView extends StatefulWidget {
  /// The mesh network data.
  final MeshTopology topology;

  /// Spec from theme.
  final TopologySpec spec;

  /// Tap callback.
  final ValueChanged<MeshNode>? onNodeTap;

  const TopologyGraphView({
    super.key,
    required this.topology,
    required this.spec,
    this.onNodeTap,
  });
}
```

### Interaction Behavior

| Gesture | Action |
|---------|--------|
| Tap node | Call onNodeTap |
| Pan | Move viewport |
| Pinch | Zoom (0.5x - 3.0x) |
| Hover client | Pause orbit, expand details |
| Mouse wheel | Zoom in/out |

---

## TreeNodeCard Widget (Internal)

### Public API

```dart
/// Device card for Tree View.
///
/// Internal component - not exported in public API.
class TreeNodeCard extends StatelessWidget {
  /// The node to display.
  final MeshNode node;

  /// Depth in hierarchy (for indentation).
  final int depth;

  /// Whether this is the last sibling (affects guide lines).
  final bool isLast;

  /// Callbacks.
  final VoidCallback? onTap;
  final ValueChanged<String>? onRename;
  final VoidCallback? onRestart;

  const TreeNodeCard({
    super.key,
    required this.node,
    required this.depth,
    required this.isLast,
    this.onTap,
    this.onRename,
    this.onRestart,
  });
}
```

---

## NodeBuilder Interface

### Contract

```dart
/// Abstract interface for node builders.
///
/// Implementers:
/// - [PulseNodeBuilder]
/// - [LiquidNodeBuilder]
/// - [OrbitNodeBuilder]
abstract class NodeBuilder {
  /// Build the node widget.
  ///
  /// [context] - BuildContext for theme access
  /// [node] - The mesh node data
  /// [style] - Visual style from TopologySpec
  /// [onTap] - Optional tap callback
  Widget build(
    BuildContext context,
    MeshNode node,
    NodeStyle style, {
    VoidCallback? onTap,
  });
}
```

### Registry

```dart
/// Node builder registry.
///
/// Maps node types to their builders.
/// Used by TopologyNodeRenderer.
final Map<MeshNodeType, NodeBuilder> nodeBuilders = {
  MeshNodeType.gateway: PulseNodeBuilder(),
  MeshNodeType.extender: LiquidNodeBuilder(),
  MeshNodeType.client: OrbitNodeBuilder(),
};
```

---

## TopologyNodeRenderer Widget (Internal)

### Public API

```dart
/// Coordinator that selects appropriate NodeBuilder based on node type.
///
/// Uses strategy map pattern to avoid runtime type checks (Constitution 6.1).
/// Internal component - not exported in public API.
class TopologyNodeRenderer extends StatelessWidget {
  /// The node to render.
  final MeshNode node;

  /// Visual style from TopologySpec (resolved by caller based on node type/status).
  final NodeStyle style;

  /// Callback when node is tapped.
  final VoidCallback? onTap;

  /// Additional parameters for orbit nodes.
  final double? orbitAngle;
  final double? orbitRadius;
  final bool isPaused;
  final bool isExpanded;

  const TopologyNodeRenderer({
    super.key,
    required this.node,
    required this.style,
    this.onTap,
    this.orbitAngle,
    this.orbitRadius,
    this.isPaused = false,
    this.isExpanded = false,
  });
}
```

### Behavior

The renderer delegates to the appropriate `NodeBuilder` based on `node.type`:

| Node Type | Builder | Widget |
|-----------|---------|--------|
| gateway | PulseNodeBuilder | PulseNode |
| extender | LiquidNodeBuilder | LiquidNode |
| client | OrbitNodeBuilder | OrbitNode |

---

## Accessibility Contract

### Semantics Requirements

| Component | Semantic Label | Value | Actions |
|-----------|----------------|-------|---------|
| PulseNode | "Gateway {name}" | "{status}" | tap |
| LiquidNode | "Extender {name}" | "{load}% load, {status}" | tap |
| OrbitNode | "Device {name}" | "{status}" | tap |
| TreeNodeCard | "{name}" | "{type}, {status}" | tap, rename, restart |

### Touch Targets

All interactive elements must meet minimum touch target sizes:
- iOS: 44x44 logical pixels
- Android: 48x48 logical pixels

### Motion Preferences

```dart
// Check reduced motion preference
final reduceMotion = MediaQuery.of(context).disableAnimations;

// Disable animations if preferred
if (reduceMotion) {
  return StaticNode(node: node, style: style);
}
return AnimatedNode(node: node, style: style);
```
