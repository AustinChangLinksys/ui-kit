import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Underline Style',
  type: AppTabs,
)
Widget buildUnderlineTabs(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Column(
        children: [
          AppTabs(
            tabs: const [
              TabItem(label: 'All'),
              TabItem(label: 'Favorites'),
              TabItem(label: 'Recent'),
            ],
            displayMode: TabDisplayMode.underline,
            onTabChanged: (index) {
              debugPrint('Selected tab: $index');
            },
          ),
          const Expanded(
            child: Center(
              child: AppText('Tab content goes here'),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Filled Style',
  type: AppTabs,
)
Widget buildFilledTabs(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTabs(
              tabs: const [
                TabItem(label: 'Day'),
                TabItem(label: 'Week'),
                TabItem(label: 'Month'),
                TabItem(label: 'Year'),
              ],
              displayMode: TabDisplayMode.filled,
              onTabChanged: (index) {
                debugPrint('Selected tab: $index');
              },
            ),
          ),
          const Expanded(
            child: Center(
              child: AppText('Calendar view content'),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Segmented Style',
  type: AppTabs,
)
Widget buildSegmentedTabs(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTabs(
              tabs: const [
                TabItem(label: 'List'),
                TabItem(label: 'Grid'),
                TabItem(label: 'Map'),
              ],
              displayMode: TabDisplayMode.segmented,
              onTabChanged: (index) {
                debugPrint('Selected tab: $index');
              },
            ),
          ),
          const Expanded(
            child: Center(
              child: AppText('View mode content'),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Icons',
  type: AppTabs,
)
Widget buildTabsWithIcons(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Column(
        children: [
          AppTabs(
            tabs: const [
              TabItem(label: 'Home', icon: Icons.home),
              TabItem(label: 'Search', icon: Icons.search),
              TabItem(label: 'Profile', icon: Icons.person),
              TabItem(label: 'Settings', icon: Icons.settings),
            ],
            displayMode: TabDisplayMode.underline,
            onTabChanged: (index) {
              debugPrint('Selected tab: $index');
            },
          ),
          const Expanded(
            child: Center(
              child: AppText('Tab content with icons'),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Disabled Tab',
  type: AppTabs,
)
Widget buildTabsWithDisabled(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: Column(
        children: [
          AppTabs(
            tabs: const [
              TabItem(label: 'Active'),
              TabItem(label: 'Pending'),
              TabItem(label: 'Locked', enabled: false),
              TabItem(label: 'Completed'),
            ],
            displayMode: TabDisplayMode.underline,
            onTabChanged: (index) {
              debugPrint('Selected tab: $index');
            },
          ),
          const Expanded(
            child: Center(
              child: AppText('Third tab is disabled'),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Tab Content',
  type: AppTabs,
)
Widget buildTabsWithContent(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      body: AppTabs(
        tabs: const [
          TabItem(label: 'Tab 1'),
          TabItem(label: 'Tab 2'),
          TabItem(label: 'Tab 3'),
        ],
        displayMode: TabDisplayMode.underline,
        tabContents: const [
          Center(child: AppText.headlineMedium('Content for Tab 1')),
          Center(child: AppText.headlineMedium('Content for Tab 2')),
          Center(child: AppText.headlineMedium('Content for Tab 3')),
        ],
        onTabChanged: (index) {
          debugPrint('Selected tab: $index');
        },
      ),
    ),
  );
}
