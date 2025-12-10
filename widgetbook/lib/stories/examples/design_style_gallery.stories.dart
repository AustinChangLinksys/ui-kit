import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

// --- 1. Glass Gallery ---
@widgetbook.UseCase(
  name: 'Glass Style (Liquid)',
  type: AppDesignTheme,
  path: 'Design Language Gallery',
)
Widget buildGlassGallery(BuildContext context) {
  return _ThemeWrapper(
    themeBuilder: (scheme) => GlassDesignTheme.light(scheme),
    darkThemeBuilder: (scheme) => GlassDesignTheme.dark(scheme),
    child: const DashboardPage(),
  );
}

// --- 2. Brutal Gallery ---
@widgetbook.UseCase(
  name: 'Brutal Style (Mechanical)',
  type: AppDesignTheme,
  path: 'Design Language Gallery',
)
Widget buildBrutalGallery(BuildContext context) {
  return _ThemeWrapper(
    themeBuilder: (scheme) => BrutalDesignTheme.light(scheme),
    darkThemeBuilder: (scheme) => BrutalDesignTheme.dark(scheme),
    child: const DashboardPage(),
  );
}

// --- 3. Flat Gallery ---
@widgetbook.UseCase(
  name: 'Flat Style (Standard)',
  type: AppDesignTheme,
  path: 'Design Language Gallery',
)
Widget buildFlatGallery(BuildContext context) {
  return _ThemeWrapper(
    themeBuilder: (scheme) => FlatDesignTheme.light(scheme),
    darkThemeBuilder: (scheme) => FlatDesignTheme.dark(scheme),
    child: const DashboardPage(),
  );
}

// --- 4. Neumorphic Gallery ---
@widgetbook.UseCase(
  name: 'Neumorphic Style (Tactile)',
  type: AppDesignTheme,
  path: 'Design Language Gallery',
)
Widget buildNeumorphicGallery(BuildContext context) {
  return _ThemeWrapper(
    themeBuilder: (scheme) => NeumorphicDesignTheme.light(scheme),
    darkThemeBuilder: (scheme) => NeumorphicDesignTheme.dark(scheme),
    child: const DashboardPage(),
  );
}

// --- 5. Pixel Gallery ---
@widgetbook.UseCase(
  name: 'Pixel Style (Retro)',
  type: AppDesignTheme,
  path: 'Design Language Gallery',
)
Widget buildPixelGallery(BuildContext context) {
  return _ThemeWrapper(
    themeBuilder: (scheme) => PixelDesignTheme.light(scheme),
    darkThemeBuilder: (scheme) => PixelDesignTheme.dark(scheme),
    child: const DashboardPage(),
  );
}

// ====================================================================
// 🛠 Helpers
// ====================================================================

typedef ThemeFactory = AppDesignTheme Function(ColorScheme scheme);

class _ThemeWrapper extends StatelessWidget {
  final ThemeFactory themeBuilder;
  final ThemeFactory darkThemeBuilder;
  final Widget child;

  const _ThemeWrapper({
    required this.themeBuilder,
    required this.darkThemeBuilder,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // ✨ 1. Brightness Knob:
    final isDark = context.knobs.boolean(
      label: 'Dark Mode',
      initialValue: true,
    );

    final isDesktop = context.knobs.boolean(
      label: 'Desktop Mode',
      initialValue: false,
    );

    final brightness = isDark ? Brightness.dark : Brightness.light;

    final themeData = AppTheme.create(
      brightness: brightness,
      designThemeBuilder:
          brightness == Brightness.light ? themeBuilder : darkThemeBuilder,
    );

    return Theme(
      data: themeData,
      child: Material(
        color: themeData.scaffoldBackgroundColor,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            width: isDesktop ? 1024 : 375,
            height: isDesktop ? 768 : 800,
            decoration: BoxDecoration(
              color: themeData.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(isDesktop ? 16 : 40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 40,
                  spreadRadius: 10,
                )
              ],
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 8,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: child,
          ),
        ),
      ),
    );
  }
}

