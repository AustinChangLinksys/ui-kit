import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/topology_style.dart';
import 'package:ui_kit_library/src/organisms/topology/models/mesh_node.dart';
import 'package:ui_kit_library/src/organisms/topology/nodes/orbit_node.dart';

import '../../../test_utils/golden_test_matrix_factory.dart';
import '../../../test_utils/font_loader.dart';

/// Default style for testing.
const _testStyle = NodeStyle(
  backgroundColor: Color(0xFFE3F2FD),
  borderColor: Color(0xFF2196F3),
  borderWidth: 2.0,
  borderRadius: 8.0,
  glowRadius: 0.0,
  glowColor: Colors.transparent,
  size: 64.0,
  iconColor: Color(0xFF1976D2),
);

/// Offline style for testing.
const _offlineStyle = NodeStyle(
  backgroundColor: Color(0xFFE0E0E0),
  borderColor: Color(0xFF9E9E9E),
  borderWidth: 2.0,
  borderRadius: 8.0,
  glowRadius: 0.0,
  glowColor: Colors.transparent,
  size: 64.0,
  iconColor: Color(0xFF757575),
);

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('OrbitNode Golden Tests', () {
    // T070: OrbitNode idle state
    goldenTest(
      'OrbitNode - Idle State',
      fileName: 'orbit_node_idle',
      builder: () => buildThemeMatrix(
        name: 'Idle',
        width: 120,
        height: 120,
        child: const OrbitNodePreview(
          node: MeshNode(
            id: 'client-1',
            name: 'MacBook Pro',
            type: MeshNodeType.client,
            parentId: 'extender-1',
            status: MeshNodeStatus.online,
            deviceCategory: 'laptop',
          ),
          style: _testStyle,
        ),
      ),
    );

    // T071: OrbitNode hovered/expanded state
    goldenTest(
      'OrbitNode - Expanded State',
      fileName: 'orbit_node_expanded',
      builder: () => buildThemeMatrix(
        name: 'Expanded',
        width: 140,
        height: 140,
        child: const OrbitNodePreview(
          node: MeshNode(
            id: 'client-1',
            name: 'MacBook Pro',
            type: MeshNodeType.client,
            parentId: 'extender-1',
            status: MeshNodeStatus.online,
            deviceCategory: 'laptop',
          ),
          style: _testStyle,
          isExpanded: true,
        ),
      ),
    );

    // OrbitNode offline state
    goldenTest(
      'OrbitNode - Offline State',
      fileName: 'orbit_node_offline',
      builder: () => buildThemeMatrix(
        name: 'Offline',
        width: 120,
        height: 120,
        child: const OrbitNodePreview(
          node: MeshNode(
            id: 'client-1',
            name: 'MacBook Pro',
            type: MeshNodeType.client,
            parentId: 'extender-1',
            status: MeshNodeStatus.offline,
            deviceCategory: 'laptop',
          ),
          style: _offlineStyle,
          isOffline: true,
        ),
      ),
    );

    // Different device categories
    goldenTest(
      'OrbitNode - Device Categories',
      fileName: 'orbit_node_categories',
      builder: () => buildThemeMatrix(
        name: 'Device Categories',
        width: 400,
        height: 120,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OrbitNodePreview(
              node: MeshNode(
                id: 'c1',
                name: 'Laptop',
                type: MeshNodeType.client,
                parentId: 'ext',
                status: MeshNodeStatus.online,
                deviceCategory: 'laptop',
              ),
              style: _testStyle,
            ),
            OrbitNodePreview(
              node: MeshNode(
                id: 'c2',
                name: 'Phone',
                type: MeshNodeType.client,
                parentId: 'ext',
                status: MeshNodeStatus.online,
                deviceCategory: 'smartphone',
              ),
              style: _testStyle,
            ),
            OrbitNodePreview(
              node: MeshNode(
                id: 'c3',
                name: 'TV',
                type: MeshNodeType.client,
                parentId: 'ext',
                status: MeshNodeStatus.online,
                deviceCategory: 'tv',
              ),
              style: _testStyle,
            ),
            OrbitNodePreview(
              node: MeshNode(
                id: 'c4',
                name: 'Sensor',
                type: MeshNodeType.client,
                parentId: 'ext',
                status: MeshNodeStatus.online,
                deviceCategory: 'iot',
              ),
              style: _testStyle,
            ),
          ],
        ),
      ),
    );
  });
}
