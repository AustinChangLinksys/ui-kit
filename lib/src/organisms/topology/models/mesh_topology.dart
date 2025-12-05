import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'mesh_link.dart';
import 'mesh_node.dart';

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

  /// Whether the topology has any nodes.
  bool get isEmpty => nodes.isEmpty;

  /// Whether the topology has nodes.
  bool get isNotEmpty => nodes.isNotEmpty;

  /// Total number of nodes.
  int get nodeCount => nodes.length;

  /// Total number of links.
  int get linkCount => links.length;

  /// Get a node by its ID.
  MeshNode? nodeById(String id) => nodes.firstWhereOrNull((n) => n.id == id);

  /// Get children of a specific node.
  List<MeshNode> childrenOf(String nodeId) =>
      nodes.where((n) => n.parentId == nodeId).toList();

  /// Get the parent of a specific node.
  MeshNode? parentOf(String nodeId) {
    final node = nodeById(nodeId);
    if (node == null || node.parentId == null) return null;
    return nodeById(node.parentId!);
  }

  /// Get the link between two nodes.
  MeshLink? linkBetween(String sourceId, String targetId) =>
      links.firstWhereOrNull(
        (l) =>
            (l.sourceId == sourceId && l.targetId == targetId) ||
            (l.sourceId == targetId && l.targetId == sourceId),
      );

  /// Get all links connected to a node.
  List<MeshLink> linksForNode(String nodeId) => links
      .where((l) => l.sourceId == nodeId || l.targetId == nodeId)
      .toList();

  /// Factory for empty topology (loading state).
  factory MeshTopology.empty() => MeshTopology(
        nodes: const [],
        links: const [],
        lastUpdated: DateTime.now(),
      );

  @override
  List<Object?> get props => [nodes, links, lastUpdated];

  /// Creates a copy of this topology with the given fields replaced.
  MeshTopology copyWith({
    List<MeshNode>? nodes,
    List<MeshLink>? links,
    DateTime? lastUpdated,
  }) {
    return MeshTopology(
      nodes: nodes ?? this.nodes,
      links: links ?? this.links,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
