import 'package:flutter/material.dart';

import '../../../molecules/menu/app_popup_menu_item.dart';
import '../models/mesh_node.dart';

/// Builder for node context menu items.
///
/// Called when user triggers context menu on a node (long press or right click).
/// Return a list of menu items, or null/empty list for no menu.
///
/// Example:
/// ```dart
/// nodeMenuBuilder: (context, node) {
///   if (node.isGateway) return null;
///   return [
///     AppPopupMenuItem(value: 'rename', label: 'Rename', icon: Icons.edit),
///     if (node.isExtender)
///       AppPopupMenuItem(value: 'restart', label: 'Restart', icon: Icons.restart_alt),
///   ];
/// },
/// onNodeMenuSelected: (nodeId, value) {
///   if (value == 'rename') _renameNode(nodeId);
///   if (value == 'restart') _restartExtender(nodeId);
/// },
/// ```
typedef NodeMenuBuilder = List<AppPopupMenuItem<String>>? Function(
  BuildContext context,
  MeshNode node,
);

// NodeContentBuilder is defined in nodes/pulse_node.dart
// and re-exported via nodes/nodes.dart

/// View mode for topology display.
enum TopologyViewMode {
  /// Automatic switching based on viewport width.
  auto,

  /// Force tree view (mobile-optimized).
  tree,

  /// Force graph view (desktop-optimized).
  graph,
}

/// Controls when client nodes are visible in the topology.
enum ClientVisibility {
  /// Always show all client nodes.
  always,

  /// Show clients only when hovering on their parent extender.
  /// Displays a count badge on extenders when collapsed.
  onHover,

  /// Hide all client nodes, show count badge on extenders.
  collapsed,

  /// Automatically cluster clients when count exceeds threshold (default: 20).
  ///
  /// - When client count <= threshold: behaves like [always]
  /// - When client count > threshold: groups into clusters with count badges
  /// - Tap a cluster to expand and show individual clients
  ///
  /// This prevents performance issues with many clients while still
  /// allowing access to individual client details.
  clustered,
}
