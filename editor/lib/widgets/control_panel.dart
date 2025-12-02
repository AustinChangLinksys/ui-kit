import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import '../controllers/theme_editor_controller.dart';
import 'property_editors/color_property.dart' as color_property;
import 'spec_editors/surface_style_editor.dart';
import 'spec_editors/input_style_editor.dart';
import 'spec_editors/global_metrics_editor.dart';
import 'spec_editors/loader_spec_editor.dart';
import 'spec_editors/toggle_spec_editor.dart';
import 'spec_editors/navigation_spec_editor.dart';
import 'spec_editors/skeleton_spec_editor.dart';
import 'spec_editors/toast_spec_editor.dart';
import 'spec_editors/divider_spec_editor.dart';
import 'export_dialog.dart';
import 'reset_confirmation_dialog.dart';

/// Control panel widget containing all theme property editors
/// Organized in tabs or sections for different theme aspects
class ControlPanel extends StatelessWidget {
  final VoidCallback? onPreviewWidthToggle;
  final bool isMobilePreviewWidth;

  const ControlPanel({
    this.onPreviewWidthToggle,
    this.isMobilePreviewWidth = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeEditorController>(
      builder: (context, themeController, _) {
        return DefaultTabController(
          length: 5,
          child: Column(
            children: [
              // 1. Header (Title + Toolbar)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme Editor',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        // Status indicator if space allows, or move elsewhere
                      ],
                    ),
                    const Gap(16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // Preset Selector with Label
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Style: ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                            const Gap(8),
                            DropdownButton<String>(
                              value: themeController.currentPreset,
                              items: ThemeEditorController.availablePresets.map((preset) {
                                return DropdownMenuItem(
                                  value: preset,
                                  child: Text(preset),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  themeController.loadPreset(value);
                                }
                              },
                              underline: const SizedBox(),
                              icon: const Icon(Icons.arrow_drop_down),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                          child: VerticalDivider(),
                        ),
                        // Action Buttons
                        IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {
                            final code = themeController.generateCode();
                            showDialog(
                              context: context,
                              builder: (context) => ExportDialog(
                                generatedCode: code,
                              ),
                            );
                          },
                          tooltip: 'Export theme code',
                        ),
                        IconButton(
                          icon: Icon(
                            isMobilePreviewWidth
                                ? Icons.phone_android
                                : Icons.desktop_mac,
                          ),
                          onPressed: onPreviewWidthToggle,
                          tooltip: isMobilePreviewWidth
                              ? 'Switch to desktop width'
                              : 'Switch to mobile width',
                        ),
                        IconButton(
                          icon: Icon(
                            themeController.brightness == Brightness.light
                                ? Icons.brightness_7
                                : Icons.brightness_4,
                          ),
                          onPressed: () => themeController.toggleBrightness(),
                          tooltip: 'Toggle brightness',
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ResetConfirmationDialog(
                                onConfirm: () => themeController.reset(),
                              ),
                            );
                          },
                          tooltip: 'Reset to default',
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              // ... Unsaved changes indicator remains same ...

              // 2. TabBar
              const TabBar(
                isScrollable: true,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Core'),
                  Tab(text: 'Colors'),
                  Tab(text: 'Inputs'),
                  Tab(text: 'Feedback'),
                  Tab(text: 'Layout'),
                ],
              ),

              // 3. TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    // Tab 1: Core
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _SectionHeader(title: 'Global Metrics'),
                        const Gap(12),
                        GlobalMetricsEditor(
                          spacingFactor:
                              themeController.currentTheme.spacingFactor,
                          animationDuration:
                              themeController.currentTheme.animation.duration,
                          buttonHeight:
                              themeController.currentTheme.buttonHeight,
                          onChanged: (metrics) {
                            themeController.updateGlobalMetrics(
                              spacingFactor: metrics.spacingFactor,
                              animationDuration: metrics.animationDuration,
                              buttonHeight: metrics.buttonHeight,
                            );
                          },
                        ),
                        const Gap(24),
                        _SectionHeader(title: 'Surfaces'),
                        const Gap(12),
                        SurfaceStyleEditor(
                          title: 'Base Surface',
                          initialStyle:
                              themeController.currentTheme.surfaceBase,
                          onChanged: (style) =>
                              themeController.updateSurfaceBase(style),
                        ),
                        const Gap(12),
                        SurfaceStyleEditor(
                          title: 'Elevated Surface',
                          initialStyle:
                              themeController.currentTheme.surfaceElevated,
                          onChanged: (style) =>
                              themeController.updateSurfaceElevated(style),
                        ),
                        const Gap(12),
                        SurfaceStyleEditor(
                          title: 'Highlight Surface',
                          initialStyle:
                              themeController.currentTheme.surfaceHighlight,
                          onChanged: (style) =>
                              themeController.updateSurfaceHighlight(style),
                        ),
                      ],
                    ),

                    // Tab 2: Colors
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _SectionHeader(title: 'Seed'),
                        const Gap(12),
                        color_property.ColorProperty(
                          label: 'Seed Color',
                          value: themeController.seedColor,
                          onChanged: (color) =>
                              themeController.updateSeedColor(color),
                        ),
                        const Gap(24),
                        _SectionHeader(title: 'Scheme Overrides'),
                        const Gap(12),
                        color_property.ColorProperty(
                          label: 'Primary',
                          value: themeController.currentLightScheme.primary,
                          onChanged: (color) => themeController.updateColorOverride(primary: color),
                        ),
                        const Gap(12),
                        color_property.ColorProperty(
                          label: 'Secondary',
                          value: themeController.currentLightScheme.secondary,
                          onChanged: (color) => themeController.updateColorOverride(secondary: color),
                        ),
                        const Gap(12),
                        color_property.ColorProperty(
                          label: 'Tertiary',
                          value: themeController.currentLightScheme.tertiary,
                          onChanged: (color) => themeController.updateColorOverride(tertiary: color),
                        ),
                        const Gap(12),
                        color_property.ColorProperty(
                          label: 'Error',
                          value: themeController.currentLightScheme.error,
                          onChanged: (color) => themeController.updateColorOverride(error: color),
                        ),
                        const Gap(12),
                        color_property.ColorProperty(
                          label: 'Surface',
                          value: themeController.currentLightScheme.surface,
                          onChanged: (color) => themeController.updateColorOverride(surface: color),
                        ),
                        const Gap(12),
                        color_property.ColorProperty(
                          label: 'Outline',
                          value: themeController.currentLightScheme.outline,
                          onChanged: (color) => themeController.updateColorOverride(outline: color),
                        ),
                        const Gap(16),
                        const Text(
                          'Note: Modifying scheme colors will re-generate the design system and reset structural changes.',
                          style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),

                    // Tab 3: Inputs
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _SectionHeader(title: 'Input Fields'),
                        const Gap(12),
                        InputStyleEditor(
                          inputStyle: themeController.currentTheme.inputStyle,
                          onChanged: (style) =>
                              themeController.updateInputStyle(style),
                        ),
                        const Gap(24),
                        ToggleSpecEditor(
                          initialStyle:
                              themeController.currentTheme.toggleStyle,
                          onChanged: (style) =>
                              themeController.updateToggleSpec(style),
                        ),
                      ],
                    ),