// --- Dashboard Page (Responsive) ---

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _navIndex = 0;
  String _selectedRoom = 'Living Room';
  bool _masterSwitch = true;
  double _temperature = 24.5;
  bool _isRefreshing = false; // 用於展示 Loader
  final TextEditingController _searchController = TextEditingController();

  // 新增：模擬設置狀態
  bool _notificationsEnabled = true;
  int _powerMode = 1; // 0: Eco, 1: Standard, 2: High Perf

  final List<Map<String, dynamic>> _devices = [
    {'name': 'Main Light', 'isOn': true, 'type': 'light'},
    {'name': 'AC Unit', 'isOn': true, 'type': 'ac'},
    {'name': 'Smart TV', 'isOn': false, 'type': 'tv'},
    {'name': 'Air Purifier', 'isOn': true, 'type': 'fan'},
  ];

  final _navItems = [
    const AppNavigationItem(
        icon: Icon(Icons.dashboard_outlined),
        activeIcon: Icon(Icons.dashboard),
        label: 'Home'),
    const AppNavigationItem(
        icon: Icon(Icons.grid_view),
        activeIcon: Icon(Icons.grid_view_rounded),
        label: 'Rooms'),
    const AppNavigationItem(
        icon: Icon(Icons.settings_outlined),
        activeIcon: Icon(Icons.settings),
        label: 'Settings'),
  ];

  void _refreshData() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final isGlass =
        Theme.of(context).extension<AppDesignTheme>() is GlassDesignTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktopLayout = constraints.maxWidth > 600;

        Widget bodyContent = SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Section
              Padding(
                padding: EdgeInsets.all(16.0 * theme.spacingFactor),
                child: Row(
                  children: [
                    if (!isDesktopLayout) ...[
                      const AppAvatar(
                          initials: 'AU',
                          size: 48,
                          imageUrl: 'https://i.pravatar.cc/150?img=12'),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.headline('Welcome Home'),
                          Row(
                            children: [
                              AppText.caption('System Status: '),
                              const SizedBox(width: 4),
                              const AppBadge(
                                  label: 'Online', color: Colors.green),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (_isRefreshing)
                      const AppLoader(
                          variant: LoaderVariant.circular,
                          value: null) // Circular Spinner
                    else
                      AppTooltip(
                        message: 'Refresh Data',
                        position: AxisDirection.down,
                        child: AppIconButton(
                          icon: const Icon(Icons.refresh),
                          onTap: _refreshData,
                          variant: SurfaceVariant.base,
                        ),
                      ),
                  ],
                ),
              ),

              const AppDivider(), // ✨ Divider Demo

              // 2. Quick Filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0 * theme.spacingFactor, vertical: 12),
                child: Row(
                  children: [
                    for (final room in [
                      'Living Room',
                      'Bedroom',
                      'Kitchen',
                      'Office'
                    ]) ...[
                      AppTag(
                        label: room,
                        color: _selectedRoom == room
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        onTap: () => setState(() => _selectedRoom = room),
                      ),
                      AppGap.sm(),
                    ],
                  ],
                ),
              ),

              AppGap.md(),

              // 3. Main Grid
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0 * theme.spacingFactor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Environment Control Card ---
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.subhead('Climate'),
                              AppSwitch(
                                  value: _masterSwitch,
                                  onChanged: (v) =>
                                      setState(() => _masterSwitch = v)),
                            ],
                          ),
                          AppGap.lg(),
                          // Temperature
                          Row(children: [
                            const Icon(Icons.thermostat,
                                size: 20, color: Colors.orange),
                            AppGap.sm(),
                            AppText.body('${_temperature.toStringAsFixed(1)}°C')
                          ]),
                          AppGap.sm(),
                          AppSlider(
                              value: _temperature,
                              min: 16,
                              max: 30,
                              divisions: 28,
                              onChanged: _masterSwitch
                                  ? (v) => setState(() => _temperature = v)
                                  : null),

                          AppGap.md(),
                          const AppDivider(
                              indent: 10, endIndent: 10), // Inner Divider
                          AppGap.md(),

                          // Power Mode (Radio Demo)
                          AppText.caption('Power Mode'),
                          AppGap.sm(),
                          Row(
                            children: [
                              _PowerModeOption(
                                  label: 'Eco',
                                  value: 0,
                                  groupValue: _powerMode,
                                  onChanged: (v) =>
                                      setState(() => _powerMode = v!)),
                              AppGap.md(),
                              _PowerModeOption(
                                  label: 'Std',
                                  value: 1,
                                  groupValue: _powerMode,
                                  onChanged: (v) =>
                                      setState(() => _powerMode = v!)),
                              AppGap.md(),
                              _PowerModeOption(
                                  label: 'High',
                                  value: 2,
                                  groupValue: _powerMode,
                                  onChanged: (v) =>
                                      setState(() => _powerMode = v!)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    AppGap.lg(),

                    // --- Search & List ---
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _searchController,
                            hintText: 'Find devices...',
                            prefixIcon: const Icon(Icons.search),
                            // Demo: Suffix Icon Button
                            suffixIcon: _searchController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: _searchController.clear,
                                    child: const Icon(Icons.close))
                                : null,
                            onChanged: (v) => setState(() {}),
                          ),
                        ),
                        AppGap.md(),
                        AppButton(
                          label: 'Add',
                          icon: const Icon(Icons.add),
                          size: AppButtonSize.medium,
                          onTap: () {}, // Shows Add Dialog
                        ),
                      ],
                    ),

                    AppGap.md(),

                    // Loader Demo (Linear)
                    if (_isRefreshing)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: AppLoader(
                            variant: LoaderVariant.linear), // Linear Progress
                      ),

                    // Device List
                    ..._devices
                        .where((d) => d['name']
                            .toString()
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()))
                        .map((device) => Padding(
                              padding: EdgeInsets.only(
                                  bottom: 8.0 * theme.spacingFactor),
                              child: _DeviceTile(
                                name: device['name'],
                                type: device['type'],
                                isOn: device['isOn'],
                                onToggle: (val) =>
                                    setState(() => device['isOn'] = val),
                              ),
                            )),

                    // Settings Checkbox Demo
                    AppGap.lg(),
                    AppSurface(
                      variant: SurfaceVariant.base,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          AppCheckbox(
                            value: _notificationsEnabled,
                            onChanged: (v) =>
                                setState(() => _notificationsEnabled = v!),
                          ),
                          AppGap.sm(),
                          AppText.body('Enable Push Notifications'),
                        ],
                      ),
                    ),

                    if (!isDesktopLayout) const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        );

        // ... (Scaffold structure remains the same) ...
        if (isDesktopLayout) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(
              children: [
                AppNavigationRail(
                  currentIndex: _navIndex,
                  onTap: (i) => setState(() => _navIndex = i),
                  items: _navItems,
                  leading: const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: AppAvatar(initials: 'AU', size: 40),
                  ),
                  trailing: AppIconButton(
                      icon: const Icon(Icons.logout), onTap: () {}),
                ),
                Expanded(child: bodyContent),
              ],
            ),
          );
        } else {
          return Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: isGlass
                  ? const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2E335A), Color(0xFF1C1B33)],
                      ),
                    )
                  : null,
              child: bodyContent,
            ),
            bottomNavigationBar: AppNavigationBar(
              currentIndex: _navIndex,
              onTap: (i) => setState(() => _navIndex = i),
              items: _navItems,
            ),
          );
        }
      },
    );
  }
}

