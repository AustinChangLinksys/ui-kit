import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Default Menu',
  type: AppPopupMenu,
)
Widget buildAppPopupMenuDefault(BuildContext context) {
  final showIcons = context.knobs.boolean(
    label: 'Show Icons',
    initialValue: true,
  );

  return Center(
    child: AppPopupMenu<String>(
      items: [
        AppPopupMenuItem(
          value: 'edit',
          label: 'Edit',
          icon: showIcons ? Icons.edit : null,
        ),
        AppPopupMenuItem(
          value: 'duplicate',
          label: 'Duplicate',
          icon: showIcons ? Icons.copy : null,
        ),
        AppPopupMenuItem(
          value: 'share',
          label: 'Share',
          icon: showIcons ? Icons.share : null,
        ),
        AppPopupMenuItem(
          value: 'delete',
          label: 'Delete',
          icon: showIcons ? Icons.delete : null,
          isDestructive: true,
        ),
      ],
      onSelected: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected: $value'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Icon Trigger',
  type: AppPopupMenu,
)
Widget buildAppPopupMenuCustomIcon(BuildContext context) {
  final iconOption = context.knobs.object.dropdown<IconData>(
    label: 'Trigger Icon',
    options: [
      Icons.more_vert,
      Icons.more_horiz,
      Icons.settings,
      Icons.tune,
    ],
    labelBuilder: (icon) {
      if (icon == Icons.more_vert) return 'More Vertical';
      if (icon == Icons.more_horiz) return 'More Horizontal';
      if (icon == Icons.settings) return 'Settings';
      return 'Tune';
    },
  );

  return Center(
    child: AppPopupMenu<String>(
      icon: iconOption,
      items: const [
        AppPopupMenuItem(
          value: 'option1',
          label: 'Option 1',
          icon: Icons.looks_one,
        ),
        AppPopupMenuItem(
          value: 'option2',
          label: 'Option 2',
          icon: Icons.looks_two,
        ),
        AppPopupMenuItem(
          value: 'option3',
          label: 'Option 3',
          icon: Icons.looks_3,
        ),
      ],
      onSelected: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected: $value'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Child Trigger',
  type: AppPopupMenu,
)
Widget buildAppPopupMenuCustomChild(BuildContext context) {
  return Center(
    child: AppPopupMenu<String>(
      items: const [
        AppPopupMenuItem(
          value: 'profile',
          label: 'View Profile',
          icon: Icons.person,
        ),
        AppPopupMenuItem(
          value: 'settings',
          label: 'Settings',
          icon: Icons.settings,
        ),
        AppPopupMenuItem(
          value: 'logout',
          label: 'Logout',
          icon: Icons.logout,
          isDestructive: true,
        ),
      ],
      onSelected: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected: $value'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 14,
              child: Icon(Icons.person, size: 16),
            ),
            const SizedBox(width: 8),
            const Text('John Doe'),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Disabled Items',
  type: AppPopupMenu,
)
Widget buildAppPopupMenuWithDisabled(BuildContext context) {
  return Center(
    child: AppPopupMenu<String>(
      items: const [
        AppPopupMenuItem(
          value: 'cut',
          label: 'Cut',
          icon: Icons.content_cut,
        ),
        AppPopupMenuItem(
          value: 'copy',
          label: 'Copy',
          icon: Icons.content_copy,
        ),
        AppPopupMenuItem(
          value: 'paste',
          label: 'Paste',
          icon: Icons.content_paste,
          enabled: false,
        ),
        AppPopupMenuItem(
          value: 'delete',
          label: 'Delete',
          icon: Icons.delete,
          isDestructive: true,
          enabled: false,
        ),
      ],
      onSelected: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected: $value'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(
  name: 'In AppBar Context',
  type: AppPopupMenu,
)
Widget buildAppPopupMenuInAppBar(BuildContext context) {
  return Scaffold(
    appBar: AppUnifiedBar(
      title: 'Notes',
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        AppPopupMenu<String>(
          tooltip: 'More options',
          items: const [
            AppPopupMenuItem(
              value: 'sort',
              label: 'Sort by date',
              icon: Icons.sort,
            ),
            AppPopupMenuItem(
              value: 'filter',
              label: 'Filter',
              icon: Icons.filter_list,
            ),
            AppPopupMenuItem(
              value: 'select',
              label: 'Select all',
              icon: Icons.select_all,
            ),
            AppPopupMenuItem(
              value: 'settings',
              label: 'Settings',
              icon: Icons.settings,
            ),
          ],
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected: $value'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(
        title: Text('Note ${index + 1}'),
        subtitle: const Text('Created yesterday'),
        trailing: AppPopupMenu<String>(
          iconSize: 20,
          items: const [
            AppPopupMenuItem(value: 'edit', label: 'Edit', icon: Icons.edit),
            AppPopupMenuItem(value: 'pin', label: 'Pin', icon: Icons.push_pin),
            AppPopupMenuItem(
              value: 'delete',
              label: 'Delete',
              icon: Icons.delete,
              isDestructive: true,
            ),
          ],
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Note ${index + 1}: $value'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Menu Preview (Static)',
  type: AppPopupMenuPreview,
)
Widget buildAppPopupMenuPreview(BuildContext context) {
  final showIcons = context.knobs.boolean(
    label: 'Show Icons',
    initialValue: true,
  );
  final showDestructive = context.knobs.boolean(
    label: 'Show Destructive',
    initialValue: true,
  );

  return Center(
    child: AppPopupMenuPreview<String>(
      width: 200,
      items: [
        AppPopupMenuItem(
          value: 'edit',
          label: 'Edit',
          icon: showIcons ? Icons.edit : null,
        ),
        AppPopupMenuItem(
          value: 'duplicate',
          label: 'Duplicate',
          icon: showIcons ? Icons.copy : null,
        ),
        AppPopupMenuItem(
          value: 'share',
          label: 'Share',
          icon: showIcons ? Icons.share : null,
        ),
        if (showDestructive)
          AppPopupMenuItem(
            value: 'delete',
            label: 'Delete',
            icon: showIcons ? Icons.delete : null,
            isDestructive: true,
          ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Three-Level Cascading Menu',
  type: CascadingMenuPreview,
)
Widget buildCascadingMenuPreview(BuildContext context) {
  return const Center(
    child: CascadingMenuPreview(
      menuWidth: 160,
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
  );
}

@widgetbook.UseCase(
  name: 'Cascading with Destructive',
  type: CascadingMenuPreview,
)
Widget buildCascadingMenuDestructive(BuildContext context) {
  return const Center(
    child: CascadingMenuPreview(
      menuWidth: 160,
      level1HighlightIndex: 0,
      level2HighlightIndex: 1,
      level1Items: [
        AppPopupMenuItem(
          value: 'actions',
          label: 'Actions',
          icon: Icons.flash_on,
          hasSubmenu: true,
        ),
        AppPopupMenuItem(
            value: 'settings', label: 'Settings', icon: Icons.settings),
      ],
      level2Items: [
        AppPopupMenuItem(
            value: 'archive', label: 'Archive', icon: Icons.archive),
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
  );
}

@widgetbook.UseCase(
  name: 'Interactive Multi-Level Menu',
  type: AppPopupMenu,
)
Widget buildInteractiveMultiLevelMenu(BuildContext context) {
  return const Center(
    child: _InteractiveMultiLevelMenuDemo(),
  );
}

/// Stateful widget for interactive multi-level menu demo
class _InteractiveMultiLevelMenuDemo extends StatefulWidget {
  const _InteractiveMultiLevelMenuDemo();

  @override
  State<_InteractiveMultiLevelMenuDemo> createState() =>
      _InteractiveMultiLevelMenuDemoState();
}

class _InteractiveMultiLevelMenuDemoState
    extends State<_InteractiveMultiLevelMenuDemo> {
  String _lastSelected = 'None';

  void _showSubMenu(BuildContext context, Offset position, int level) {
    final List<AppPopupMenuItem<String>> items;
    if (level == 2) {
      items = const [
        AppPopupMenuItem(value: 'cut', label: 'Cut', icon: Icons.content_cut),
        AppPopupMenuItem(value: 'copy', label: 'Copy', icon: Icons.copy),
        AppPopupMenuItem(value: 'paste', label: 'Paste', icon: Icons.paste),
      ];
    } else {
      items = const [
        AppPopupMenuItem(value: 'small', label: 'Small'),
        AppPopupMenuItem(value: 'medium', label: 'Medium'),
        AppPopupMenuItem(value: 'large', label: 'Large'),
      ];
    }

    showAppPopupMenu<String>(
      context: context,
      position: position,
      items: items,
    ).then((value) {
      if (value != null && mounted && context.mounted) {
        setState(() => _lastSelected = value);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected: $value'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Last selected: $_lastSelected',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Level 1 Menu
            AppPopupMenu<String>(
              icon: Icons.menu,
              tooltip: 'Main Menu',
              items: const [
                AppPopupMenuItem(
                  value: 'file',
                  label: 'File',
                  icon: Icons.folder,
                ),
                AppPopupMenuItem(
                  value: 'edit',
                  label: 'Edit',
                  icon: Icons.edit,
                  hasSubmenu: true,
                ),
                AppPopupMenuItem(
                  value: 'view',
                  label: 'View',
                  icon: Icons.visibility,
                  hasSubmenu: true,
                ),
                AppPopupMenuItem(
                  value: 'delete',
                  label: 'Delete',
                  icon: Icons.delete,
                  isDestructive: true,
                ),
              ],
              onSelected: (value) {
                if (value == 'edit' || value == 'view') {
                  // Show submenu
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final position = box.localToGlobal(Offset.zero);
                  _showSubMenu(
                    context,
                    Offset(position.dx + 200, position.dy + 100),
                    value == 'edit' ? 2 : 3,
                  );
                } else {
                  setState(() => _lastSelected = value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: $value'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
            ),
            const SizedBox(width: 16),
            // Direct Submenu Trigger
            Builder(
              builder: (buttonContext) {
                return FilledButton.icon(
                  onPressed: () {
                    final RenderBox box =
                        buttonContext.findRenderObject() as RenderBox;
                    final position = box.localToGlobal(Offset.zero);
                    final size = box.size;
                    _showSubMenu(
                      context,
                      Offset(position.dx, position.dy + size.height + 4),
                      2,
                    );
                  },
                  icon: const Icon(Icons.content_paste),
                  label: const Text('Clipboard'),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Tip: Select "Edit" or "View" from menu to open submenu',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'Context Menu Demo',
  type: AppPopupMenu,
)
Widget buildContextMenuDemo(BuildContext context) {
  return Center(
    child: GestureDetector(
      onSecondaryTapDown: (details) {
        showAppPopupMenu<String>(
          context: context,
          position: details.globalPosition,
          items: const [
            AppPopupMenuItem(value: 'copy', label: 'Copy', icon: Icons.copy),
            AppPopupMenuItem(value: 'paste', label: 'Paste', icon: Icons.paste),
            AppPopupMenuItem(value: 'cut', label: 'Cut', icon: Icons.cut),
            AppPopupMenuItem(
              value: 'delete',
              label: 'Delete',
              icon: Icons.delete,
              isDestructive: true,
            ),
          ],
        ).then((value) {
          if (value != null && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Context menu: $value'),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        });
      },
      child: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mouse,
                size: 48,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 8),
              Text(
                'Right-click here',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'to open context menu',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
