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

  group('LiquidNode Golden Tests', () {
    // T030: LiquidNode low-load state
    goldenTest(
      'LiquidNode - Low Load State',
      fileName: 'liquid_node_low_load',
      builder: () => buildThemeMatrix(
        name: 'Low Load',
        width: 150,
        height: 150,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<AppDesignTheme>()!;
            final style = theme.topologySpec.extenderNormalStyle;
            return Center(
              child: LiquidNode(
                node: const MeshNode(
                  id: 'extender-1',
                  name: 'Living Room Extender',
                  type: MeshNodeType.extender,
                  status: MeshNodeStatus.online,
                  load: 0.25, // Low load - 25%
                ),
                style: style,
                enableAnimation: false, // Disable for golden test
              ),
            );
          },
        ),
      ),
    );

    // T031: LiquidNode high-load state
    goldenTest(
      'LiquidNode - High Load State',
      fileName: 'liquid_node_high_load',
      builder: () => buildThemeMatrix(
        name: 'High Load',
        width: 150,
        height: 150,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<AppDesignTheme>()!;
            final style = theme.topologySpec.extenderHighLoadStyle;
            return Center(
              child: LiquidNode(
                node: const MeshNode(
                  id: 'extender-1',
                  name: 'Living Room Extender',
                  type: MeshNodeType.extender,
                  status: MeshNodeStatus.highLoad,
                  load: 0.85, // High load - 85%
                ),
                style: style,
                enableAnimation: false,
              ),
            );
          },
        ),
      ),
    );

    // Additional test: LiquidNode offline state
    goldenTest(
      'LiquidNode - Offline State',
      fileName: 'liquid_node_offline',
      builder: () => buildThemeMatrix(
        name: 'Offline',
        width: 150,
        height: 150,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<AppDesignTheme>()!;
            final style = theme.topologySpec.extenderOfflineStyle;
            return Center(
              child: LiquidNode(
                node: const MeshNode(
                  id: 'extender-1',
                  name: 'Living Room Extender',
                  type: MeshNodeType.extender,
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

    // LiquidNode with custom contentBuilder - Rich device info
    goldenTest(
      'LiquidNode - Custom Content Builder',
      fileName: 'liquid_node_custom_content',
      builder: () => buildThemeMatrix(
        name: 'Custom Content',
        width: 200,
        height: 200,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<AppDesignTheme>()!;
            // Use a larger style for rich content
            final baseStyle = theme.topologySpec.extenderNormalStyle;
            final style = baseStyle.copyWith(size: 120);
            return Center(
              child: LiquidNode(
                node: const MeshNode(
                  id: 'extender-1',
                  name: 'WHW03',
                  type: MeshNodeType.extender,
                  status: MeshNodeStatus.online,
                  load: 0.65, // 65% load - shows wave at this level
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
                          Icons.wifi_tethering,
                          size: 20,
                          color: textColor,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          node.name,
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'S/N: X9Y8Z7W6',
                          style: TextStyle(
                            fontSize: 6,
                            color: textColor.withValues(alpha: 0.8),
                          ),
                        ),
                        Text(
                          '192.168.1.101',
                          style: TextStyle(
                            fontSize: 6,
                            color: textColor.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 30,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: node.load,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: node.load > 0.7
                                        ? Colors.red
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${(node.load * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 6,
                                color: textColor,
                              ),
                            ),
                          ],
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