                    // Tab 4: Feedback
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _SectionHeader(title: 'Feedback Components'),
                        const Gap(12),
                        LoaderSpecEditor(
                          initialStyle:
                              themeController.currentTheme.loaderStyle,
                          onChanged: (style) =>
                              themeController.updateLoaderSpec(style),
                        ),
                        const Gap(12),
                        SkeletonSpecEditor(
                          initialStyle:
                              themeController.currentTheme.skeletonStyle,
                          onChanged: (style) =>
                              themeController.updateSkeletonStyle(style),
                        ),
                        const Gap(12),
                        ToastSpecEditor(
                          initialStyle: themeController.currentTheme.toastStyle,
                          onChanged: (style) =>
                              themeController.updateToastStyle(style),
                        ),
                      ],
                    ),

                    // Tab 5: Layout
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _SectionHeader(title: 'Navigation'),
                        const Gap(12),
                        NavigationSpecEditor(
                          initialStyle:
                              themeController.currentTheme.navigationStyle,
                          onChanged: (style) =>
                              themeController.updateNavigationSpec(style),
                        ),
                        const Gap(24),
                        DividerSpecEditor(
                          initialStyle:
                              themeController.currentTheme.dividerStyle,
                          onChanged: (style) =>
                              themeController.updateDividerStyle(style),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Section header widget with visual separation
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const Gap(8),
        Container(
          height: 1,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }
}
