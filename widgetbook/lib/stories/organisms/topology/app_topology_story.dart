import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Sample topology for demos.
MeshTopology _createSampleTopology() {
  return MeshTopology(
    nodes: const [
      MeshNode(
        id: 'gateway-1',
        name: 'Main Router',
        type: MeshNodeType.gateway,
        status: MeshNodeStatus.online,
        load: 0.35,
      ),
      MeshNode(
        id: 'extender-1',
        name: 'Living Room',
        type: MeshNodeType.extender,
        parentId: 'gateway-1',
        status: MeshNodeStatus.online,
        load: 0.45,
      ),
      MeshNode(
        id: 'extender-2',
        name: 'Office',
        type: MeshNodeType.extender,
        parentId: 'gateway-1',
        status: MeshNodeStatus.highLoad,
        load: 0.82,
      ),
      MeshNode(
        id: 'extender-3',
        name: 'Garage',
        type: MeshNodeType.extender,
        parentId: 'gateway-1',
        status: MeshNodeStatus.offline,
        load: 0.0,
      ),
      MeshNode(
        id: 'client-1',
        name: 'iPhone',
        type: MeshNodeType.client,
        parentId: 'gateway-1',
        status: MeshNodeStatus.online,
        deviceCategory: 'smartphone',
      ),
      MeshNode(
        id: 'client-2',
        name: 'MacBook Pro',
        type: MeshNodeType.client,
        parentId: 'extender-1',
        status: MeshNodeStatus.online,
        deviceCategory: 'laptop',
      ),
    ],
    links: const [
      MeshLink(
        sourceId: 'gateway-1',
        targetId: 'extender-1',
        connectionType: ConnectionType.ethernet,
      ),
      MeshLink(
        sourceId: 'gateway-1',
        targetId: 'extender-2',
        connectionType: ConnectionType.wifi,
        rssi: -55,
      ),
      MeshLink(
        sourceId: 'gateway-1',
        targetId: 'extender-3',
        connectionType: ConnectionType.wifi,
        rssi: -78,
      ),
      MeshLink(
        sourceId: 'gateway-1',
        targetId: 'client-1',
        connectionType: ConnectionType.wifi,
        rssi: -48,
      ),
      MeshLink(
        sourceId: 'extender-1',
        targetId: 'client-2',
        connectionType: ConnectionType.wifi,
        rssi: -65,
      ),
    ],
    lastUpdated: DateTime.now(),
  );
}

@widgetbook.UseCase(
  name: 'Auto Mode',
  type: AppTopology,
)
Widget buildAutoMode(BuildContext context) {
  return DesignSystem.init(
    context,
    AppTopology(
      topology: _createSampleTopology(),
      viewMode: TopologyViewMode.auto,
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Node tapped: $nodeId')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Tree View',
  type: AppTopology,
)
Widget buildTreeView(BuildContext context) {
  return DesignSystem.init(
    context,
    AppTopology(
      topology: _createSampleTopology(),
      viewMode: TopologyViewMode.tree,
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Node tapped: $nodeId')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Graph View',
  type: AppTopology,
)
Widget buildGraphView(BuildContext context) {
  return DesignSystem.init(
    context,
    AppTopology(
      topology: _createSampleTopology(),
      viewMode: TopologyViewMode.graph,
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Node tapped: $nodeId')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Loading State',
  type: AppTopology,
)
Widget buildLoadingState(BuildContext context) {
  return DesignSystem.init(
    context,
    const AppTopology(
      topology: null,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Empty State',
  type: AppTopology,
)
Widget buildEmptyState(BuildContext context) {
  return DesignSystem.init(
    context,
    AppTopology(
      topology: MeshTopology.empty(),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive',
  type: AppTopology,
)
Widget buildInteractive(BuildContext context) {
  final viewModeIndex = context.knobs.int.slider(
    label: 'View Mode (0=auto, 1=tree, 2=graph)',
    initialValue: 0,
    min: 0,
    max: 2,
  );

  final breakpoint = context.knobs.double.slider(
    label: 'Breakpoint',
    initialValue: 600,
    min: 400,
    max: 1200,
  );

  final viewMode = TopologyViewMode.values[viewModeIndex];

  return DesignSystem.init(
    context,
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText(
            'View Mode: ${viewMode.name}, Breakpoint: ${breakpoint.toInt()}px',
            variant: AppTextVariant.bodySmall,
          ),
        ),
        Expanded(
          child: AppTopology(
            topology: _createSampleTopology(),
            viewMode: viewMode,
            breakpoint: breakpoint,
            onNodeTap: (nodeId) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Node tapped: $nodeId')),
              );
            },
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Content',
  type: AppTopology,
)
Widget buildCustomContent(BuildContext context) {
  return DesignSystem.init(
    context,
    AppTopology(
      topology: _createSampleTopology(),
      viewMode: TopologyViewMode.tree,
      nodeContentBuilder: (context, node, style, isOffline) {
        // Example: Custom content showing icon with label and status info
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              node.iconData ?? Icons.device_hub,
              size: style.size * 0.3,
              color: isOffline
                  ? style.iconColor.withValues(alpha: 0.5)
                  : style.iconColor,
            ),
            const SizedBox(height: 2),
            Text(
              node.name,
              style: TextStyle(
                fontSize: 8,
                color: isOffline ? Colors.grey : Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            if (node.isExtender)
              Text(
                '${(node.load * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 7,
                  color: node.load > 0.7 ? Colors.red : Colors.green,
                ),
              ),
          ],
        );
      },
      onNodeTap: (nodeId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Node tapped: $nodeId')),
        );
      },
    ),
  );
}
