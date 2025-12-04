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

  group('AppBottomSheet Golden Tests', () {
    goldenTest(
      'AppBottomSheet - Basic Content',
      fileName: 'bottom_sheet_basic',
      builder: () => buildThemeMatrix(
        name: 'Basic Content',
        width: 375.0,
        height: 300.0,
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Show Sheet'),
            ),
          ),
          bottomSheet: AppBottomSheet(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  'Sheet Title',
                  variant: AppTextVariant.headlineSmall,
                ),
                const SizedBox(height: 12),
                const AppText(
                  'This is a bottom sheet with content.',
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Action'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'AppBottomSheet - With List Content',
      fileName: 'bottom_sheet_list',
      builder: () => buildThemeMatrix(
        name: 'With List Content',
        width: 375.0,
        height: 350.0,
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Show Options'),
            ),
          ),
          bottomSheet: AppBottomSheet(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  'Options',
                  variant: AppTextVariant.headlineSmall,
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  3,
                  (index) => Column(
                    children: [
                      ListTile(
                        title: AppText('Option ${index + 1}'),
                        onTap: () {},
                      ),
                      if (index < 2)
                        const Divider(height: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'AppBottomSheet - Non-Dismissible',
      fileName: 'bottom_sheet_nondismissible',
      builder: () => buildThemeMatrix(
        name: 'Non-Dismissible Mode',
        width: 375.0,
        height: 300.0,
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Show Confirm'),
            ),
          ),
          bottomSheet: AppBottomSheet(
            isDismissible: false,
            enableDrag: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  'Confirmation',
                  variant: AppTextVariant.headlineSmall,
                ),
                const SizedBox(height: 16),
                const AppText(
                  'Cannot dismiss by tapping outside.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'AppBottomSheet - Limited Height',
      fileName: 'bottom_sheet_limited',
      builder: () => buildThemeMatrix(
        name: 'Limited Height',
        width: 375.0,
        height: 250.0,
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Show Short'),
            ),
          ),
          bottomSheet: AppBottomSheet(
            maxHeight: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  'Short Sheet',
                  variant: AppTextVariant.headlineSmall,
                ),
                const SizedBox(height: 8),
                const AppText('Limited height content'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}
