import 'package:flutter/material.dart';

import '../../../foundation/theme/design_system/specs/topology_style.dart';
import '../models/mesh_node.dart';
import 'liquid_node.dart';
import 'pulse_node.dart';

/// Abstract interface for node builders.
///
/// Uses Strategy pattern to render different node types without runtime
/// type checks (Constitution 6.1 compliance).
///
/// Implementers:
/// - [PulseNodeBuilder] for Gateway nodes
/// - [LiquidNodeBuilder] for Extender nodes
/// - [OrbitNodeBuilder] for Client nodes
abstract class NodeBuilder {
  /// Build the node widget.
  ///
  /// [context] - BuildContext for theme access
  /// [node] - The mesh node data
  /// [style] - Visual style from TopologySpec
  /// [onTap] - Optional tap callback
  /// [enableAnimation] - Whether animations are enabled
  Widget build(
    BuildContext context,
    MeshNode node,
    NodeStyle style, {
    VoidCallback? onTap,
    bool enableAnimation = true,
  });
}

/// Builder for Gateway nodes with breathing pulse animation.
class PulseNodeBuilder implements NodeBuilder {
  const PulseNodeBuilder();

  @override
  Widget build(
    BuildContext context,
    MeshNode node,
    NodeStyle style, {
    VoidCallback? onTap,
    bool enableAnimation = true,
  }) {
    return PulseNode(
      node: node,
      style: style,
      onTap: onTap,
      enableAnimation: enableAnimation,
    );
  }
}

/// Builder for Extender nodes with liquid level animation.
class LiquidNodeBuilder implements NodeBuilder {
  const LiquidNodeBuilder();

  @override
  Widget build(
    BuildContext context,
    MeshNode node,
    NodeStyle style, {
    VoidCallback? onTap,
    bool enableAnimation = true,
  }) {
    return LiquidNode(
      node: node,
      style: style,
      onTap: onTap,
      enableAnimation: enableAnimation,
    );
  }
}

/// Placeholder OrbitNodeBuilder - to be implemented in US4.
class OrbitNodeBuilder implements NodeBuilder {
  const OrbitNodeBuilder();

  @override
  Widget build(
    BuildContext context,
    MeshNode node,
    NodeStyle style, {
    VoidCallback? onTap,
    bool enableAnimation = true,
  }) {
    // Placeholder - will be implemented in Phase 6 (US4)
    return const SizedBox.shrink();
  }
}

/// Node builder registry.
///
/// Maps node types to their builders using Strategy pattern
/// to avoid runtime type checks (Constitution 6.1 compliance).
final Map<MeshNodeType, NodeBuilder> nodeBuilders = {
  MeshNodeType.gateway: const PulseNodeBuilder(),
  MeshNodeType.extender: const LiquidNodeBuilder(),
  MeshNodeType.client: const OrbitNodeBuilder(),
};

/// Get the appropriate builder for a node type.
NodeBuilder getNodeBuilder(MeshNodeType type) {
  final builder = nodeBuilders[type];
  if (builder == null) {
    throw ArgumentError('No builder registered for node type: $type');
  }
  return builder;
}
