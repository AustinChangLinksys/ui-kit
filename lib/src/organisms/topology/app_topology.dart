import 'package:flutter/material.dart';

import '../../foundation/theme/design_system/app_design_theme.dart';
import 'models/mesh_topology.dart';
import 'nodes/pulse_node.dart' show NodeContentBuilder;
import 'types/topology_types.dart';
import 'views/graph_view/topology_graph_view.dart';
import 'views/tree_view/topology_tree_view.dart';

// Re-export types for backward compatibility
export 'types/topology_types.dart';

// Re-export layout types for consumer use
export 'views/graph_view/topology_graph_view.dart'
    show LayoutRecommendation, TopologyAnalyzer, TopologyType;

/// Main entry point for mesh topology visualization.
///
/// Automatically switches between Tree View (mobile <600px) and
/// Graph View (desktop ≥600px) based on viewport width.
///
/// Part of User Story 2: Responsive View Switching.
///
/// ## Usage
///
/// ```dart
/// AppTopology(
///   topology: myTopology,
///   onNodeTap: (nodeId) => print('Tapped $nodeId'),
///   onTopologyChanged: (newTopology) => updateState(newTopology),
/// )
/// ```
class AppTopology extends StatelessWidget {
  /// The mesh topology data to display.
  final MeshTopology? topology;

  /// View mode override. Defaults to [TopologyViewMode.auto].
  final TopologyViewMode viewMode;

  /// Breakpoint for view switching in logical pixels.
  /// Defaults to 600px.
  final double breakpoint;

  /// Callback when a node is tapped.
  final void Function(String nodeId)? onNodeTap;

  /// Callback when topology data changes (for real-time updates).
  /// FR-023 compliance.
  final void Function(MeshTopology topology)? onTopologyChanged;

  /// Builder for node context menu items.
  ///
  /// When provided and returns non-empty list, shows AppPopupMenu on
  /// long press (mobile) or right click (desktop).
  final NodeMenuBuilder? nodeMenuBuilder;

  /// Callback when a menu item is selected on a node.
  ///
  /// Parameters:
  /// - [nodeId]: The ID of the node where menu was triggered
  /// - [value]: The value of the selected menu item
  final void Function(String nodeId, String value)? onNodeMenuSelected;

  /// Custom widget to show when topology is empty.
  final Widget? emptyStateWidget;

  /// Whether animations are enabled.
  /// Set to false for testing.
  final bool enableAnimation;

  /// Custom content builder for nodes.
  ///
  /// When provided, this builder is used to create custom content
  /// inside each node, allowing consumers to display additional
  /// information beyond the default icon/image.
  ///
  /// Example:
  /// ```dart
  /// AppTopology(
  ///   topology: myTopology,
  ///   nodeContentBuilder: (context, node, style, isOffline) {
  ///     return Column(
  ///       mainAxisSize: MainAxisSize.min,
  ///       children: [
  ///         Icon(node.iconData ?? Icons.devices),
  ///         Text(node.name, style: TextStyle(fontSize: 8)),
  ///         if (node.isExtender)
  ///           Text('${(node.load * 100).toInt()}%'),
  ///       ],
  ///     );
  ///   },
  /// )
  /// ```
  final NodeContentBuilder? nodeContentBuilder;

  /// Controls when client nodes are visible.
  ///
  /// - [ClientVisibility.always]: Show all clients (default)
  /// - [ClientVisibility.onHover]: Show clients only when hovering parent
  /// - [ClientVisibility.collapsed]: Hide all clients, show count badge
  final ClientVisibility clientVisibility;

  /// Layout mode for graph view.
  ///
  /// - [LayoutRecommendation.auto]: Automatically selects layout based on topology
  /// - [LayoutRecommendation.concentric]: Forces concentric (radial) layout
  /// - [LayoutRecommendation.horizontal]: Forces horizontal (linear) layout
  final LayoutRecommendation layoutMode;

  /// Breakpoint constant for view switching.
  static const double defaultBreakpoint = 600.0;

  const AppTopology({
    super.key,
    this.topology,
    this.viewMode = TopologyViewMode.auto,
    this.breakpoint = defaultBreakpoint,
    this.onNodeTap,
    this.onTopologyChanged,
    this.nodeMenuBuilder,
    this.onNodeMenuSelected,
    this.emptyStateWidget,
    this.enableAnimation = true,
    this.nodeContentBuilder,
    this.clientVisibility = ClientVisibility.always,
    this.layoutMode = LayoutRecommendation.auto,
  });

  @override
  Widget build(BuildContext context) {
    // Handle loading state (null topology)
    if (topology == null) {
      return _buildLoadingSkeleton(context);
    }

    // Handle empty state
    if (topology!.nodes.isEmpty) {
      return emptyStateWidget ?? _buildDefaultEmptyState(context);
    }

    // Get theme extension for animation specification
    final theme = Theme.of(context).extension<AppDesignTheme>();
    assert(theme != null, 'AppDesignTheme not found in context');

    final topologySpec = theme!.topologySpec;
    final viewTransitionSpec = topologySpec.viewTransition;

    // Check for reduced motion preference (T111)
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final effectiveAnimation = enableAnimation && !reduceMotion;

    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveMode = _resolveViewMode(constraints.maxWidth);

        Widget viewWidget;
        if (effectiveMode == TopologyViewMode.tree) {
          viewWidget = TopologyTreeView(
            key: const ValueKey('tree'),
            topology: topology!,
            onNodeTap: onNodeTap,
            nodeMenuBuilder: nodeMenuBuilder,
            onNodeMenuSelected: onNodeMenuSelected,
            nodeContentBuilder: nodeContentBuilder,
          );
        } else {
          viewWidget = TopologyGraphView(
            key: const ValueKey('graph'),
            topology: topology!,
            onNodeTap: onNodeTap,
            nodeMenuBuilder: nodeMenuBuilder,
            onNodeMenuSelected: onNodeMenuSelected,
            enableAnimation: effectiveAnimation,
            nodeContentBuilder: nodeContentBuilder,
            clientVisibility: clientVisibility,
            layoutMode: layoutMode,
          );
        }

        // Wrap with AnimatedSwitcher for smooth transitions
        // Constitution 5.1 compliance: Use theme animation specification
        return AnimatedSwitcher(
          duration: effectiveAnimation ? viewTransitionSpec.duration : Duration.zero,
          switchInCurve: viewTransitionSpec.curve,
          switchOutCurve: viewTransitionSpec.curve,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: viewWidget,
        );
      },
    );
  }

  /// Resolve effective view mode based on viewport width.
  TopologyViewMode _resolveViewMode(double width) {
    switch (viewMode) {
      case TopologyViewMode.auto:
        return width < breakpoint
            ? TopologyViewMode.tree
            : TopologyViewMode.graph;
      case TopologyViewMode.tree:
      case TopologyViewMode.graph:
        return viewMode;
    }
  }

  /// Build loading skeleton when topology is null.
  Widget _buildLoadingSkeleton(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Loading topology...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  /// Build default empty state widget.
  Widget _buildDefaultEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.device_hub,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No devices found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Connect devices to see your network topology',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
