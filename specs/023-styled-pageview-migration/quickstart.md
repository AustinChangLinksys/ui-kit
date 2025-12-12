# Quickstart Guide: Enhanced AppPageView

**Feature**: 023-styled-pageview-migration
**Quick Reference**: Common usage patterns and examples
**Date**: 2025-12-10

## Overview

This guide provides copy-paste examples for using the enhanced AppPageView system with AppBar integration, bottom action bars, responsive menus, and tabbed navigation.

## Basic Usage Patterns

### 1. Simple Page with Title

```dart
import 'package:ui_kit/ui_kit.dart';

class BasicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: 'Settings',
        showBackButton: true,
        onBackTap: () => Navigator.pop(context),
      ),
      child: (context, constraints) => Center(
        child: AppText.body('Page content goes here'),
      ),
    );
  }
}
```

### 2. Page with Bottom Action Bar

```dart
class PageWithActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: 'Edit Profile',
        showBackButton: true,
      ),
      bottomBarConfig: PageBottomBarConfig(
        positiveLabel: 'Save',
        onPositiveTap: () => _saveProfile(),
        negativeLabel: 'Cancel',
        onNegativeTap: () => Navigator.pop(context),
        isPositiveEnabled: _isValid,
      ),
      child: (context, constraints) => ProfileEditForm(),
    );
  }
}
```

### 3. Page with Responsive Menu

```dart
class PageWithMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: 'Network Settings',
      ),
      menuConfig: PageMenuConfig(
        title: 'Network Options',
        items: [
          PageMenuItem(
            label: 'Wi-Fi Settings',
            icon: Icons.wifi,
            onTap: () => _openWifiSettings(),
          ),
          PageMenuItem(
            label: 'Ethernet Settings',
            icon: Icons.cable,
            onTap: () => _openEthernetSettings(),
          ),
          PageMenuItem.divider(),
          PageMenuItem(
            label: 'Advanced Options',
            icon: Icons.settings_ethernet,
            onTap: () => _openAdvancedOptions(),
          ),
        ],
        largeMenu: context.isDesktop,
      ),
      child: (context, constraints) => NetworkSettingsContent(),
    );
  }
}
```

### 4. Tabbed Page Layout

```dart
class TabbedPage extends StatefulWidget {
  @override
  _TabbedPageState createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: 'Device Management',
        showBackButton: true,
      ),
      tabs: [
        Tab(text: 'Overview'),
        Tab(text: 'Devices'),
        Tab(text: 'Analytics'),
      ],
      tabViews: [
        OverviewTab(),
        DevicesTab(),
        AnalyticsTab(),
      ],
      tabController: _tabController,
      onTabChanged: (index) => _onTabChanged(index),
      child: (context, constraints) => const SizedBox.shrink(),
    );
  }
}
```

### 5. Collapsible AppBar with Sliver

```dart
class SliverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageView(
      useSlivers: true,
      appBarConfig: PageAppBarConfig(
        title: 'Photo Gallery',
        enableSliver: true,
        toolbarHeight: 120,
        actions: [
          AppIconButton.ghost(
            icon: Icons.search,
            onTap: () => _openSearch(),
          ),
        ],
      ),
      child: (context, constraints) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => PhotoTile(photo: photos[index]),
          childCount: photos.length,
        ),
      ),
    );
  }
}
```

## Advanced Patterns

### Complex Page with All Features

