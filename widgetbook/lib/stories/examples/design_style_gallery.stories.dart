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
    final seedColor = AppPalette.brandPrimary;
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    final designTheme = brightness == Brightness.light
        ? themeBuilder(scheme)
        : darkThemeBuilder(scheme);

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
              borderRadius:
                  BorderRadius.circular(isDesktop ? 16 : 40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 40,
                  spreadRadius: 10,
                )
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
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
  double _brightness = 0.8;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _devices = [
    {'name': 'Main Light', 'isOn': true, 'type': 'light'},
    {'name': 'AC Unit', 'isOn': true, 'type': 'ac'},
    {'name': 'Smart TV', 'isOn': false, 'type': 'tv'},
    {'name': 'Air Purifier', 'isOn': true, 'type': 'fan'},
  ];

  final _navItems = [
    AppNavigationItem(
        icon: Icon(Icons.dashboard_outlined),
        activeIcon: Icon(Icons.dashboard),
        label: 'Home'),
    AppNavigationItem(
        icon: Icon(Icons.grid_view),
        activeIcon: Icon(Icons.grid_view_rounded),
        label: 'Rooms'),
    AppNavigationItem(
        icon: Icon(Icons.access_time),
        activeIcon: Icon(Icons.access_time_filled),
        label: 'History'),
    AppNavigationItem(
        icon: Icon(Icons.settings_outlined),
        activeIcon: Icon(Icons.settings),
        label: 'Settings'),
  ];

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
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(16.0 * theme.spacingFactor),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (!isDesktopLayout) ...[
                          const AppAvatar(initials: 'AU', size: 48),
                          AppGap.md(),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.headline('Welcome Home'),
                              AppText.caption('Austin • 3 Active Devices'),
                            ],
                          ),
                        ),
                        if (!isDesktopLayout) ...[
                          const Spacer(),
                          AppIconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onTap: () {},
                            variant: SurfaceVariant.base,
                          ),
                        ]
                      ],
                    ),
                    AppGap.lg(),
                    AppTextField(
                      controller: _searchController,
                      hintText: 'Search devices...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () =>
                                  setState(() => _searchController.clear()),
                              child: const Icon(Icons.close),
                            )
                          : null,
                      onChanged: (v) => setState(() {}),
                    ),
                  ],
                ),
              ),

              // Rooms
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0 * theme.spacingFactor),
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

              // Grid Content
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0 * theme.spacingFactor),
                child: Column(
                  children: [
                    // Environment Card
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.subhead('Environment'),
                              AppSwitch(
                                  value: _masterSwitch,
                                  onChanged: (v) =>
                                      setState(() => _masterSwitch = v)),
                            ],
                          ),
                          AppGap.lg(),
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
                        ],
                      ),
                    ),
                    AppGap.lg(),

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

                    // Bottom Padding for Mobile Nav
                    if (!isDesktopLayout) SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        );

        // ✨ 響應式佈局分支
        if (isDesktopLayout) {
          // --- Desktop Layout (Row with NavRail) ---
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(
              children: [
                // Side Navigation
                AppNavigationRail(
                  currentIndex: _navIndex,
                  onTap: (i) => setState(() => _navIndex = i),
                  items: _navItems,
                  leading: const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: AppAvatar(initials: 'AU', size: 40),
                  ),
                  trailing: AppIconButton(
                      icon: const Icon(Icons.logout),
                      onTap: () {},
                      variant: SurfaceVariant.base),
                ),
                // Main Content
                Expanded(child: bodyContent),
              ],
            ),
          );
        } else {
          // --- Mobile Layout (Column with BottomBar) ---
          return Scaffold(
            extendBody: true, // Glass Effect
            backgroundColor: Colors.transparent,
            body: Container(
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
