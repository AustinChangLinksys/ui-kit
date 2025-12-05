import 'package:flutter/material.dart';

import '../../../../foundation/theme/design_system/app_design_theme.dart';
import '../../../../molecules/menu/app_popup_menu.dart';
import '../../layouts/concentric_layout.dart';
import '../../layouts/horizontal_layout.dart';
import '../../models/mesh_link.dart';
import '../../models/mesh_node.dart';
import '../../models/mesh_topology.dart';
import '../../nodes/cluster_badge.dart';
import '../../nodes/liquid_node.dart';
import '../../nodes/pulse_node.dart';
import '../../types/topology_types.dart';

export '../../layouts/horizontal_layout.dart' show LayoutRecommendation, TopologyAnalyzer, TopologyType;

/// Graph View for mesh topology visualization.
///
/// Displays devices in a 2D layout optimized for desktop:
/// - Concentric: Gateway at center, extenders in ring, clients orbit parent
/// - Horizontal: Linear chain layout for daisy chain topologies
///
/// Supports pan and zoom via [InteractiveViewer].
///
/// Part of User Story 2: Responsive View Switching.
class TopologyGraphView extends StatefulWidget {
  /// The mesh topology data to display.
  final MeshTopology topology;

  /// Callback when a node is tapped.
  final void Function(String nodeId)? onNodeTap;

  /// Builder for node context menu items.
  final NodeMenuBuilder? nodeMenuBuilder;

  /// Callback when a menu item is selected on a node.
  final void Function(String nodeId, String value)? onNodeMenuSelected;

  /// Whether animations are enabled.
  final bool enableAnimation;

  /// Custom content builder for nodes.
  final NodeContentBuilder? nodeContentBuilder;

  /// Concentric layout configuration.
  final ConcentricLayout concentricLayout;

  /// Horizontal layout configuration.
  final HorizontalLayout horizontalLayout;

  /// Layout mode selection.
  ///
  /// - [LayoutRecommendation.auto]: Automatically selects based on topology
  /// - [LayoutRecommendation.concentric]: Forces concentric layout
  /// - [LayoutRecommendation.horizontal]: Forces horizontal layout
  final LayoutRecommendation layoutMode;

  /// Controls when client nodes are visible.
  final ClientVisibility clientVisibility;

  /// Threshold for clustering clients (only used with [ClientVisibility.clustered]).
  ///
  /// When a parent node has more than this number of clients, they are
  /// automatically grouped into a cluster badge. Default is 20.
  final int clusterThreshold;

  const TopologyGraphView({
    super.key,
    required this.topology,
    this.onNodeTap,
    this.nodeMenuBuilder,
    this.onNodeMenuSelected,
    this.enableAnimation = true,
    this.nodeContentBuilder,
    this.concentricLayout = const ConcentricLayout(),
    this.horizontalLayout = const HorizontalLayout(),
    this.layoutMode = LayoutRecommendation.auto,
    this.clientVisibility = ClientVisibility.always,
    this.clusterThreshold = 20,
  });

  @override
  State<TopologyGraphView> createState() => _TopologyGraphViewState();
}

class _TopologyGraphViewState extends State<TopologyGraphView> {
  late Map<String, NodePosition> _nodePositions;
  late TransformationController _transformationController;

  /// Currently hovered node ID (for onHover visibility mode).
  String? _hoveredNodeId;

  /// Client count per parent node (cached for badge display).
  late Map<String, int> _clientCounts;

  /// Expanded cluster parent IDs (for clustered visibility mode).
  final Set<String> _expandedClusters = {};

