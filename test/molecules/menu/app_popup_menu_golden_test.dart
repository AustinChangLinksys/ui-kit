import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppPopupMenu Trigger Golden Tests', () {
    // Test 1: Default trigger (more_vert icon)
    goldenTest(
      'AppPopupMenu - Default Trigger',
      fileName: 'app_popup_menu_default_trigger',
      builder: () => buildThemeMatrix(
        name: 'Default Trigger',
        width: 80,
        height: 60,
        child: AppPopupMenu<String>(
          items: const [
            AppPopupMenuItem(value: 'edit', label: 'Edit'),
            AppPopupMenuItem(value: 'delete', label: 'Delete'),
          ],
          onSelected: (_) {},
        ),
      ),
    );

    // Test 2: Custom icon trigger
    goldenTest(
      'AppPopupMenu - Custom Icon',
      fileName: 'app_popup_menu_custom_icon',
      builder: () => buildThemeMatrix(
        name: 'Custom Icon',
        width: 80,
        height: 60,
        child: AppPopupMenu<String>(
          icon: Icons.settings,
          items: const [
            AppPopupMenuItem(value: 'settings', label: 'Settings'),
            AppPopupMenuItem(value: 'help', label: 'Help'),
          ],
          onSelected: (_) {},
        ),
      ),
    );

    // Test 3: Disabled state
    goldenTest(
      'AppPopupMenu - Disabled',
      fileName: 'app_popup_menu_disabled',
      builder: () => buildThemeMatrix(
        name: 'Disabled',
        width: 80,
        height: 60,
        child: AppPopupMenu<String>(
          enabled: false,
          items: const [
            AppPopupMenuItem(value: 'edit', label: 'Edit'),
          ],
          onSelected: (_) {},
        ),
      ),
    );
  });

  group('AppPopupMenuPreview Golden Tests', () {
    // Test: Full menu preview with multiple items
    goldenTest(
      'AppPopupMenuPreview - Standard Menu',
      fileName: 'app_popup_menu_preview_standard',
      builder: () => buildThemeMatrix(
        name: 'Standard Menu',
        width: 220,
        height: 220,
        child: const AppPopupMenuPreview<String>(
          width: 180,
          items: [
            AppPopupMenuItem(value: 'edit', label: 'Edit', icon: Icons.edit),
            AppPopupMenuItem(value: 'copy', label: 'Duplicate', icon: Icons.copy),
            AppPopupMenuItem(value: 'share', label: 'Share', icon: Icons.share),
            AppPopupMenuItem(
              value: 'delete',
              label: 'Delete',
              icon: Icons.delete,
              isDestructive: true,
            ),
          ],
        ),
      ),
    );

    // Test: Menu with disabled items
    goldenTest(
      'AppPopupMenuPreview - With Disabled Items',
      fileName: 'app_popup_menu_preview_disabled',
      builder: () => buildThemeMatrix(
        name: 'With Disabled',
        width: 220,
        height: 180,
        child: const AppPopupMenuPreview<String>(
          width: 180,
          items: [
            AppPopupMenuItem(value: 'cut', label: 'Cut', icon: Icons.content_cut),
            AppPopupMenuItem(value: 'copy', label: 'Copy', icon: Icons.content_copy),
            AppPopupMenuItem(
              value: 'paste',
              label: 'Paste',
              icon: Icons.content_paste,
              enabled: false,
            ),
          ],
        ),
      ),
    );

    // Test: Menu without icons
    goldenTest(
      'AppPopupMenuPreview - Text Only',
      fileName: 'app_popup_menu_preview_text_only',
      builder: () => buildThemeMatrix(
        name: 'Text Only',
        width: 180,
        height: 180,
        child: const AppPopupMenuPreview<String>(
          width: 140,
          items: [
            AppPopupMenuItem(value: 'option1', label: 'Option 1'),
            AppPopupMenuItem(value: 'option2', label: 'Option 2'),
            AppPopupMenuItem(value: 'option3', label: 'Option 3'),
          ],
        ),
      ),
    );

    // Test: Destructive only
    goldenTest(
      'AppPopupMenuPreview - Destructive Actions',
      fileName: 'app_popup_menu_preview_destructive',
      builder: () => buildThemeMatrix(
        name: 'Destructive',
        width: 220,
        height: 150,
        child: const AppPopupMenuPreview<String>(
          width: 180,
          items: [
            AppPopupMenuItem(value: 'archive', label: 'Archive', icon: Icons.archive),
            AppPopupMenuItem(
              value: 'delete',
              label: 'Delete Forever',
              icon: Icons.delete_forever,
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  });

  group('CascadingMenuPreview Golden Tests', () {
    // Test: Three-level cascading menu
    goldenTest(
      'CascadingMenuPreview - Three Level Menu',
      fileName: 'cascading_menu_three_level',
      builder: () => buildThemeMatrix(
        name: 'Three Level',
        width: 560,
        height: 280,
        child: const CascadingMenuPreview(
          menuWidth: 150,
          level1HighlightIndex: 1,
          level2HighlightIndex: 0,
          level1Items: [
            AppPopupMenuItem(value: 'file', label: 'File', icon: Icons.folder),
            AppPopupMenuItem(
              value: 'edit',
              label: 'Edit',
              icon: Icons.edit,
              hasSubmenu: true,
            ),
            AppPopupMenuItem(value: 'view', label: 'View', icon: Icons.visibility),
            AppPopupMenuItem(value: 'help', label: 'Help', icon: Icons.help),
          ],
          level2Items: [
            AppPopupMenuItem(
              value: 'clipboard',
              label: 'Clipboard',
              icon: Icons.content_paste,
              hasSubmenu: true,
            ),
            AppPopupMenuItem(value: 'undo', label: 'Undo', icon: Icons.undo),
            AppPopupMenuItem(value: 'redo', label: 'Redo', icon: Icons.redo),
          ],
          level3Items: [
            AppPopupMenuItem(value: 'cut', label: 'Cut', icon: Icons.content_cut),
            AppPopupMenuItem(value: 'copy', label: 'Copy', icon: Icons.copy),
            AppPopupMenuItem(value: 'paste', label: 'Paste', icon: Icons.paste),
          ],
        ),
      ),
    );

    // Test: Cascading with destructive action
    goldenTest(
      'CascadingMenuPreview - With Destructive',
      fileName: 'cascading_menu_destructive',
      builder: () => buildThemeMatrix(
        name: 'Destructive',
        width: 560,
        height: 220,
        child: const CascadingMenuPreview(
          menuWidth: 150,
          level1HighlightIndex: 0,
          level2HighlightIndex: 1,
          level1Items: [
            AppPopupMenuItem(
              value: 'actions',
              label: 'Actions',
              icon: Icons.flash_on,
              hasSubmenu: true,
            ),
            AppPopupMenuItem(value: 'settings', label: 'Settings', icon: Icons.settings),
          ],
          level2Items: [
            AppPopupMenuItem(value: 'archive', label: 'Archive', icon: Icons.archive),
            AppPopupMenuItem(
              value: 'danger',
              label: 'Danger Zone',
              icon: Icons.warning,
              hasSubmenu: true,
            ),
          ],
          level3Items: [
            AppPopupMenuItem(value: 'reset', label: 'Reset', icon: Icons.refresh),
            AppPopupMenuItem(
              value: 'delete',
              label: 'Delete All',
              icon: Icons.delete_forever,
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  });
}
