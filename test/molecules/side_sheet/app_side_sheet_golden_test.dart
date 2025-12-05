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
        child: AppSideSheet(
          position: SideSheetPosition.left,
          displayMode: SideSheetDisplayMode.overlay,
          width: 280,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                  child: ColoredBox(
                    color: Colors.black,
                    child: Center(
                      child: Text('Navigation', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                ListTile(title: Text('Home')),
                ListTile(title: Text('Projects')),
                ListTile(title: Text('Profile')),
                ListTile(title: Text('Settings')),
              ],
            ),
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
        child: AppSideSheet(
          position: SideSheetPosition.right,
          displayMode: SideSheetDisplayMode.overlay,
          width: 280,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                  child: ColoredBox(
                    color: Colors.black,
                    child: Center(
                      child: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                ListTile(title: Text('Dark Mode')),
                ListTile(title: Text('Notifications')),
                ListTile(title: Text('Language')),
              ],
            ),
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
        child: Row(
          children: [
            const AppSideSheet(
              position: SideSheetPosition.left,
              displayMode: SideSheetDisplayMode.persistent,
              width: 120,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 48, child: Center(child: Text('Nav'))),
                    ListTile(title: Text('Home')),
                    ListTile(title: Text('Settings')),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: Colors.grey[100]!,
                child: const Center(
                  child: Text('Main'),
                ),
              ),
            ),
          ],
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
        child: AppDrawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 56,
                  child: ColoredBox(
                    color: Colors.blue,
                    child: Center(child: Text('Menu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ),
                ),
                ListTile(title: Text('Home')),
                ListTile(title: Text('Favorites')),
                ListTile(title: Text('Bookmarks')),
              ],
            ),
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
        child: AppSideSheet(
          position: SideSheetPosition.left,
          displayMode: SideSheetDisplayMode.overlay,
          width: 350,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 48, child: Center(child: Text('Settings'))),
                ListTile(title: Text('Theme')),
                ListTile(title: Text('Notifications')),
                ListTile(title: Text('Language')),
              ],
            ),
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
        child: AppSideSheet(
          position: SideSheetPosition.left,
          displayMode: SideSheetDisplayMode.overlay,
          width: 200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40, child: Center(child: Text('Menu'))),
                ListTile(title: Text('Home')),
                ListTile(title: Text('Likes')),
              ],
            ),
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
        child: AppSideSheet(
          position: SideSheetPosition.left,
          displayMode: SideSheetDisplayMode.overlay,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 48, child: Center(child: Text('Items'))),
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
                ListTile(title: Text('Item 3')),
                ListTile(title: Text('Item 4')),
                ListTile(title: Text('Item 5')),
              ],
            ),
          ),
        ),
      ),
    );
  });
}
