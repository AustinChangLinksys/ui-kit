import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

/// Factory Constructors for AppPageView
/// Demonstrates all available factory methods

@widgetbook.UseCase(
  name: 'basic()',
  type: AppPageView,
)
Widget buildBasic(BuildContext context) {
  return AppPageView.basic(
    title: 'Basic Page',
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.dashboard, size: 64),
          AppGap.md(),
          AppText.titleLarge('Basic Factory'),
          AppGap.sm(),
          AppText.bodyMedium('Simple page with title and content'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'withBottomBar()',
  type: AppPageView,
)
Widget buildWithBottomBar(BuildContext context) {
  return AppPageView.withBottomBar(
    title: 'Edit Profile',
    positiveLabel: 'Save',
    negativeLabel: 'Cancel',
    onPositiveTap: () {},
    onNegativeTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.titleMedium('User Information'),
          AppGap.lg(),
          const AppTextField(
            hintText: 'Full Name',
            prefixIcon: Icon(Icons.person),
          ),
          AppGap.md(),
          const AppTextField(
            hintText: 'Email Address',
            prefixIcon: Icon(Icons.email),
          ),
          AppGap.md(),
          const AppTextField(
            hintText: 'Phone Number',
            prefixIcon: Icon(Icons.phone),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'withMenu()',
  type: AppPageView,
)
Widget buildWithMenu(BuildContext context) {
  return AppPageView.withMenu(
    title: 'Dashboard',
    menuTitle: 'Navigation',
    menuPosition: MenuPosition.left,
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
      PageMenuItem.navigation(
        label: 'Reports',
        icon: Icons.assessment,
        onTap: () {},
      ),
      const PageMenuItem.divider(),
      PageMenuItem.settings(
        label: 'Settings',
        onTap: () {},
      ),
    ],
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.menu, size: 64),
          AppGap.md(),
          AppText.titleLarge('Menu Factory'),
          AppGap.sm(),
          AppText.bodyMedium('Page with responsive sidebar menu'),
          AppGap.sm(),
          AppText.caption('Desktop: Sidebar | Mobile: AppBar'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'withTabs()',
  type: AppPageView,
)
Widget buildWithTabs(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: AppPageView.withTabs(
      title: 'Settings',
      tabs: const [
        Tab(text: 'General'),
        Tab(text: 'Privacy'),
        Tab(text: 'About'),
      ],
      tabViews: [
        _buildTabContent('General', Icons.settings, 'General settings content'),
        _buildTabContent('Privacy', Icons.lock, 'Privacy settings content'),
        _buildTabContent('About', Icons.info, 'About information'),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'withSlivers()',
  type: AppPageView,
)
Widget buildWithSlivers(BuildContext context) {
  return AppPageView.withSlivers(
    title: 'Custom Slivers',
    showBackButton: true,
    slivers: [
      // Header section
      SliverToBoxAdapter(
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withValues(alpha: 0.3),
                Colors.purple.withValues(alpha: 0.3),
              ],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.layers, size: 48),
                SizedBox(height: 8),
                Text('Custom Sliver Header'),
              ],
            ),
          ),
        ),
      ),
      // List section
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => AppListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: AppText('Sliver Item ${index + 1}'),
            subtitle: AppText.bodySmall('Custom sliver content'),
            trailing: const AppIcon.font(Icons.arrow_forward_ios, size: 16),
          ),
          childCount: 10,
        ),
      ),
      // Footer section
      SliverToBoxAdapter(
        child: Container(
          height: 100,
          color: Colors.grey.withValues(alpha: 0.1),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 32),
                SizedBox(height: 8),
                Text('Sliver Footer'),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// Helper
Widget _buildTabContent(String title, IconData icon, String description) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon.font(Icons.check_circle, size: 64),
          AppGap.lg(),
          AppText.titleLarge(title),
          AppGap.md(),
          AppText.bodyMedium(description),
        ],
      ),
    ),
  );
}
