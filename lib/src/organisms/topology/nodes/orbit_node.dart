import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../foundation/theme/design_system/specs/topology_style.dart';
import '../models/mesh_node.dart';
import 'pulse_node.dart' show NodeContentBuilder;

/// A satellite node widget for Client device visualization.
///
/// Implements orbital animation that indicates connection to parent:
/// - Idle: Continuous slow orbit around parent
/// - Hovered: Pause orbit and expand details
/// - Offline: No animation, grayscale appearance
///
/// Part of User Story 4: Explore Connected Clients.
class OrbitNode extends StatefulWidget {
  /// The mesh node data to display.
  final MeshNode node;

  /// Visual style from TopologySpec.
  final NodeStyle style;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Whether animations are enabled. Set to false for golden tests.
  final bool enableAnimation;

  /// Whether the orbit animation is paused (e.g., on hover).
  final bool isPaused;

  /// Whether details are expanded (e.g., on hover).
  final bool isExpanded;

  /// Callback when hover state changes.
  final ValueChanged<bool>? onHoverChanged;

  /// Optional custom content builder.
  final NodeContentBuilder? contentBuilder;

  /// Orbit radius from parent center.
  final double orbitRadius;

  /// Initial angle on the orbit (radians).
  final double initialAngle;

  /// Duration for one complete orbit.
  final Duration orbitDuration;

  const OrbitNode({
    super.key,
    required this.node,
    required this.style,
    this.onTap,
    this.enableAnimation = true,
    this.isPaused = false,
    this.isExpanded = false,
    this.onHoverChanged,
    this.contentBuilder,
    this.orbitRadius = 80.0,
    this.initialAngle = 0.0,
    this.orbitDuration = const Duration(seconds: 10),
  });

  @override
  State<OrbitNode> createState() => _OrbitNodeState();
}

