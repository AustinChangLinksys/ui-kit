import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/organisms/topology/links/link_renderer.dart';
import 'package:ui_kit_library/src/organisms/topology/models/mesh_link.dart';

import '../../../test_utils/golden_test_matrix_factory.dart';
import '../../../test_utils/font_loader.dart';

/// Widget to display a single link for golden testing.
class _LinkTestWidget extends StatelessWidget {
  final MeshLink link;
  final bool isOffline;

  const _LinkTestWidget({
    required this.link,
    this.isOffline = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 60,
      child: Stack(
        children: [
          // Start node indicator
          Positioned(
            left: 10,
            top: 25,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // End node indicator
          Positioned(
            right: 10,
            top: 25,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Link line using CustomPaint directly for static golden
          CustomPaint(
            size: const Size(200, 60),
            painter: LinkPainter(
              start: const Offset(20, 30),
              end: const Offset(180, 30),
              connectionType: link.connectionType,
              signalQuality: link.signalQuality,
              isOffline: isOffline,
              strokeWidth: 3.0,
              color: _getLinkColor(context),
            ),
          ),
          // Label
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Text(
              _getLabel(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }

  Color _getLinkColor(BuildContext context) {
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

  String _getLabel() {
    if (isOffline) return 'Offline';
    if (link.isEthernet) return 'Ethernet';
    switch (link.signalQuality) {
      case SignalQuality.strong:
        return 'WiFi Strong (${link.rssi} dBm)';
      case SignalQuality.medium:
        return 'WiFi Medium (${link.rssi} dBm)';
      case SignalQuality.weak:
        return 'WiFi Weak (${link.rssi} dBm)';
      case SignalQuality.unknown:
        return 'WiFi Unknown';
      case SignalQuality.wired:
        return 'Wired';
    }
  }
}

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('LinkRenderer Golden Tests', () {
    // T059: Ethernet link (solid line)
    goldenTest(
      'LinkRenderer - Ethernet',
      fileName: 'link_renderer_ethernet',
      builder: () => buildThemeMatrix(
        name: 'Ethernet Link',
        width: 220,
        height: 80,
        child: const _LinkTestWidget(
          link: MeshLink(
            sourceId: 'node-1',
            targetId: 'node-2',
            connectionType: ConnectionType.ethernet,
          ),
        ),
      ),
    );

    // T060: WiFi strong signal (green, dashed)
    goldenTest(
      'LinkRenderer - WiFi Strong',
      fileName: 'link_renderer_wifi_strong',
      builder: () => buildThemeMatrix(
        name: 'WiFi Strong',
        width: 220,
        height: 80,
        child: const _LinkTestWidget(
          link: MeshLink(
            sourceId: 'node-1',
            targetId: 'node-2',
            connectionType: ConnectionType.wifi,
            rssi: -45, // Strong signal
          ),
        ),
      ),
    );

    // WiFi medium signal (orange, dashed)
    goldenTest(
      'LinkRenderer - WiFi Medium',
      fileName: 'link_renderer_wifi_medium',
      builder: () => buildThemeMatrix(
        name: 'WiFi Medium',
        width: 220,
        height: 80,
        child: const _LinkTestWidget(
          link: MeshLink(
            sourceId: 'node-1',
            targetId: 'node-2',
            connectionType: ConnectionType.wifi,
            rssi: -60, // Medium signal
          ),
        ),
      ),
    );

    // T061: WiFi weak signal (red, dashed)
    goldenTest(
      'LinkRenderer - WiFi Weak',
      fileName: 'link_renderer_wifi_weak',
      builder: () => buildThemeMatrix(
        name: 'WiFi Weak',
        width: 220,
        height: 80,
        child: const _LinkTestWidget(
          link: MeshLink(
            sourceId: 'node-1',
            targetId: 'node-2',
            connectionType: ConnectionType.wifi,
            rssi: -75, // Weak signal
          ),
        ),
      ),
    );

    // Offline link (faded, dashed)
    goldenTest(
      'LinkRenderer - Offline',
      fileName: 'link_renderer_offline',
      builder: () => buildThemeMatrix(
        name: 'Offline Link',
        width: 220,
        height: 80,
        child: const _LinkTestWidget(
          link: MeshLink(
            sourceId: 'node-1',
            targetId: 'node-2',
            connectionType: ConnectionType.wifi,
            rssi: -50,
          ),
          isOffline: true,
        ),
      ),
    );

    // Unknown signal quality
    goldenTest(
      'LinkRenderer - Unknown Signal',
      fileName: 'link_renderer_unknown',
      builder: () => buildThemeMatrix(
        name: 'Unknown Signal',
        width: 220,
        height: 80,
        child: const _LinkTestWidget(
          link: MeshLink(
            sourceId: 'node-1',
            targetId: 'node-2',
            connectionType: ConnectionType.wifi,
            // No RSSI = unknown
          ),
        ),
      ),
    );

    // All link types comparison
    goldenTest(
      'LinkRenderer - All Types',
      fileName: 'link_renderer_all_types',
      builder: () => buildThemeMatrix(
        name: 'All Link Types',
        width: 220,
        height: 420,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LinkTestWidget(
              link: MeshLink(
                sourceId: 'a',
                targetId: 'b',
                connectionType: ConnectionType.ethernet,
              ),
            ),
            _LinkTestWidget(
              link: MeshLink(
                sourceId: 'a',
                targetId: 'b',
                connectionType: ConnectionType.wifi,
                rssi: -45,
              ),
            ),
            _LinkTestWidget(
              link: MeshLink(
                sourceId: 'a',
                targetId: 'b',
                connectionType: ConnectionType.wifi,
                rssi: -60,
              ),
            ),
            _LinkTestWidget(
              link: MeshLink(
                sourceId: 'a',
                targetId: 'b',
                connectionType: ConnectionType.wifi,
                rssi: -75,
              ),
            ),
            _LinkTestWidget(
              link: MeshLink(
                sourceId: 'a',
                targetId: 'b',
                connectionType: ConnectionType.wifi,
              ),
            ),
            _LinkTestWidget(
              link: MeshLink(
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
  });
}
