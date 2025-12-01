import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Mockup Page',
  path: 'Examples',
  type: MockupPage,
)
Widget buildMockupPageStory(BuildContext context) {
  return const MockupPage();
}

class MockupPage extends StatefulWidget {
  const MockupPage({super.key});

  @override
  State<MockupPage> createState() => _MockupPageState();
}

class _MockupPageState extends State<MockupPage> {
  int _navIndex = 0;
  bool _wifiEnabled = true;
  double _volume = 0.7;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [const Color(0xFF1A1F38), const Color(0xFF050505)]
                : [const Color(0xFFE0EAFC), const Color(0xFFCFDEF3)],
          ),
        ),
        child: SafeArea(
          bottom: false, 
          child: Column(
            children: [
              // 1. Header Section
              Padding(
                padding: EdgeInsets.all(16.0 * theme.spacingFactor),
                child: Row(
                  children: [
                    const AppAvatar(initials: 'AU', size: 48),
                    AppGap.md(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.headline('Hello, Austin',
                            color: theme.surfaceBase.contentColor),
                        AppText.caption('Welcome back to your dashboard'),
                      ],
                    ),
                    const Spacer(),
                    AppIconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onTap: () {},
                      variant: SurfaceVariant.base,
                    ),
                  ],
                ),
              ),

              // 2. Search & Filters
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0 * theme.spacingFactor),
                child: Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        hintText: 'Search devices...',
                        prefixIcon: const Icon(Icons.search),
                        onChanged: (v) => setState(() {}),
                      ),
                    ),
                    AppGap.sm(),
                    AppIconButton(
                      icon: const Icon(Icons.tune),
                      onTap: () {}, 
                    ),
                  ],
                ),
              ),

              AppGap.md(),

              // 3. Horizontal Tags
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0 * theme.spacingFactor),
                child: Row(
                  children: [
                    AppTag(label: 'All', color: Colors.blue, onTap: () {}),
                    AppGap.sm(),
                    AppTag(label: 'Online', color: Colors.green, onTap: () {}),
                    AppGap.sm(),
                    AppTag(label: 'Offline', color: Colors.red, onTap: () {}),
                    AppGap.sm(),
                    AppTag(label: 'Maintenance', onTap: () {}),
                  ],
                ),
              ),

              AppGap.md(),

              // 4. Main Content (Scrollable)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    16 * theme.spacingFactor,
                    0,
                    16 * theme.spacingFactor,
                    100,
                  ),
                  children: [
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.subhead('System Status'),
                              const AppBadge(
                                  label: 'Healthy', color: Colors.green),
                            ],
                          ),
                          AppGap.md(),
                          Row(
                            children: [
                              AppText.body('Wi-Fi'),
                              const Spacer(),
                              AppSwitch(
                                value: _wifiEnabled,
                                onChanged: (v) =>
                                    setState(() => _wifiEnabled = v),
                              ),
                            ],
                          ),
                          AppGap.md(),
                          Row(
                            children: [
                              AppText.body('Volume'),
                              AppGap.md(),
                              Expanded(
                                child: AppSlider(
                                  value: _volume,
                                  onChanged: (v) => setState(() => _volume = v),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    AppGap.md(),
                    AppText.subhead('Quick Actions'),
                    AppGap.sm(),

                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Scan',
                            icon: const Icon(Icons.qr_code_scanner),
                            onTap: () {},
                          ),
                        ),
                        AppGap.md(),
                        Expanded(
                          child: AppButton(
                            label: 'Add New',
                            icon: const Icon(Icons.add),
                            variant: SurfaceVariant.base,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),

                    AppGap.md(),
                    AppText.subhead('Recent Devices'),
                    AppGap.sm(),

                    const _DeviceTile(
                        name: 'Living Room TV',
                        status: 'Online',
                        isOnline: true),
                    AppGap.sm(),
                    const _DeviceTile(
                        name: 'Kitchen Hub',
                        status: 'Updating...',
                        isOnline: false,
                        isLoading: true),
                    AppGap.sm(),
                    const _DeviceTile(
                        name: 'Master Bedroom',
                        status: 'Offline',
                        isOnline: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: AppNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        items: const [
          AppNavigationItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Home'),
          AppNavigationItem(
              icon: Icon(Icons.devices_outlined),
              activeIcon: Icon(Icons.devices),
              label: 'Devices'),
          AppNavigationItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics),
              label: 'Stats'),
          AppNavigationItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final String name;
  final String status;
  final bool isOnline;
  final bool isLoading;

  const _DeviceTile({
    required this.name,
    required this.status,
    required this.isOnline,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return AppCard(
      padding: const EdgeInsets.all(12),
      onTap: () {}, 
      child: Row(
        children: [
          AppSurface(
            width: 40,
            height: 40,
            shape: BoxShape.circle,
            variant: SurfaceVariant.base,
            child: Center(
              child: Icon(
                isOnline ? Icons.wifi : Icons.wifi_off,
                size: 20,
                color: isOnline ? theme.primary : theme.outline,
              ),
            ),
          ),
          AppGap.md(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(name, fontWeight: FontWeight.bold),
                if (isLoading)
                  AppSkeleton.text(width: 60, height: 10)
                else
                  AppText.caption(status,
                      color: isOnline ? Colors.green : Colors.grey),
              ],
            ),
          ),
          Icon(Icons.chevron_right,
              color: theme.onSurface.withValues(alpha: 0.3)),
        ],
      ),
    );
  }
}
