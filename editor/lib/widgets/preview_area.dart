import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../controllers/theme_editor_controller.dart';
import 'templates/component_showcase_template.dart';
import 'templates/dashboard_template.dart';
import 'templates/settings_template.dart';

enum PreviewTemplate {
  components('Components'),
  dashboard('Dashboard'),
  settings('Settings');

  final String label;
  const PreviewTemplate(this.label);
}

/// Widget that displays a live preview of the current theme
/// All preview components use UI Kit library widgets
class PreviewArea extends StatefulWidget {
  final double? previewWidth;

  const PreviewArea({
    this.previewWidth,
    super.key,
  });

  @override
  State<PreviewArea> createState() => _PreviewAreaState();
}

class _PreviewAreaState extends State<PreviewArea> {
  PreviewTemplate _selectedTemplate = PreviewTemplate.components;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeEditorController>(
      builder: (context, themeController, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Template Selector Toolbar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Preview Template:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<PreviewTemplate>(
                        value: _selectedTemplate,
                        items: PreviewTemplate.values.map((template) {
                          return DropdownMenuItem(
                            value: template,
                            child: Text(template.label),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedTemplate = value;
                            });
                          }
                        },
                        isDense: true,
                        underline: Container(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Preview Content
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5), // Neutral canvas background
                      // border: Border.all(color: Colors.grey.shade300), // Border moved to outer container if needed, or removed
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.zero, // Changed from circular 8 as it's full panel now
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0), // Padding to show canvas
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16), // Device-like rounded corners
                              child: SizedBox(
                                width: widget.previewWidth,
                                child: Theme(
                                  data: AppTheme.create(
                                    brightness: themeController.brightness,
                                    // seedColor is redundant if we pass colorSchemeOverride, but keep for safety
                                    seedColor: themeController.seedColor,
                                    colorSchemeOverride: themeController.createColorScheme(themeController.brightness),
                                    designThemeBuilder: (_) => themeController.currentTheme,
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      // Responsive logic based on effective width
                                      final effectiveWidth = widget.previewWidth ?? constraints.maxWidth;
                                      final isMobile = effectiveWidth < 600;

                                      Widget body;
                                      switch (_selectedTemplate) {
                                        case PreviewTemplate.components:
                                          body = const ComponentShowcaseTemplate();
                                          break;
                                        case PreviewTemplate.dashboard:
                                          body = const DashboardTemplate();
                                          break;
                                        case PreviewTemplate.settings:
                                          body = const SettingsTemplate();
                                          break;
                                      }

                                      Widget? bottomNav;

                                      if (isMobile) {
                                        bottomNav = AppNavigationBar(
                                          items: const [
                                            AppNavigationItem(icon: Icon(Icons.home), label: 'Home'),
                                            AppNavigationItem(icon: Icon(Icons.settings), label: 'Settings'),
                                          ],
                                          currentIndex: 0,
                                          onTap: (_) {},
                                        );
                                      } else {
                                        body = Row(
                                          children: [
                                            AppNavigationRail(
                                              items: const [
                                                AppNavigationItem(icon: Icon(Icons.home), label: 'Home'),
                                                AppNavigationItem(icon: Icon(Icons.settings), label: 'Settings'),
                                              ],
                                              currentIndex: 0,
                                              onTap: (_) {},
                                            ),
                                            Expanded(child: body),
                                          ],
                                        );
                                      }

                                      return Scaffold(
                                        backgroundColor: AppTheme.of(context).surfaceBase.backgroundColor,
                                        body: body,
                                        bottomNavigationBar: bottomNav,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}