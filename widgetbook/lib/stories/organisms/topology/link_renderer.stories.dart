import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'All Link Types',
  type: LinkRenderer,
)
Widget buildAllLinkTypes(BuildContext context) {
  return DesignSystem.init(
    context,
    SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLinkDemo(
            context,
            'Ethernet (Solid)',
            const MeshLink(
              sourceId: 'a',
              targetId: 'b',
              connectionType: ConnectionType.ethernet,
            ),
          ),
          const SizedBox(height: 24),
          _buildLinkDemo(
            context,
            'WiFi Strong (-45 dBm)',
            const MeshLink(
              sourceId: 'a',
              targetId: 'b',
              connectionType: ConnectionType.wifi,
              rssi: -45,
            ),
          ),
          const SizedBox(height: 24),
          _buildLinkDemo(
            context,
            'WiFi Medium (-60 dBm)',
            const MeshLink(
              sourceId: 'a',
              targetId: 'b',
              connectionType: ConnectionType.wifi,
              rssi: -60,
            ),
          ),
          const SizedBox(height: 24),
          _buildLinkDemo(
            context,
            'WiFi Weak (-75 dBm)',
            const MeshLink(
              sourceId: 'a',
              targetId: 'b',
              connectionType: ConnectionType.wifi,
              rssi: -75,
            ),
          ),
          const SizedBox(height: 24),
          _buildLinkDemo(
            context,
            'WiFi Unknown Signal',
            const MeshLink(
              sourceId: 'a',
              targetId: 'b',
              connectionType: ConnectionType.wifi,
            ),
          ),
          const SizedBox(height: 24),
          _buildLinkDemo(
            context,
            'Offline Connection',
            const MeshLink(
              sourceId: 'a',
              targetId: 'b',
              connectionType: ConnectionType.wifi,
              rssi: -50,
            ),
            isOffline: true,
          ),
        ],
      ),
    ),
  );
}

Widget _buildLinkDemo(
  BuildContext context,
  String label,
  MeshLink link, {
  bool isOffline = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      const SizedBox(height: 8),
      SizedBox(
        width: 300,
        height: 40,
        child: CustomPaint(
          painter: LinkPainter(
            start: const Offset(20, 20),
            end: const Offset(280, 20),
            connectionType: link.connectionType,
            signalQuality: link.signalQuality,
            isOffline: isOffline,
            strokeWidth: 3.0,
            color: _getLinkColor(context, link, isOffline),
          ),
        ),
      ),
    ],
  );
}

Color _getLinkColor(BuildContext context, MeshLink link, bool isOffline) {
  final outline = Theme.of(context).colorScheme.outline;

  if (isOffline) {
    return outline.withValues(alpha: 0.3);
  }

  if (link.isEthernet) {
    return outline.withValues(alpha: 0.6);
  }

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

@widgetbook.UseCase(
  name: 'Interactive',
  type: LinkRenderer,
)
Widget buildInteractive(BuildContext context) {
  final connectionTypeIndex = context.knobs.int.slider(
    label: 'Connection Type (0=Ethernet, 1=WiFi)',
    initialValue: 1,
    min: 0,
    max: 1,
  );

  final rssi = context.knobs.int.slider(
    label: 'RSSI (dBm)',
    initialValue: -50,
    min: -90,
    max: -30,
  );

  final isOffline = context.knobs.boolean(
    label: 'Offline',
    initialValue: false,
  );

  final enableAnimation = context.knobs.boolean(
    label: 'Enable Flow Animation',
    initialValue: true,
  );

  final connectionType = connectionTypeIndex == 0
      ? ConnectionType.ethernet
      : ConnectionType.wifi;

  final link = MeshLink(
    sourceId: 'node-1',
    targetId: 'node-2',
    connectionType: connectionType,
    rssi: connectionType == ConnectionType.wifi ? rssi : null,
    throughput: 100,
  );

  return DesignSystem.init(
    context,
    Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Signal: ${link.signalQuality.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 300,
            height: 60,
            child: Stack(
              children: [
                // Start node
                Positioned(
                  left: 10,
                  top: 25,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // End node
                Positioned(
                  right: 10,
                  top: 25,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Link with optional animation
                if (connectionType == ConnectionType.wifi &&
                    !isOffline &&
                    enableAnimation)
                  FlowAnimation(
                    start: const Offset(30, 35),
                    end: const Offset(270, 35),
                    color: _getLinkColor(context, link, isOffline),
                    speed: 1.5,
                    strokeWidth: 3.0,
                  ),
                CustomPaint(
                  size: const Size(300, 60),
                  painter: LinkPainter(
                    start: const Offset(30, 35),
                    end: const Offset(270, 35),
                    connectionType: link.connectionType,
                    signalQuality: link.signalQuality,
                    isOffline: isOffline,
                    strokeWidth: 3.0,
                    color: _getLinkColor(context, link, isOffline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
