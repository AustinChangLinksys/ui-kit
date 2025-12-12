import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ui_kit_library/ui_kit.dart';

import 'expansion_panel_renderer.dart';

/// A panel item in an expansion panel group
class ExpansionPanelItem {
  /// Title displayed in the panel header
  final String headerTitle;

  /// Content displayed when panel is expanded
  final Widget content;

  /// Whether this panel can be interacted with
  final bool enabled;

  /// Whether this panel can be expanded
  final bool canExpand;

  const ExpansionPanelItem({
    required this.headerTitle,
    required this.content,
    this.enabled = true,
    this.canExpand = true,
  });
}

/// Legacy alias for backward compatibility
typedef ExpansionPanel = ExpansionPanelItem;

/// A collapsible panel component for organizing content into expandable sections
///
/// Supports single or multiple open panels, smooth animations, and theme-aware styling.
///
/// **Usage Example**:
/// ```dart
/// AppExpansionPanel(
///   panels: [
///     ExpansionPanel(
///       headerTitle: 'General Settings',
///       content: Column(
///         children: [
///           CheckboxListTile(title: Text('Enable Notifications')),
///           CheckboxListTile(title: Text('Dark Mode')),
///         ],
///       ),
///     ),
///     ExpansionPanel(
///       headerTitle: 'Privacy',
///       content: CheckboxListTile(title: Text('Share Profile')),
///     ),
///   ],
///   onPanelToggled: (index) => print('Panel $index toggled'),
/// )
/// ```
class AppExpansionPanel extends StatefulWidget {
  /// List of expansion panels
  final List<ExpansionPanelItem> panels;

  /// Indices of initially expanded panels
  final Set<int> initialExpandedIndices;

  /// Whether multiple panels can be open simultaneously
  final bool allowMultipleOpen;

  /// Callback when a panel is toggled
  final ValueChanged<int>? onPanelToggled;

  /// Custom style for expansion panels
  final ExpansionPanelStyle? style;

  const AppExpansionPanel({
    required this.panels,
    this.initialExpandedIndices = const {},
    this.allowMultipleOpen = true,
    this.onPanelToggled,
    this.style,
    super.key,
  });

  /// Creates an expansion panel with a single item.
  ///
  /// Use [panel] to pass an [ExpansionPanelItem] directly, or use
  /// [headerTitle] and [content] for convenience.
  ///
  /// **Usage Examples**:
  /// ```dart
  /// // Using ExpansionPanelItem directly
  /// AppExpansionPanel.single(
  ///   panel: ExpansionPanelItem(
  ///     headerTitle: 'Settings',
  ///     content: SettingsWidget(),
  ///   ),
  /// )
  ///
  /// // Using headerTitle and content directly
  /// AppExpansionPanel.single(
  ///   headerTitle: 'Settings',
  ///   content: SettingsWidget(),
  /// )
  /// ```
  AppExpansionPanel.single({
    ExpansionPanelItem? panel,
    String? headerTitle,
    Widget? content,
    bool initiallyExpanded = false,
    this.onPanelToggled,
    this.style,
    super.key,
  })  : assert(
          panel != null || (headerTitle != null && content != null),
          'Either panel or both headerTitle and content must be provided',
        ),
        panels = [
          panel ??
              ExpansionPanelItem(
                headerTitle: headerTitle!,
                content: content!,
              ),
        ],
        initialExpandedIndices = initiallyExpanded ? {0} : const {},
        allowMultipleOpen = true;

  @override
  State<AppExpansionPanel> createState() => _AppExpansionPanelState();
}

class _AppExpansionPanelState extends State<AppExpansionPanel> {
  late ValueNotifier<Set<int>> _expandedIndices;

  @override
  void initState() {
    super.initState();
    _expandedIndices = ValueNotifier<Set<int>>(widget.initialExpandedIndices);
  }

  @override
  void dispose() {
    _expandedIndices.dispose();
    super.dispose();
  }

  void _togglePanel(int index) {
    if (!widget.panels[index].canExpand || !widget.panels[index].enabled) {
      return;
    }

    final currentExpanded = Set<int>.from(_expandedIndices.value);

    if (currentExpanded.contains(index)) {
      // Close the panel
      currentExpanded.remove(index);
    } else {
      // Open the panel
      if (!widget.allowMultipleOpen) {
        currentExpanded.clear();
      }
      currentExpanded.add(index);
    }

    _expandedIndices.value = currentExpanded;
    widget.onPanelToggled?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    final style = widget.style ?? theme.expansionPanelStyle;

    return Semantics(
      label: 'Expansion Panel Group',
      child: ValueListenableBuilder<Set<int>>(
        valueListenable: _expandedIndices,
        builder: (context, expandedIndices, _) {
          return Column(
            children: List.generate(
              widget.panels.length,
              (index) => _buildPanelItem(
                context,
                index,
                style,
                expandedIndices,
                theme,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPanelItem(
    BuildContext context,
    int index,
    ExpansionPanelStyle style,
    Set<int> expandedIndices,
    AppDesignTheme theme,
  ) {
    final panel = widget.panels[index];
    final isExpanded = expandedIndices.contains(index);
    final isEnabled = panel.enabled && panel.canExpand;
    final renderer = ExpansionPanelRenderer.of(context);

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Column(
        children: [
          // Header
          AppSurface(
            variant: SurfaceVariant.base,
            interactive: isEnabled,
            onTap: isEnabled ? () => _togglePanel(index) : null,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Semantics(
              button: true,
              enabled: isEnabled,
              expanded: isExpanded,
              label: panel.headerTitle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppText(
                      panel.headerTitle,
                      variant: AppTextVariant.labelLarge,
                      color: style.headerTextColor,
                    ),
                  ),
                  renderer
                      .buildExpandIcon(
                        style.expandIcon,
                        style.headerTextColor,
                        isExpanded,
                        style.animationDuration,
                      )
                      .animate(target: isExpanded ? 1 : 0)
                      .rotate(
                        begin: 0,
                        end: 0.5,
                        duration: style.animationDuration,
                        curve: renderer.getAnimationCurve(),
                      ),
                ],
              ),
            ),
          ),
          // Expanded Content
          if (isExpanded)
            AnimatedContainer(
              duration: style.animationDuration,
              curve: renderer.getAnimationCurve(),
              color: renderer.getExpandedBackgroundColor(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppSurface(
                  variant: SurfaceVariant.base,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: panel.content,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
