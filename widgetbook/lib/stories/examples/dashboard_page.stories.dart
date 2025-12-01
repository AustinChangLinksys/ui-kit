import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Home Dashboard',
  type: DashboardPage,
  path: 'Examples',
)
Widget buildDashboardStory(BuildContext context) {
  return const DashboardPage();
}

/// 模擬的 Dashboard 頁面
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    // 使用 SingleChildScrollView 允許捲動
    return Scaffold(
      backgroundColor: Colors.transparent, // 讓外層背景透進來
      body: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacingFactor * 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            const _DashboardHeader(),
            AppGap.xl(),

            // 2. Main Content Grid
            // 在寬螢幕下並排，窄螢幕下垂直排列
            LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column (Network Status & Topology)
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          const _InternetStatusCard(),
                          AppGap.lg(),
                          const _NetworkTopologyCard(),
                        ],
                      ),
                    ),
                    AppGap.lg(),
                    // Right Column (Speed & WiFi Settings)
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          const _SpeedTestCard(),
                          AppGap.lg(),
                          const _WiFiCard(
                            band: '2.4GHz Band',
                            ssid: 'HAO-9F-2.4G',
                            deviceCount: 5,
                            isOn: true,
                          ),
                          AppGap.lg(),
                          const _WiFiCard(
                            band: '5GHz Band',
                            ssid: 'HAO-9F',
                            deviceCount: 8,
                            isOn: true,
                          ),
                          AppGap.lg(),
                          const _WiFiCard(
                            band: 'Guest WiFi',
                            ssid: 'Linksys00107-guest',
                            deviceCount: 0,
                            isOn: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Mobile Layout
                return Column(
                  children: [
                    const _InternetStatusCard(),
                    AppGap.md(),
                    const _SpeedTestCard(),
                    AppGap.md(),
                    const _NetworkTopologyCard(),
                    AppGap.md(),
                    const _WiFiCard(
                        band: '2.4GHz',
                        ssid: 'HAO-9F-2.4G',
                        deviceCount: 5,
                        isOn: true),
                    AppGap.md(),
                    const _WiFiCard(
                        band: '5GHz',
                        ssid: 'HAO-9F',
                        deviceCount: 8,
                        isOn: true),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

// --- Sub-Components (Organisms) ---

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.headline('Good morning!'),
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
            AppGap.xs(),
            AppText.body('9:17 AM Dec 1, 2025', color: Colors.grey),
          ],
        ),
      ],
    );
  }
}

class _InternetStatusCard extends StatelessWidget {
  const _InternetStatusCard();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return AppCard(
      child: Column(
        children: [
          // Status Header
          Row(
            children: [
              const Icon(Icons.circle, color: Colors.green, size: 12),
              AppGap.sm(),
              AppText.titleMedium('Internet Online'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: AppText.body('Chunghwa Telecom • Hsinchu, HSQ',
                color: Colors.grey),
          ),
          const Divider(height: 32, color: Colors.white10),

          // Device Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Device Image Placeholder
              AppSurface(
                width: 60,
                height: 100,
                variant: SurfaceVariant.base,
                style:
                    theme.surfaceBase.copyWith(backgroundColor: Colors.white10),
                child: const Center(
                    child: Icon(Icons.router, size: 32, color: Colors.white)),
              ),
              AppGap.lg(),
              // Info Grid
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.titleMedium('Linksys00107'),
                    AppGap.md(),
                    const _InfoRow(label: 'Connection:', value: 'Wired'),
                    const _InfoRow(label: 'Model:', value: 'LN16'),
                    const _InfoRow(label: 'Serial#:', value: '65G10M2CE00107'),
                    Row(
                      children: [
                        SizedBox(
                            width: 100,
                            child: AppText.body('FW Version:',
                                color: Colors.grey)),
                        AppText.body('1.0.10.216621 '),
                        const Icon(Icons.check, color: Colors.green, size: 16),
                        AppText.caption(' Up to date', color: Colors.green),
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
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: AppText.body(label, color: Colors.grey)),
          AppText.body(value),
        ],
      ),
    );
  }
}

class _SpeedTestCard extends StatelessWidget {
  const _SpeedTestCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Speed Visual
          Center(
            child: Column(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                AppGap.xs(),
                const Icon(Icons.speed, size: 48, color: Colors.greenAccent),
                AppGap.xs(),
                AppText.headline('1Gbps', color: Colors.white),
                AppText.caption('Connected Speed'),
              ],
            ),
          ),
          const Divider(height: 32, color: Colors.white10),
          AppText.titleMedium('Start Speed Test'),
          AppGap.xs(),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 14, color: Colors.blue),
              AppGap.xs(),
              AppText.caption('Understand your speed test results'),
            ],
          ),
          AppGap.md(),
          Row(
            children: [
              Expanded(
                  child: AppButton(
                      label: 'CloudFlare',
                      onTap: () {},
                      size: AppButtonSize.small)),
              AppGap.md(),
              Expanded(
                  child: AppButton(
                      label: 'Fast.com',
                      onTap: () {},
                      size: AppButtonSize.small)),
            ],
          ),
          AppGap.sm(),
          Center(
              child: AppText.caption('Or test with your preferred service',
                  color: Colors.grey)),
        ],
      ),
    );
  }
}

