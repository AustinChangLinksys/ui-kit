import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/layout/app_page_view.dart';
import 'package:ui_kit_library/src/layout/models/page_app_bar_config.dart';
import 'package:ui_kit_library/src/layout/models/page_bottom_bar_config.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_config.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_item.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../test_utils/golden_test_matrix_factory.dart';
import '../test_utils/font_loader.dart';

/// Golden tests for enhanced AppPageView component
/// This test ensures the component renders correctly across all themes
void main() {
  setUpAll(() async {
    // Load real fonts for proper golden test rendering
    await loadAppFonts();
  });

  group('Enhanced AppPageView Golden Tests', () {
    // Note: These tests will initially FAIL as enhanced AppPageView doesn't exist yet
    // This is expected behavior following TDD approach

    goldenTest(
      'AppPageView - Basic Enhanced Page',
      fileName: 'app_page_view_enhanced_basic',
      builder: () => buildThemeMatrix(
        name: 'Enhanced AppPageView - Basic',
        width: 400,
        height: 600,
        child: AppPageView(
            appBarConfig: PageAppBarConfig(
              title: 'Enhanced Page',
              showBackButton: true,
              actions: [
                IconButton(icon: Icon(Icons.settings), onPressed: () {}),
              ],
            ),
            child: (context, constraints) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Enhanced AppPageView'),
                  Text('Width: ${constraints.maxWidth.isFinite ? constraints.maxWidth.toInt() : 'Unlimited'}'),
                  Text('Height: ${constraints.maxHeight.isFinite ? constraints.maxHeight.toInt() : 'Unlimited'}'),
                ],
              ),
            ),
          ),
      ),
    );

    goldenTest(
      'AppPageView - With Bottom Action Bar',
      fileName: 'app_page_view_with_bottom_bar',
      builder: () => buildThemeMatrix(
        name: 'Enhanced AppPageView - Bottom Bar',
          width: 400,
          height: 600,
          child: AppPageView(
            appBarConfig: PageAppBarConfig(
              title: 'Edit Settings',
              showBackButton: true,
            ),
            bottomBarConfig: PageBottomBarConfig(
              positiveLabel: 'Save',
              negativeLabel: 'Cancel',
              onPositiveTap: () {},
              onNegativeTap: () {},
              isPositiveEnabled: true,
            ),
            child: (context, constraints) => Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Setting Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Setting Value',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );

    goldenTest(
      'AppPageView - With Responsive Menu (Single Theme)',
      fileName: 'app_page_view_with_menu_single',
      builder: () => GoldenTestGroup(
        columns: 1, // Single column to avoid width calculation issues
        children: [
          GoldenTestScenario(
            name: 'Glass Light',
            child: SizedBox(
              width: 1600, // Fixed desktop width
              height: 600,
              child: ColoredBox(
                color: Colors.white,
                child: Theme(
                  data: AppTheme.create(
                    brightness: Brightness.light,
                    designThemeBuilder: (s) => GlassDesignTheme.light(s),
                  ),
                  child: AppPageView(
                    appBarConfig: PageAppBarConfig(
                      title: 'Dashboard',
                      showBackButton: false,
                    ),
                    menuConfig: PageMenuConfig(
                      title: 'Navigation',
                      items: [
                        PageMenuItem(
                          label: 'Dashboard',
                          icon: Icons.dashboard,
                          isSelected: true,
                          onTap: () {},
                        ),
                        PageMenuItem(
                          label: 'Analytics',
                          icon: Icons.analytics,
                          onTap: () {},
                        ),
                        PageMenuItem(
                          label: 'Settings',
                          icon: Icons.settings,
                          onTap: () {},
                        ),
                      ],
                      showOnDesktop: true,
                      showOnMobile: true,
                    ),
                    showGridOverlay: false, // Disable debug overlay for clean golden
                    child: (context, constraints) => Center(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.dashboard, size: 48),
                              SizedBox(height: 16),
                              Text('Dashboard Content'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}