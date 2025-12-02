import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/layout/app_list_tile.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppListTile Golden Tests', () {
    goldenTest(
      'AppListTile - Standard',
      fileName: 'app_list_tile_standard',
      builder: () => buildThemeMatrix(
        name: 'Standard',
        width: 300,
        height: 100,
        child: const AppListTile(
          leading: Icon(Icons.folder),
          title: Text('Folder'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );

    goldenTest(
      'AppListTile - Selected',
      fileName: 'app_list_tile_selected',
      builder: () => buildThemeMatrix(
        name: 'Selected',
        width: 300,
        height: 100,
        child: const AppListTile(
          leading: Icon(Icons.wifi),
          title: Text('Wi-Fi'),
          subtitle: Text('Connected'),
          trailing: Icon(Icons.check),
          selected: true,
        ),
      ),
    );
  });
}