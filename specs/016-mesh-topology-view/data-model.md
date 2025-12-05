# Data Model: Mesh Network Topology View

**Feature**: 016-mesh-topology-view
**Date**: 2025-12-05
**Phase**: 1 - Entity Definitions

## Entity Relationship Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                          MeshTopology                                │
│  ┌─────────────────┐    ┌─────────────────┐    ┌────────────────┐  │
│  │   List<MeshNode> │    │  List<MeshLink>  │    │  DateTime      │  │
│  │      nodes       │    │     links        │    │  lastUpdated   │  │
│  └────────┬────────┘    └────────┬────────┘    └────────────────┘  │
└───────────┼─────────────────────┼───────────────────────────────────┘
            │                      │
            ▼                      ▼
┌───────────────────────┐    ┌───────────────────────┐
│      MeshNode          │    │      MeshLink          │
├───────────────────────┤    ├───────────────────────┤
│ + id: String           │◄───┤ + sourceId: String     │
│ + name: String         │    │ + targetId: String     │
│ + type: MeshNodeType   │    │ + type: ConnectionType │
│ + status: NodeStatus   │    │ + rssi: int?           │
│ + parentId: String?    │    │ + throughput: double?  │
│ + load: double         │    └───────────────────────┘
│ + iconData: IconData?  │
│ + deviceCategory: Str? │
└───────────────────────┘

┌───────────────────────┐    ┌───────────────────────┐
│    MeshNodeType        │    │    ConnectionType      │
├───────────────────────┤    ├───────────────────────┤
│ • gateway              │    │ • ethernet             │
│ • extender             │    │ • wifi                 │
│ • client               │    └───────────────────────┘
└───────────────────────┘

┌───────────────────────┐
│    MeshNodeStatus      │
├───────────────────────┤
│ • online               │
│ • offline              │
│ • highLoad             │
└───────────────────────┘
```

## Core Entities

### MeshNode

Represents any device in the mesh network topology.

```dart
/// A device in the mesh network topology.
///
/// Supports three node types:
/// - [MeshNodeType.gateway]: The primary router (breathing animation)
/// - [MeshNodeType.extender]: Range extenders (liquid level animation)
/// - [MeshNodeType.client]: Connected devices (orbit animation)
@immutable
class MeshNode extends Equatable {
  /// Unique identifier for this node.
  final String id;

  /// Display name for the device.
  final String name;

  /// The type of node determining visual representation.
  final MeshNodeType type;

  /// Current operational status affecting animation behavior.
  final MeshNodeStatus status;

  /// Parent node ID for hierarchy. Null for gateway.
  final String? parentId;

  /// Current load percentage (0.0 to 1.0).
  /// Used by extenders for liquid level visualization.
  final double load;

  /// Optional icon for the device.
  final IconData? iconData;

  /// Device category for clustering (e.g., "smartphone", "laptop", "iot").
  final String? deviceCategory;

  const MeshNode({
    required this.id,
    required this.name,
    required this.type,
    this.status = MeshNodeStatus.online,
    this.parentId,
    this.load = 0.0,
    this.iconData,
    this.deviceCategory,
  });

  /// Whether this node is the root gateway.
  bool get isGateway => type == MeshNodeType.gateway;

  /// Whether this node has high load (> 70%).
  bool get isHighLoad => load > 0.7;

  @override
  List<Object?> get props => [
    id, name, type, status, parentId, load, iconData, deviceCategory
  ];
}
```

### MeshNodeType

```dart
/// Classification of mesh network nodes.
enum MeshNodeType {
  /// Primary router - rendered as PulseNode with breathing animation.
  gateway,

  /// Range extender - rendered as LiquidNode with water level animation.
  extender,

  /// Connected device - rendered as OrbitNode with satellite animation.
  client,
}
```

### MeshNodeStatus

```dart
/// Operational status of a mesh node.
enum MeshNodeStatus {
  /// Normal operation - calm animations, full color.
  online,

