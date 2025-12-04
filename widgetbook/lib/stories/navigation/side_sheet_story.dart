import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Overlay Mode - Left',
  type: AppSideSheet,
)
Widget buildLeftOverlaySheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      appBar: AppBar(title: const Text('Side Sheet Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: 'Side Sheet',
              barrierColor: Colors.transparent,
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (dialogContext, anim1, anim2) {
                final themeData = Theme.of(context);
                return Theme(
                  data: themeData,
                  child: Builder(
                    builder: (context) => AppSideSheet(
                    position: SideSheetPosition.left,
                    displayMode: SideSheetDisplayMode.overlay,
                    width: 280,
                    child: Scaffold(
                      appBar: AppBar(title: const Text('Navigation')),
                      body: ListView(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.home),
                            title: const Text('Home'),
                            onTap: () => Navigator.pop(dialogContext),
                          ),
                          ListTile(
                            leading: const Icon(Icons.business),
                            title: const Text('Projects'),
                            onTap: () => Navigator.pop(dialogContext),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('Profile'),
                            onTap: () => Navigator.pop(dialogContext),
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text('Settings'),
                            onTap: () => Navigator.pop(dialogContext),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),
                );
              },
            );
          },
          child: const Text('Open Left Sheet'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Overlay Mode - Right',
  type: AppSideSheet,
)
Widget buildRightOverlaySheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      appBar: AppBar(title: const Text('Side Sheet Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: 'Side Sheet',
              barrierColor: Colors.transparent,
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (dialogContext, anim1, anim2) {
                final themeData = Theme.of(context);
                return Theme(
                  data: themeData,
                  child: Builder(
                    builder: (context) => AppSideSheet(
                    position: SideSheetPosition.right,
                    displayMode: SideSheetDisplayMode.overlay,
                    width: 320,
                    child: Scaffold(
                      appBar: AppBar(title: const Text('Settings')),
                      body: ListView(
                        children: [
                          ListTile(
                            title: const Text('Dark Mode'),
                            trailing: Switch(value: false, onChanged: (_) {}),
                          ),
                          ListTile(
                            title: const Text('Notifications'),
                            trailing: Switch(value: true, onChanged: (_) {}),
                          ),
                          ListTile(
                            title: const Text('Language'),
                            subtitle: const Text('English'),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),
                );
              },
            );
          },
          child: const Text('Open Right Sheet'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'AppDrawer (Convenience Wrapper)',
  type: AppDrawer,
)
Widget buildAppDrawer(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      appBar: AppBar(title: const Text('Drawer Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: 'Side Sheet',
              barrierColor: Colors.transparent,
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (dialogContext, anim1, anim2) {
                final themeData = Theme.of(context);
                return Theme(
                  data: themeData,
                  child: Builder(
                    builder: (context) => AppDrawer(
                      width: 280,
                      child: Scaffold(
                        appBar: AppBar(
                          title: const Text('Menu'),
                          automaticallyImplyLeading: false,
                        ),
                        body: ListView(
                          children: [
                            const DrawerHeader(
                              child: Text('App Menu'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.home),
                              title: const Text('Home'),
                              onTap: () => Navigator.pop(dialogContext),
                            ),
                            ListTile(
                              leading: const Icon(Icons.favorite),
                              title: const Text('Favorites'),
                              onTap: () => Navigator.pop(dialogContext),
                            ),
                            ListTile(
                              leading: const Icon(Icons.bookmark),
                              title: const Text('Bookmarks'),
                              onTap: () => Navigator.pop(dialogContext),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Open Drawer'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Persistent Mode',
  type: AppSideSheet,
)
Widget buildPersistentSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      appBar: AppBar(title: const Text('Persistent Side Sheet')),
      body: Row(
        children: [
          AppSideSheet(
            position: SideSheetPosition.left,
            displayMode: SideSheetDisplayMode.persistent,
            width: 280,
            child: Scaffold(
              appBar: AppBar(title: const Text('Navigation')),
              body: const SingleChildScrollView(
                child: Column(
                  children: [
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
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  AppText(
                    'Main Content Area',
                    variant: AppTextVariant.headlineSmall,
                  ),
                  SizedBox(height: 16),
                  AppText(
                    'The side panel is always visible.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Dismissible (Tap Outside)',
  type: AppSideSheet,
)
Widget buildDismissibleSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      appBar: AppBar(title: const Text('Dismissible Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: 'Side Sheet',
              barrierColor: Colors.transparent,
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (dialogContext, anim1, anim2) {
                final themeData = Theme.of(context);
                return Theme(
                  data: themeData,
                  child: Builder(
                    builder: (context) => AppSideSheet(
                    isDismissible: true,
                    position: SideSheetPosition.left,
                    displayMode: SideSheetDisplayMode.overlay,
                    onDismiss: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sheet dismissed!')),
                      );
                    },
                    child: Scaffold(
                      appBar: AppBar(title: const Text('Dismissible Sheet')),
                      body: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              AppText('Tap outside to dismiss'),
                              SizedBox(height: 16),
                              AppText(
                                'Or click the back button',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ),
                );
              },
            );
          },
          child: const Text('Open Dismissible Sheet'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Non-Dismissible (Requires Action)',
  type: AppSideSheet,
)
Widget buildNonDismissibleSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      appBar: AppBar(title: const Text('Non-Dismissible Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.transparent,
              barrierLabel: 'Side Sheet',
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (dialogContext, anim1, anim2) {
                final themeData = Theme.of(context);
                return Theme(
                  data: themeData,
                  child: Builder(
                    builder: (context) => AppSideSheet(
                    isDismissible: false,
                    position: SideSheetPosition.left,
                    displayMode: SideSheetDisplayMode.overlay,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('Settings'),
                        automaticallyImplyLeading: false,
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const AppText(
                              'This sheet cannot be dismissed by tapping outside.',
                              variant: AppTextVariant.bodyMedium,
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Close'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ),
                );
              },
            );
          },
          child: const Text('Open Non-Dismissible Sheet'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Width Variations',
  type: AppSideSheet,
)
Widget buildCustomWidthSheet(BuildContext context) {
  return DesignSystem.init(
    context,
    Scaffold(
      appBar: AppBar(title: const Text('Custom Width Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'Side Sheet',
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (dialogContext, anim1, anim2) {
                    final themeData = Theme.of(context);
                    return Theme(
                      data: themeData,
                      child: Builder(
                        builder: (context) => AppSideSheet(
                          width: 200,
                          position: SideSheetPosition.left,
                          displayMode: SideSheetDisplayMode.overlay,
                          child: Scaffold(
                            appBar: AppBar(title: const Text('Narrow')),
                            body: const Center(child: AppText('200px wide')),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text('Narrow Sheet (200px)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'Side Sheet',
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (dialogContext, anim1, anim2) {
                    final themeData = Theme.of(context);
                    return Theme(
                      data: themeData,
                      child: Builder(
                        builder: (context) => AppSideSheet(
                          width: 350,
                          position: SideSheetPosition.left,
                          displayMode: SideSheetDisplayMode.overlay,
                          child: Scaffold(
                            appBar: AppBar(title: const Text('Wide')),
                            body: const Center(child: AppText('350px wide')),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text('Wide Sheet (350px)'),
            ),
          ],
        ),
      ),
    ),
  );
}