class _PowerModeOption extends StatelessWidget {
  final String label;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  const _PowerModeOption(
      {required this.label,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppRadio<int>(
            value: value, groupValue: groupValue, onChanged: onChanged),
        AppGap.xs(),
        AppText.caption(label),
      ],
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final String name;
  final String type;
  final bool isOn;
  final ValueChanged<bool> onToggle;

  const _DeviceTile({
    required this.name,
    required this.type,
    required this.isOn,
    required this.onToggle,
  });

  IconData _getIcon() {
    switch (type) {
      case 'light':
        return isOn ? Icons.lightbulb : Icons.lightbulb_outline;
      case 'ac':
        return Icons.ac_unit;
      case 'tv':
        return Icons.tv;
      case 'fan':
        return Icons.air;
      default:
        return Icons.devices;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return AppSurface(
      variant: SurfaceVariant.base,
      interactive: true,
      onTap: () => onToggle(!isOn),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * theme.spacingFactor,
        vertical: 12 * theme.spacingFactor,
      ),
      child: Row(
        children: [
          AppSurface(
            width: 40,
            height: 40,
            shape: BoxShape.circle,
            style: theme.surfaceBase.copyWith(
              backgroundColor: isOn
                  ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                  : null,
            ),
            child: Center(
              child: Icon(
                _getIcon(),
                color:
                    isOn ? Theme.of(context).colorScheme.primary : Colors.grey,
                size: 20,
              ),
            ),
          ),
          AppGap.md(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.labelMedium(name),
                AppText.caption(isOn ? 'On' : 'Off',
                    color: isOn ? Colors.green : Colors.grey),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: AppSwitch(
              value: isOn,
              onChanged: onToggle,
              scale: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
