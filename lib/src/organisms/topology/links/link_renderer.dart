import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../foundation/theme/design_system/app_design_theme.dart';
import '../models/mesh_link.dart';

/// Renders a connection link between two topology nodes.
///
/// Features:
/// - Solid line for Ethernet connections
/// - Dashed line for WiFi connections
/// - Color coding based on signal quality (RSSI)
/// - Optional flow animation for active WiFi links
///
/// Part of User Story 3: Identify Connection Quality.
class LinkRenderer extends StatelessWidget {
  /// The link data to render.
  final MeshLink link;

  /// Start position of the link.
  final Offset start;

  /// End position of the link.
  final Offset end;

  /// Whether the link is to/from an offline node.
  final bool isOffline;

  /// Whether to show flow animation (for WiFi links).
  final bool enableAnimation;

  /// Stroke width for the link line.
  final double strokeWidth;

  const LinkRenderer({
    super.key,
    required this.link,
    required this.start,
    required this.end,
    this.isOffline = false,
    this.enableAnimation = true,
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final topologySpec = theme?.topologySpec;
    final linkStyle = topologySpec?.linkStyleFor(link.signalQuality);

    // Calculate link bounds
    final minX = math.min(start.dx, end.dx);
    final minY = math.min(start.dy, end.dy);
    final maxX = math.max(start.dx, end.dx);
    final maxY = math.max(start.dy, end.dy);
    final width = maxX - minX + strokeWidth * 2;
    final height = maxY - minY + strokeWidth * 2;

    // Adjust positions relative to bounds
    final adjustedStart = Offset(
      start.dx - minX + strokeWidth,
      start.dy - minY + strokeWidth,
    );
    final adjustedEnd = Offset(
      end.dx - minX + strokeWidth,
      end.dy - minY + strokeWidth,
    );

    return Positioned(
      left: minX - strokeWidth,
      top: minY - strokeWidth,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            // Base link line
            CustomPaint(
              size: Size(width, height),
              painter: LinkPainter(
                start: adjustedStart,
                end: adjustedEnd,
                connectionType: link.connectionType,
                signalQuality: link.signalQuality,
                isOffline: isOffline,
                strokeWidth: strokeWidth,
                color: linkStyle?.color ?? _getDefaultColor(context),
              ),
            ),

            // Flow animation for WiFi (only if online and animation enabled)
            if (link.isWifi && !isOffline && enableAnimation)
              FlowAnimation(
                start: adjustedStart,
                end: adjustedEnd,
                color: linkStyle?.color ?? _getDefaultColor(context),
                speed: _getFlowSpeed(),
                strokeWidth: strokeWidth,
              ),
          ],
        ),
      ),
    );
  }

  Color _getDefaultColor(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outline;

    if (isOffline) {
      return outline.withValues(alpha: 0.3);
    }

    if (link.isEthernet) {
      return outline.withValues(alpha: 0.6);
    }

    // WiFi - color by signal quality
    switch (link.signalQuality) {
      case SignalQuality.strong:
        return Colors.green.withValues(alpha: 0.7);
      case SignalQuality.medium:
        return Colors.orange.withValues(alpha: 0.7);
      case SignalQuality.weak:
        return Colors.red.withValues(alpha: 0.7);
      case SignalQuality.wired:
      case SignalQuality.unknown:
        return outline.withValues(alpha: 0.5);
    }
  }

  double _getFlowSpeed() {
    // Speed based on throughput or signal quality
    if (link.throughput != null) {
      // Faster animation for higher throughput
      return (link.throughput! / 100).clamp(0.5, 3.0);
    }

    // Default speeds based on signal quality
    switch (link.signalQuality) {
      case SignalQuality.strong:
        return 2.0;
      case SignalQuality.medium:
        return 1.5;
      case SignalQuality.weak:
        return 1.0;
      default:
        return 1.0;
    }
  }
}

