/// Topology node widgets.
///
/// Animated node widgets for different device types:
/// - [PulseNode]: Gateway node with breathing animation
/// - [LiquidNode]: Extender node with water level animation
/// - [OrbitNode]: Client node with orbital animation
/// - [ClusterBadge]: Cluster badge for grouped clients
library topology_nodes;

export 'pulse_node.dart' show PulseNode, NodeContentBuilder;
export 'liquid_node.dart' show LiquidNode;
export 'orbit_node.dart' show OrbitNode, OrbitNodeGroup, OrbitNodePreview;
export 'cluster_badge.dart' show ClusterBadge, ClusterBadgePreview;
export 'node_builder.dart';