  /// Whether horizontal layout is currently used.
  bool _isHorizontalLayout = false;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _calculateLayout();
    _calculateClientCounts();
  }

  @override
  void didUpdateWidget(TopologyGraphView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.topology != widget.topology ||
        oldWidget.concentricLayout != widget.concentricLayout ||
        oldWidget.horizontalLayout != widget.horizontalLayout ||
        oldWidget.layoutMode != widget.layoutMode) {
      _calculateLayout();
      _calculateClientCounts();
    }
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _calculateLayout() {
    final effectiveMode = _resolveLayoutMode();
    _isHorizontalLayout = effectiveMode == LayoutRecommendation.horizontal;

    if (_isHorizontalLayout) {
      _nodePositions = widget.horizontalLayout.calculatePositions(widget.topology);
    } else {
      _nodePositions = widget.concentricLayout.calculatePositions(widget.topology);
    }
  }

  /// Resolve layout mode based on setting and topology analysis.
  LayoutRecommendation _resolveLayoutMode() {
    switch (widget.layoutMode) {
      case LayoutRecommendation.auto:
        final topologyType = TopologyAnalyzer.analyze(widget.topology);
        return TopologyAnalyzer.getRecommendedLayout(topologyType);
      case LayoutRecommendation.horizontal:
      case LayoutRecommendation.concentric:
        return widget.layoutMode;
    }
  }

  void _calculateClientCounts() {
    _clientCounts = {};
    for (final node in widget.topology.nodes) {
      if (node.isClient && node.parentId != null) {
        _clientCounts[node.parentId!] =
            (_clientCounts[node.parentId!] ?? 0) + 1;
      }
    }
  }

  /// Check if a client node should be visible based on visibility setting.
  bool _isClientVisible(MeshNode node) {
    if (!node.isClient) return true;

    switch (widget.clientVisibility) {
      case ClientVisibility.always:
        return true;
      case ClientVisibility.collapsed:
        return false;
      case ClientVisibility.onHover:
        return _hoveredNodeId == node.parentId;
      case ClientVisibility.clustered:
        // Show if parent has <= threshold clients, or if cluster is expanded
        final parentId = node.parentId;
        if (parentId == null) return true;
        final clientCount = _clientCounts[parentId] ?? 0;
        if (clientCount <= widget.clusterThreshold) return true;
        return _expandedClusters.contains(parentId);
    }
  }

  /// Check if a parent node should show a cluster badge.
  bool _shouldShowClusterBadge(String parentId) {
    if (widget.clientVisibility != ClientVisibility.clustered) return false;
    final clientCount = _clientCounts[parentId] ?? 0;
    return clientCount > widget.clusterThreshold;
  }

  /// Get clients for a specific parent node.
  List<MeshNode> _getClientsForParent(String parentId) {
    return widget.topology.nodes
        .where((n) => n.isClient && n.parentId == parentId)
        .toList();
  }

  /// Toggle cluster expansion state.
  void _toggleCluster(String parentId) {
    setState(() {
      if (_expandedClusters.contains(parentId)) {
        _expandedClusters.remove(parentId);
      } else {
        _expandedClusters.add(parentId);
      }
    });
  }

  /// Check if a link should be visible (based on client visibility).
  bool _isLinkVisible(MeshLink link) {
    final targetNode = widget.topology.nodes
        .where((n) => n.id == link.targetId)
        .firstOrNull;
    if (targetNode == null) return true;
    return _isClientVisible(targetNode);
  }

  void _onNodeHover(String? nodeId) {
    if (widget.clientVisibility == ClientVisibility.onHover) {
      setState(() {
        _hoveredNodeId = nodeId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_nodePositions.isEmpty) {
      return const Center(
        child: Text('No devices to display'),
      );
    }

    final theme = Theme.of(context).extension<AppDesignTheme>();
    final topologySpec = theme?.topologySpec;

    // Calculate bounds for the layout
    final defaultNodeSize = topologySpec?.gatewayNormalStyle.size ?? 64.0;
    final bounds = _isHorizontalLayout
        ? widget.horizontalLayout.calculateBounds(_nodePositions, defaultNodeSize)
        : widget.concentricLayout.calculateBounds(_nodePositions, defaultNodeSize);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate scale to fit layout in view with padding
        final scaleX = constraints.maxWidth / bounds.width;
        final scaleY = constraints.maxHeight / bounds.height;
        final fitScale = (scaleX < scaleY ? scaleX : scaleY).clamp(0.5, 1.5);

        // Center the layout in view
        final scaledWidth = bounds.width * fitScale;
        final scaledHeight = bounds.height * fitScale;
        final offsetX = (constraints.maxWidth - scaledWidth) / 2;
        final offsetY = (constraints.maxHeight - scaledHeight) / 2;

        return InteractiveViewer(
          transformationController: _transformationController,
          boundaryMargin: const EdgeInsets.all(200),
          minScale: 0.3,
          maxScale: 3.0,
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Link layer (behind nodes)
                CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: _LinksPainter(
                    topology: widget.topology,
                    positions: _nodePositions,
                    offset: Offset(
                      -bounds.left * fitScale + offsetX,
                      -bounds.top * fitScale + offsetY,
                    ),
                    scale: fitScale,
                    linkColor: Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
                    isLinkVisible: _isLinkVisible,
                  ),
                ),

                // Node layer - filter based on visibility
                ..._nodePositions.entries
                    .where((entry) => _isClientVisible(entry.value.node))
                    .map((entry) {
                  final nodeId = entry.key;
                  final nodePos = entry.value;
                  final node = nodePos.node;

                  // Scale and center node positions
                  final scaledX = (nodePos.position.dx - bounds.left) * fitScale + offsetX;
                  final scaledY = (nodePos.position.dy - bounds.top) * fitScale + offsetY;

                  // Calculate actual node size based on node type
                  // Clients are smaller (0.7x) than gateway/extenders
                  final nodeSize = node.isClient
                      ? defaultNodeSize * 0.7
                      : defaultNodeSize;
                  final scaledNodeSize = nodeSize * fitScale;

                  // Show client count badge on extenders when clients are hidden
                  final clientCount = _clientCounts[nodeId] ?? 0;
                  // Simple badge for onHover/collapsed modes (not clustered)
                  final showSimpleBadge = clientCount > 0 &&
                      widget.clientVisibility != ClientVisibility.always &&
                      widget.clientVisibility != ClientVisibility.clustered &&
                      (widget.clientVisibility == ClientVisibility.collapsed ||
                          _hoveredNodeId != nodeId);

                  // Menu items for this node
                  final menuItems = widget.nodeMenuBuilder?.call(context, node);
                  final hasMenu = menuItems != null && menuItems.isNotEmpty;
                  final menuSize = scaledNodeSize * 0.35;

                  return Positioned(
                    left: scaledX - (scaledNodeSize / 2),
                    top: scaledY - (scaledNodeSize / 2),
                    child: MouseRegion(
                      onEnter: (_) => _onNodeHover(nodeId),
                      onExit: (_) => _onNodeHover(null),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            width: scaledNodeSize,
                            height: scaledNodeSize,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: _buildNode(context, node, nodeId),
                            ),
                          ),
                          // Simple client count badge (for onHover/collapsed)
                          if (showSimpleBadge)
                            Positioned(
                              right: -4,
                              top: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$clientCount',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 10 * fitScale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          // Menu button (positioned outside FittedBox for correct scaling)
                          if (hasMenu)
                            Positioned(
                              right: -menuSize * 0.2,
                              bottom: -menuSize * 0.2,
                              child: SizedBox(
                                width: menuSize,
                                height: menuSize,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.15),
                                        blurRadius: 3,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: AppPopupMenu<String>(
                                    items: menuItems,
                                    onSelected: (value) =>
                                        widget.onNodeMenuSelected?.call(nodeId, value),
                                    icon: Icons.more_horiz,
                                    iconSize: menuSize * 0.5,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),

                // Cluster badges layer - rendered AFTER all nodes to ensure they're on top
                ..._nodePositions.entries
                    .where((entry) => _shouldShowClusterBadge(entry.key))
                    .map((entry) {
                  final nodeId = entry.key;
                  final nodePos = entry.value;

                  final scaledX = (nodePos.position.dx - bounds.left) * fitScale + offsetX;
                  final scaledY = (nodePos.position.dy - bounds.top) * fitScale + offsetY;
                  final scaledNodeSize = defaultNodeSize * fitScale;
                  final badgeSize = scaledNodeSize * 0.6;

                  return Positioned(
                    left: scaledX + (scaledNodeSize / 2) - (badgeSize * 0.3),
                    top: scaledY + (scaledNodeSize / 2) - (badgeSize * 0.3),
                    child: ClusterBadge(
                      parentId: nodeId,
                      clients: _getClientsForParent(nodeId),
                      isExpanded: _expandedClusters.contains(nodeId),
                      onTap: () => _toggleCluster(nodeId),
                      size: badgeSize,
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNode(BuildContext context, MeshNode node, String nodeId) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final topologySpec = theme?.topologySpec;

    if (topologySpec == null) {
      return const SizedBox.shrink();
    }

    final style = topologySpec.nodeStyleFor(node.type, node.status);

    Widget nodeWidget;

    if (node.isGateway) {
      nodeWidget = PulseNode(
        node: node,
        style: style,
        enableAnimation: widget.enableAnimation,
        contentBuilder: widget.nodeContentBuilder,
        onTap: widget.onNodeTap != null ? () => widget.onNodeTap!(nodeId) : null,
      );
    } else if (node.isExtender) {
      nodeWidget = LiquidNode(
        node: node,
        style: style,
        enableAnimation: widget.enableAnimation,
        contentBuilder: widget.nodeContentBuilder,
        onTap: widget.onNodeTap != null ? () => widget.onNodeTap!(nodeId) : null,
      );
    } else {
      // Client - use a simple container for now (OrbitNode will be added in Phase 6)
      nodeWidget = GestureDetector(
        onTap: widget.onNodeTap != null ? () => widget.onNodeTap!(nodeId) : null,
        child: Container(
          width: style.size * 0.7,
          height: style.size * 0.7,
          decoration: BoxDecoration(
            color: node.isOffline
                ? style.backgroundColor.withValues(alpha: 0.5)
                : style.backgroundColor,
            borderRadius: BorderRadius.circular(style.borderRadius * 0.7),
            border: style.borderWidth > 0
                ? Border.all(
                    color: style.borderColor,
                    width: style.borderWidth,
                  )
                : null,
          ),
          child: Center(
            child: Icon(
              node.iconData ?? Icons.devices,
              color: node.isOffline
                  ? style.iconColor.withValues(alpha: 0.5)
                  : style.iconColor,
              size: style.size * 0.35,
            ),
          ),
        ),
      );
    }

    // Menu button is now added in the outer Stack (build method)
    // to avoid positioning issues with FittedBox scaling

    return nodeWidget;
  }
}

/// Painter for drawing connection lines between nodes.
class _LinksPainter extends CustomPainter {
  final MeshTopology topology;
  final Map<String, NodePosition> positions;
  final Offset offset;
  final double scale;
  final Color linkColor;
  final bool Function(MeshLink)? isLinkVisible;

  _LinksPainter({
    required this.topology,
    required this.positions,
    required this.offset,
    required this.linkColor,
    this.scale = 1.0,
    this.isLinkVisible,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = linkColor
      ..strokeWidth = 2.0 * scale
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final link in topology.links) {
      // Skip invisible links
      if (isLinkVisible != null && !isLinkVisible!(link)) continue;

      final sourcePos = positions[link.sourceId];
      final targetPos = positions[link.targetId];

      if (sourcePos == null || targetPos == null) continue;

      // Scale positions and apply offset
      final start = Offset(
        sourcePos.position.dx * scale + offset.dx,
        sourcePos.position.dy * scale + offset.dy,
      );
      final end = Offset(
        targetPos.position.dx * scale + offset.dx,
        targetPos.position.dy * scale + offset.dy,
      );

      // Check if either node is offline for dashed line
      final sourceNode = positions[link.sourceId]?.node;
      final targetNode = positions[link.targetId]?.node;
      final isOffline = (sourceNode?.isOffline ?? false) || (targetNode?.isOffline ?? false);

      if (isOffline) {
        _drawDashedLine(canvas, start, end, paint..color = linkColor.withValues(alpha: 0.3));
      } else {
        // Color based on signal quality
        paint.color = _getLinkColor(link);
        canvas.drawLine(start, end, paint);
      }
    }
  }

  Color _getLinkColor(MeshLink link) {
    // Ethernet - neutral color
    if (link.isEthernet) {
      return linkColor;
    }

    // WiFi - color by signal quality
    switch (link.signalQuality) {
      case SignalQuality.strong:
        return Colors.green.withValues(alpha: 0.6);
      case SignalQuality.medium:
        return Colors.orange.withValues(alpha: 0.6);
      case SignalQuality.weak:
        return Colors.red.withValues(alpha: 0.6);
      case SignalQuality.wired:
      case SignalQuality.unknown:
        return linkColor;
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLength = 6.0;
    const gapLength = 4.0;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    if (dx == 0 && dy == 0) return;

    // Simple approximation for line length
    final lineLength = (dx.abs() + dy.abs()) * 0.7;
    if (lineLength == 0) return;

    final unitX = dx / lineLength;
    final unitY = dy / lineLength;

    var progress = 0.0;
    while (progress < lineLength) {
      final dashStart = progress;
      final dashEnd = (progress + dashLength).clamp(0.0, lineLength);

      canvas.drawLine(
        Offset(start.dx + unitX * dashStart, start.dy + unitY * dashStart),
        Offset(start.dx + unitX * dashEnd, start.dy + unitY * dashEnd),
        paint,
      );

      progress += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(_LinksPainter oldDelegate) {
    return topology != oldDelegate.topology ||
        positions != oldDelegate.positions ||
        offset != oldDelegate.offset ||
        scale != oldDelegate.scale;
  }
}
