import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/mesh_node.dart';
import '../models/mesh_topology.dart';

/// Position data for a node in the topology graph.
@immutable
class NodePosition {
  /// The node this position is for.
  final MeshNode node;

  /// Center position of the node.
  final Offset position;

  /// Angle from parent (radians), used for orbit animation.
  final double angle;

  /// Distance from parent center.
  final double radius;

  const NodePosition({
    required this.node,
    required this.position,
    this.angle = 0,
    this.radius = 0,
  });

  /// Create a copy with updated position (for animation).
  NodePosition copyWith({Offset? position, double? angle}) {
    return NodePosition(
      node: node,
      position: position ?? this.position,
      angle: angle ?? this.angle,
      radius: radius,
    );
  }
}

/// Calculates node positions using a concentric circle layout.
///
/// Layout structure:
/// - Gateway at center (0, 0)
/// - Extenders in a ring at radius R1 around gateway
/// - Clients in a smaller ring at radius R2 around their parent
///
/// Part of User Story 2: Responsive View Switching.
class ConcentricLayout {
  /// Base radius of the extender ring from gateway center.
  final double extenderRadius;

  /// Base radius of client orbit from parent center.
  final double clientRadius;

  /// Minimum spacing between nodes on same ring.
  final double minNodeSpacing;

  /// Center offset of the entire layout.
  final Offset center;

  /// Node size for calculating proper spacing (default gateway size).
  final double nodeSize;

  const ConcentricLayout({
    this.extenderRadius = 180.0,
    this.clientRadius = 100.0,
    this.minNodeSpacing = 60.0,
    this.center = Offset.zero,
    this.nodeSize = 64.0,
  });

  /// Calculate positions for all nodes in the topology.
  ///
  /// Returns a map of node ID to [NodePosition].
  ///
  /// Supports daisy chain topologies where extenders connect to other extenders:
  /// ```
  /// Gateway → Extender1 → Extender2 → Extender3
  /// ```
  Map<String, NodePosition> calculatePositions(MeshTopology topology) {
    final positions = <String, NodePosition>{};

    // Build parent-child relationships
    final childrenMap = <String?, List<MeshNode>>{};
    MeshNode? gateway;

    for (final node in topology.nodes) {
      if (node.isGateway) {
        gateway = node;
      }
      childrenMap.putIfAbsent(node.parentId, () => []).add(node);
    }

    if (gateway == null) {
      // No gateway - return empty or handle gracefully
      return positions;
    }

    // Position gateway at center
    positions[gateway.id] = NodePosition(
      node: gateway,
      position: center,
      angle: 0,
      radius: 0,
    );

    // Use BFS to traverse all nodes level by level
    // This supports daisy chain: Gateway → Ext1 → Ext2 → Ext3
    _positionChildrenRecursively(
      parentId: gateway.id,
      parentPosition: center,
      parentAngle: 0,
      depth: 1,
      childrenMap: childrenMap,
      positions: positions,
    );

    return positions;
  }

  /// Recursively position children of a node.
  ///
  /// For extenders: positions them in a ring/arc around their parent
  /// For clients: positions them on left/right sides (perpendicular to chain)
  void _positionChildrenRecursively({
    required String parentId,
    required Offset parentPosition,
    required double parentAngle,
    required int depth,
    required Map<String?, List<MeshNode>> childrenMap,
    required Map<String, NodePosition> positions,
  }) {
    final children = childrenMap[parentId] ?? [];
    if (children.isEmpty) return;

    final extenders = children.where((n) => n.isExtender).toList();
    final clients = children.where((n) => n.isClient).toList();

    // Calculate radius based on depth and node size to prevent overlap
    // Minimum spacing = node size + gap
    final minExtenderSpacing = nodeSize * 1.5 + minNodeSpacing;
    final minClientSpacing = nodeSize * 0.7 + minNodeSpacing * 0.6;

    // Use larger of calculated or base radius
    final currentExtenderRadius = math.max(
      extenderRadius * math.pow(0.85, depth - 1),
      minExtenderSpacing,
    );
    final currentClientRadius = math.max(
      clientRadius * math.pow(0.9, depth - 1),
      minClientSpacing,
    );

    // Position extenders around parent
    if (extenders.isNotEmpty) {
      if (depth == 1) {
        // First level: full ring around gateway, starting from bottom
        // This places gateway at top with children below
        _positionNodesInRing(
          nodes: extenders,
          centerPosition: parentPosition,
          radius: currentExtenderRadius,
          startAngle: math.pi / 2, // Start from bottom (gateway at top)
          positions: positions,
        );
      } else {
        // Deeper levels (daisy chain): continue in same direction
        _positionNodesInArc(
          nodes: extenders,
          centerPosition: parentPosition,
          radius: currentExtenderRadius,
          centerAngle: parentAngle, // Continue in same direction as parent
          arcSpan: math.pi * 0.4, // 72 degree arc for tighter chain
          positions: positions,
        );
      }

      // Recursively position children of each extender
      for (final extender in extenders) {
        final extenderPos = positions[extender.id]!;
        _positionChildrenRecursively(
          parentId: extender.id,
          parentPosition: extenderPos.position,
          parentAngle: extenderPos.angle,
          depth: depth + 1,
          childrenMap: childrenMap,
          positions: positions,
        );
      }
    }

    // Position clients around parent
    if (clients.isNotEmpty) {
      if (depth == 1) {
        // Direct clients of gateway: inner ring, offset from extenders
        // Start from top (-π/2) for symmetric distribution
        _positionNodesInRing(
          nodes: clients,
          centerPosition: parentPosition,
          radius: currentExtenderRadius * 0.5,
          startAngle: -math.pi / 2, // Start from top for symmetric look
          positions: positions,
        );
      } else {
        // Clients of extenders: position on LEFT and RIGHT sides only
        // Perpendicular to chain direction, NOT in chain direction (no below)
        _positionClientsOnSides(
          nodes: clients,
          centerPosition: parentPosition,
          radius: currentClientRadius,
          chainAngle: parentAngle,
          positions: positions,
        );
      }
    }
  }

