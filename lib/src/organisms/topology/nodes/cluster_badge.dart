import 'package:flutter/material.dart';

import '../../../foundation/theme/design_system/app_design_theme.dart';
import '../models/mesh_node.dart';

/// A badge widget that represents a cluster of client nodes.
///
/// Used when [ClientVisibility.clustered] is enabled and the number of
/// clients exceeds the threshold (default: 20).
///
/// Features:
/// - Displays client count
/// - Shows category breakdown on hover
/// - Tap to expand and show individual clients
/// - Applies theme-specific styling from TopologySpec
class ClusterBadge extends StatefulWidget {
  /// The parent node ID this cluster belongs to.
  final String parentId;

  /// The clients in this cluster.
  final List<MeshNode> clients;

  /// Whether the cluster is currently expanded.
  final bool isExpanded;

  /// Callback when the cluster is tapped.
  final VoidCallback? onTap;

  /// Size of the badge.
  final double size;

  const ClusterBadge({
    super.key,
    required this.parentId,
    required this.clients,
    this.isExpanded = false,
    this.onTap,
    this.size = 48.0,
  });

  @override
  State<ClusterBadge> createState() => _ClusterBadgeState();
}

class _ClusterBadgeState extends State<ClusterBadge> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designTheme = theme.extension<AppDesignTheme>();
    final topologySpec = designTheme?.topologySpec;

    // Use client style as base for cluster badge
    final clientStyle = topologySpec?.clientNormalStyle;

    // Fallback colors if theme not available
    final backgroundColor = widget.isExpanded
        ? (clientStyle?.borderColor ?? theme.colorScheme.primary)
        : (clientStyle?.backgroundColor ?? theme.colorScheme.surfaceContainerHighest);
    final borderColor = clientStyle?.borderColor ?? theme.colorScheme.outline;
    final borderWidth = clientStyle?.borderWidth ?? 2.0;
    final iconColor = widget.isExpanded
        ? (clientStyle?.backgroundColor ?? theme.colorScheme.onPrimary)
        : (clientStyle?.iconColor ?? theme.colorScheme.onSurfaceVariant);
    final glowColor = clientStyle?.glowColor ?? theme.colorScheme.primary;
    final glowRadius = clientStyle?.glowRadius ?? 8.0;

    return Semantics(
      label: '${widget.clients.length} devices cluster, tap to ${widget.isExpanded ? "collapse" : "expand"}',
      button: true,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor.withValues(alpha: _isHovering ? 0.8 : 0.5),
                width: borderWidth,
              ),
              boxShadow: _isHovering || widget.isExpanded
                  ? [
                      BoxShadow(
                        color: glowColor.withValues(alpha: 0.3),
                        blurRadius: glowRadius,
                        spreadRadius: glowRadius * 0.25,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: _isHovering && !widget.isExpanded
                  ? _buildHoverContent(iconColor)
                  : _buildDefaultContent(iconColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultContent(Color iconColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.devices,
          size: widget.size * 0.35,
          color: iconColor,
        ),
        Text(
          '+${widget.clients.length}',
          style: TextStyle(
            fontSize: widget.size * 0.22,
            fontWeight: FontWeight.bold,
            color: iconColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHoverContent(Color iconColor) {
    // Simple hover content showing count and tap hint
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${widget.clients.length}',
          style: TextStyle(
            fontSize: widget.size * 0.3,
            fontWeight: FontWeight.bold,
            color: iconColor,
          ),
        ),
        Text(
          'tap',
          style: TextStyle(
            fontSize: widget.size * 0.18,
            color: iconColor.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

/// A preview widget for ClusterBadge in Widgetbook and golden tests.
class ClusterBadgePreview extends StatelessWidget {
  final int clientCount;
  final bool isExpanded;

  const ClusterBadgePreview({
    super.key,
    this.clientCount = 25,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    // Generate mock clients
    final clients = List.generate(
      clientCount,
      (i) => MeshNode(
        id: 'client-$i',
        name: 'Device $i',
        type: MeshNodeType.client,
        parentId: 'extender-1',
        deviceCategory: ['smartphone', 'laptop', 'tablet', 'tv', 'iot'][i % 5],
      ),
    );

    return Center(
      child: ClusterBadge(
        parentId: 'extender-1',
        clients: clients,
        isExpanded: isExpanded,
        onTap: () {},
      ),
    );
  }
}
