import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Enterprise Complex Layouts',
  type: AppPageView,
)
Widget buildEnterpriseComplexLayouts(BuildContext context) {
  return const _ComplexLayoutDemo();
}

class _ComplexLayoutDemo extends StatefulWidget {
  const _ComplexLayoutDemo();

  @override
  State<_ComplexLayoutDemo> createState() => _ComplexLayoutDemoState();
}

class _ComplexLayoutDemoState extends State<_ComplexLayoutDemo> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppPageView(
      useSlivers: true,
      useContentPadding: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tabs for switching between different complex layouts
          AppTabs(
            tabs: const [
              TabItem(label: 'Enterprise Dashboard', icon: Icons.dashboard),
              TabItem(label: 'Network Settings', icon: Icons.network_wifi),
              TabItem(label: 'System Config', icon: Icons.settings),
            ],
            initialIndex: _selectedTabIndex,
            displayMode: TabDisplayMode.underline,
            onTabChanged: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
          ),
          AppGap.lg(),

          // Dynamic content based on selected tab
          Container(
            constraints: const BoxConstraints(minHeight: 600),
            width: double.infinity,
            child: _buildTabContent(_selectedTabIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return _buildDashboardLayout();
      case 1:
        return _buildNetworkSettingsLayout();
      case 2:
        return _buildSystemConfigLayout();
      default:
        return _buildDashboardLayout();
    }
  }

  // Enterprise Dashboard Layout
  Widget _buildDashboardLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dashboard Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Enterprise Dashboard', style: Theme.of(context).textTheme.headlineMedium),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text('9:17 AM Dec 1, 2025', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Complex responsive layout
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column - Status Cards
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildInternetStatusCard(),
                      const SizedBox(height: 16),
                      _buildSystemMetricsCard(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Right Column - Controls
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _buildSpeedTestCard(),
                      const SizedBox(height: 16),
                      _buildWiFiCard('2.4GHz Band', 'HAO-9F-2.4G', 5, true),
                      const SizedBox(height: 16),
                      _buildWiFiCard('5GHz Band', 'HAO-9F', 8, false),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // Mobile layout
            return Column(
              children: [
                _buildInternetStatusCard(),
                const SizedBox(height: 16),
                _buildSpeedTestCard(),
                const SizedBox(height: 16),
                _buildWiFiCard('2.4GHz', 'HAO-9F-2.4G', 5, true),
              ],
            );
          }
        }),
      ],
    );
  }

  // Network Settings Layout
  Widget _buildNetworkSettingsLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Network Configuration', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 24),

        // IPv4 Configuration Section
        Text('IPv4 Configuration', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        const AppTextField(
          hintText: '192.168.1.1',
          prefixIcon: Icon(Icons.network_wifi),
        ),
        const SizedBox(height: 24),

        const Divider(),
        const SizedBox(height: 24),

        // MAC Address Section
        Text('MAC Address Filter', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        const AppTextField(
          hintText: 'AA:BB:CC:DD:EE:FF',
          prefixIcon: Icon(Icons.security),
        ),
        const SizedBox(height: 24),

        const Divider(),
        const SizedBox(height: 24),

        // IPv6 Configuration Section
        Text('IPv6 Configuration', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        const AppTextField(
          hintText: '2001:db8::1',
          prefixIcon: Icon(Icons.language),
        ),
        const SizedBox(height: 32),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Cancel',
                onTap: () {},
                variant: SurfaceVariant.base,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppButton(
                label: 'Save Settings',
                onTap: () {},
                variant: SurfaceVariant.highlight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // System Configuration Layout
  Widget _buildSystemConfigLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Sidebar - Navigation
        Container(
          width: 280,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('System Menu', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),

              // Search field
              const AppTextField(
                hintText: 'Search settings...',
                prefixIcon: Icon(Icons.search),
              ),
              const SizedBox(height: 16),

              // Navigation items
              _buildNavItem('Network Settings', Icons.network_wifi, true),
              _buildNavItem('Security Settings', Icons.security, false),
              _buildNavItem('Advanced Options', Icons.tune, false),
              _buildNavItem('Monitoring Dashboard', Icons.dashboard, false),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // System status
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green, size: 16),
                        const SizedBox(width: 8),
                        Text('System Status: Normal', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Uptime: 15 days 3 hours', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                    Text('Memory Usage: 67%', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              AppButton(
                label: 'Restart System',
                onTap: () {},
                variant: SurfaceVariant.base,
                size: AppButtonSize.small,
              ),
            ],
          ),
        ),

        const SizedBox(width: 24),

        // Right Content - Configuration Forms
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Advanced System Configuration', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),

              // Configuration sections
              _buildConfigSection('Performance Settings', [
                _buildConfigRow('CPU Throttling', true),
                _buildConfigRow('Memory Optimization', false),
                _buildConfigRow('Background Processing', true),
              ]),

              const SizedBox(height: 24),

              _buildConfigSection('Security Options', [
                _buildConfigRow('Firewall Enabled', true),
                _buildConfigRow('Intrusion Detection', true),
                _buildConfigRow('Auto Updates', false),
              ]),

              const SizedBox(height: 24),

              _buildConfigSection('Monitoring', [
                _buildConfigRow('Real-time Alerts', true),
                _buildConfigRow('Performance Logging', false),
                _buildConfigRow('Usage Analytics', true),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(String title, IconData icon, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isActive ? Theme.of(context).colorScheme.primary : Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isActive)
              Icon(Icons.chevron_right, size: 16, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildConfigRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          AppSwitch(value: value, onChanged: (v) {}),
        ],
      ),
    );
  }

  // Helper widgets for dashboard cards
  Widget _buildInternetStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.circle, color: Colors.green, size: 12),
              const SizedBox(width: 8),
              Text('Internet Online', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 8),
          Text('Chunghwa Telecom • Hsinchu, HSQ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
          const SizedBox(height: 16),

          // Device info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 70,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.router, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Linksys00107', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    _buildInfoRow('Connection:', 'Wired'),
                    _buildInfoRow('Model:', 'LN16'),
                    _buildInfoRow('Serial#:', '65G10M2CE00107'),
                    Row(
                      children: [
                        Text('FW: ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                        Text('1.0.10.216621', style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: 4),
                        const Icon(Icons.check, color: Colors.green, size: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSystemMetricsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('System Metrics', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          _buildMetricRow('CPU Usage', '42%', Colors.blue),
          _buildMetricRow('Memory', '67%', Colors.orange),
          _buildMetricRow('Storage', '23%', Colors.green),
          _buildMetricRow('Network', '1.2 GB/s', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildSpeedTestCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          const Icon(Icons.speed, size: 40, color: Colors.greenAccent),
          const SizedBox(height: 8),
          Text('1Gbps', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
          Text('Connected Speed', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Text('Start Speed Test', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'CloudFlare',
                  onTap: () {},
                  size: AppButtonSize.small,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButton(
                  label: 'Fast.com',
                  onTap: () {},
                  size: AppButtonSize.small,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWiFiCard(String band, String ssid, int deviceCount, bool isOn) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(band, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
              AppSwitch(value: isOn, onChanged: (v) {}),
            ],
          ),
          const SizedBox(height: 8),
          Text(ssid, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.devices, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    deviceCount == 0 ? 'No devices' : '$deviceCount devices',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const Icon(Icons.qr_code, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey))),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Desktop Dashboard (Fixed Header + Menu)',
  type: AppPageView,
)
Widget buildDesktopDashboard(BuildContext context) {

  final showOverlay = context.knobs.boolean(label: 'Show Grid Overlay', initialValue: true);

  return AppPageView(
    useSlivers: false,
    scrollable: true,
    showGridOverlay: showOverlay,

    header: Container(
      height: 64,
      width: double.infinity,
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Text('Dashboard Header', style: Theme.of(context).textTheme.titleLarge),
    ),

    sideMenu: Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MenuLink(icon: Icons.home, label: 'Home', active: true),
          _MenuLink(icon: Icons.analytics, label: 'Analytics'),
          _MenuLink(icon: Icons.people, label: 'Users'),
          Spacer(),
          _MenuLink(icon: Icons.settings, label: 'Settings'),
        ],
      ),
    ),

    // Content (8 Cols)
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Main Content Area', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        ...List.generate(10, (index) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Container(height: 100, alignment: Alignment.center, child: Text('Chart Widget $index')),
        )),
      ],
    ),
  );
}

class _MenuLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const _MenuLink({required this.icon, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: active ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: active ? Theme.of(context).colorScheme.primary : Colors.grey),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(
            color: active ? Theme.of(context).colorScheme.primary : Colors.grey[700],
            fontWeight: active ? FontWeight.bold : FontWeight.normal
          )),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Mobile Feed (Sliver Header)',
  type: AppPageView,
)
Widget buildMobileFeed(BuildContext context) {
  final showOverlay = context.knobs.boolean(label: 'Show Grid Overlay', initialValue: true);

  return AppPageView(
    useSlivers: true,
    showGridOverlay: showOverlay,
    
    // Header (Sliver)
    header: SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 160,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Mobile Feed'),
        background: Container(color: Colors.blueGrey),
      ),
    ),

    sideMenu: null,

    // Content (Full Width)
    child: Column(
      children: List.generate(20, (index) => ListTile(
        title: Text('Feed Item #$index'),
        subtitle: const Text('Matches standard mobile behavior'),
        leading: const CircleAvatar(child: Icon(Icons.person)),
      )),
    ),
  );
}
