import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import '../controllers/theme_editor_controller.dart';
import 'spec_editors/surface_style_editor.dart';
import 'spec_editors/input_style_editor.dart';
import 'spec_editors/global_metrics_editor.dart';
import 'spec_editors/loader_spec_editor.dart';
import 'spec_editors/toggle_spec_editor.dart';
import 'spec_editors/navigation_spec_editor.dart';
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
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header with title and actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Theme Editor',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Row(
                              children: [
                                // Export button
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
                                // Viewport width toggle
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
                                // Brightness toggle
                                IconButton(
                                  icon: Icon(
                                    themeController.brightness == Brightness.light
                                        ? Icons.brightness_7
                                        : Icons.brightness_4,
                                  ),
                                  onPressed: () => themeController.toggleBrightness(),
                                  tooltip: 'Toggle brightness',
                                ),
                                // Reset button
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
                        const Gap(16),

                        // Unsaved changes indicator
                        if (themeController.hasUnsavedChanges)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.info, color: Colors.orange),
                                const Gap(8),
                                const Text('You have unsaved changes'),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    // TODO: Implement save functionality
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          ),
                        const Gap(24),

                        // Color Settings Section
                        _SectionHeader(title: 'Colors'),
                        const Gap(12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('Color editors (primary, secondary, tertiary, error) coming in Phase 4'),
                        ),
                        const Gap(24),

                        // Input Style Section
                        _SectionHeader(title: 'Input Fields'),
                        const Gap(12),
                        InputStyleEditor(
                          inputStyle: themeController.currentTheme.inputStyle,
                          onChanged: (style) => themeController.updateInputStyle(style),
                        ),
                        const Gap(24),

                        // Surface Settings Section
                        _SectionHeader(title: 'Surfaces'),
                        const Gap(12),
                        SurfaceStyleEditor(
                          title: 'Base Surface',
                          initialStyle: themeController.currentTheme.surfaceBase,
                          onChanged: (style) => themeController.updateSurfaceBase(style),
                        ),
                        const Gap(12),
                        SurfaceStyleEditor(
                          title: 'Elevated Surface',
                          initialStyle: themeController.currentTheme.surfaceElevated,
                          onChanged: (style) => themeController.updateSurfaceElevated(style),
                        ),
                        const Gap(12),
                        SurfaceStyleEditor(
                          title: 'Highlight Surface',
                          initialStyle: themeController.currentTheme.surfaceHighlight,
                          onChanged: (style) => themeController.updateSurfaceHighlight(style),
                        ),
                        const Gap(24),

                        // Global Metrics Section
                        _SectionHeader(title: 'Global Metrics'),
                        const Gap(12),
                        GlobalMetricsEditor(
                          spacingFactor: themeController.currentTheme.spacingFactor,
                          animationDuration: themeController.currentTheme.animation.duration,
                          onChanged: (metrics) {
                            themeController.updateGlobalMetrics(
                              spacingFactor: metrics.spacingFactor,
                              animationDuration: metrics.animationDuration,
                            );
                          },
                        ),
                        const Gap(24),

                        // Loader Section
                        _SectionHeader(title: 'Feedback Components'),
                        const Gap(12),
                        LoaderSpecEditor(
                          initialStyle: themeController.currentTheme.loaderStyle,
                          onChanged: (style) => themeController.updateLoaderSpec(style),
                        ),
                        const Gap(24),

                        // Toggle Section
                        ToggleSpecEditor(
                          initialStyle: themeController.currentTheme.toggleStyle,
                          onChanged: (style) => themeController.updateToggleSpec(style),
                        ),
                        const Gap(24),

                        // Navigation Section
                        _SectionHeader(title: 'Navigation'),
                        const Gap(12),
                        NavigationSpecEditor(
                          initialStyle: themeController.currentTheme.navigationStyle,
                          onChanged: (style) => themeController.updateNavigationSpec(style),
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
