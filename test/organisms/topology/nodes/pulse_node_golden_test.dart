import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../../test_utils/golden_test_matrix_factory.dart';
import '../../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('PulseNode Golden Tests', () {
    // T027: PulseNode normal state
    goldenTest(
      'PulseNode - Normal State',
      fileName: 'pulse_node_normal',
      builder: () => buildThemeMatrix(
        name: 'Normal',
        width: 150,
        height: 150,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<AppDesignTheme>()!;
            final style = theme.topologySpec.gatewayNormalStyle;
            return Center(
              child: PulseNode(
                node: const MeshNode(
                  id: 'gateway-1',
                  name: 'Main Router',
                  type: MeshNodeType.gateway,
                  status: MeshNodeStatus.online,
                  load: 0.3,
                ),
                style: style,
                enableAnimation: false, // Disable for golden test
              ),
            );
          },
        ),
      ),
    );

    // T028: PulseNode high-load state
    goldenTest(
      'PulseNode - High Load State',
      fileName: 'pulse_node_high_load',
      builder: () => buildThemeMatrix(
        name: 'High Load',
        width: 150,
        height: 150,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<AppDesignTheme>()!;
            final style = theme.topologySpec.gatewayHighLoadStyle;
            return Center(
              child: PulseNode(
                node: const MeshNode(
                  id: 'gateway-1',
                  name: 'Main Router',
                  type: MeshNodeType.gateway,
                  status: MeshNodeStatus.highLoad,
                  load: 0.85,
                ),
                style: style,
                enableAnimation: false,
              ),
            );
          },
        ),
      ),
    );

    // T029: PulseNode offline state
    goldenTest(
      'PulseNode - Offline State',
      fileName: 'pulse_node_offline',
      builder: () => buildThemeMatrix(
        name: 'Offline',
        width: 150,
        height: 150,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<AppDesignTheme>()!;
            final style = theme.topologySpec.gatewayOfflineStyle;
            return Center(
              child: PulseNode(
                node: const MeshNode(
                  id: 'gateway-1',
                  name: 'Main Router',
                  type: MeshNodeType.gateway,
                  status: MeshNodeStatus.offline,
                  load: 0.0,
                ),
                style: style,
                enableAnimation: false,
              ),
            );
          },
        ),
      ),
    );

    // PulseNode with custom contentBuilder - Rich device info
    goldenTest(
      'PulseNode - Custom Content Builder',
      fileName: 'pulse_node_custom_content',
      builder: () => buildThemeMatrix(
        name: 'Custom Content',
        width: 200,
        height: 200,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<AppDesignTheme>()!;
            // Use a larger style for rich content
            final baseStyle = theme.topologySpec.gatewayNormalStyle;
            final style = baseStyle.copyWith(size: 120);
            return Center(
              child: PulseNode(
                node: const MeshNode(
                  id: 'gateway-1',
                  name: 'MX6200',
                  type: MeshNodeType.gateway,
                  status: MeshNodeStatus.online,
                  load: 0.45,
                ),
                style: style,
                enableAnimation: false,
                contentBuilder: (context, node, style, isOffline) {
                  final textColor = isOffline
                      ? style.iconColor.withValues(alpha: 0.5)
                      : style.iconColor;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.router,
                          size: 24,
                          color: textColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          node.name,
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'S/N: A1B2C3D4',
                          style: TextStyle(
                            fontSize: 7,
                            color: textColor.withValues(alpha: 0.8),
                          ),
                        ),
                        Text(
                          '192.168.1.1',
                          style: TextStyle(
                            fontSize: 7,
                            color: textColor.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Online',
                            style: TextStyle(
                              fontSize: 6,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  });
}