```dart
class ComplexPage extends StatefulWidget {
  @override
  _ComplexPageState createState() => _ComplexPageState();
}

class _ComplexPageState extends State<ComplexPage> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isEditing = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: _isEditing ? 'Edit Device' : 'Device Details',
        showBackButton: true,
        onBackTap: _handleBackPress,
        actions: [
          if (!_isEditing)
            AppIconButton.ghost(
              icon: Icons.edit,
              onTap: () => setState(() => _isEditing = true),
            ),
        ],
      ),
      menuConfig: _buildMenuConfig(),
      bottomBarConfig: _isEditing ? PageBottomBarConfig(
        positiveLabel: 'Save Changes',
        onPositiveTap: _saveChanges,
        negativeLabel: 'Cancel',
        onNegativeTap: _cancelEditing,
        isPositiveEnabled: _hasChanges,
      ) : null,
      tabs: [
        Tab(text: 'General'),
        Tab(text: 'Advanced'),
      ],
      tabViews: [
        GeneralSettingsTab(
          isEditing: _isEditing,
          onChanged: () => setState(() => _hasChanges = true),
        ),
        AdvancedSettingsTab(
          isEditing: _isEditing,
          onChanged: () => setState(() => _hasChanges = true),
        ),
      ],
      tabController: _tabController,
      child: (context, constraints) => const SizedBox.shrink(),
    );
  }

  PageMenuConfig? _buildMenuConfig() {
    if (_isEditing) return null; // Hide menu during editing

    return PageMenuConfig(
      title: 'Actions',
      items: [
        PageMenuItem(
          label: 'Restart Device',
          icon: Icons.restart_alt,
          onTap: _restartDevice,
        ),
        PageMenuItem(
          label: 'Factory Reset',
          icon: Icons.factory_reset,
          onTap: _factoryReset,
        ),
        PageMenuItem.divider(),
        PageMenuItem(
          label: 'Export Settings',
          icon: Icons.file_download,
          onTap: _exportSettings,
        ),
      ],
    );
  }

  void _handleBackPress() {
    if (_isEditing && _hasChanges) {
      _showDiscardChangesDialog();
    } else {
      Navigator.pop(context);
    }
  }
}
```

### Destructive Action Page

```dart
class DestructivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: 'Delete Account',
        showBackButton: true,
      ),
      bottomBarConfig: PageBottomBarConfig(
        positiveLabel: 'Delete Account',
        onPositiveTap: () => _confirmDeletion(context),
        negativeLabel: 'Cancel',
        onNegativeTap: () => Navigator.pop(context),
        isDestructive: true, // Applies red/warning styling
      ),
      child: (context, constraints) => Padding(
        padding: context.pageMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.headline('Warning'),
            AppGap.large(),
            AppText.body(
              'This action cannot be undone. All your data will be permanently deleted.',
            ),
            AppGap.medium(),
            AppCard(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: AppText.body(
                  'Before deleting your account, make sure to:\n'
                  '• Download any important data\n'
                  '• Cancel active subscriptions\n'
                  '• Inform team members',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Refresh-Enabled Page

```dart
class RefreshablePage extends StatefulWidget {
  @override
  _RefreshablePageState createState() => _RefreshablePageState();
}

