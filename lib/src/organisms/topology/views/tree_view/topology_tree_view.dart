import 'package:flutter/material.dart';

import '../../../../molecules/menu/app_popup_menu.dart';
import '../../../../molecules/menu/app_popup_menu_item.dart';
import '../../models/mesh_node.dart';
import '../../models/mesh_topology.dart';
import '../../nodes/pulse_node.dart' show NodeContentBuilder;
import '../../types/topology_types.dart';

/// Tree View for mesh topology visualization.
///
/// Displays devices in a hierarchical list format optimized for mobile.
/// Features:
/// - Hierarchical indentation based on parent-child relationships
/// - Connection lines (solid for online, dashed for offline)
/// - Offline nodes sorted to the end within each level
/// - Context menu support via [nodeMenuBuilder]
///
/// Part of User Story 2 & 6: Responsive View Switching & Network Hierarchy.
class TopologyTreeView extends StatelessWidget {
  /// The mesh topology data to display.
  final MeshTopology topology;

  /// Callback when a node is tapped.
  final void Function(String nodeId)? onNodeTap;

  /// Builder for node context menu items.
  final NodeMenuBuilder? nodeMenuBuilder;

  /// Callback when a menu item is selected on a node.
  final void Function(String nodeId, String value)? onNodeMenuSelected;

  /// Custom content builder for nodes.
  final NodeContentBuilder? nodeContentBuilder;

  /// Indentation per level in logical pixels.
  static const double _indentPerLevel = 24.0;

  /// Line width for connection lines.
  static const double _lineWidth = 1.5;

  const TopologyTreeView({
    super.key,
    required this.topology,
    this.onNodeTap,
    this.nodeMenuBuilder,
    this.onNodeMenuSelected,
    this.nodeContentBuilder,
  });

  /// Build hierarchical tree structure from flat node list.
  List<_TreeNode> _buildTree() {
    final nodeMap = <String, MeshNode>{};
    final childrenMap = <String?, List<MeshNode>>{};

    // Index nodes
    for (final node in topology.nodes) {
      nodeMap[node.id] = node;
      childrenMap.putIfAbsent(node.parentId, () => []).add(node);
    }

    // Sort children: online first, then offline
    for (final children in childrenMap.values) {
      children.sort((a, b) {
        if (a.isOffline && !b.isOffline) return 1;
        if (!a.isOffline && b.isOffline) return -1;
        return a.name.compareTo(b.name);
      });
    }

    // Build tree recursively
    List<_TreeNode> buildSubtree(String? parentId, int depth) {
      final children = childrenMap[parentId] ?? [];
      final result = <_TreeNode>[];

      for (var i = 0; i < children.length; i++) {
        final node = children[i];
        final isLast = i == children.length - 1;
        final subtree = buildSubtree(node.id, depth + 1);

        result.add(_TreeNode(
          node: node,
          depth: depth,
          isLast: isLast,
          children: subtree,
        ));
      }

      return result;
    }

    return buildSubtree(null, 0);
  }

  /// Flatten tree for ListView rendering.
  List<_FlatTreeItem> _flattenTree(List<_TreeNode> tree) {
    final result = <_FlatTreeItem>[];

    void flatten(_TreeNode treeNode, List<bool> ancestorIsLast) {
      result.add(_FlatTreeItem(
        node: treeNode.node,
        depth: treeNode.depth,
        isLast: treeNode.isLast,
        ancestorIsLast: List.from(ancestorIsLast),
        hasChildren: treeNode.children.isNotEmpty,
      ));

      final newAncestorIsLast = [...ancestorIsLast, treeNode.isLast];
      for (final child in treeNode.children) {
        flatten(child, newAncestorIsLast);
      }
    }

    for (final node in tree) {
      flatten(node, []);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final tree = _buildTree();
    final flatList = _flattenTree(tree);

    if (flatList.isEmpty) {
      return const Center(
        child: Text('No devices'),
      );
    }

    return ListView.builder(
      itemCount: flatList.length,
      itemBuilder: (context, index) {
        final item = flatList[index];
        return _TreeNodeTile(
          item: item,
          onTap: onNodeTap != null ? () => onNodeTap!(item.node.id) : null,
          menuItems: nodeMenuBuilder?.call(context, item.node),
          onMenuSelected: onNodeMenuSelected != null
              ? (value) => onNodeMenuSelected!(item.node.id, value)
              : null,
        );
      },
    );
  }
}

/// Internal tree node representation.
class _TreeNode {
  final MeshNode node;
  final int depth;
  final bool isLast;
  final List<_TreeNode> children;

  _TreeNode({
    required this.node,
    required this.depth,
    required this.isLast,
    required this.children,
  });
}

/// Flattened tree item for ListView.
class _FlatTreeItem {
  final MeshNode node;
  final int depth;
  final bool isLast;
  final List<bool> ancestorIsLast;
  final bool hasChildren;

  _FlatTreeItem({
    required this.node,
    required this.depth,
    required this.isLast,
    required this.ancestorIsLast,
    required this.hasChildren,
  });
}

/// Widget for rendering a single tree node with connection lines.
class _TreeNodeTile extends StatelessWidget {
  final _FlatTreeItem item;
  final VoidCallback? onTap;
  final List<AppPopupMenuItem<String>>? menuItems;
  final void Function(String value)? onMenuSelected;

  /// Total height of each tile row including content
  static const double _tileHeight = 56.0;