  /// Device unreachable - stopped animations, grayscale.
  offline,

  /// High utilization - faster animations, warning colors.
  highLoad,
}
```

### MeshLink

Represents a connection between two nodes.

```dart
/// A connection between two mesh nodes.
@immutable
class MeshLink extends Equatable {
  /// ID of the source node (typically parent).
  final String sourceId;

  /// ID of the target node (typically child).
  final String targetId;

  /// Physical connection type.
  final ConnectionType connectionType;

  /// Signal strength in dBm (WiFi only). Null if unavailable.
  /// - > -50: Strong (green)
  /// - -50 to -70: Medium (yellow)
  /// - < -70: Weak (red)
  final int? rssi;

  /// Current throughput in Mbps. Null if unavailable.
  /// Affects flow animation speed for WiFi links.
  final double? throughput;

  const MeshLink({
    required this.sourceId,
    required this.targetId,
    required this.connectionType,
    this.rssi,
    this.throughput,
  });

  /// Signal quality classification based on RSSI.
  SignalQuality get signalQuality {
    if (connectionType == ConnectionType.ethernet) {
      return SignalQuality.wired;
    }
    if (rssi == null) return SignalQuality.unknown;
    if (rssi! > -50) return SignalQuality.strong;
    if (rssi! >= -70) return SignalQuality.medium;
    return SignalQuality.weak;
  }

  @override
  List<Object?> get props => [sourceId, targetId, connectionType, rssi, throughput];
}
```

### ConnectionType

```dart
/// Physical connection type between nodes.
enum ConnectionType {
  /// Wired connection - solid line, no signal quality.
  ethernet,

  /// Wireless connection - dashed line with flow animation.
  wifi,
}
```

### SignalQuality

```dart
/// Derived signal quality from RSSI values.
enum SignalQuality {
  /// Wired connection (Ethernet) - not applicable.
  wired,

  /// RSSI > -50 dBm.
  strong,

  /// RSSI -50 to -70 dBm.
  medium,

  /// RSSI < -70 dBm.
  weak,

  /// RSSI data unavailable.
  unknown,
}
```

### MeshTopology

Container for the complete network graph.

```dart
/// Complete mesh network topology data.
@immutable
class MeshTopology extends Equatable {
  /// All nodes in the network.
  final List<MeshNode> nodes;

  /// All connections between nodes.
  final List<MeshLink> links;

  /// Timestamp of last data update.
  final DateTime lastUpdated;

  const MeshTopology({
    required this.nodes,
    required this.links,
    required this.lastUpdated,
  });

  /// The gateway node (root of the topology).
  MeshNode? get gateway =>
    nodes.firstWhereOrNull((n) => n.type == MeshNodeType.gateway);

  /// All extender nodes.
  List<MeshNode> get extenders =>
    nodes.where((n) => n.type == MeshNodeType.extender).toList();

  /// All client nodes.
  List<MeshNode> get clients =>
    nodes.where((n) => n.type == MeshNodeType.client).toList();

  /// Get children of a specific node.
  List<MeshNode> childrenOf(String nodeId) =>
    nodes.where((n) => n.parentId == nodeId).toList();

  /// Get the link between two nodes.
  MeshLink? linkBetween(String sourceId, String targetId) =>
    links.firstWhereOrNull(
      (l) => l.sourceId == sourceId && l.targetId == targetId ||
             l.sourceId == targetId && l.targetId == sourceId
    );

  /// Factory for empty topology (loading state).
  factory MeshTopology.empty() => MeshTopology(
    nodes: const [],
    links: const [],
    lastUpdated: DateTime.now(),
  );

  @override
  List<Object?> get props => [nodes, links, lastUpdated];
}
```

---

## Theme Spec Entities

### TopologySpec

Main theme extension for topology visualization.

```dart
/// Theme specification for mesh topology visualization.
///
/// Registered in AppDesignTheme and accessed via:
/// ```dart
/// final spec = Theme.of(context).extension<AppDesignTheme>()!.topologySpec;
/// ```
@TailorMixin()
class TopologySpec extends ThemeExtension<TopologySpec> {
  // Node styles per type and status
  final NodeStyle gatewayNormalStyle;
  final NodeStyle gatewayHighLoadStyle;
  final NodeStyle gatewayOfflineStyle;