class _NetworkTopologyCard extends StatelessWidget {
  const _NetworkTopologyCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.titleMedium('My Network'),
              Row(
                children: [
                  AppText.caption('Firmware is '),
                  AppText.caption('up-to-date', color: Colors.green),
                  const Icon(Icons.check, size: 14, color: Colors.green),
                ],
              ),
            ],
          ),
          AppGap.lg(),

          // Summary Stats
          Row(
            children: [
              const Expanded(
                  child: _StatBox(label: 'Nodes', value: '3', icon: Icons.hub)),
              AppGap.md(),
              const Expanded(
                  child: _StatBox(
                      label: 'Devices', value: '13', icon: Icons.devices)),
            ],
          ),

          AppGap.lg(),

          // Tree View
          const _TreeNode(
              name: 'Linksys00107',
              subtitle: '8 devices\nUptime: 9d 23h',
              isRoot: true),
          const _TreeNode(
              name: 'Linksys03045',
              subtitle: '2 devices',
              hasLine: true,
              isLast: false),
          const _TreeNode(
              name: 'Linksys16420',
              subtitle: '2 devices',
              hasLine: true,
              isLast: true),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatBox(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppSurface(
      style: theme.surfaceBase.copyWith(
        backgroundColor: Colors.transparent,
        borderColor: Colors.white24,
        borderWidth: 1,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.headline(value),
              Icon(icon, color: Colors.grey, size: 20),
            ],
          ),
          AppText.body(label, color: Colors.grey),
        ],
      ),
    );
  }
}

class _TreeNode extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool isRoot;
  final bool hasLine;
  final bool isLast;

  const _TreeNode({
    required this.name,
    required this.subtitle,
    this.isRoot = false,
    this.hasLine = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tree Line Drawing
          SizedBox(
            width: 24,
            child: hasLine
                ? CustomPaint(
                    painter: _TreeLinePainter(isLast: isLast),
                  )
                : null,
          ),

          // Node Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AppSurface(
                style: theme.surfaceBase.copyWith(
                    backgroundColor: Colors.white.withValues(alpha: 0.05)),
                child: Row(
                  children: [
                    const Icon(Icons.router, size: 32),
                    AppGap.md(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.titleSmall(name),
                          AppText.caption(subtitle, color: Colors.grey),
                        ],
                      ),
                    ),
                    const Icon(Icons.wifi, color: Colors.green, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TreeLinePainter extends CustomPainter {
  final bool isLast;
  _TreeLinePainter({required this.isLast});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Vertical Line
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, isLast ? size.height / 2 : size.height),
      paint,
    );

    // Horizontal Connector
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WiFiCard extends StatefulWidget {
  final String band;
  final String ssid;
  final int deviceCount;
  final bool isOn;

  const _WiFiCard({
    required this.band,
    required this.ssid,
    required this.deviceCount,
    required this.isOn,
  });

  @override
  State<_WiFiCard> createState() => _WiFiCardState();
}

class _WiFiCardState extends State<_WiFiCard> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.isOn;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.body(widget.band, color: Colors.grey),
              AppSwitch(
                value: _isOn,
                onChanged: (v) => setState(() => _isOn = v),
              ),
            ],
          ),
          AppGap.sm(),
          AppText.titleMedium(widget.ssid),
          AppGap.lg(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.devices, size: 16, color: Colors.grey),
                  AppGap.xs(),
                  AppText.body(
                    widget.deviceCount == 0
                        ? 'No devices'
                        : '${widget.deviceCount} devices',
                  ),
                ],
              ),
              const Icon(Icons.qr_code, size: 20, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
