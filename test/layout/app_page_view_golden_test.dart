import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../test_utils/golden_test_matrix_factory.dart';
import '../test_utils/font_loader.dart';

/// Golden tests for AppPageView component
/// Tests factory constructors, content APIs, and layout modes
void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  // ===========================================================================
  // Group 1: Factory Constructors
  // ===========================================================================
  group('Factory Constructors', () {
    goldenTest(
      'AppPageView.basic()',
      fileName: 'app_page_view_factory_basic',
      builder: () => buildThemeMatrix(
        name: 'Basic Factory',
        width: 400,
        height: 500,
        child: AppPageView.basic(
          title: 'Settings',
          child: const Center(
            child: Text('Simple content with basic factory'),
          ),
        ),
      ),
    );

    goldenTest(
      'AppPageView.withBottomBar()',
      fileName: 'app_page_view_factory_bottom_bar',
      builder: () => buildThemeMatrix(
        name: 'BottomBar Factory',
        width: 400,
        height: 500,
        child: AppPageView.withBottomBar(
          title: 'Edit Profile',
          positiveLabel: 'Save',
          negativeLabel: 'Cancel',
          onPositiveTap: () {},
          onNegativeTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const AppTextField(hintText: 'Username'),
                AppGap.md(),
                const AppTextField(hintText: 'Email'),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'AppPageView.withMenu()',
      fileName: 'app_page_view_factory_menu',
      builder: () => GoldenTestGroup(
        columns: 1,
        children: [
          _buildDesktopScenario(
            name: 'Menu Factory (Desktop)',
            width: 1200,
            height: 400,
            child: AppPageView.withMenu(
              title: 'Dashboard',
              menuTitle: 'Navigation',
              menuItems: [
                PageMenuItem.navigation(
                  label: 'Overview',
                  icon: Icons.dashboard,
                  isSelected: true,
                  onTap: () {},
                ),
                PageMenuItem.navigation(
                  label: 'Analytics',
                  icon: Icons.analytics,
                  onTap: () {},
                ),
              ],
              child: const Center(child: Text('Dashboard Content')),
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'AppPageView.withTabs()',
      fileName: 'app_page_view_factory_tabs',
      builder: () => buildThemeMatrixWithBuilder(
        name: 'Tabs Factory',
        width: 400,
        height: 500,
        childBuilder: () => DefaultTabController(
          length: 3,
          child: AppPageView.withTabs(
            title: 'Settings',
            tabs: const [
              Tab(text: 'General'),
              Tab(text: 'Privacy'),
              Tab(text: 'About'),
            ],
            tabViews: const [
              Center(child: Text('General Settings')),
              Center(child: Text('Privacy Settings')),
              Center(child: Text('About Info')),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'AppPageView.withSlivers()',
      fileName: 'app_page_view_factory_slivers',
      builder: () => buildThemeMatrix(
        name: 'Slivers Factory',
        width: 400,
        height: 500,
        child: AppPageView.withSlivers(
          title: 'Custom Slivers',
          showBackButton: true,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                color: Colors.blue.withValues(alpha: 0.2),
                child: const Center(child: Text('Header Section')),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('Item ${index + 1}'),
                  leading: const Icon(Icons.star),
                ),
                childCount: 5,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 80,
                color: Colors.green.withValues(alpha: 0.2),
                child: const Center(child: Text('Footer Section')),
              ),
            ),
          ],
        ),
      ),
    );
  });

  // ===========================================================================
  // Group 2: Content API (child vs childBuilder)
  // ===========================================================================
  group('Content API', () {
    goldenTest(
      'child - Static Widget',
      fileName: 'app_page_view_child_static',
      builder: () => buildThemeMatrix(
        name: 'Static Child',
        width: 400,
        height: 400,
        child: const AppPageView(
          appBarConfig: PageAppBarConfig(
            title: 'Static Content',
            showBackButton: true,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.widgets, size: 48),
                SizedBox(height: 16),
                Text('Static Widget Content'),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'childBuilder - Constraint-Aware',
      fileName: 'app_page_view_child_builder',
      builder: () => buildThemeMatrixWithBuilder(
        name: 'ChildBuilder',
        width: 400,
        height: 400,
        childBuilder: () => AppPageView(
          useSlivers: false,
          appBarConfig: const PageAppBarConfig(
            title: 'Constraint-Aware',
            showBackButton: true,
          ),
          childBuilder: (context, constraints) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.aspect_ratio, size: 48),
                const SizedBox(height: 16),
                Text(
                  'W: ${constraints.maxWidth.isFinite ? constraints.maxWidth.toInt() : "∞"}',
                ),
                Text(
                  'H: ${constraints.maxHeight.isFinite ? constraints.maxHeight.toInt() : "∞"}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });

  // ===========================================================================
  // Group 3: Layout Modes
  // ===========================================================================
  group('Layout Modes', () {
    goldenTest(
      'Sliver Mode (useSlivers: true)',
      fileName: 'app_page_view_sliver_mode',
      builder: () => buildThemeMatrix(
        name: 'Sliver Mode',
        width: 400,
        height: 500,
        child: AppPageView(
          useSlivers: true,
          appBarConfig: const PageAppBarConfig(
            title: 'Sliver Layout',
            showBackButton: true,
          ),
          child: Column(
            children: [
              AppGap.lg(),
              AppText.titleMedium('Sliver Mode Content'),
              AppGap.md(),
              const AppTextField(hintText: 'Input Field'),
              AppGap.md(),
              AppButton(
                label: 'Action',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'Box Mode (useSlivers: false)',
      fileName: 'app_page_view_box_mode',
      builder: () => buildThemeMatrix(
        name: 'Box Mode',
        width: 400,
        height: 500,
        child: AppPageView(
          useSlivers: false,
          appBarConfig: const PageAppBarConfig(
            title: 'Box Layout',
            showBackButton: true,
          ),
          child: Column(
            children: [
              AppGap.lg(),
              AppText.titleMedium('Box Mode Content'),
              AppGap.md(),
              const AppTextField(hintText: 'Input Field'),
              AppGap.md(),
              AppButton(
                label: 'Action',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'Non-Scrollable (scrollable: false)',
      fileName: 'app_page_view_non_scrollable',
      builder: () => buildThemeMatrix(
        name: 'Non-Scrollable',
        width: 400,
        height: 400,
        child: const AppPageView(
          useSlivers: false,
          scrollable: false,
          appBarConfig: PageAppBarConfig(
            title: 'Fixed Layout',
            showBackButton: false,
          ),
          child: Center(
            child: Text('Non-scrollable fixed content'),
          ),
        ),
      ),
    );
  });

  // ===========================================================================
  // Group 4: Header Variations
  // ===========================================================================
  group('Header', () {
    goldenTest(
      'Header - Sliver Mode',
      fileName: 'app_page_view_header_sliver',
      builder: () => buildThemeMatrix(
        name: 'Header (Sliver)',
        width: 400,
        height: 500,
        child: AppPageView(
          useSlivers: true,
          appBarConfig: const PageAppBarConfig(
            title: 'Page with Header',
            showBackButton: true,
          ),
          header: SliverToBoxAdapter(
            child: Container(
              height: 120,
              color: Colors.blue.withValues(alpha: 0.2),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 48),
                    SizedBox(height: 8),
                    Text('Sliver Header Banner'),
                  ],
                ),
              ),
            ),
          ),
          child: const Center(
            child: Text('Content below header'),
          ),
        ),
      ),
    );

    goldenTest(
      'Header - Box Mode',
      fileName: 'app_page_view_header_box',
      builder: () => buildThemeMatrix(
        name: 'Header (Box)',
        width: 400,
        height: 500,
        child: AppPageView(
          useSlivers: false,
          appBarConfig: const PageAppBarConfig(
            title: 'Page with Header',
            showBackButton: true,
          ),
          header: Container(
            height: 120,
            color: Colors.green.withValues(alpha: 0.2),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 48),
                  SizedBox(height: 8),
                  Text('Box Header Banner'),
                ],
              ),
            ),
          ),
          child: const Center(
            child: Text('Content below header'),
          ),
        ),
      ),
    );

    goldenTest(
      'Header - With Tabs',
      fileName: 'app_page_view_header_tabs',
      builder: () => buildThemeMatrixWithBuilder(
        name: 'Header + Tabs',
        width: 400,
        height: 550,
        childBuilder: () => DefaultTabController(
          length: 2,
          child: AppPageView(
            useSlivers: true,
            appBarConfig: const PageAppBarConfig(
              title: 'Header + Tabs',
              showBackButton: true,
            ),
            header: SliverToBoxAdapter(
              child: Container(
                height: 100,
                color: Colors.purple.withValues(alpha: 0.2),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle, size: 40),
                      SizedBox(height: 4),
                      Text('Profile Header'),
                    ],
                  ),
                ),
              ),
            ),
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'About'),
            ],
            tabViews: const [
              Center(child: Text('Posts Content')),
              Center(child: Text('About Content')),
            ],
          ),
        ),
      ),
    );
  });

  // ===========================================================================
  // Group 5: MenuPosition Variations
  // ===========================================================================
  group('MenuPosition', () {
    goldenTest(
      'MenuPosition.none - Hidden Menu',
      fileName: 'app_page_view_menu_none',
      builder: () => buildThemeMatrix(
        name: 'Hidden Menu',
        width: 400,
        height: 400,
        child: AppPageView(
          appBarConfig: const PageAppBarConfig(
            title: 'No Menu',
            showBackButton: true,
          ),
          menuConfig: PageMenuConfig(
            title: 'Hidden',
            items: [
              PageMenuItem(label: 'Item', icon: Icons.star, onTap: () {}),
            ],
          ),
          menuPosition: MenuPosition.none,
          child: const Center(child: Text('Menu is hidden')),
        ),
      ),
    );
  });
}

/// Helper: Build desktop scenario with MediaQuery
GoldenTestScenario _buildDesktopScenario({
  required String name,
  required double width,
  required double height,
  required Widget child,
}) {
  final theme = AppTheme.create(
    brightness: Brightness.light,
    designThemeBuilder: (s) => GlassDesignTheme.light(s),
  );

  return GoldenTestScenario(
    name: name,
    child: SizedBox(
      width: width,
      height: height,
      child: MediaQuery(
        data: MediaQueryData(size: Size(width, height)),
        child: Theme(
          data: theme,
          child: ColoredBox(
            color: theme.scaffoldBackgroundColor,
            child: child,
          ),
        ),
      ),
    ),
  );
}
