import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

/// Content API for AppPageView
/// Demonstrates child, childBuilder, and header variations

@widgetbook.UseCase(
  name: 'Static Child',
  type: AppPageView,
)
Widget buildStaticChild(BuildContext context) {
  return AppPageView(
    appBarConfig: const PageAppBarConfig(
      title: 'Static Content',
      showBackButton: true,
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppIcon.font(Icons.widgets, size: 64, color: Colors.blue),
            AppGap.lg(),
            AppText.titleLarge('Static Child Widget'),
            AppGap.sm(),
            AppText.bodyMedium(
              'This content is provided via the child parameter',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'ChildBuilder (Constraint-Aware)',
  type: AppPageView,
)
Widget buildChildBuilder(BuildContext context) {
  return AppPageView(
    useSlivers: false,
    appBarConfig: const PageAppBarConfig(
      title: 'Constraint-Aware Content',
      showBackButton: true,
    ),
    childBuilder: (context, constraints) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppIcon.font(Icons.aspect_ratio, size: 64, color: Colors.green),
              AppGap.lg(),
              AppText.titleLarge('ChildBuilder'),
              AppGap.md(),
              AppText.bodyMedium(
                'This content adapts to available constraints',
                textAlign: TextAlign.center,
              ),
              AppGap.lg(),
              AppCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.titleSmall('Available Constraints:'),
                      AppGap.sm(),
                      AppText.bodyMedium(
                        'Width: ${constraints.maxWidth.isFinite ? constraints.maxWidth.toInt() : "∞"}px',
                      ),
                      AppText.bodyMedium(
                        'Height: ${constraints.maxHeight.isFinite ? constraints.maxHeight.toInt() : "∞"}px',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Header (Sliver Mode)',
  type: AppPageView,
)
Widget buildHeaderSliver(BuildContext context) {
  return AppPageView(
    useSlivers: true,
    appBarConfig: const PageAppBarConfig(
      title: 'Page with Header',
      showBackButton: true,
    ),
    header: SliverToBoxAdapter(
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
              Icon(Icons.image, size: 48, color: Colors.white),
              SizedBox(height: 8),
              Text(
                'Sliver Header Banner',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Above AppBar in scroll',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.titleMedium('Content Below Header'),
          AppGap.md(),
          AppText.bodyMedium(
            'The header scrolls with the content in Sliver mode. '
            'Scroll up to see the header above the AppBar.',
          ),
          AppGap.lg(),
          ...List.generate(
            10,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                child: AppListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: AppText('List Item ${index + 1}'),
                  subtitle: AppText.bodySmall('Scroll to see header behavior'),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Header (Box Mode)',
  type: AppPageView,
)
Widget buildHeaderBox(BuildContext context) {
  return AppPageView(
    useSlivers: false,
    appBarConfig: const PageAppBarConfig(
      title: 'Page with Header',
      showBackButton: true,
    ),
    header: Container(
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withValues(alpha: 0.3),
            Colors.teal.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 48, color: Colors.white),
            SizedBox(height: 8),
            Text(
              'Box Header Banner',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Above AppBar, always visible',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.titleMedium('Content Below Header'),
          AppGap.md(),
          AppText.bodyMedium(
            'In Box mode, the header stays fixed above the AppBar. '
            'The content scrolls independently.',
          ),
          AppGap.lg(),
          ...List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                child: AppListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: AppText('List Item ${index + 1}'),
                  subtitle: AppText.bodySmall('Header remains fixed above'),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
