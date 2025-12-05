import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('ClientVisibility.clustered', () {
    /// Creates a test topology with specified number of clients.
    MeshTopology createTopology({required int clientCount}) {
      final nodes = <MeshNode>[
        const MeshNode(
          id: 'gateway',
          name: 'Gateway',
          type: MeshNodeType.gateway,
          status: MeshNodeStatus.online,
        ),
        const MeshNode(
          id: 'extender-1',
          name: 'Extender',
          type: MeshNodeType.extender,
          status: MeshNodeStatus.online,
          parentId: 'gateway',
        ),
      ];

      final links = <MeshLink>[
        const MeshLink(
          sourceId: 'gateway',
          targetId: 'extender-1',
          connectionType: ConnectionType.ethernet,
        ),
      ];

      // Add clients to extender
      for (var i = 0; i < clientCount; i++) {
        nodes.add(MeshNode(
          id: 'client-$i',
          name: 'Device $i',
          type: MeshNodeType.client,
          status: MeshNodeStatus.online,
          parentId: 'extender-1',
          deviceCategory: ['smartphone', 'laptop', 'tablet', 'tv', 'iot'][i % 5],
        ));
        links.add(MeshLink(
          sourceId: 'extender-1',
          targetId: 'client-$i',
          connectionType: ConnectionType.wifi,
          rssi: -50,
        ));
      }

      return MeshTopology(
        nodes: nodes,
        links: links,
        lastUpdated: DateTime.now(),
      );
    }

    Widget buildTestWidget({
      required MeshTopology topology,
      ClientVisibility clientVisibility = ClientVisibility.clustered,
    }) {
      return MaterialApp(
        theme: AppTheme.create(
          brightness: Brightness.light,
          designThemeBuilder: (s) => FlatDesignTheme.light(s),
        ),
        home: Scaffold(
          body: SizedBox(
            width: 800,
            height: 600,
            child: AppTopology(
              topology: topology,
              viewMode: TopologyViewMode.graph,
              clientVisibility: clientVisibility,
            ),
          ),
        ),
      );
    }

    testWidgets('shows all clients when count <= threshold', (tester) async {
      final topology = createTopology(clientCount: 15);

      await tester.pumpWidget(buildTestWidget(
        topology: topology,
        clientVisibility: ClientVisibility.clustered,
      ));
      // Use pump with duration to skip animation frames
      await tester.pump(const Duration(milliseconds: 500));

      // Should NOT show cluster badge when under threshold
      expect(find.byType(ClusterBadge), findsNothing);
    });

    testWidgets('shows cluster badge when count > threshold', (tester) async {
      final topology = createTopology(clientCount: 25);

      await tester.pumpWidget(buildTestWidget(
        topology: topology,
        clientVisibility: ClientVisibility.clustered,
      ));
      await tester.pump(const Duration(milliseconds: 500));

      // Should show cluster badge when over threshold
      expect(find.byType(ClusterBadge), findsOneWidget);
    });

    testWidgets('cluster badge shows correct client count', (tester) async {
      final topology = createTopology(clientCount: 30);

      await tester.pumpWidget(buildTestWidget(
        topology: topology,
        clientVisibility: ClientVisibility.clustered,
      ));
      await tester.pump(const Duration(milliseconds: 500));

      // Find cluster badge and verify count
      final badge = tester.widget<ClusterBadge>(find.byType(ClusterBadge));
      expect(badge.clients.length, equals(30));
    });

    testWidgets('does not show cluster badge in always mode', (tester) async {
      final topology = createTopology(clientCount: 30);

      await tester.pumpWidget(buildTestWidget(
        topology: topology,
        clientVisibility: ClientVisibility.always,
      ));
      await tester.pump(const Duration(milliseconds: 500));

      // Should NOT show cluster badge in always mode
      expect(find.byType(ClusterBadge), findsNothing);
    });

    testWidgets('does not show cluster badge in collapsed mode',
        (tester) async {
      final topology = createTopology(clientCount: 30);

      await tester.pumpWidget(buildTestWidget(
        topology: topology,
        clientVisibility: ClientVisibility.collapsed,
      ));
      await tester.pump(const Duration(milliseconds: 500));

      // Should NOT show cluster badge in collapsed mode (uses simple badge)
      expect(find.byType(ClusterBadge), findsNothing);
    });
  });

  group('ClusterBadge Widget', () {
    Widget buildClusterBadge({
      required int clientCount,
      bool isExpanded = false,
      VoidCallback? onTap,
    }) {
      final clients = List.generate(
        clientCount,
        (i) => MeshNode(
          id: 'client-$i',
          name: 'Device $i',
          type: MeshNodeType.client,
          parentId: 'extender-1',
          deviceCategory: ['smartphone', 'laptop', 'tablet'][i % 3],
        ),
      );

      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: ClusterBadge(
              parentId: 'extender-1',
              clients: clients,
              isExpanded: isExpanded,
              onTap: onTap,
            ),
          ),
        ),
      );
    }

    testWidgets('displays client count', (tester) async {
      await tester.pumpWidget(buildClusterBadge(clientCount: 25));
      await tester.pumpAndSettle();

      expect(find.text('+25'), findsOneWidget);
    });

    testWidgets('displays devices icon', (tester) async {
      await tester.pumpWidget(buildClusterBadge(clientCount: 25));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.devices), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(buildClusterBadge(
        clientCount: 25,
        onTap: () => tapped = true,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ClusterBadge));
      expect(tapped, isTrue);
    });

    testWidgets('has correct semantics label', (tester) async {
      await tester.pumpWidget(buildClusterBadge(clientCount: 25));
      await tester.pumpAndSettle();

      final semantics = tester.getSemantics(find.byType(ClusterBadge));
      expect(semantics.label, contains('25 devices cluster'));
      expect(semantics.label, contains('tap to expand'));
    });

    testWidgets('semantics label changes when expanded', (tester) async {
      await tester.pumpWidget(buildClusterBadge(
        clientCount: 25,
        isExpanded: true,
      ));
      await tester.pumpAndSettle();

      final semantics = tester.getSemantics(find.byType(ClusterBadge));
      expect(semantics.label, contains('tap to collapse'));
    });
  });

  group('ClusterBadgePreview', () {
    testWidgets('creates correct number of mock clients', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ClusterBadgePreview(clientCount: 50),
        ),
      ));
      await tester.pumpAndSettle();

      final badge = tester.widget<ClusterBadge>(find.byType(ClusterBadge));
      expect(badge.clients.length, equals(50));
    });

    testWidgets('passes isExpanded to ClusterBadge', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ClusterBadgePreview(
            clientCount: 25,
            isExpanded: true,
          ),
        ),
      ));
      await tester.pumpAndSettle();

      final badge = tester.widget<ClusterBadge>(find.byType(ClusterBadge));
      expect(badge.isExpanded, isTrue);
    });
  });
}
