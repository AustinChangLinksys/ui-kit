import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/mesh_node.dart';
import '../models/mesh_topology.dart';
import 'concentric_layout.dart';

/// Horizontal layout for daisy chain topologies.
///
/// Arranges nodes in a horizontal line:
/// ```
/// Gateway ─── Ext1 ─── Ext2 ─── Ext3
///              │        │        │
///           Clients  Clients  Clients
/// ```
///
/// Best suited for:
/// - Linear/daisy chain topologies
/// - Simple hierarchies with few branches
class HorizontalLayout {
  /// Horizontal spacing between nodes in the chain.
  final double horizontalSpacing;

  /// Vertical spacing for client nodes below their parent.
  final double verticalSpacing;

  /// Client spacing when multiple clients exist.
  final double clientSpacing;

  /// Node size for calculating proper spacing.
  final double nodeSize;

  /// Starting position offset.
  final Offset startOffset;

  const HorizontalLayout({
    this.horizontalSpacing = 160.0,
    this.verticalSpacing = 100.0,
    this.clientSpacing = 60.0,
    this.nodeSize = 64.0,
    this.startOffset = Offset.zero,
  });

  /// Calculate positions for all nodes in a horizontal layout.
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
      return positions;
    }

    // Position gateway at start
    var currentX = startOffset.dx;
    final baseY = startOffset.dy;

    positions[gateway.id] = NodePosition(
      node: gateway,
      position: Offset(currentX, baseY),
      angle: 0,
      radius: 0,
    );

    // Position direct clients of gateway above
    final gatewayClients = childrenMap[gateway.id]
            ?.where((n) => n.isClient)
            .toList() ??
        [];
    if (gatewayClients.isNotEmpty) {
      _positionClientsAbove(
        clients: gatewayClients,
        parentPosition: Offset(currentX, baseY),
        positions: positions,
      );
    }

    // Follow the chain of extenders
    _positionChain(
      parentId: gateway.id,
      startX: currentX + horizontalSpacing,
      baseY: baseY,
      childrenMap: childrenMap,
      positions: positions,
    );

    return positions;
  }

  /// Position the chain of extenders horizontally.
  void _positionChain({
    required String parentId,
    required double startX,
    required double baseY,
    required Map<String?, List<MeshNode>> childrenMap,
    required Map<String, NodePosition> positions,
  }) {
    final children = childrenMap[parentId] ?? [];
    final extenders = children.where((n) => n.isExtender).toList();

    if (extenders.isEmpty) return;

    var currentX = startX;

    for (final extender in extenders) {
      // Position extender
      positions[extender.id] = NodePosition(
        node: extender,
        position: Offset(currentX, baseY),
        angle: 0, // Horizontal = angle 0
        radius: horizontalSpacing,
      );

      // Position clients below this extender
      final clients =
          childrenMap[extender.id]?.where((n) => n.isClient).toList() ?? [];
      if (clients.isNotEmpty) {
        _positionClientsBelow(
          clients: clients,
          parentPosition: Offset(currentX, baseY),
          positions: positions,
        );
      }

      // Recursively position child extenders (daisy chain continues)
      final childExtenders =
          childrenMap[extender.id]?.where((n) => n.isExtender).toList() ?? [];
      if (childExtenders.isNotEmpty) {
        _positionChain(
          parentId: extender.id,
          startX: currentX + horizontalSpacing,
          baseY: baseY,
          childrenMap: childrenMap,
          positions: positions,
        );
      }

      currentX += horizontalSpacing;
    }
  }

  /// Position clients above their parent (for gateway).
  void _positionClientsAbove({
    required List<MeshNode> clients,
    required Offset parentPosition,
    required Map<String, NodePosition> positions,
  }) {
    final totalWidth = (clients.length - 1) * clientSpacing;
    var startX = parentPosition.dx - totalWidth / 2;

    for (final client in clients) {
      positions[client.id] = NodePosition(
        node: client,
        position: Offset(startX, parentPosition.dy - verticalSpacing),
        angle: -math.pi / 2, // Upward
        radius: verticalSpacing,
      );
      startX += clientSpacing;
    }
  }

  /// Position clients below their parent (for extenders).
  void _positionClientsBelow({
    required List<MeshNode> clients,
    required Offset parentPosition,
    required Map<String, NodePosition> positions,
  }) {
    final totalWidth = (clients.length - 1) * clientSpacing;
    var startX = parentPosition.dx - totalWidth / 2;

    for (final client in clients) {
      positions[client.id] = NodePosition(
        node: client,
        position: Offset(startX, parentPosition.dy + verticalSpacing),
        angle: math.pi / 2, // Downward
        radius: verticalSpacing,
      );
      startX += clientSpacing;
    }
  }

  /// Calculate the bounding box of all positioned nodes.
  Rect calculateBounds(Map<String, NodePosition> positions, double nodeSize) {
    if (positions.isEmpty) {
      return Rect.fromCenter(
          center: startOffset, width: 100, height: 100);
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

    const padding = 50.0;
    return Rect.fromLTRB(
      minX - padding,
      minY - padding,
      maxX + padding,
      maxY + padding,
    );
  }
}