  /// Position clients on left and right sides of parent (perpendicular to chain).
  ///
  /// This prevents clients from appearing below the extender in a daisy chain,
  /// which would cause overlap with the next extender in the chain.
  ///
  /// For many clients (3+), uses a semi-circle arc on the upstream side.
  void _positionClientsOnSides({
    required List<MeshNode> nodes,
    required Offset centerPosition,
    required double radius,
    required double chainAngle,
    required Map<String, NodePosition> positions,
  }) {
    if (nodes.isEmpty) return;

    // For many clients, use upstream semi-circle instead of left/right split
    if (nodes.length >= 3) {
      // Position in a semi-circle on the UPSTREAM side (opposite to chain direction)
      final upstreamAngle = chainAngle + math.pi; // Opposite to chain direction
      final arcSpan = math.min(math.pi * 0.8, nodes.length * 0.4); // Max 144°

      _positionNodesInArc(
        nodes: nodes,
        centerPosition: centerPosition,
        radius: radius,
        centerAngle: upstreamAngle,
        arcSpan: arcSpan,
        positions: positions,
      );
      return;
    }

    // For 1-2 clients, use left/right positioning
    final leftAngle = chainAngle - math.pi / 2;
    final rightAngle = chainAngle + math.pi / 2;

    if (nodes.length == 1) {
      // Single client: place on left side
      final node = nodes.first;
      final x = centerPosition.dx + radius * math.cos(leftAngle);
      final y = centerPosition.dy + radius * math.sin(leftAngle);
      positions[node.id] = NodePosition(
        node: node,
        position: Offset(x, y),
        angle: leftAngle,
        radius: radius,
      );
    } else {
      // Two clients: one left, one right
      final leftNode = nodes[0];
      final rightNode = nodes[1];

      positions[leftNode.id] = NodePosition(
        node: leftNode,
        position: Offset(
          centerPosition.dx + radius * math.cos(leftAngle),
          centerPosition.dy + radius * math.sin(leftAngle),
        ),
        angle: leftAngle,
        radius: radius,
      );

      positions[rightNode.id] = NodePosition(
        node: rightNode,
        position: Offset(
          centerPosition.dx + radius * math.cos(rightAngle),
          centerPosition.dy + radius * math.sin(rightAngle),
        ),
        angle: rightAngle,
        radius: radius,
      );
    }
  }

  /// Position nodes evenly in a full circle ring.
  void _positionNodesInRing({
    required List<MeshNode> nodes,
    required Offset centerPosition,
    required double radius,
    required double startAngle,
    required Map<String, NodePosition> positions,
  }) {
    if (nodes.isEmpty) return;

    final angleStep = (2 * math.pi) / nodes.length;

    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final angle = startAngle + (i * angleStep);
      final x = centerPosition.dx + radius * math.cos(angle);
      final y = centerPosition.dy + radius * math.sin(angle);

      positions[node.id] = NodePosition(
        node: node,
        position: Offset(x, y),
        angle: angle,
        radius: radius,
      );
    }
  }

  /// Position nodes in an arc (partial circle) around a center point.
  void _positionNodesInArc({
    required List<MeshNode> nodes,
    required Offset centerPosition,
    required double radius,
    required double centerAngle,
    required double arcSpan,
    required Map<String, NodePosition> positions,
  }) {
    if (nodes.isEmpty) return;

    final startAngle = centerAngle - (arcSpan / 2);

    if (nodes.length == 1) {
      // Single node - place at center angle
      final x = centerPosition.dx + radius * math.cos(centerAngle);
      final y = centerPosition.dy + radius * math.sin(centerAngle);

      positions[nodes.first.id] = NodePosition(
        node: nodes.first,
        position: Offset(x, y),
        angle: centerAngle,
        radius: radius,
      );
    } else {
      // Multiple nodes - distribute evenly in arc
      final angleStep = arcSpan / (nodes.length - 1);

      for (var i = 0; i < nodes.length; i++) {
        final node = nodes[i];
        final angle = startAngle + (i * angleStep);
        final x = centerPosition.dx + radius * math.cos(angle);
        final y = centerPosition.dy + radius * math.sin(angle);

        positions[node.id] = NodePosition(
          node: node,
          position: Offset(x, y),
          angle: angle,
          radius: radius,
        );
      }
    }
  }

  /// Calculate the bounding box of all positioned nodes.
  Rect calculateBounds(Map<String, NodePosition> positions, double nodeSize) {
    if (positions.isEmpty) {
      return Rect.fromCenter(center: center, width: 100, height: 100);
    }

    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    final halfSize = nodeSize / 2;

    for (final pos in positions.values) {
      minX = math.min(minX, pos.position.dx - halfSize);
      minY = math.min(minY, pos.position.dy - halfSize);
      maxX = math.max(maxX, pos.position.dx + halfSize);
      maxY = math.max(maxY, pos.position.dy + halfSize);
    }

    // Add padding
    const padding = 50.0;
    return Rect.fromLTRB(
      minX - padding,
      minY - padding,
      maxX + padding,
      maxY + padding,
    );
  }
}
