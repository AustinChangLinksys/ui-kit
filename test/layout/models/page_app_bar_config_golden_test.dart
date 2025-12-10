import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/layout/models/page_app_bar_config.dart';
import 'package:ui_kit_library/src/atoms/typography/app_text.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Golden tests for PageAppBarConfig model variations
/// This test ensures the configuration model behaves consistently across all themes
void main() {
  setUpAll(() async {
    // Load real fonts for proper golden test rendering
    await loadAppFonts();
  });

  group('PageAppBarConfig Golden Tests', () {
    // Note: This test will initially FAIL as PageAppBarConfig doesn't exist yet
    // This is expected behavior following TDD approach

    goldenTest(
      'PageAppBarConfig - Basic Configuration',
      fileName: 'page_app_bar_config_basic',
      builder: () => buildThemeMatrix(
        name: 'PageAppBarConfig Basic',
        width: 400,
        height: 300,
        child: TestWidget(
          config: PageAppBarConfig(
            title: 'Test Page',
            showBackButton: true,
          ),
        ),
      ),
    );

    goldenTest(
      'PageAppBarConfig - With Actions',
      fileName: 'page_app_bar_config_with_actions',
      builder: () => buildThemeMatrix(
        name: 'PageAppBarConfig With Actions',
        width: 400,
        height: 300,
        child: TestWidget(
          config: PageAppBarConfig(
            title: 'Test Page',
            showBackButton: true,
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'PageAppBarConfig - Sliver Mode',
      fileName: 'page_app_bar_config_sliver',
      builder: () => buildThemeMatrix(
        name: 'PageAppBarConfig Sliver',
        width: 400,
        height: 400,
        child: TestWidget(
          config: PageAppBarConfig(
            title: 'Collapsible Page',
            showBackButton: true,
            enableSliver: true,
            toolbarHeight: 120,
          ),
        ),
      ),
    );
  });
}

/// Test widget to display configuration model behavior
class TestWidget extends StatelessWidget {
  final PageAppBarConfig config;

  const TestWidget({
    Key? key,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(config.title ?? 'No Title'),
        automaticallyImplyLeading: config.showBackButton,
        actions: config.actions,
        toolbarHeight: config.toolbarHeight,
      ),
      body: Center(
        child: AppSurface(
          variant: SurfaceVariant.base,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText('Title: ${config.title}'),
                AppText('Show Back Button: ${config.showBackButton}'),
                AppText('Enable Sliver: ${config.enableSliver}'),
                AppText('Toolbar Height: ${config.toolbarHeight}'),
                AppText('Actions Count: ${config.actions?.length ?? 0}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}