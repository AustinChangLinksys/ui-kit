# Quickstart: Unified Button System Architecture

**Feature**: 022-button-system-unified
**Date**: 2025-12-09
**Purpose**: Copy-paste examples and usage guide for the unified button system

## Quick Examples

### Basic Named Constructors (Most Common)

```dart
import 'package:ui_kit_library/ui_kit.dart';

// ✨ Primary actions - most important buttons
AppButton.primary(
  label: "Save Changes",
  onTap: () => save(),
)

AppButton.primaryOutline(
  label: "Continue",
  onTap: () => next(),
)

// ✨ Secondary actions - common patterns
AppButton.secondary(
  label: "Add Item",
  onTap: () => add(),
)

AppButton.secondaryOutline(
  label: "Cancel",
  onTap: () => cancel(),
)

// ✨ Minimal actions
AppButton.text(
  label: "Skip",
  onTap: () => skip(),
)

// ✨ Destructive actions
AppButton.danger(
  label: "Delete Account",
  onTap: () => delete(),
)
```

### Icon Buttons

```dart
// ✨ Primary icon actions
AppIconButton.primary(
  icon: Icons.add,
  onTap: () => create(),
)

// ✨ Secondary styles
AppIconButton.outline(
  icon: Icons.favorite_border,
  onTap: () => toggleFavorite(),
)

AppIconButton.ghost(
  icon: Icons.more_vert,
  onTap: () => showMenu(),
)

// ✨ Toggle states
AppIconButton.toggle(
  icon: isFavorited ? Icons.favorite : Icons.favorite_border,
  isActive: isFavorited,
  onTap: () => toggleFavorite(),
)
```

### With Icons and Loading States

```dart
// ✨ Button with leading icon
AppButton.primary(
  label: "Download",
  icon: Icon(Icons.download),
  onTap: () => download(),
)

// ✨ Button with trailing icon
AppButton.secondary(
  label: "Next",
  icon: Icon(Icons.arrow_forward),
  iconPosition: AppButtonIconPosition.trailing,
  onTap: () => next(),
)

// ✨ Loading state
AppButton.primary(
  label: "Saving...",
  isLoading: _isSaving,
  onTap: _isSaving ? null : () => save(),
)
```

### Size Variants

```dart
// ✨ Different sizes
AppButton.small(label: "OK", onTap: () => confirm())
AppButton.large(label: "Get Started", onTap: () => start())

AppIconButton.small(icon: Icons.close, onTap: () => close())
AppIconButton.large(icon: Icons.add, onTap: () => create())
```

## Complete Usage Examples

### Form with Button Hierarchy

```dart
class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Form fields here...

        AppGap.lg(),

        // Primary action - most important
        AppButton.primary(
          label: "Create Account",
          onTap: () => submitForm(),
        ),

        AppGap.sm(),

        // Secondary action - less emphasis
        AppButton.secondaryOutline(
          label: "Back to Login",
          onTap: () => Navigator.pop(context),
        ),

        AppGap.xs(),

        // Tertiary action - minimal emphasis
        AppButton.text(
          label: "Skip for now",
          onTap: () => skipRegistration(),
        ),
      ],
    );
  }
}
```

### Action Bar with Mixed Button Types

```dart
class DocumentActionBar extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Primary action - contextual
        if (isEditing)
          AppButton.primary(
            label: "Save",
            onTap: onSave,
          )
        else
          AppButton.secondary(
            label: "Edit",
            icon: Icon(Icons.edit),
            onTap: onEdit,
          ),

        AppGap.md(),

        // Icon actions
        AppIconButton.outline(
          icon: Icons.share,
          tooltip: "Share document",
          onTap: () => shareDocument(),
        ),

        AppGap.sm(),

        AppIconButton.outline(
          icon: Icons.download,
          tooltip: "Download",
          onTap: () => downloadDocument(),
        ),

        Spacer(),

        // Destructive action - separated
        AppIconButton.danger(
          icon: Icons.delete,
          tooltip: "Delete document",
          onTap: onDelete,
        ),
      ],
    );
  }
}
```

### Complex Button Grid

