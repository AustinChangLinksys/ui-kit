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

  group('AppSideSheet Golden Tests', () {
    goldenTest(
      'AppSideSheet - Overlay Left',
      fileName: 'side_sheet_overlay_left',
      builder: () => buildThemeMatrix(
        name: 'Left Overlay',
        width: 400.0,
        height: 300.0,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.grey[200]!,
                ),
              ),
              const Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 280,
                child: AppSideSheet(
                  position: SideSheetPosition.left,
                  displayMode: SideSheetDisplayMode.overlay,
                  width: 280,
                  child: _OverlayContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'AppSideSheet - Overlay Right',
      fileName: 'side_sheet_overlay_right',
      builder: () => buildThemeMatrix(
        name: 'Right Overlay',
        width: 400.0,
        height: 300.0,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.grey[200]!,
                ),
              ),
              const Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 280,
                child: AppSideSheet(
                  position: SideSheetPosition.right,
                  displayMode: SideSheetDisplayMode.overlay,
                  width: 280,
                  child: _OverlayContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'AppSideSheet - Persistent',
      fileName: 'side_sheet_persistent',
      builder: () => buildThemeMatrix(
        name: 'Persistent',
        width: 400.0,
        height: 300.0,
        child: Scaffold(
          body: Row(
            children: [
              const AppSideSheet(
                position: SideSheetPosition.left,
                displayMode: SideSheetDisplayMode.persistent,
                width: 120,
                child: _PersistentContent(),
              ),
              Expanded(
                child: ColoredBox(
                  color: Colors.grey[100]!,
                  child: const Center(
                    child: AppText('Main'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'AppSideSheet - AppDrawer Wrapper',
      fileName: 'side_sheet_drawer',
      builder: () => buildThemeMatrix(
        name: 'Drawer',
        width: 400.0,
        height: 300.0,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.grey[200]!,
                ),
              ),
              const Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 280,
                child: AppDrawer(
                  child: _DrawerContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'AppSideSheet - Wide Layout',
      fileName: 'side_sheet_wide',
      builder: () => buildThemeMatrix(
        name: 'Wide',
        width: 400.0,
        height: 300.0,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.grey[200]!,
                ),
              ),
              const Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 350,
                child: AppSideSheet(
                  position: SideSheetPosition.left,
                  displayMode: SideSheetDisplayMode.overlay,
                  width: 350,
                  child: _WideContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'AppSideSheet - Narrow Layout',
      fileName: 'side_sheet_narrow',
      builder: () => buildThemeMatrix(
        name: 'Narrow',
        width: 400.0,
        height: 300.0,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.grey[200]!,
                ),
              ),
              const Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 200,
                child: AppSideSheet(
                  position: SideSheetPosition.left,
                  displayMode: SideSheetDisplayMode.overlay,
                  width: 200,
                  child: _NarrowContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'AppSideSheet - Scrollable Content',
      fileName: 'side_sheet_scrollable',
      builder: () => buildThemeMatrix(
        name: 'Scrollable',
        width: 400.0,
        height: 300.0,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.grey[200]!,
                ),
              ),
              const Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 280,
                child: AppSideSheet(
                  position: SideSheetPosition.left,
                  displayMode: SideSheetDisplayMode.overlay,
                  child: _ScrollableContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}

class _OverlayContent extends StatelessWidget {
  const _OverlayContent();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AppBar(title: const Text('Navigation')),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  leading: Icon(Icons.business),
                  title: Text('Projects'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PersistentContent extends StatelessWidget {
  const _PersistentContent();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AppBar(title: const Text('Menu')),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                ),
                ListTile(
                  leading: Icon(Icons.analytics),
                  title: Text('Analytics'),
                ),
                ListTile(
                  leading: Icon(Icons.report),
                  title: Text('Reports'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerContent extends StatelessWidget {
  const _DrawerContent();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text('App Menu'),
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Favorites'),
                ),
                ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text('Bookmarks'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WideContent extends StatelessWidget {
  const _WideContent();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AppBar(title: const Text('Wide Panel')),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const AppText('Settings'),
                const SizedBox(height: 16),
                const ListTile(
                  title: Text('Theme'),
                  subtitle: Text('Dark Mode'),
                ),
                const ListTile(
                  title: Text('Notifications'),
                ),
                const ListTile(
                  title: Text('Language'),
                  subtitle: Text('English'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrowContent extends StatelessWidget {
  const _NarrowContent();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AppBar(title: const Text('Menu'), elevation: 0),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Likes'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollableContent extends StatelessWidget {
  const _ScrollableContent();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AppBar(title: const Text('Long List')),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item ${index + 1}'),
                  subtitle: Text('Description ${index + 1}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
