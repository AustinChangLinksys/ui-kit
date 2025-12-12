import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

/// Interactive Playground for AppPageView
/// Allows testing various configurations interactively

@widgetbook.UseCase(
  name: 'Interactive Testing',
  type: AppPageView,
)
Widget buildPlayground(BuildContext context) {
  // Layout Mode
  final useSlivers = context.knobs.boolean(
    label: 'Use Slivers',
    initialValue: true,
    description: 'Sliver mode vs Box mode',
  );

  final scrollable = context.knobs.boolean(
    label: 'Scrollable',
    initialValue: true,
    description: 'Enable scrolling',
  );

  // Menu Configuration
  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    initialValue: 3,
    min: 0,
    max: 6,
    description: '0: no menu, 1-2: icons, 3+: popup',
  );

  final menuPositionIndex = context.knobs.object.dropdown<int>(
    label: 'Menu Position',
    options: [0, 1, 2, 3, 4],
    labelBuilder: (value) => switch (value) {
      0 => 'None',
      1 => 'Left',
      2 => 'Right',
      3 => 'Top',
      4 => 'FAB',
      _ => 'Unknown',
    },
    initialOption: 1,
    description: 'Where to display menu',
  );

  final hasMenuView = context.knobs.boolean(
    label: 'Has MenuView',
    initialValue: false,
    description: 'Include custom menuView (profile panel)',
  );

  // AppBar Configuration
  final showBackButton = context.knobs.boolean(
    label: 'Show Back Button',
    initialValue: false,
    description: 'Display back button in AppBar',
  );

  // Bottom Bar Configuration
  final hasBottomBar = context.knobs.boolean(
    label: 'Has Bottom Bar',
    initialValue: false,
    description: 'Include bottom action bar',
  );

  // Header Configuration
  final hasHeader = context.knobs.boolean(
    label: 'Has Header',
    initialValue: false,
    description: 'Include header above AppBar',
  );

  // Map index to MenuPosition
  final menuPosition = switch (menuPositionIndex) {
    0 => MenuPosition.none,
    1 => MenuPosition.left,
    2 => MenuPosition.right,
    3 => MenuPosition.top,
    4 => MenuPosition.fab,
    _ => MenuPosition.left,
  };

  // Generate menu items
  final allItems = [
    PageMenuItem.navigation(
      label: 'Home',
      icon: Icons.home,
      onTap: () {},
      isSelected: true,
    ),
    PageMenuItem.navigation(
      label: 'Search',
      icon: Icons.search,
      onTap: () {},
    ),
    PageMenuItem.navigation(
      label: 'Favorites',
      icon: Icons.favorite,
      onTap: () {},
    ),
    const PageMenuItem.divider(),
    PageMenuItem.navigation(
      label: 'Settings',
      icon: Icons.settings,
      onTap: () {},
    ),
    PageMenuItem.navigation(
      label: 'Help',
      icon: Icons.help,
      onTap: () {},
    ),
  ];

  final items = itemCount > 0 ? allItems.take(itemCount).toList() : <PageMenuItem>[];

  // Build configuration summary
  final configSummary = [
    'Layout: ${useSlivers ? "Sliver" : "Box"}',
    'Scrollable: ${scrollable ? "Yes" : "No"}',
    'Menu: ${menuPosition.name} ($itemCount items)',
    'MenuView: ${hasMenuView ? "Yes" : "No"}',
    'Back Button: ${showBackButton ? "Yes" : "No"}',
    'Bottom Bar: ${hasBottomBar ? "Yes" : "No"}',
    'Header: ${hasHeader ? "Yes" : "No"}',
  ];

  return AppPageView(
    useSlivers: useSlivers,
    scrollable: scrollable,
    appBarConfig: PageAppBarConfig(
      title: 'Playground',
      showBackButton: showBackButton,
    ),
    menuConfig: itemCount > 0
        ? PageMenuConfig(
            title: 'Menu',
            items: items,
          )
        : null,
    menuPosition: menuPosition,
    menuView: hasMenuView
        ? PageMenuView(
            icon: Icons.person,
            label: 'Profile',
            content: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.person, size: 32),
                  ),
                  AppGap.md(),
                  AppText.titleMedium('John Doe'),
                  AppText.bodySmall('john@example.com'),
                  AppGap.lg(),
                  AppText.bodySmall('Custom menuView content'),
                ],
              ),
            ),
          )
        : null,
    bottomBarConfig: hasBottomBar
        ? PageBottomBarConfig(
            positiveLabel: 'Save',
            negativeLabel: 'Cancel',
            onPositiveTap: () {},
            onNegativeTap: () {},
          )
        : null,
    header: hasHeader
        ? Container(
            height: 100,
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
                  Icon(Icons.image, size: 40, color: Colors.white),
                  SizedBox(height: 4),
                  Text(
                    'Header Banner',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        : null,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.science, size: 64, color: Colors.blue),
          AppGap.lg(),
          AppText.titleLarge('Interactive Playground'),
          AppGap.md(),
          AppText.bodyMedium(
            'Use the knobs panel to test different configurations',
          ),
          AppGap.xl(),
          AppCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.titleSmall('Current Configuration:'),
                  AppGap.md(),
                  ...configSummary.map(
                    (line) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: AppText.bodySmall(line),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppGap.lg(),
          AppCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.titleSmall('Responsive Behavior:'),
                  AppGap.sm(),
                  AppText.bodySmall('Desktop (>1024px):'),
                  AppText.caption('• left/right → Sidebar'),
                  AppText.caption('• top → AppBar icons'),
                  AppText.caption('• fab → FAB menu'),
                  AppGap.sm(),
                  AppText.bodySmall('Mobile (<1024px):'),
                  AppText.caption('• All → AppBar icons/popup'),
                ],
              ),
            ),
          ),
          if (scrollable) ...[
            AppGap.xl(),
            AppText.bodyMedium('Scroll down for more content...'),
            AppGap.lg(),
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AppCard(
                  child: AppListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: AppText('Item ${index + 1}'),
                    subtitle: const AppText('Test content for scrolling'),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