/// CustomPainter for drawing link lines.
///
/// Draws solid lines for Ethernet and dashed lines for WiFi.
class LinkPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final ConnectionType connectionType;
  final SignalQuality signalQuality;
  final bool isOffline;
  final double strokeWidth;
  final Color color;

  LinkPainter({
    required this.start,
    required this.end,
    required this.connectionType,
    required this.signalQuality,
    required this.isOffline,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (isOffline || connectionType == ConnectionType.wifi) {
      // Dashed line for WiFi or offline connections
      _drawDashedLine(canvas, paint);
    } else {
      // Solid line for Ethernet
      canvas.drawLine(start, end, paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Paint paint) {
    const dashLength = 6.0;
    const gapLength = 4.0;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    if (distance == 0) return;

    final unitX = dx / distance;
    final unitY = dy / distance;

    var progress = 0.0;
    while (progress < distance) {
      final dashStart = progress;
      final dashEnd = (progress + dashLength).clamp(0.0, distance);

      canvas.drawLine(
        Offset(start.dx + unitX * dashStart, start.dy + unitY * dashStart),
        Offset(start.dx + unitX * dashEnd, start.dy + unitY * dashEnd),
        paint,
      );

      progress += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(LinkPainter oldDelegate) {
    return start != oldDelegate.start ||
        end != oldDelegate.end ||
        connectionType != oldDelegate.connectionType ||
        signalQuality != oldDelegate.signalQuality ||
        isOffline != oldDelegate.isOffline ||
        color != oldDelegate.color;
  }
}

/// Animated flow effect for WiFi links.
///
/// Shows particles flowing along the link to indicate data transfer.
class FlowAnimation extends StatefulWidget {
  final Offset start;
  final Offset end;
  final Color color;
  final double speed;
  final double strokeWidth;

  const FlowAnimation({
    super.key,
    required this.start,
    required this.end,
    required this.color,
    this.speed = 1.0,
    this.strokeWidth = 2.0,
  });

  @override
  State<FlowAnimation> createState() => _FlowAnimationState();
}

class _FlowAnimationState extends State<FlowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: (2000 / widget.speed).round()),
      vsync: this,
    )..repeat();
  }

  @override
  void didUpdateWidget(FlowAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.speed != widget.speed) {
      _controller.duration =
          Duration(milliseconds: (2000 / widget.speed).round());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _FlowPainter(
            start: widget.start,
            end: widget.end,
            color: widget.color,
            progress: _controller.value,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

/// Painter for flow animation particles.
class _FlowPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;
  final double progress;
  final double strokeWidth;

  static const int particleCount = 3;
  static const double particleSize = 4.0;

  _FlowPainter({
    required this.start,
    required this.end,
    required this.color,
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;

    final paint = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    // Draw multiple particles along the path
    for (var i = 0; i < particleCount; i++) {
      final particleProgress = (progress + i / particleCount) % 1.0;

      // Fade in at start, fade out at end
      final alpha = _calculateAlpha(particleProgress);
      paint.color = color.withValues(alpha: alpha);

      final x = start.dx + dx * particleProgress;
      final y = start.dy + dy * particleProgress;

      canvas.drawCircle(
        Offset(x, y),
        particleSize / 2,
        paint,
      );
    }
  }

  double _calculateAlpha(double progress) {
    // Fade in from 0-0.1, full opacity 0.1-0.9, fade out 0.9-1.0
    if (progress < 0.1) {
      return progress * 10 * 0.8;
    } else if (progress > 0.9) {
      return (1 - progress) * 10 * 0.8;
    }
    return 0.8;
  }

  @override
  bool shouldRepaint(_FlowPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        start != oldDelegate.start ||
        end != oldDelegate.end ||
        color != oldDelegate.color;
  }
}

/// Preview widget for displaying link styles in isolation.
///
/// Used for golden tests and Widgetbook stories to showcase
/// different link types and signal qualities.
class LinkPreview extends StatelessWidget {
  /// Connection type to display.
  final ConnectionType connectionType;

  /// Signal quality for WiFi links.
  final SignalQuality signalQuality;

  /// Whether to show offline state.
  final bool isOffline;

  /// Whether to enable flow animation.
  final bool enableAnimation;

  /// Preview size.
  final Size size;

  /// Stroke width.
  final double strokeWidth;

  const LinkPreview({
    super.key,
    this.connectionType = ConnectionType.ethernet,
    this.signalQuality = SignalQuality.strong,
    this.isOffline = false,
    this.enableAnimation = false,
    this.size = const Size(250, 60),
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    final link = MeshLink(
      sourceId: 'source',
      targetId: 'target',
      connectionType: connectionType,
      rssi: _rssiFromQuality(signalQuality),
    );

    final start = Offset(30, size.height / 2);
    final end = Offset(size.width - 30, size.height / 2);

    final theme = Theme.of(context).extension<AppDesignTheme>();
    final topologySpec = theme?.topologySpec;
    final linkStyle = topologySpec?.linkStyleFor(link.signalQuality);
    final color = linkStyle?.color ?? _getDefaultColor(context, link);

    return Container(
      width: size.width,
      height: size.height,
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          // Link label
          Positioned(
            left: 8,
            top: 4,
            child: Text(
              _getLinkLabel(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          // Link line
          CustomPaint(
            size: size,
            painter: LinkPainter(
              start: start,
              end: end,
              connectionType: connectionType,
              signalQuality: signalQuality,
              isOffline: isOffline,
              strokeWidth: strokeWidth,
              color: color,
            ),
          ),
          // Flow animation
          if (connectionType == ConnectionType.wifi && !isOffline && enableAnimation)
            FlowAnimation(
              start: start,
              end: end,
              color: color,
              speed: _getFlowSpeed(),
              strokeWidth: strokeWidth,
            ),
          // Node indicators
          Positioned(
            left: start.dx - 8,
            top: start.dy - 8,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isOffline
                    ? Colors.grey.withValues(alpha: 0.5)
                    : Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: end.dx - 8,
            top: end.dy - 8,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isOffline
                    ? Colors.grey.withValues(alpha: 0.5)
                    : Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLinkLabel() {
    final type = connectionType == ConnectionType.ethernet ? 'Ethernet' : 'WiFi';
    final quality = signalQuality.name;
    final offline = isOffline ? ' (Offline)' : '';
    return '$type - $quality$offline';
  }

  Color _getDefaultColor(BuildContext context, MeshLink link) {
    final outline = Theme.of(context).colorScheme.outline;

    if (isOffline) {
      return outline.withValues(alpha: 0.3);
    }

    if (link.isEthernet) {
      return outline.withValues(alpha: 0.6);
    }

    switch (signalQuality) {
      case SignalQuality.strong:
        return Colors.green.withValues(alpha: 0.7);
      case SignalQuality.medium:
        return Colors.orange.withValues(alpha: 0.7);
      case SignalQuality.weak:
        return Colors.red.withValues(alpha: 0.7);
      case SignalQuality.wired:
      case SignalQuality.unknown:
        return outline.withValues(alpha: 0.5);
    }
  }

  int? _rssiFromQuality(SignalQuality quality) {
    switch (quality) {
      case SignalQuality.strong:
        return -45;
      case SignalQuality.medium:
        return -65;
      case SignalQuality.weak:
        return -80;
      case SignalQuality.wired:
      case SignalQuality.unknown:
        return null;
    }
  }

  double _getFlowSpeed() {
    switch (signalQuality) {
      case SignalQuality.strong:
        return 2.0;
      case SignalQuality.medium:
        return 1.5;
      case SignalQuality.weak:
        return 1.0;
      default:
        return 1.0;
    }
  }
}