/// Analyzes topology structure and recommends best layout.
class TopologyAnalyzer {
  /// Analyze the topology and return its type.
  static TopologyType analyze(MeshTopology topology) {
    if (topology.nodes.isEmpty) {
      return TopologyType.empty;
    }

    final gateway = topology.nodes.where((n) => n.isGateway).firstOrNull;
    if (gateway == null) {
      return TopologyType.unknown;
    }

    // Build parent-child map
    final childrenMap = <String?, List<MeshNode>>{};
    for (final node in topology.nodes) {
      childrenMap.putIfAbsent(node.parentId, () => []).add(node);
    }

    // Count extenders at each level
    final gatewayChildren = childrenMap[gateway.id] ?? [];
    final directExtenders = gatewayChildren.where((n) => n.isExtender).toList();

    if (directExtenders.isEmpty) {
      return TopologyType.gatewayOnly;
    }

    // Check if it's a daisy chain (single extender path)
    if (directExtenders.length == 1) {
      // Check if the chain continues
      var current = directExtenders.first;
      var chainLength = 1;
      var hasBranches = false;

      while (true) {
        final currentChildren = childrenMap[current.id] ?? [];
        final childExtenders =
            currentChildren.where((n) => n.isExtender).toList();

        if (childExtenders.isEmpty) {
          break;
        } else if (childExtenders.length == 1) {
          current = childExtenders.first;
          chainLength++;
        } else {
          hasBranches = true;
          break;
        }
      }

      if (!hasBranches && chainLength >= 2) {
        return TopologyType.daisyChain;
      }
    }

    // Check if it's a star topology (all extenders connect to gateway)
    var allConnectToGateway = true;
    for (final node in topology.nodes) {
      if (node.isExtender && node.parentId != gateway.id) {
        allConnectToGateway = false;
        break;
      }
    }

    if (allConnectToGateway && directExtenders.length >= 2) {
      return TopologyType.star;
    }

    // Mixed topology
    return TopologyType.mixed;
  }

  /// Get recommended layout for the topology type.
  static LayoutRecommendation getRecommendedLayout(TopologyType type) {
    switch (type) {
      case TopologyType.daisyChain:
        return LayoutRecommendation.horizontal;
      case TopologyType.star:
        return LayoutRecommendation.concentric;
      case TopologyType.mixed:
        return LayoutRecommendation.concentric;
      case TopologyType.gatewayOnly:
      case TopologyType.empty:
      case TopologyType.unknown:
        return LayoutRecommendation.concentric;
    }
  }
}

/// Types of network topology structures.
enum TopologyType {
  /// No nodes
  empty,

  /// Only gateway, no extenders
  gatewayOnly,

  /// Linear chain: Gateway → Ext1 → Ext2 → Ext3
  daisyChain,

  /// Star: All extenders connect directly to gateway
  star,

  /// Combination of star and chain
  mixed,

  /// Unable to determine
  unknown,
}

/// Recommended layout strategy.
enum LayoutRecommendation {
  /// Use HorizontalLayout
  horizontal,

  /// Use ConcentricLayout
  concentric,

  /// Automatically select based on topology structure.
  auto,
}
