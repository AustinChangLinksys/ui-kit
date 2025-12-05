import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Basic Navigation',
  type: AppBreadcrumb,
)
Widget buildBasicBreadcrumb(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headlineSmall('Basic Breadcrumb'),
            const SizedBox(height: 16),
            AppBreadcrumb(
              items: const [
                BreadcrumbItem(label: 'Home'),
                BreadcrumbItem(label: 'Products'),
                BreadcrumbItem(label: 'Electronics'),
                BreadcrumbItem(label: 'Phones'),
              ],
              onItemTap: (index) {
                debugPrint('Tapped breadcrumb at index: $index');
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
  type: AppBreadcrumb,
)
Widget buildBreadcrumbWithIcons(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headlineSmall('Breadcrumb with Icons'),
            const SizedBox(height: 16),
            AppBreadcrumb(
              items: const [
                BreadcrumbItem(label: 'Home', icon: Icons.home),
                BreadcrumbItem(label: 'Settings', icon: Icons.settings),
                BreadcrumbItem(label: 'Account', icon: Icons.person),
                BreadcrumbItem(label: 'Security', icon: Icons.security),
              ],
              onItemTap: (index) {
                debugPrint('Tapped breadcrumb at index: $index');
              },
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Long Path',
  type: AppBreadcrumb,
)
Widget buildLongBreadcrumb(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headlineSmall('Long Path (Scrollable)'),
            const SizedBox(height: 16),
            AppBreadcrumb(
              items: const [
                BreadcrumbItem(label: 'Home'),
                BreadcrumbItem(label: 'Documents'),
                BreadcrumbItem(label: 'Projects'),
                BreadcrumbItem(label: '2024'),
                BreadcrumbItem(label: 'Q4'),
                BreadcrumbItem(label: 'Reports'),
                BreadcrumbItem(label: 'Final'),
              ],
              onItemTap: (index) {
                debugPrint('Tapped breadcrumb at index: $index');
              },
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Disabled Items',
  type: AppBreadcrumb,
)
Widget buildDisabledBreadcrumb(BuildContext context) {
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
            AppBreadcrumb(
              items: const [
                BreadcrumbItem(label: 'Home'),
                BreadcrumbItem(label: 'Archive', enabled: false),
                BreadcrumbItem(label: 'Old Project', enabled: false),
                BreadcrumbItem(label: 'Current View'),
              ],
              onItemTap: (index) {
                debugPrint('Tapped breadcrumb at index: $index');
              },
            ),
          ],
        ),
      ),
    ),
  );
}
