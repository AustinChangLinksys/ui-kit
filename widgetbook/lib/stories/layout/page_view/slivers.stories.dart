import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

/// Advanced Sliver Layouts for AppPageView
/// Demonstrates various sliver combinations and patterns

@widgetbook.UseCase(
  name: 'Basic Slivers',
  type: AppPageView,
)
Widget buildBasicSlivers(BuildContext context) {
  return AppPageView.withSlivers(
    title: 'Basic Slivers',
    showBackButton: true,
    slivers: [
      // Header
      SliverToBoxAdapter(
        child: Container(
          height: 120,
          color: Colors.blue.withValues(alpha: 0.2),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.layers, size: 48),
                SizedBox(height: 8),
                Text('Header Section'),
              ],
            ),
          ),
        ),
      ),
      // List
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => AppListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: AppText('List Item ${index + 1}'),
            subtitle: AppText.bodySmall('Basic sliver list item'),
          ),
          childCount: 10,
        ),
      ),
      // Footer
      SliverToBoxAdapter(
        child: Container(
          height: 80,
          color: Colors.grey.withValues(alpha: 0.1),
          child: const Center(child: Text('Footer Section')),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Sliver AppBar',
  type: AppPageView,
)
Widget buildSliverAppBar(BuildContext context) {
  return AppPageView.withSlivers(
    title: 'Collapsible Header',
    showBackButton: true,
    slivers: [
      // Collapsible AppBar
      SliverAppBar(
        expandedHeight: 200,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: const AppText('Collapsible'),
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.withValues(alpha: 0.5),
                  Colors.blue.withValues(alpha: 0.5),
                ],
              ),
            ),
            child: const Center(
              child: Icon(Icons.expand, size: 64, color: Colors.white),
            ),
          ),
        ),
      ),
      // Content
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: AppCard(
              child: AppListTile(
                leading: const Icon(Icons.article),
                title: AppText('Article ${index + 1}'),
                subtitle: AppText.bodySmall('Scroll to collapse header'),
              ),
            ),
          ),
          childCount: 20,
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Sliver Grid',
  type: AppPageView,
)
Widget buildSliverGrid(BuildContext context) {
  return AppPageView.withSlivers(
    title: 'Grid Layout',
    showBackButton: true,
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppText.titleMedium('Photo Gallery'),
        ),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length]
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 32,
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
          ),
          childCount: 30,
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Mixed Slivers',
  type: AppPageView,
)
Widget buildMixedSlivers(BuildContext context) {
  return AppPageView.withSlivers(
    title: 'Mixed Layout',
    showBackButton: true,
    slivers: [
      // Header
      SliverToBoxAdapter(
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.withValues(alpha: 0.3),
                Colors.red.withValues(alpha: 0.3),
              ],
            ),
          ),
          child: const Center(
            child: Text(
              'Mixed Sliver Types',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      // Section 1: List
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppText.titleMedium('Recent Items'),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: AppCard(
              child: AppListTile(
                leading: const Icon(Icons.folder),
                title: AppText('Item ${index + 1}'),
              ),
            ),
          ),
          childCount: 3,
        ),
      ),
      // Section 2: Grid
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppText.titleMedium('Gallery'),
        ),
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1.5,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('Grid ${index + 1}')),
          ),
          childCount: 4,
        ),
      ),
      // Section 3: Another List
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppText.titleMedium('More Items'),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: AppCard(
              child: AppListTile(
                leading: const Icon(Icons.star),
                title: AppText('Favorite ${index + 1}'),
              ),
            ),
          ),
          childCount: 5,
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Pull to Refresh',
  type: AppPageView,
)
Widget buildPullToRefresh(BuildContext context) {
  return AppPageView(
    useSlivers: true,
    appBarConfig: const PageAppBarConfig(
      title: 'Pull to Refresh',
      showBackButton: true,
    ),
    onRefresh: () async {
      // Simulate refresh
      await Future.delayed(const Duration(seconds: 2));
    },
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green.withValues(alpha: 0.1),
          child: const Column(
            children: [
              Icon(Icons.refresh, size: 48, color: Colors.green),
              SizedBox(height: 8),
              Text(
                'Pull down to refresh',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: AppCard(
              child: AppListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withValues(alpha: 0.2),
                  child: Text('${index + 1}'),
                ),
                title: AppText('Refreshable Item ${index + 1}'),
                subtitle: AppText.bodySmall('Pull to refresh this list'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
          childCount: 15,
        ),
      ),
    ],
  );
}
