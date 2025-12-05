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

  group('AppBreadcrumb Golden Tests', () {
    final basicItems = [
      const BreadcrumbItem(label: 'Home'),
      const BreadcrumbItem(label: 'Products'),
      const BreadcrumbItem(label: 'Electronics'),
    ];

    final itemsWithIcons = [
      const BreadcrumbItem(label: 'Home', icon: Icons.home),
      const BreadcrumbItem(label: 'Settings', icon: Icons.settings),
      const BreadcrumbItem(label: 'Profile', icon: Icons.person),
    ];

    final longPath = [
      const BreadcrumbItem(label: 'Home'),
      const BreadcrumbItem(label: 'Category'),
      const BreadcrumbItem(label: 'Subcategory'),
      const BreadcrumbItem(label: 'Product'),
      const BreadcrumbItem(label: 'Details'),
    ];

    goldenTest(
      'AppBreadcrumb - Basic Path',
      fileName: 'breadcrumb_basic',
      builder: () => buildThemeMatrix(
        name: 'Basic 3-item Path',
        width: 400.0,
        height: 80.0,
        child: AppBreadcrumb(
          items: basicItems,
        ),
      ),
    );

    goldenTest(
      'AppBreadcrumb - With Icons',
      fileName: 'breadcrumb_with_icons',
      builder: () => buildThemeMatrix(
        name: 'With Icons',
        width: 400.0,
        height: 80.0,
        child: AppBreadcrumb(
          items: itemsWithIcons,
          showIcons: true,
        ),
      ),
    );

    goldenTest(
      'AppBreadcrumb - Long Path',
      fileName: 'breadcrumb_long_path',
      builder: () => buildThemeMatrix(
        name: 'Long 5-item Path',
        width: 450.0,
        height: 80.0,
        child: AppBreadcrumb(
          items: longPath,
        ),
      ),
    );

    goldenTest(
      'AppBreadcrumb - Single Item',
      fileName: 'breadcrumb_single',
      builder: () => buildThemeMatrix(
        name: 'Single Item (Root)',
        width: 300.0,
        height: 80.0,
        child: const AppBreadcrumb(
          items: [
            BreadcrumbItem(label: 'Home'),
          ],
        ),
      ),
    );

    goldenTest(
      'AppBreadcrumb - Disabled Item',
      fileName: 'breadcrumb_disabled',
      builder: () => buildThemeMatrix(
        name: 'With Disabled Item',
        width: 400.0,
        height: 80.0,
        child: const AppBreadcrumb(
          items: [
            BreadcrumbItem(label: 'Home'),
            BreadcrumbItem(label: 'Restricted', enabled: false),
            BreadcrumbItem(label: 'Current'),
          ],
        ),
      ),
    );
  });
}
