import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/layout/models/page_bottom_bar_config.dart';
import 'package:ui_kit_library/src/atoms/typography/app_text.dart';
import 'package:ui_kit_library/src/molecules/buttons/app_button.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Golden tests for PageBottomBarConfig model variations
/// This test ensures the configuration model behaves consistently across all themes
void main() {
  setUpAll(() async {
    // Load real fonts for proper golden test rendering
    await loadAppFonts();
  });

  group('PageBottomBarConfig Golden Tests', () {
    // Note: This test will initially FAIL as PageBottomBarConfig doesn't exist yet
    // This is expected behavior following TDD approach

    goldenTest(
      'PageBottomBarConfig - Basic Actions',
      fileName: 'page_bottom_bar_config_basic',
      builder: () => buildThemeMatrix(
        name: 'Basic Actions',
        width: 400,
        height: 300,
        child: TestWidget(
          config: PageBottomBarConfig(
            positiveLabel: 'Save',
            negativeLabel: 'Cancel',
            onPositiveTap: () {},
            onNegativeTap: () {},
          ),
        ),
      ),
    );

    goldenTest(
      'PageBottomBarConfig - Destructive Action',
      fileName: 'page_bottom_bar_config_destructive',
      builder: () => buildThemeMatrix(
        name: 'Destructive Action',
        width: 400,
        height: 300,
        child: TestWidget(
          config: PageBottomBarConfig(
            positiveLabel: 'Delete',
            negativeLabel: 'Cancel',
            onPositiveTap: () {},
            onNegativeTap: () {},
            isDestructive: true,
          ),
        ),
      ),
    );

    goldenTest(
      'PageBottomBarConfig - Disabled State',
      fileName: 'page_bottom_bar_config_disabled',
      builder: () => buildThemeMatrix(
        name: 'Disabled State',
        width: 400,
        height: 300,
        child: TestWidget(
          config: PageBottomBarConfig(
            positiveLabel: 'Save',
            negativeLabel: 'Cancel',
            onPositiveTap: () {},
            onNegativeTap: () {},
            isPositiveEnabled: false,
          ),
        ),
      ),
    );
  });
}

/// Test widget to display configuration model behavior
class TestWidget extends StatelessWidget {
  final PageBottomBarConfig config;

  const TestWidget({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppSurface(
          variant: SurfaceVariant.base,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText('Positive Label: ${config.positiveLabel}'),
                AppText('Negative Label: ${config.negativeLabel}'),
                AppText('Is Positive Enabled: ${config.isPositiveEnabled}'),
                AppText('Is Negative Enabled: ${config.isNegativeEnabled}'),
                AppText('Is Destructive: ${config.isDestructive}'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (config.negativeLabel != null)
              Expanded(
                child: AppButton.secondary(
                  onTap: (config.isNegativeEnabled ?? true) ? config.onNegativeTap : null,
                  label: config.negativeLabel!,
                ),
              ),
            if (config.negativeLabel != null && config.positiveLabel != null)
              const SizedBox(width: 16),
            if (config.positiveLabel != null)
              Expanded(
                child: AppButton.primary(
                  onTap: config.isPositiveEnabled ? config.onPositiveTap : null,
                  label: config.positiveLabel!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}