import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Collapsed State',
  type: ClusterBadge,
)
Widget buildCollapsedState(BuildContext context) {
  final clientCount = context.knobs.int.slider(
    label: 'Client Count',
    initialValue: 25,
    min: 5,
    max: 100,
  );

  final clients = List.generate(
    clientCount,
    (i) => MeshNode(
      id: 'client-$i',
      name: 'Device $i',
      type: MeshNodeType.client,
      parentId: 'extender-1',
      deviceCategory: ['smartphone', 'laptop', 'tablet', 'tv', 'iot'][i % 5],
    ),
  );

  return DesignSystem.init(
    context,
    Center(
      child: ClusterBadge(
        parentId: 'extender-1',
        clients: clients,
        isExpanded: false,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cluster tapped - would expand')),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Expanded State',
  type: ClusterBadge,
)
Widget buildExpandedState(BuildContext context) {
  final clientCount = context.knobs.int.slider(
    label: 'Client Count',
    initialValue: 25,
    min: 5,
    max: 100,
  );

  final clients = List.generate(
    clientCount,
    (i) => MeshNode(
      id: 'client-$i',
      name: 'Device $i',
      type: MeshNodeType.client,
      parentId: 'extender-1',
      deviceCategory: ['smartphone', 'laptop', 'tablet', 'tv', 'iot'][i % 5],
    ),
  );

  return DesignSystem.init(
    context,
    Center(
      child: ClusterBadge(
        parentId: 'extender-1',
        clients: clients,
        isExpanded: true,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cluster tapped - would collapse')),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive Toggle',
  type: ClusterBadge,
)
Widget buildInteractiveToggle(BuildContext context) {
  final clientCount = context.knobs.int.slider(
    label: 'Client Count',
    initialValue: 30,
    min: 5,
    max: 100,
  );

  final clients = List.generate(
    clientCount,
    (i) => MeshNode(
      id: 'client-$i',
      name: 'Device $i',
      type: MeshNodeType.client,
      parentId: 'extender-1',
      deviceCategory: ['smartphone', 'laptop', 'tablet', 'tv', 'iot'][i % 5],
    ),
  );

  return DesignSystem.init(
    context,
    _InteractiveClusterBadge(clients: clients),
  );
}

class _InteractiveClusterBadge extends StatefulWidget {
  final List<MeshNode> clients;

  const _InteractiveClusterBadge({required this.clients});

  @override
  State<_InteractiveClusterBadge> createState() =>
      _InteractiveClusterBadgeState();
}

class _InteractiveClusterBadgeState extends State<_InteractiveClusterBadge> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClusterBadge(
            parentId: 'extender-1',
            clients: widget.clients,
            isExpanded: _isExpanded,
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          const SizedBox(height: 16),
          AppText(
            _isExpanded ? 'Expanded (tap to collapse)' : 'Collapsed (tap to expand)',
            variant: AppTextVariant.labelMedium,
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Size Variants',
  type: ClusterBadge,
)
Widget buildSizeVariants(BuildContext context) {
  final clients = List.generate(
    25,
    (i) => MeshNode(
      id: 'client-$i',
      name: 'Device $i',
      type: MeshNodeType.client,
      parentId: 'extender-1',
      deviceCategory: ['smartphone', 'laptop', 'tablet', 'tv', 'iot'][i % 5],
    ),
  );

  return DesignSystem.init(
    context,
    Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClusterBadge(
                parentId: 'extender-1',
                clients: clients,
                size: 32,
              ),
              const SizedBox(height: 8),
              const AppText('32px', variant: AppTextVariant.labelSmall),
            ],
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClusterBadge(
                parentId: 'extender-1',
                clients: clients,
                size: 48,
              ),
              const SizedBox(height: 8),
              const AppText('48px (default)', variant: AppTextVariant.labelSmall),
            ],
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClusterBadge(
                parentId: 'extender-1',
                clients: clients,
                size: 64,
              ),
              const SizedBox(height: 8),
              const AppText('64px', variant: AppTextVariant.labelSmall),
            ],
          ),
        ],
      ),
    ),
  );
}
