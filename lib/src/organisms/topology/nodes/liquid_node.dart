import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../foundation/theme/design_system/specs/topology_style.dart';
import '../models/mesh_node.dart';
import 'pulse_node.dart' show NodeContentBuilder;

/// A liquid-level node widget for Extender visualization.
///
/// Shows load as water level with wave animation:
/// - Water level corresponds to load percentage (0-100%)
/// - Turbulence increases at high load (>70%)
/// - Color interpolates from blue (cool) to orange/red (hot) based on load
///
/// Content can be customized via [contentBuilder] to display
/// complex information beyond just icons or images.
///
/// Part of User Story 1: View Network Status at a Glance.
class LiquidNode extends StatefulWidget {
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
  /// LiquidNode(
  ///   node: node,
  ///   style: style,
  ///   contentBuilder: (context, node, style, isOffline) {
  ///     return Column(
  ///       mainAxisSize: MainAxisSize.min,
  ///       children: [
  ///         Icon(Icons.wifi_tethering, size: 20),
  ///         Text('${(node.load * 100).toInt()}%'),
  ///       ],
  ///     );
  ///   },
  /// )
  /// ```
  final NodeContentBuilder? contentBuilder;

  const LiquidNode({
    super.key,
    required this.node,
    required this.style,
    this.onTap,
    this.enableAnimation = true,
    this.contentBuilder,
  });

  @override
  State<LiquidNode> createState() => _LiquidNodeState();
}

class _LiquidNodeState extends State<LiquidNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    if (widget.enableAnimation && widget.node.status != MeshNodeStatus.offline) {
      _waveController.repeat();
    }
  }

  @override
  void didUpdateWidget(LiquidNode oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.node.status == MeshNodeStatus.offline) {
      _waveController.stop();
    } else if (widget.enableAnimation && !_waveController.isAnimating) {
      _waveController.repeat();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  /// Build the node content.
  ///
  /// Priority order:
  /// 1. Custom contentBuilder (if provided)
  /// 2. Image asset (if provided)
  /// 3. Icon (default fallback)
  Widget _buildNodeContent(BuildContext context, NodeStyle style, bool isOffline) {
    // Use custom content builder if provided
    if (widget.contentBuilder != null) {
      return widget.contentBuilder!(context, widget.node, style, isOffline);
    }

    final contentSize = style.size * 0.45;

    // Image takes priority if provided
    if (widget.node.imageAsset != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(style.borderRadius * 0.3),
        child: Image.asset(
          widget.node.imageAsset!,
          width: contentSize,
          height: contentSize,
          fit: BoxFit.cover,
          color: isOffline ? style.iconColor.withValues(alpha: 0.5) : null,
          colorBlendMode: isOffline ? BlendMode.saturation : null,
          errorBuilder: (context, error, stackTrace) => Icon(
            widget.node.iconData ?? Icons.wifi_tethering,
            color: isOffline
                ? style.iconColor.withValues(alpha: 0.5)
                : style.iconColor,
            size: contentSize,
          ),
        ),
      );
    }

    // Fallback to icon
    return Icon(
      widget.node.iconData ?? Icons.wifi_tethering,
      color: isOffline
          ? style.iconColor.withValues(alpha: 0.5)
          : style.iconColor,
      size: contentSize,
    );
  }

  /// Calculate wave color based on load level.
  Color _getWaveColor() {
    final load = widget.node.load.clamp(0.0, 1.0);

    // Interpolate from cool (blue-ish) to hot (orange/red)
    if (load < 0.5) {
      // Cool to warm: blue -> yellow
      return Color.lerp(
        Colors.blue.shade400,
        Colors.amber.shade400,
        load * 2,
      )!;
    } else {
      // Warm to hot: yellow -> red
      return Color.lerp(
        Colors.amber.shade400,
        Colors.red.shade400,
        (load - 0.5) * 2,
      )!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = widget.node.status == MeshNodeStatus.offline;
    final style = widget.style;
    final load = widget.node.load.clamp(0.0, 1.0);
    final isHighLoad = load > 0.7;

    Widget nodeContent = AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Container(
          width: style.size,
          height: style.size,
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(style.borderRadius),
            border: style.borderWidth > 0
                ? Border.all(
                    color: style.borderColor,
                    width: style.borderWidth,
                  )
                : null,
            boxShadow: style.glowRadius > 0
                ? [
                    BoxShadow(
                      color: style.glowColor,
                      blurRadius: style.glowRadius,
                      spreadRadius: style.glowRadius * 0.2,
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              style.borderRadius - style.borderWidth,
            ),
            child: Stack(
              children: [
                // Wave layer
                if (!isOffline)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: WavePainter(
                        wavePhase: widget.enableAnimation
                            ? _waveController.value * 2 * math.pi
                            : 0,
                        waterLevel: load,
                        waveColor: _getWaveColor(),
                        turbulence: isHighLoad ? 0.15 : 0.05,
                      ),
                    ),
                  ),
                // Content layer (image or icon)
                Center(
                  child: _buildNodeContent(context, style, isOffline),
                ),
              ],
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

    // Wrap with gesture detector if tap callback provided
    if (widget.onTap != null) {
      nodeContent = GestureDetector(
        onTap: widget.onTap,
        child: nodeContent,
      );
    }

    // Add semantics for accessibility
    return Semantics(
      label: '${widget.node.name}, Extender, ${(load * 100).toInt()}% load, ${widget.node.status.name}',
      button: widget.onTap != null,
      child: nodeContent,
    );
  }
}

/// Custom painter for liquid wave animation.
///
/// Draws a wave at the specified water level with configurable
/// turbulence for high-load visualization.
class WavePainter extends CustomPainter {
  /// Current phase of wave animation (0 to 2π).
  final double wavePhase;

  /// Water level as percentage (0.0 to 1.0).
  final double waterLevel;

  /// Color of the wave/water.
  final Color waveColor;

  /// Turbulence factor (higher = more chaotic waves).
  final double turbulence;

  WavePainter({
    required this.wavePhase,
    required this.waterLevel,
    required this.waveColor,
    this.turbulence = 0.05,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Calculate base Y position (inverted: 0 load = bottom, 1 load = top)
    final baseY = size.height * (1 - waterLevel);

    // Wave parameters
    final waveHeight = size.height * turbulence;
    const frequency = 2.0;

    // Start path from bottom-left
    path.moveTo(0, size.height);

    // Draw wave across the top of water
    for (double x = 0; x <= size.width; x += 2) {
      final normalizedX = x / size.width;
      final y = baseY +
          math.sin((normalizedX * frequency * math.pi * 2) + wavePhase) *
              waveHeight +
          math.sin((normalizedX * frequency * math.pi * 4) + wavePhase * 1.5) *
              waveHeight *
              0.5;
      path.lineTo(x, y);
    }

    // Complete the path to fill
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Draw a second wave layer for depth effect
    final paint2 = Paint()
      ..color = waveColor.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x += 2) {
      final normalizedX = x / size.width;
      final y = baseY +
          math.sin((normalizedX * frequency * math.pi * 2) + wavePhase + math.pi) *
              waveHeight *
              0.7 +
          waveHeight * 0.3;
      path2.lineTo(x, y);
    }

    path2.lineTo(size.width, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.wavePhase != wavePhase ||
        oldDelegate.waterLevel != waterLevel ||
        oldDelegate.waveColor != waveColor ||
        oldDelegate.turbulence != turbulence;
  }
}
