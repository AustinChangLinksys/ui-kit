import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../../test_utils/font_loader.dart';
import '../../test_utils/golden_test_matrix_factory.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppChipGroup Golden Tests', () {
    final basicChips = [
      const ChipItem(label: 'All'),
      const ChipItem(label: 'Active'),
      const ChipItem(label: 'Completed'),
    ];

    final chipsWithIcons = [
      const ChipItem(label: 'Photos', icon: Icons.photo),
      const ChipItem(label: 'Videos', icon: Icons.videocam),
      const ChipItem(label: 'Music', icon: Icons.music_note),
    ];

    goldenTest(
      'AppChipGroup - None Selected',
      fileName: 'chip_group_none_selected',
      builder: () => buildThemeMatrix(
        name: 'None Selected',
        width: 350.0,
        height: 100.0,
        child: AppChipGroup(
          chips: basicChips,
          selectedIndices: const {},
        ),
      ),
    );

    goldenTest(
      'AppChipGroup - Single Selected',
      fileName: 'chip_group_single_selected',
      builder: () => buildThemeMatrix(
        name: 'First Selected',
        width: 350.0,
        height: 100.0,
        child: AppChipGroup(
          chips: basicChips,
          selectedIndices: const {0},
          selectionMode: ChipSelectionMode.single,
        ),
      ),
    );

    goldenTest(
      'AppChipGroup - Multiple Selected',
      fileName: 'chip_group_multiple_selected',
      builder: () => buildThemeMatrix(
        name: 'Multiple Selected',
        width: 350.0,
        height: 100.0,
        child: AppChipGroup(
          chips: basicChips,
          selectedIndices: const {0, 2},
          selectionMode: ChipSelectionMode.multiple,
        ),
      ),
    );

    goldenTest(
      'AppChipGroup - With Icons',
      fileName: 'chip_group_with_icons',
      builder: () => buildThemeMatrix(
        name: 'With Icons',
        width: 400.0,
        height: 100.0,
        child: AppChipGroup(
          chips: chipsWithIcons,
          selectedIndices: const {1},
        ),
      ),
    );

    goldenTest(
      'AppChipGroup - Disabled Chip',
      fileName: 'chip_group_disabled',
      builder: () => buildThemeMatrix(
        name: 'With Disabled Chip',
        width: 350.0,
        height: 100.0,
        child: AppChipGroup(
          chips: const [
            ChipItem(label: 'Active'),
            ChipItem(label: 'Disabled', enabled: false),
            ChipItem(label: 'Active'),
          ],
          selectedIndices: const {0},
        ),
      ),
    );

    goldenTest(
      'AppChipGroup - Wrapped Layout',
      fileName: 'chip_group_wrapped',
      builder: () => buildThemeMatrix(
        name: 'Wrapped Layout',
        width: 250.0,
        height: 150.0,
        child: AppChipGroup(
          chips: const [
            ChipItem(label: 'Tag 1'),
            ChipItem(label: 'Tag 2'),
            ChipItem(label: 'Tag 3'),
            ChipItem(label: 'Tag 4'),
            ChipItem(label: 'Tag 5'),
          ],
          selectedIndices: const {0, 3},
          selectionMode: ChipSelectionMode.multiple,
          wrap: true,
        ),
      ),
    );
  });
}