  const _TreeNodeTile({
    required this.item,
    this.onTap,
    this.menuItems,
    this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOffline = item.node.isOffline;
    final lineColor = theme.colorScheme.outline.withValues(alpha: 0.6);

    Widget tileContent = SizedBox(
        height: _tileHeight,
        child: Row(
          children: [
            // Connection lines for ancestors (vertical continuation)
            ...List.generate(item.depth, (i) {
              final isAncestorLast = i < item.ancestorIsLast.length
                  ? item.ancestorIsLast[i]
                  : false;
              return SizedBox(
                width: TopologyTreeView._indentPerLevel,
                height: _tileHeight,
                child: CustomPaint(
                  painter: _VerticalLinePainter(
                    color: lineColor,
                    drawLine: !isAncestorLast,
                  ),
                ),
              );
            }),

            // Connector to this node (L or T shape)
            if (item.depth > 0)
              SizedBox(
                width: TopologyTreeView._indentPerLevel,
                height: _tileHeight,
                child: CustomPaint(
                  painter: _ConnectorPainter(
                    color: lineColor,
                    isLast: item.isLast,
                    isDashed: isOffline,
                  ),
                ),
              ),

            // Node icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isOffline
                    ? theme.colorScheme.surfaceContainerHighest
                    : _getNodeColor(item.node, theme),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isOffline
                      ? theme.colorScheme.outline
                      : _getNodeColor(item.node, theme),
                  width: isOffline ? 1 : 0,
                ),
              ),
              child: Icon(
                _getNodeIcon(item.node),
                color: isOffline
                    ? theme.colorScheme.outline
                    : theme.colorScheme.onPrimary,
                size: 20,
              ),
            ),

            const SizedBox(width: 12),

            // Node info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.node.name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isOffline
                          ? theme.colorScheme.outline
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        item.node.type.name.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(item.node).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.node.status.name,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _getStatusColor(item.node),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (item.node.isExtender) ...[
                        const SizedBox(width: 8),
                        Text(
                          '${(item.node.load * 100).toInt()}%',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: item.node.load > 0.7
                                ? Colors.red
                                : theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Menu button or Chevron
            if (menuItems != null && menuItems!.isNotEmpty)
              AppPopupMenu<String>(
                items: menuItems!,
                onSelected: (value) => onMenuSelected?.call(value),
                icon: Icons.more_vert,
                iconSize: 20,
              )
            else
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.outline,
              ),

            const SizedBox(width: 8),
          ],
        ),
      );

    // Wrap with InkWell for tap handling
    return InkWell(
      onTap: onTap,
      child: tileContent,
    );
  }

  IconData _getNodeIcon(MeshNode node) {
    if (node.iconData != null) return node.iconData!;
    switch (node.type) {
      case MeshNodeType.gateway:
        return Icons.router;
      case MeshNodeType.extender:
        return Icons.wifi_tethering;
      case MeshNodeType.client:
        return Icons.devices;
    }
  }

  Color _getNodeColor(MeshNode node, ThemeData theme) {
    switch (node.type) {
      case MeshNodeType.gateway:
        return theme.colorScheme.primary;
      case MeshNodeType.extender:
        return Colors.orange;
      case MeshNodeType.client:
        return theme.colorScheme.secondary;
    }
  }

  Color _getStatusColor(MeshNode node) {
    switch (node.status) {
      case MeshNodeStatus.online:
        return Colors.green;
      case MeshNodeStatus.highLoad:
        return Colors.orange;
      case MeshNodeStatus.offline:
        return Colors.grey;
    }
  }
}

/// Painter for vertical continuation lines.
class _VerticalLinePainter extends CustomPainter {
  final Color color;
  final bool drawLine;

  _VerticalLinePainter({
    required this.color,
    required this.drawLine,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!drawLine) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = TopologyTreeView._lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    // Draw full vertical line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(_VerticalLinePainter oldDelegate) =>
      color != oldDelegate.color || drawLine != oldDelegate.drawLine;
}

/// Painter for connector lines (L-shaped or T-shaped).
class _ConnectorPainter extends CustomPainter {
  final Color color;
  final bool isLast;
  final bool isDashed;

  _ConnectorPainter({
    required this.color,
    required this.isLast,
    required this.isDashed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = TopologyTreeView._lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    if (isDashed) {
      // Draw dashed vertical line
      _drawDashedLine(
        canvas,
        Offset(centerX, 0),
        Offset(centerX, isLast ? centerY : size.height),
        paint,
      );
      // Draw dashed horizontal line
      _drawDashedLine(
        canvas,
        Offset(centerX, centerY),
        Offset(size.width, centerY),
        paint,
      );
    } else {
      // Solid vertical line (from top to center for L, or full height for T)
      canvas.drawLine(
        Offset(centerX, 0),
        Offset(centerX, isLast ? centerY : size.height),
        paint,
      );

      // Solid horizontal line (from center to right edge)
      canvas.drawLine(
        Offset(centerX, centerY),
        Offset(size.width, centerY),
        paint,
      );
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLength = 4.0;
    const gapLength = 3.0;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final totalLength = (dx.abs() > dy.abs()) ? dx.abs() : dy.abs();
    if (totalLength == 0) return;

    final unitX = dx / totalLength;
    final unitY = dy / totalLength;

    var progress = 0.0;
    while (progress < totalLength) {
      final dashStart = progress;
      final dashEnd = (progress + dashLength).clamp(0.0, totalLength);

      canvas.drawLine(
        Offset(start.dx + unitX * dashStart, start.dy + unitY * dashStart),
        Offset(start.dx + unitX * dashEnd, start.dy + unitY * dashEnd),
        paint,
      );

      progress += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(_ConnectorPainter oldDelegate) =>
      color != oldDelegate.color ||
      isLast != oldDelegate.isLast ||
      isDashed != oldDelegate.isDashed;
}