  final NodeStyle extenderNormalStyle;
  final NodeStyle extenderHighLoadStyle;
  final NodeStyle extenderOfflineStyle;

  final NodeStyle clientNormalStyle;
  final NodeStyle clientOfflineStyle;

  // Link styles per signal quality
  final LinkStyle ethernetLinkStyle;
  final LinkStyle wifiStrongStyle;
  final LinkStyle wifiMediumStyle;
  final LinkStyle wifiWeakStyle;
  final LinkStyle wifiUnknownStyle;

  // Guide line for Tree View
  final Color guideLineColor;
  final double guideLineWidth;

  // Animation parameters
  final Duration breathingPeriodNormal;
  final Duration breathingPeriodStressed;
  final Duration orbitPeriod;
  final Duration viewTransitionDuration;
  final Curve viewTransitionCurve;

  // Layout parameters
  final double nodeSize;
  final double orbitRadius;
  final double extenderRingRadius;
  final double clientClusterThreshold;

  const TopologySpec({
    required this.gatewayNormalStyle,
    required this.gatewayHighLoadStyle,
    required this.gatewayOfflineStyle,
    required this.extenderNormalStyle,
    required this.extenderHighLoadStyle,
    required this.extenderOfflineStyle,
    required this.clientNormalStyle,
    required this.clientOfflineStyle,
    required this.ethernetLinkStyle,
    required this.wifiStrongStyle,
    required this.wifiMediumStyle,
    required this.wifiWeakStyle,
    required this.wifiUnknownStyle,
    required this.guideLineColor,
    required this.guideLineWidth,
    required this.breathingPeriodNormal,
    required this.breathingPeriodStressed,
    required this.orbitPeriod,
    required this.viewTransitionDuration,
    required this.viewTransitionCurve,
    required this.nodeSize,
    required this.orbitRadius,
    required this.extenderRingRadius,
    required this.clientClusterThreshold,
  });
}
```

### NodeStyle

Visual parameters for node rendering.

```dart
/// Visual style for a mesh node.
@TailorMixin()
class NodeStyle extends ThemeExtension<NodeStyle> {
  /// Background color of the node surface.
  final Color backgroundColor;

  /// Border color of the node.
  final Color borderColor;

  /// Border width in logical pixels.
  final double borderWidth;

  /// Corner radius for the node shape.
  final double borderRadius;

  /// Blur strength (Glass theme).
  final double blurStrength;

  /// Glow radius for pulse animation.
  final double glowRadius;

  /// Glow color for pulse animation.
  final Color glowColor;

  /// Shadow configuration.
  final List<BoxShadow> shadows;

  /// Content/icon color.
  final Color contentColor;

  /// Wave colors for liquid node (low to high load).
  final Color waveLowColor;
  final Color waveHighColor;

  const NodeStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.blurStrength,
    required this.glowRadius,
    required this.glowColor,
    required this.shadows,
    required this.contentColor,
    required this.waveLowColor,
    required this.waveHighColor,
  });
}
```

### LinkStyle

Visual parameters for link rendering.

```dart
/// Visual style for a mesh link.
@TailorMixin()
class LinkStyle extends ThemeExtension<LinkStyle> {
  /// Line color.
  final Color color;

  /// Line width in logical pixels.
  final double width;

  /// Dash pattern (null for solid line).
  /// [dashLength, gapLength]
  final List<double>? dashPattern;

  /// Flow animation speed (0 = no animation).
  final double flowSpeed;

  /// Glow effect for the line.
  final double glowRadius;

