import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/layout/models/page_app_bar_config.dart';
import 'package:ui_kit_library/src/layout/models/page_bottom_bar_config.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_config.dart';
import 'package:ui_kit_library/src/layout/models/page_menu_item.dart';

/// Unit tests for page configuration models
void main() {
  group('PageAppBarConfig', () {
    test('creates instance with default values', () {
      const config = PageAppBarConfig();

      expect(config.title, isNull);
      expect(config.showBackButton, false);
      expect(config.enableSliver, false);
      expect(config.toolbarHeight, isNull);
    });

    test('creates instance with custom values', () {
      const config = PageAppBarConfig(
        title: 'Test Page',
        showBackButton: true,
        enableSliver: true,
        toolbarHeight: 120,
      );

      expect(config.title, 'Test Page');
      expect(config.showBackButton, true);
      expect(config.enableSliver, true);
      expect(config.toolbarHeight, 120);
    });

    test('copyWith works correctly', () {
      const original = PageAppBarConfig(title: 'Original');
      final copy = original.copyWith(title: 'Modified');

      expect(original.title, 'Original');
      expect(copy.title, 'Modified');
      expect(copy.showBackButton, original.showBackButton);
    });

    test('equality works correctly', () {
      const config1 = PageAppBarConfig(title: 'Test');
      const config2 = PageAppBarConfig(title: 'Test');
      const config3 = PageAppBarConfig(title: 'Different');

      expect(config1, equals(config2));
      expect(config1, isNot(equals(config3)));
    });
  });

  group('PageBottomBarConfig', () {
    test('creates instance with default values', () {
      const config = PageBottomBarConfig();

      expect(config.positiveLabel, isNull);
      expect(config.negativeLabel, isNull);
      expect(config.isPositiveEnabled, true);
      expect(config.isNegativeEnabled, isNull);
      expect(config.isDestructive, false);
    });

    test('equality works correctly', () {
      const config1 = PageBottomBarConfig(positiveLabel: 'Save');
      const config2 = PageBottomBarConfig(positiveLabel: 'Save');
      const config3 = PageBottomBarConfig(positiveLabel: 'Cancel');

      expect(config1, equals(config2));
      expect(config1, isNot(equals(config3)));
    });
  });

  group('PageMenuItem', () {
    test('creates regular menu item', () {
      final item = PageMenuItem(
        label: 'Settings',
        icon: Icons.settings,
        onTap: () {},
      );

      expect(item.label, 'Settings');
      expect(item.icon, Icons.settings);
      expect(item.isSelected, false);
      expect(item.enabled, true);
      expect(item.isDivider, false);
    });

    test('creates divider menu item', () {
      const item = PageMenuItem.divider();

      expect(item.label, '');
      expect(item.icon, isNull);
      expect(item.isDivider, true);
      expect(item.enabled, false);
    });

    test('equality works correctly', () {
      void sameCallback() {}

      final item1 = PageMenuItem(label: 'Test', onTap: sameCallback);
      final item2 = PageMenuItem(label: 'Test', onTap: sameCallback);
      final item3 = PageMenuItem(label: 'Different', onTap: sameCallback);

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
    });
  });

  group('PageMenuConfig', () {
    test('creates instance with default values', () {
      const config = PageMenuConfig();

      expect(config.title, isNull);
      expect(config.items, isEmpty);
      expect(config.largeMenu, false);
      expect(config.icon, isNull);
    });

    test('hasItems works correctly', () {
      const emptyConfig = PageMenuConfig();
      final configWithItems = PageMenuConfig(items: [
        PageMenuItem(label: 'Test', onTap: () {}),
      ]);

      expect(emptyConfig.hasItems, false);
      expect(configWithItems.hasItems, true);
    });

    test('menuItems filters dividers', () {
      final config = PageMenuConfig(items: [
        PageMenuItem(label: 'Item 1', onTap: () {}),
        const PageMenuItem.divider(),
        PageMenuItem(label: 'Item 2', onTap: () {}),
      ]);

      expect(config.menuItems.length, 2);
      expect(config.menuItems[0].label, 'Item 1');
      expect(config.menuItems[1].label, 'Item 2');
    });
  });
}
