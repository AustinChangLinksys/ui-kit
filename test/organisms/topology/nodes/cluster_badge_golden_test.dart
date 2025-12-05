import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/organisms/topology/nodes/cluster_badge.dart';

import '../../../test_utils/golden_test_matrix_factory.dart';
import '../../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('ClusterBadge Golden Tests', () {
    // ClusterBadge collapsed state (default)
    goldenTest(
      'ClusterBadge - Collapsed',
      fileName: 'cluster_badge_collapsed',
      builder: () => buildThemeMatrix(
        name: 'Collapsed',
        width: 80,
        height: 80,
        child: const ClusterBadgePreview(
          clientCount: 25,
          isExpanded: false,
        ),
      ),
    );

    // ClusterBadge expanded state
    goldenTest(
      'ClusterBadge - Expanded',
      fileName: 'cluster_badge_expanded',
      builder: () => buildThemeMatrix(
        name: 'Expanded',
        width: 80,
        height: 80,
        child: const ClusterBadgePreview(
          clientCount: 25,
          isExpanded: true,
        ),
      ),
    );

    // ClusterBadge with large count
    goldenTest(
      'ClusterBadge - Large Count',
      fileName: 'cluster_badge_large_count',
      builder: () => buildThemeMatrix(
        name: 'Large Count',
        width: 80,
        height: 80,
        child: const ClusterBadgePreview(
          clientCount: 100,
          isExpanded: false,
        ),
      ),
    );
  });
}
