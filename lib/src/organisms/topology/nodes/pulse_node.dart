import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../foundation/theme/design_system/specs/topology_style.dart';
import '../models/mesh_node.dart';

/// Builder function for custom node content.
///
/// Parameters:
/// - [context]: Build context
/// - [node]: The mesh node data
/// - [style]: The node style from theme
/// - [isOffline]: Whether the node is currently offline
///
/// Returns a widget to display inside the node.
typedef NodeContentBuilder = Widget Function(
  BuildContext context,
  MeshNode node,
  NodeStyle style,
  bool isOffline,
);

/// A pulsating node widget for Gateway visualization.
///
/// Implements breathing animation that reflects device health:
/// - Normal: Slow 4-second breathing cycle
/// - High Load: Fast 1-second stressed breathing
/// - Offline: No animation, grayscale appearance
///
/// Content can be customized via [contentBuilder] to display
/// complex information beyond just icons or images.
///
/// Part of User Story 1: View Network Status at a Glance.
class PulseNode extends StatefulWidget {
  /// The mesh node data to display.
  final MeshNode node;

  /// Visual style from TopologySpec.
  final NodeStyle style;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Whether animations are enabled. Set to false for golden tests.
  final bool enableAnimation;

  /// Optional custom content builder.
  ///
  /// When provided, this builder is used to create the node's content
  /// instead of the default image/icon rendering.
  ///
  /// Example:
  /// ```dart
  /// PulseNode(
  ///   node: node,
  ///   style: style,
  ///   contentBuilder: (context, node, style, isOffline) {
  ///     return Column(
  ///       mainAxisSize: MainAxisSize.min,
  ///       children: [
  ///         Icon(Icons.router, size: 24),
  ///         Text(node.name, style: TextStyle(fontSize: 10)),
  ///       ],
  ///     );
  ///   },
  /// )
  /// ```
  final NodeContentBuilder? contentBuilder;

  const PulseNode({
    super.key,
    required this.node,
    required this.style,
    this.onTap,
    this.enableAnimation = true,
    this.contentBuilder,
  });

  @override
  State<PulseNode> createState() => _PulseNodeState();
}

class _PulseNodeState extends State<PulseNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  // Status change debounce
  DateTime? _lastStatusChange;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  @override
  void didUpdateWidget(PulseNode oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle status change with debounce (500ms)
    if (oldWidget.node.status != widget.node.status) {
      final now = DateTime.now();
      if (_lastStatusChange == null ||
          now.difference(_lastStatusChange!) > const Duration(milliseconds: 500)) {
        _lastStatusChange = now;
        _setupAnimation();
      }
    }
  }

  void _setupAnimation() {
    final isOffline = widget.node.status == MeshNodeStatus.offline;
    final isHighLoad = widget.node.status == MeshNodeStatus.highLoad;

    // Determine breathing period based on status
    final period = isHighLoad
        ? const Duration(milliseconds: 1000)
        : const Duration(milliseconds: 4000);

    _controller = AnimationController(
      vsync: this,
      duration: period,
    );

    // Scale animation: subtle breathing effect
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: isHighLoad ? 1.08 : 1.04,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Glow intensity animation
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start animation if not offline and animation is enabled
    if (!isOffline && widget.enableAnimation) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Build the node content.
  ///
  /// Priority order:
  /// 1. Custom contentBuilder (if provided)
  /// 2. Image asset (if provided)
  /// 3. Icon (default fallback)
  Widget _buildNodeContent(BuildContext context, NodeStyle style) {
    final isOffline = widget.node.isOffline;

    // Use custom content builder if provided
    if (widget.contentBuilder != null) {
      return widget.contentBuilder!(context, widget.node, style, isOffline);
    }

    final contentSize = style.size * 0.5;

    // Image takes priority if provided
    if (widget.node.imageAsset != null) {
      return ClipOval(
        child: Image.asset(
          widget.node.imageAsset!,
          width: contentSize,
          height: contentSize,
          fit: BoxFit.cover,
          color: isOffline ? style.iconColor.withValues(alpha: 0.5) : null,
          colorBlendMode: isOffline ? BlendMode.saturation : null,
          errorBuilder: (context, error, stackTrace) => Icon(
            widget.node.iconData ?? Icons.router,
            color: style.iconColor,
            size: contentSize,
          ),
        ),
      );
    }

    // Fallback to icon
    return Icon(
      widget.node.iconData ?? Icons.router,
      color: style.iconColor,
      size: contentSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = widget.node.status == MeshNodeStatus.offline;
    final style = widget.style;

    Widget nodeContent = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = widget.enableAnimation ? _scaleAnimation.value : 1.0;
        final glowIntensity = widget.enableAnimation ? _glowAnimation.value : 0.5;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: style.size,
            height: style.size,
            decoration: BoxDecoration(
              color: style.backgroundColor,
              borderRadius: style.borderRadius >= 999
                  ? null
                  : BorderRadius.circular(style.borderRadius),
              shape: style.borderRadius >= 999
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              border: style.borderWidth > 0
                  ? Border.all(
                      color: style.borderColor,
                      width: style.borderWidth,
                    )
                  : null,
              boxShadow: style.glowRadius > 0
                  ? [
                      BoxShadow(
                        color: style.glowColor.withValues(alpha: glowIntensity * 0.5),
                        blurRadius: style.glowRadius * glowIntensity,
                        spreadRadius: style.glowRadius * 0.3 * glowIntensity,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: _buildNodeContent(context, style),
            ),
          ),
        );
      },
    );

    // Apply grayscale effect for offline state
    if (isOffline) {
      nodeContent = ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ]),
        child: nodeContent,
      );
    }

    // Add glow effect using flutter_animate for online states
    if (!isOffline && widget.enableAnimation && style.glowRadius > 0) {
      nodeContent = nodeContent.animate(
        onPlay: (controller) => controller.repeat(reverse: true),
      ).shimmer(
        duration: widget.node.status == MeshNodeStatus.highLoad
            ? const Duration(milliseconds: 1500)
            : const Duration(milliseconds: 3000),
        color: style.glowColor.withValues(alpha: 0.3),
      );
    }

    // Wrap with gesture detector if tap callback provided
    if (widget.onTap != null) {
      nodeContent = GestureDetector(
        onTap: widget.onTap,
        child: nodeContent,
      );
    }

    // Add semantics for accessibility
    return Semantics(
      label: '${widget.node.name}, ${widget.node.type.name}, ${widget.node.status.name}',
      button: widget.onTap != null,
      child: nodeContent,
    );
  }
}