class _RefreshablePageState extends State<RefreshablePage> {
  List<Device> _devices = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: 'Connected Devices',
        actions: [
          AppIconButton.ghost(
            icon: Icons.refresh,
            onTap: _refreshDevices,
          ),
        ],
      ),
      refreshCallback: _refreshDevices,
      child: (context, constraints) => _isLoading
        ? AppLoader.centered()
        : ListView.builder(
            itemCount: _devices.length,
            itemBuilder: (context, index) => DeviceTile(_devices[index]),
          ),
    );
  }

  Future<void> _refreshDevices() async {
    setState(() => _isLoading = true);
    try {
      final devices = await DeviceService.getDevices();
      setState(() => _devices = devices);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
```

## Factory Constructor Shortcuts

### Quick Basic Pages

```dart
// Simple titled page
Widget buildBasicPage() => AppPageView.basic(
  title: 'Settings',
  child: (context, constraints) => SettingsContent(),
);

// Page with bottom actions
Widget buildActionPage() => AppPageView.withBottomBar(
  title: 'Edit Profile',
  positiveLabel: 'Save',
  onPositiveTap: _save,
  negativeLabel: 'Cancel',
  onNegativeTap: _cancel,
  child: (context, constraints) => ProfileForm(),
);

// Page with menu
Widget buildMenuPage() => AppPageView.withMenu(
  title: 'Network',
  menuItems: [
    PageMenuItem(label: 'Wi-Fi', icon: Icons.wifi, onTap: _openWifi),
    PageMenuItem(label: 'Ethernet', icon: Icons.cable, onTap: _openEthernet),
  ],
  child: (context, constraints) => NetworkContent(),
);

// Tabbed page
Widget buildTabbedPage() => AppPageView.withTabs(
  title: 'Analytics',
  tabs: [Tab(text: 'Overview'), Tab(text: 'Details')],
  tabViews: [OverviewTab(), DetailsTab()],
);
```

## Theme Customization

### Custom Page Styling

```dart
// Apply custom styling to specific pages
class StyledPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        extensions: [
          Theme.of(context).extension<AppDesignTheme>()?.copyWith(
            pageLayoutStyle: PageLayoutStyle(
              animation: AnimationSpec.slow,
              backgroundColor: Colors.grey.shade50,
              contentPadding: EdgeInsets.all(24),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
      child: AppPageView(
        appBarConfig: PageAppBarConfig(title: 'Custom Styled Page'),
        child: (context, constraints) => CustomContent(),
      ),
    );
  }
}
```

### Per-Theme Variations

```dart
// Adapt behavior based on active theme
class ThemeAdaptivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    final isGlassTheme = theme.animation.duration > Duration(milliseconds: 400);

    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: 'Adaptive Page',
        enableSliver: isGlassTheme, // Only use sliver in Glass theme
      ),
      useSlivers: isGlassTheme,
      child: (context, constraints) => AdaptiveContent(),
    );
  }
}
```

## Migration Helpers

### Converting from StyledAppPageView

```dart
// Old StyledAppPageView usage
StyledAppPageView(
  title: 'Settings',
  bottomBar: PageBottomBar(
    positiveLabel: 'Save',
    onPositiveTap: _save,
    isPositiveEnabled: _isValid,
  ),
  menu: PageMenu(
    items: [MenuItem(label: 'Option 1', onTap: _option1)],
  ),
  child: (context, constraints) => Content(),
)

// New AppPageView equivalent
AppPageView(
  appBarConfig: PageAppBarConfig(
    title: 'Settings',
  ),
  bottomBarConfig: PageBottomBarConfig(
    positiveLabel: 'Save',
    onPositiveTap: _save,
    isPositiveEnabled: _isValid,
  ),
  menuConfig: PageMenuConfig(
    items: [PageMenuItem(label: 'Option 1', onTap: _option1)],
  ),
  child: (context, constraints) => Content(),
)
```

## Common Patterns & Best Practices

### State Management Integration

```dart
// With Provider/Riverpod
class ProviderIntegratedPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pageStateProvider);

    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: state.title,
        actions: state.actions,
      ),
      bottomBarConfig: state.hasChanges ? PageBottomBarConfig(
        positiveLabel: 'Save',
        onPositiveTap: () => ref.read(pageStateProvider.notifier).save(),
        isPositiveEnabled: state.isValid,
      ) : null,
      child: (context, constraints) => PageContent(),
    );
  }
}
```

### Error Handling

```dart
class ErrorHandledPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageView(
      appBarConfig: PageAppBarConfig(
        title: 'Data View',
        actions: [
          AppIconButton.ghost(
            icon: Icons.refresh,
            onTap: () => _retryLoad(context),
          ),
        ],
      ),
      refreshCallback: () => _retryLoad(context),
      child: (context, constraints) => FutureBuilder<Data>(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorDisplay(
              error: snapshot.error!,
              onRetry: () => _retryLoad(context),
            );
          }
          return snapshot.hasData
            ? DataDisplay(snapshot.data!)
            : AppLoader.centered();
        },
      ),
    );
  }
}
```

This quickstart guide covers the most common usage patterns for the enhanced AppPageView system. Copy and modify these examples to fit your specific use cases.