  const LinkStyle({
    required this.color,
    required this.width,
    this.dashPattern,
    this.flowSpeed = 0.0,
    this.glowRadius = 0.0,
  });
}
```

---

## Widget Interfaces

### AppTopology (Main Entry Point)

```dart
/// Mesh network topology visualization component.
///
/// Automatically switches between Tree View (mobile) and Graph View (desktop)
/// based on viewport width at 600px breakpoint.
///
/// Example:
/// ```dart
/// AppTopology(
///   topology: meshTopology,
///   onNodeTap: (node) => showDetails(node),
///   onNodeRename: (node, newName) => rename(node, newName),
///   onExtenderRestart: (node) => restart(node),
/// )
/// ```
class AppTopology extends StatelessWidget {
  /// The mesh network data to visualize.
  final MeshTopology topology;

  /// Callback when a node is tapped.
  final ValueChanged<MeshNode>? onNodeTap;

  /// Callback when a node is renamed (Tree View only).
  final void Function(MeshNode node, String newName)? onNodeRename;

  /// Callback when an extender restart is requested (Tree View only).
  final ValueChanged<MeshNode>? onExtenderRestart;

  /// Override automatic view mode selection.
  final TopologyViewMode? viewMode;

  const AppTopology({
    super.key,
    required this.topology,
    this.onNodeTap,
    this.onNodeRename,
    this.onExtenderRestart,
    this.viewMode,
  });
}

/// Manual view mode override.
enum TopologyViewMode {
  /// Automatic based on viewport width.
  auto,

  /// Force Tree View (mobile layout).
  tree,

  /// Force Graph View (desktop layout).
  graph,
}
```

### NodeBuilder Interface

```dart
/// Abstract builder for rendering mesh nodes.
///
/// Implementations:
/// - [PulseNodeBuilder] for Gateway nodes
/// - [LiquidNodeBuilder] for Extender nodes
/// - [OrbitNodeBuilder] for Client nodes
abstract class NodeBuilder {
  /// Build the widget for the given node.
  Widget build(
    BuildContext context,
    MeshNode node,
    NodeStyle style, {
    VoidCallback? onTap,
  });
}
```

---

## Validation Rules

| Entity | Field | Rule |
|--------|-------|------|
| MeshNode | id | Non-empty, unique within topology |
| MeshNode | name | Non-empty, max 50 characters |
| MeshNode | load | 0.0 to 1.0 inclusive |
| MeshNode | parentId | Must reference existing node ID (except gateway) |
| MeshLink | sourceId | Must reference existing node ID |
| MeshLink | targetId | Must reference existing node ID |
| MeshLink | rssi | -100 to 0 dBm (if present) |
| MeshLink | throughput | >= 0 Mbps (if present) |
| MeshTopology | nodes | Must contain exactly one gateway |
| MeshTopology | nodes | Max 1 gateway, 8 extenders, 50 clients |

---

## Default Theme Values

### Glass Theme

```dart
TopologySpec(
  gatewayNormalStyle: NodeStyle(
    backgroundColor: Colors.white.withOpacity(0.15),
    borderColor: Colors.white.withOpacity(0.3),
    borderWidth: 1.0,
    borderRadius: 24.0,
    blurStrength: 20.0,
    glowRadius: 20.0,
    glowColor: Colors.cyan.withOpacity(0.3),
    ...
  ),
  breathingPeriodNormal: Duration(seconds: 4),
  breathingPeriodStressed: Duration(seconds: 1),
  orbitPeriod: Duration(seconds: 10),
  ...
)
```

### Brutal Theme

```dart
TopologySpec(
  gatewayNormalStyle: NodeStyle(
    backgroundColor: Colors.white,
    borderColor: Colors.black,
    borderWidth: 3.0,
    borderRadius: 0.0,  // Sharp corners
    blurStrength: 0.0,  // No blur
    glowRadius: 0.0,    // No glow
    shadows: [BoxShadow(offset: Offset(4, 4), color: Colors.black)],
    ...
  ),
  // Offline uses cross-hatch pattern instead of grayscale
  ...
)
```
