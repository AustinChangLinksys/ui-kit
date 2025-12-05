import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Single Selection',
  type: AppChipGroup,
)
Widget buildSingleSelectionChipGroup(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headlineSmall('Single Selection'),
            const SizedBox(height: 16),
            AppChipGroup(
              chips: const [
                ChipItem(label: 'All'),
                ChipItem(label: 'Active'),
                ChipItem(label: 'Completed'),
                ChipItem(label: 'Archived'),
              ],
              selectedIndices: const {0},
              selectionMode: ChipSelectionMode.single,
              onSelectionChanged: (indices) {
                debugPrint('Selected: $indices');
              },
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multiple Selection',
  type: AppChipGroup,
)
Widget buildMultipleSelectionChipGroup(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headlineSmall('Multiple Selection'),
            const SizedBox(height: 16),
            AppChipGroup(
              chips: const [
                ChipItem(label: 'JavaScript'),
                ChipItem(label: 'TypeScript'),
                ChipItem(label: 'Dart'),
                ChipItem(label: 'Python'),
                ChipItem(label: 'Rust'),
              ],
              selectedIndices: const {0, 2},
              selectionMode: ChipSelectionMode.multiple,
              onSelectionChanged: (indices) {
                debugPrint('Selected: $indices');
              },
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Icons',
  type: AppChipGroup,
)
Widget buildChipGroupWithIcons(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headlineSmall('Chips with Icons'),
            const SizedBox(height: 16),
            AppChipGroup(
              chips: const [
                ChipItem(label: 'Photos', icon: Icons.photo),
                ChipItem(label: 'Videos', icon: Icons.videocam),
                ChipItem(label: 'Music', icon: Icons.music_note),
                ChipItem(label: 'Documents', icon: Icons.description),
              ],
              selectedIndices: const {0},
              onSelectionChanged: (indices) {
                debugPrint('Selected: $indices');
              },
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Horizontal Scroll',
  type: AppChipGroup,
)
Widget buildHorizontalChipGroup(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headlineSmall('Horizontal Scroll (No Wrap)'),
            const SizedBox(height: 16),
            AppChipGroup(
              chips: const [
                ChipItem(label: 'Category 1'),
                ChipItem(label: 'Category 2'),
                ChipItem(label: 'Category 3'),
                ChipItem(label: 'Category 4'),
                ChipItem(label: 'Category 5'),
                ChipItem(label: 'Category 6'),
                ChipItem(label: 'Category 7'),
              ],
              selectedIndices: const {0},
              wrap: false,
              onSelectionChanged: (indices) {
                debugPrint('Selected: $indices');
              },
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Disabled Items',
  type: AppChipGroup,
)
Widget buildDisabledChipGroup(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headlineSmall('With Disabled Items'),
            const SizedBox(height: 16),
            AppChipGroup(
              chips: const [
                ChipItem(label: 'Available'),
                ChipItem(label: 'Sold Out', enabled: false),
                ChipItem(label: 'In Stock'),
                ChipItem(label: 'Coming Soon', enabled: false),
              ],
              selectedIndices: const {0},
              onSelectionChanged: (indices) {
                debugPrint('Selected: $indices');
              },
            ),
          ],
        ),
      ),
    ),
  );
}
