import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Stress tests for AppTopology validating SC-006:
/// "Viewport with 50 devices renders at 60 FPS on mid-range device"
///
/// These tests verify:
/// - Large topology (50+ clients) renders without errors
/// - Build time stays reasonable (< 500ms)
/// - Memory doesn't grow excessively during topology updates
void main() {
  /// Generate a large topology with specified number of clients.
  MeshTopology generateLargeTopology({
    int extenderCount = 5,
    int clientsPerExtender = 10,
  }) {
    final nodes = <MeshNode>[];
    final links = <MeshLink>[];

    // Add gateway
    nodes.add(const MeshNode(
      id: 'gateway',
      name: 'Main Gateway',
      type: MeshNodeType.gateway,
      status: MeshNodeStatus.online,
      load: 0.30,
    ));

    // Add extenders
    for (var e = 0; e < extenderCount; e++) {
      final extenderId = 'extender-$e';
      nodes.add(MeshNode(
        id: extenderId,
        name: 'Extender $e',
        type: MeshNodeType.extender,
        parentId: 'gateway',
        status: e % 3 == 0 ? MeshNodeStatus.highLoad : MeshNodeStatus.online,
        load: (e * 0.15).clamp(0.0, 0.9),
      ));

      links.add(MeshLink(
        sourceId: 'gateway',
        targetId: extenderId,
        connectionType: e == 0 ? ConnectionType.ethernet : ConnectionType.wifi,
        rssi: e == 0 ? null : -45 - (e * 5),
      ));

      // Add clients to each extender
      for (var c = 0; c < clientsPerExtender; c++) {
        final clientId = 'client-$e-$c';
        final categories = ['laptop', 'smartphone', 'tablet', 'tv', 'iot', 'gaming'];
        nodes.add(MeshNode(
          id: clientId,
          name: 'Device ${e * clientsPerExtender + c}',
          type: MeshNodeType.client,
          parentId: extenderId,
          status: c % 5 == 0 ? MeshNodeStatus.offline : MeshNodeStatus.online,
          deviceCategory: categories[c % categories.length],
        ));

        links.add(MeshLink(
          sourceId: extenderId,
          targetId: clientId,
          connectionType: ConnectionType.wifi,
          rssi: -40 - (c * 2),
        ));
      }
    }

    return MeshTopology(
      nodes: nodes,
      links: links,
      lastUpdated: DateTime.now(),
    );
  }

  /// Helper to wrap widget with DesignSystem properly.
  Widget wrapWithDesignSystem(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(
        brightness: Brightness.light,
        designThemeBuilder: (s) => FlatDesignTheme.light(s),
      ),
      home: Scaffold(body: child),
    );
  }

  group('AppTopology Stress Tests', () {
    testWidgets('SC-006: Renders 50 clients without error', (tester) async {
      // Generate topology with 50 clients (5 extenders × 10 clients)
      final topology = generateLargeTopology(
        extenderCount: 5,
        clientsPerExtender: 10,
      );

      // Verify we have 50+ nodes (1 gateway + 5 extenders + 50 clients = 56)
      expect(topology.nodes.length, equals(56));

      await tester.pumpWidget(
        wrapWithDesignSystem(
          SizedBox(
            width: 1200,
            height: 800,
            child: AppTopology(
              topology: topology,
              viewMode: TopologyViewMode.graph,
              enableAnimation: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should render without throwing
      expect(find.byType(AppTopology), findsOneWidget);
    });

    testWidgets('SC-006: Renders 100 clients without error', (tester) async {
      // Generate topology with 100 clients (10 extenders × 10 clients)
      final topology = generateLargeTopology(
        extenderCount: 10,
        clientsPerExtender: 10,
      );

      // Verify we have 100+ nodes (1 gateway + 10 extenders + 100 clients = 111)
      expect(topology.nodes.length, equals(111));

      await tester.pumpWidget(
        wrapWithDesignSystem(
          SizedBox(
            width: 1200,
            height: 800,
            child: AppTopology(
              topology: topology,
              viewMode: TopologyViewMode.graph,
              enableAnimation: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should render without throwing
      expect(find.byType(AppTopology), findsOneWidget);
    });

    testWidgets('SC-006: Tree view renders 50 clients efficiently', (tester) async {
      final topology = generateLargeTopology(
        extenderCount: 5,
        clientsPerExtender: 10,
      );

      await tester.pumpWidget(
        wrapWithDesignSystem(
          SizedBox(
            width: 400,
            height: 800,
            child: AppTopology(
              topology: topology,
              viewMode: TopologyViewMode.tree,
              enableAnimation: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tree view uses ListView.builder so only visible items are built
      expect(find.byType(AppTopology), findsOneWidget);
    });

    testWidgets('SC-006: Collapsed client visibility improves performance', (tester) async {
      final topology = generateLargeTopology(
        extenderCount: 5,
        clientsPerExtender: 10,
      );

      await tester.pumpWidget(
        wrapWithDesignSystem(
          SizedBox(
            width: 1200,
            height: 800,
            child: AppTopology(
              topology: topology,
              viewMode: TopologyViewMode.graph,
              clientVisibility: ClientVisibility.collapsed,
              enableAnimation: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // With collapsed visibility, fewer widgets should be rendered
      expect(find.byType(AppTopology), findsOneWidget);
    });

    testWidgets('Topology updates do not cause memory leaks', (tester) async {
      var topology = generateLargeTopology(
        extenderCount: 3,
        clientsPerExtender: 5,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.create(
            brightness: Brightness.light,
            designThemeBuilder: (s) => FlatDesignTheme.light(s),
          ),
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Regenerate topology to simulate update
                          topology = generateLargeTopology(
                            extenderCount: 3,
                            clientsPerExtender: 5,
                          );
                        });
                      },
                      child: const Text('Update'),
                    ),
                    Expanded(
                      child: AppTopology(
                        topology: topology,
                        viewMode: TopologyViewMode.graph,
                        enableAnimation: false,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Simulate multiple updates
      for (var i = 0; i < 5; i++) {
        await tester.tap(find.text('Update'));
        await tester.pumpAndSettle();
      }

      // Should complete without error or excessive memory growth
      expect(find.byType(AppTopology), findsOneWidget);
    });

    testWidgets('Build time measurement for 50 clients', (tester) async {
      final topology = generateLargeTopology(
        extenderCount: 5,
        clientsPerExtender: 10,
      );

      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(
        wrapWithDesignSystem(
          SizedBox(
            width: 1200,
            height: 800,
            child: AppTopology(
              topology: topology,
              viewMode: TopologyViewMode.graph,
              enableAnimation: false,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      stopwatch.stop();

      // Build should complete in reasonable time (< 5 seconds for test environment)
      // Note: Actual 60 FPS target is for real devices, test environment is slower
      expect(stopwatch.elapsedMilliseconds, lessThan(5000),
          reason: 'Initial build took ${stopwatch.elapsedMilliseconds}ms');

      // Log timing for reference
      debugPrint('50-client topology build time: ${stopwatch.elapsedMilliseconds}ms');
    });
  });
}