```dart
class SettingsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        // Large primary actions
        AppButton.large(
          label: "Sync Now",
          icon: Icon(Icons.sync),
          onTap: () => syncData(),
        ),

        AppButton.large(
          label: "Backup",
          icon: Icon(Icons.backup),
          onTap: () => backup(),
        ),

        // Secondary actions
        AppButton.secondary(
          label: "Export Data",
          icon: Icon(Icons.file_download),
          onTap: () => export(),
        ),

        AppButton.secondary(
          label: "Import",
          icon: Icon(Icons.file_upload),
          onTap: () => import(),
        ),

        // Destructive actions
        AppButton.dangerOutline(
          label: "Reset Settings",
          onTap: () => confirmReset(),
        ),

        AppButton.danger(
          label: "Delete All",
          onTap: () => confirmDeleteAll(),
        ),
      ],
    );
  }
}
```

## Migration Guide

### From Old Pattern to New Pattern

#### Before (Old Pattern)
```dart
// ❌ Old verbose approach
AppButton(
  label: "Save",
  variant: SurfaceVariant.highlight,
  onTap: () => save(),
)

AppButton(
  label: "Cancel",
  variant: SurfaceVariant.tonal,
  onTap: () => cancel(),
)

AppIconButton(
  icon: Icons.add,
  variant: SurfaceVariant.highlight,
  onTap: () => create(),
)
```

#### After (New Pattern)
```dart
// ✅ New simplified approach
AppButton.primary(
  label: "Save",
  onTap: () => save(),
)

AppButton.secondaryOutline(
  label: "Cancel",
  onTap: () => cancel(),
)

AppIconButton.primary(
  icon: Icons.add,
  onTap: () => create(),
)
```

### Still Want Full Control?

```dart
// ✅ Full control still available
AppButton(
  label: "Custom Button",
  variant: ButtonStyleVariant.outline,
  emphasis: SurfaceVariant.elevated,
  size: AppButtonSize.large,
  icon: Icon(Icons.custom),
  iconPosition: AppButtonIconPosition.trailing,
  isLoading: false,
  onTap: () => customAction(),
)
```

## Theme Integration

The unified button system automatically works with all themes:

```dart
// ✅ Same code works across all themes
class ThemedButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Glass theme: Translucent with blur
        // Brutal theme: Bold borders and solid colors
        // Flat theme: Simple solid colors
        // Neumorphic theme: Soft shadows
        // Pixel theme: Hard edges and high contrast
        AppButton.primary(label: "Primary Action", onTap: () {}),
        AppButton.secondaryOutline(label: "Secondary", onTap: () {}),
        AppButton.text(label: "Tertiary", onTap: () {}),

        Row(
          children: [
            AppIconButton.primary(icon: Icons.add, onTap: () {}),
            AppIconButton.outline(icon: Icons.favorite, onTap: () {}),
            AppIconButton.ghost(icon: Icons.more_vert, onTap: () {}),
          ],
        ),
      ],
    );
  }
}
```

## Performance Tips

### Use Const Constructors
```dart
// ✅ Const constructors enable compile-time optimization
const AppButton.primary(
  label: "Static Button",
  // onTap: null, // const requires compile-time constants
)

// ✅ For dynamic callbacks, still efficient
AppButton.primary(
  label: "Dynamic Button",
  onTap: () => dynamicAction(),
)
```

### Avoid Unnecessary Rebuilds
```dart
class OptimizedButtonList extends StatelessWidget {
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        // ✅ Extract callbacks to avoid recreating
        return _buildItemButton(item, index);
      },
    );
  }

  Widget _buildItemButton(String item, int index) {
    return AppButton.secondary(
      label: item,
      onTap: () => selectItem(index),
    );
  }
}
```

## Common Patterns

### Confirmation Dialogs
```dart
void showDeleteConfirmation() {
  showAppDialog(
    context: context,
    builder: (context) => AppDialog(
      title: "Delete Item",
      content: "Are you sure you want to delete this item?",
      actions: [
        AppButton.secondaryOutline(
          label: "Cancel",
          onTap: () => Navigator.pop(context),
        ),
        AppButton.danger(
          label: "Delete",
          onTap: () {
            deleteItem();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
```

### Loading States
```dart
class AsyncButtonExample extends StatefulWidget {
  @override
  _AsyncButtonExampleState createState() => _AsyncButtonExampleState();
}

class _AsyncButtonExampleState extends State<AsyncButtonExample> {
  bool _isLoading = false;

  Future<void> _handleSave() async {
    setState(() => _isLoading = true);

    try {
      await saveData();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppButton.primary(
      label: _isLoading ? "Saving..." : "Save",
      isLoading: _isLoading,
      onTap: _isLoading ? null : _handleSave,
    );
  }
}
```

This quickstart guide covers the most common usage patterns for the unified button system. The named constructors provide simple, intuitive APIs for 90% of use cases while maintaining full customization capabilities when needed.