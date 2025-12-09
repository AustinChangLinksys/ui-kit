import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../test_utils/golden_test_matrix_factory.dart';
import '../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppPageView Golden Tests', () {
    // Test 1: Basic Sliver Layout
    goldenTest(
      'AppPageView - Basic Sliver',
      fileName: 'app_page_view_basic_sliver',
      builder: () => buildThemeMatrix(
        name: 'Basic Sliver',
        width: 600,
        height: 300,
        child: const AppPageView(
          useSlivers: true,
          useContentPadding: true,
          child: Center(
            child: Text('Basic Sliver Content'),
          ),
        ),
      ),
    );

    // Test 2: Box Layout Mode
    goldenTest(
      'AppPageView - Box Layout',
      fileName: 'app_page_view_box_layout',
      builder: () => buildThemeMatrix(
        name: 'Box Layout',
        width: 600,
        height: 300,
        child: const AppPageView(
          useSlivers: false,
          useContentPadding: true,
          scrollable: false,
          child: Center(
            child: Text('Box Layout Content'),
          ),
        ),
      ),
    );

    // Test 3: With Tabs Integration (No Expanded to avoid viewport issues)
    goldenTest(
      'AppPageView - With Tabs',
      fileName: 'app_page_view_with_tabs',
      builder: () => buildThemeMatrix(
        name: 'With Tabs',
        width: 600,
        height: 400,
        child: AppPageView(
          useSlivers: true,
          useContentPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTabs(
                tabs: const [
                  TabItem(label: 'Tab 1'),
                  TabItem(label: 'Tab 2'),
                  TabItem(label: 'Tab 3'),
                ],
                initialIndex: 0,
                displayMode: TabDisplayMode.underline,
              ),
              const SizedBox(height: 16),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  border: Border.all(color: const Color(0xFF90CAF9)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Tab Content Area'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}