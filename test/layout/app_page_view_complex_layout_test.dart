import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../test_utils/golden_test_matrix_factory.dart';
import '../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppPageView Complex Layout Tests', () {

    // 輔助方法：建立網際網路狀態卡片
    Widget buildInternetStatusCard() {
      return AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.circle, color: Colors.green, size: 12),
                AppGap.sm(),
                AppText.titleMedium('Internet Online'),
              ],
            ),
            AppGap.sm(),
            AppText.caption('Network Provider • Location', color: Colors.grey),
            AppGap.md(),

            // Device info - ultra simplified
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.router, size: 16, color: Colors.white),
                ),
                AppGap.sm(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.caption('Router Device'),
                      AppText.caption('Status: Online', color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // 輔助方法：建立速度測試卡片
    Widget buildSpeedTestCard() {
      return AppCard(
        child: Column(
          children: [
            const Icon(Icons.speed, size: 40, color: Colors.greenAccent),
            AppGap.sm(),
            AppText.headline('1Gbps', color: Colors.white),
            AppText.caption('Connected Speed'),
            AppGap.md(),
            const Divider(color: Colors.white10),
            AppGap.sm(),
            AppText.titleSmall('Start Speed Test'),
            AppGap.sm(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Test 1',
                    onTap: () {},
                    size: AppButtonSize.small,
                  ),
                ),
                AppGap.sm(),
                Expanded(
                  child: AppButton(
                    label: 'Test 2',
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

    // Build enterprise dashboard scenario - simplified version
    Widget buildDashboardScenario() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dashboard Header - simplified
          AppText.titleMedium('Enterprise Dashboard'),
          AppGap.md(),
          AppText.body('9:17 AM Dec 1, 2025', color: Colors.grey),
          AppGap.lg(),

          // Simplified content - just one card to avoid overflow
          buildInternetStatusCard(),
          AppGap.md(),
          buildSpeedTestCard(),
        ],
      );
    }

    // Build network settings form scenario - simplified version
    Widget buildNetworkSettingsScenario() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.titleMedium('Network Settings'),
          AppGap.lg(),

          // IPv4 Configuration Section - simplified
          AppText.titleSmall('IPv4 Configuration'),
          AppGap.md(),
          const AppTextField(hintText: '192.168.1.1'),
          AppGap.lg(),

          // MAC Address Section - simplified
          AppText.titleSmall('MAC Address'),
          AppGap.md(),
          const AppTextField(hintText: 'AA:BB:CC:DD:EE:FF'),
          AppGap.lg(),

          // Action buttons - simplified
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Cancel',
                  onTap: () {},
                  variant: SurfaceVariant.base,
                ),
              ),
              AppGap.md(),
              Expanded(
                child: AppButton(
                  label: 'Save',
                  onTap: () {},
                  variant: SurfaceVariant.highlight,
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Test 1: Enterprise dashboard scenario - complex layout test
    goldenTest(
      'AppPageView - Enterprise Dashboard',
      fileName: 'app_page_view_enterprise_dashboard',
      builder: () => buildThemeMatrix(
        name: 'Enterprise Dashboard',
        width: 500,
        height: 600,
        child: AppPageView(
          useSlivers: true,
          useContentPadding: true,
          child: buildDashboardScenario(),
        ),
      ),
    );

    // Test 2: Network settings form scenario - professional form layout
    goldenTest(
      'AppPageView - Network Settings Form',
      fileName: 'app_page_view_network_settings',
      builder: () => buildThemeMatrix(
        name: 'Network Settings Form',
        width: 500,
        height: 700,
        child: AppPageView(
          useSlivers: true,
          useContentPadding: true,
          child: buildNetworkSettingsScenario(),
        ),
      ),
    );

    // Test 3: Dashboard + Tabs complex integration
    goldenTest(
      'AppPageView - Dashboard Tabs Integration',
      fileName: 'app_page_view_dashboard_tabs_integration',
      builder: () => buildThemeMatrix(
        name: 'Dashboard Tabs Integration',
        width: 500,
        height: 500,
        child: AppPageView(
          useSlivers: true,
          useContentPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tabs navigation - minimal to prevent overflow
              AppTabs(
                tabs: const [
                  TabItem(label: 'Home'),
                  TabItem(label: 'Setup'),
                  TabItem(label: 'Net'),
                ],
                initialIndex: 0,
                displayMode: TabDisplayMode.underline,
              ),
              AppGap.lg(),
              // Tab content - Simplified Dashboard
              Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: buildInternetStatusCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Test 4: Complex form layout (no sidebar to avoid overflow)
    goldenTest(
      'AppPageView - Complex Form Layout',
      fileName: 'app_page_view_complex_form',
      builder: () => buildThemeMatrix(
        name: 'Complex Form Layout',
        width: 500,
        height: 500,
        child: AppPageView(
          useSlivers: true,
          useContentPadding: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.titleMedium('Configuration'),
              AppGap.lg(),

              // Multiple form sections to show complexity
              AppText.titleSmall('Server Settings'),
              AppGap.md(),
              const AppTextField(hintText: '192.168.1.1'),
              AppGap.sm(),
              const AppTextField(hintText: '192.168.1.2'),
              AppGap.lg(),

              AppText.titleSmall('Security'),
              AppGap.md(),
              const AppTextField(hintText: 'Key'),
              AppGap.lg(),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Reset',
                      onTap: () {},
                      variant: SurfaceVariant.base,
                    ),
                  ),
                  AppGap.md(),
                  Expanded(
                    child: AppButton(
                      label: 'Apply',
                      onTap: () {},
                      variant: SurfaceVariant.highlight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  });
}