class _OrbitNodeState extends State<OrbitNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _orbitController;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      duration: widget.orbitDuration,
      vsync: this,
    );

    if (widget.enableAnimation && !widget.node.isOffline && !widget.isPaused) {
      _orbitController.repeat();
    }

    // Start from initial angle position
    _orbitController.value = widget.initialAngle / (2 * math.pi);
  }

  @override
  void didUpdateWidget(OrbitNode oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle pause/resume
    if (oldWidget.isPaused != widget.isPaused) {
      if (widget.isPaused) {
        _orbitController.stop();
      } else if (widget.enableAnimation && !widget.node.isOffline) {
        _orbitController.repeat();
      }
    }

    // Handle offline state changes
    if (oldWidget.node.isOffline != widget.node.isOffline) {
      if (widget.node.isOffline) {
        _orbitController.stop();
      } else if (widget.enableAnimation && !widget.isPaused) {
        _orbitController.repeat();
      }
    }

    // Handle animation enable/disable
    if (oldWidget.enableAnimation != widget.enableAnimation) {
      if (!widget.enableAnimation) {
        _orbitController.stop();
      } else if (!widget.node.isOffline && !widget.isPaused) {
        _orbitController.repeat();
      }
    }
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    if (!_isHovering) {
      setState(() => _isHovering = true);
      widget.onHoverChanged?.call(true);
    }
  }

  void _onHoverExit() {
    if (_isHovering) {
      setState(() => _isHovering = false);
      widget.onHoverChanged?.call(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = widget.node.isOffline;
    final size = widget.style.size * 0.7; // Clients are smaller

    Widget nodeContent = _buildNodeContent(context, isOffline, size);

    // Apply offline grayscale effect
    if (isOffline) {
      nodeContent = ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 0.5, 0,
        ]),
        child: nodeContent,
      );
    }

    // Wrap with hover detection
    Widget result = MouseRegion(
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: nodeContent,
      ),
    );

    // Add expand animation when hovered
    if (widget.enableAnimation && (_isHovering || widget.isExpanded)) {
      result = result
          .animate()
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.15, 1.15),
            duration: 200.ms,
            curve: Curves.easeOutCubic,
          );
    }

    // Add semantics for accessibility
    return Semantics(
      label: '${widget.node.name}, Client device, ${widget.node.status.name}${widget.node.deviceCategory != null ? ', ${widget.node.deviceCategory}' : ''}',
      button: widget.onTap != null,
      child: result,
    );
  }

  Widget _buildNodeContent(BuildContext context, bool isOffline, double size) {
    // Custom content builder
    if (widget.contentBuilder != null) {
      return Container(
        width: size,
        height: size,
        decoration: _buildDecoration(isOffline),
        child: Center(
          child: widget.contentBuilder!(
            context,
            widget.node,
            widget.style,
            isOffline,
          ),
        ),
      );
    }

    // Default icon content
    return Container(
      width: size,
      height: size,
      decoration: _buildDecoration(isOffline),
      child: Center(
        child: Icon(
          widget.node.iconData ?? _getDefaultIcon(),
          color: isOffline
              ? widget.style.iconColor.withValues(alpha: 0.5)
              : widget.style.iconColor,
          size: size * 0.5,
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(bool isOffline) {
    return BoxDecoration(
      color: isOffline
          ? widget.style.backgroundColor.withValues(alpha: 0.5)
          : widget.style.backgroundColor,
      borderRadius: BorderRadius.circular(widget.style.borderRadius * 0.7),
      border: widget.style.borderWidth > 0
          ? Border.all(
              color: widget.style.borderColor,
              width: widget.style.borderWidth,
            )
          : null,
      boxShadow: widget.style.glowRadius > 0
          ? [
              BoxShadow(
                color: widget.style.glowColor,
                blurRadius: widget.style.glowRadius,
              ),
            ]
          : null,
    );
  }

  IconData _getDefaultIcon() {
    // Return icon based on device category
    final category = widget.node.deviceCategory;
    if (category == null) return Icons.devices;

    switch (category.toLowerCase()) {
      case 'laptop':
        return Icons.laptop;
      case 'smartphone':
      case 'phone':
        return Icons.smartphone;
      case 'tablet':
        return Icons.tablet;
      case 'tv':
        return Icons.tv;
      case 'gaming':
        return Icons.sports_esports;
      case 'iot':
      case 'sensor':
        return Icons.sensors;
      case 'camera':
        return Icons.videocam;
      case 'speaker':
        return Icons.speaker;
      default:
        return Icons.devices_other;
    }
  }
}

/// A group of orbit nodes with synchronized animation.
///
/// Used when displaying multiple clients connected to the same parent.
/// Provides:
/// - Evenly spaced orbit positioning
/// - Shared ticker for synchronized animation
/// - Hover to reveal all clients
class OrbitNodeGroup extends StatefulWidget {
  /// Client nodes to display in orbit.
  final List<MeshNode> clients;

  /// Callback to get style for a node.
  final NodeStyle Function(MeshNode node) styleForNode;

  /// Orbit radius from center.
  final double orbitRadius;

  /// Whether animations are enabled.
  final bool enableAnimation;

  /// Callback when a node is tapped.
  final ValueChanged<String>? onNodeTap;

  /// Optional custom content builder.
  final NodeContentBuilder? contentBuilder;

  const OrbitNodeGroup({
    super.key,
    required this.clients,
    required this.styleForNode,
    this.orbitRadius = 80.0,
    this.enableAnimation = true,
    this.onNodeTap,
    this.contentBuilder,
  });

  @override
  State<OrbitNodeGroup> createState() => _OrbitNodeGroupState();
}

class _OrbitNodeGroupState extends State<OrbitNodeGroup>
    with SingleTickerProviderStateMixin {
  late AnimationController _sharedOrbitController;
  String? _hoveredNodeId;

  @override
  void initState() {
    super.initState();
    _sharedOrbitController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    if (widget.enableAnimation) {
      _sharedOrbitController.repeat();
    }
  }

  @override
  void dispose() {
    _sharedOrbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clients.isEmpty) {
      return const SizedBox.shrink();
    }

    final angleStep = (2 * math.pi) / widget.clients.length;

    // Calculate max node size for proper sizing
    double maxNodeSize = 0;
    for (final client in widget.clients) {
      final style = widget.styleForNode(client);
      final nodeSize = style.size * 0.7;
      if (nodeSize > maxNodeSize) maxNodeSize = nodeSize;
    }

    // Container size: diameter of orbit + max node size for padding
    final containerSize = (widget.orbitRadius * 2) + maxNodeSize;
    final center = containerSize / 2;

    return AnimatedBuilder(
      animation: _sharedOrbitController,
      builder: (context, child) {
        return SizedBox(
          width: containerSize,
          height: containerSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(widget.clients.length, (index) {
              final client = widget.clients[index];
              final baseAngle = index * angleStep;
              final currentAngle = baseAngle + (_sharedOrbitController.value * 2 * math.pi);

              final x = math.cos(currentAngle) * widget.orbitRadius;
              final y = math.sin(currentAngle) * widget.orbitRadius;

              final style = widget.styleForNode(client);
              final nodeSize = style.size * 0.7;

              return Positioned(
                left: center + x - (nodeSize / 2),
                top: center + y - (nodeSize / 2),
                child: OrbitNode(
                  node: client,
                  style: style,
                  enableAnimation: false, // Group handles animation
                  isPaused: _hoveredNodeId != null,
                  isExpanded: _hoveredNodeId == client.id,
                  contentBuilder: widget.contentBuilder,
                  onTap: widget.onNodeTap != null
                      ? () => widget.onNodeTap!(client.id)
                      : null,
                  onHoverChanged: (isHovering) {
                    setState(() {
                      _hoveredNodeId = isHovering ? client.id : null;
                    });
                    if (isHovering) {
                      _sharedOrbitController.stop();
                    } else if (widget.enableAnimation) {
                      _sharedOrbitController.repeat();
                    }
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

/// Preview widget for OrbitNode golden tests.
class OrbitNodePreview extends StatelessWidget {
  /// The mesh node to display.
  final MeshNode node;

  /// Visual style from TopologySpec.
  final NodeStyle style;

  /// Whether to show expanded state.
  final bool isExpanded;

  /// Whether to show offline state.
  final bool isOffline;

  const OrbitNodePreview({
    super.key,
    required this.node,
    required this.style,
    this.isExpanded = false,
    this.isOffline = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Center(
        child: OrbitNode(
          node: node.copyWith(
            status: isOffline ? MeshNodeStatus.offline : node.status,
          ),
          style: style,
          enableAnimation: false,
          isExpanded: isExpanded,
        ),
      ),
    );
  }
}
