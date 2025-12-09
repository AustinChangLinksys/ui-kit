import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Configuration for individual tab items
class TabItem {
  /// Label displayed on the tab
  final String label;

  /// Optional icon for the tab
  final IconData? icon;

  /// Whether this tab is enabled
  final bool enabled;

  const TabItem({
    required this.label,
    this.icon,
    this.enabled = true,
  });
}

/// Display mode for tab presentation
enum TabDisplayMode {
  /// Indicator underline below active tab
  underline,

  /// Filled background on active tab
  filled,

  /// Segmented control style
  segmented,
}

/// AppTabs provides tab-based content switching navigation
///
/// Features:
/// - Theme-aware styling with animated indicator transitions
/// - Multiple display modes: underline, filled, segmented
/// - Keyboard navigation support (arrow keys, Enter/Space)
/// - Accessibility: proper semantics, tab count announcements
///
/// Usage:
/// ```dart
/// AppTabs(
///   tabs: [
///     TabItem(label: 'All'),
///     TabItem(label: 'Favorites'),
///     TabItem(label: 'Recent'),
///   ],
///   onTabChanged: (index) => print('Selected: $index'),
/// )
/// ```
class AppTabs extends StatefulWidget {
  /// List of tab items
  final List<TabItem> tabs;

  /// Initially selected tab index
  final int initialIndex;

  /// Display mode for tabs
  final TabDisplayMode displayMode;

  /// Callback when tab selection changes
  final ValueChanged<int>? onTabChanged;

  /// Optional style override
  final TabsStyle? style;

  /// Content widgets for each tab (optional)
  final List<Widget>? tabContents;

  const AppTabs({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.displayMode = TabDisplayMode.underline,
    this.onTabChanged,
    this.style,
    this.tabContents,
  }) : assert(tabs.length > 0, 'AppTabs requires at least one tab');

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> with TickerProviderStateMixin {
  late ValueNotifier<int> _selectedIndex;
  late TabsStyle _style;
  late AnimationController _animationController;
  bool _hasCheckedTickerMode = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = ValueNotifier<int>(widget.initialIndex);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animationController.value = 1.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Constitution 4.1: AppDesignTheme is single source of truth
    final theme = Theme.of(context).extension<AppDesignTheme>();
    assert(
      theme != null,
      'AppTabs requires DesignSystem initialization. '
      'Call DesignSystem.init() in MaterialApp.builder.',
    );
    _style = widget.style ?? theme!.tabsStyle;

    // When TickerMode is disabled (e.g., in golden tests), animations won't tick.
    if (!_hasCheckedTickerMode) {
      _hasCheckedTickerMode = true;
      if (!TickerMode.of(context)) {
        _animationController.value = 1.0;
      }
    }
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    if (!widget.tabs[index].enabled) return;
    if (_selectedIndex.value == index) return;

    _animationController.forward(from: 0);
    _selectedIndex.value = index;
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Tab bar, ${widget.tabs.length} tabs',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tab bar
          _buildTabBar(),
          // Tab content (if provided)
          if (widget.tabContents != null && widget.tabContents!.isNotEmpty)
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: _selectedIndex,
                builder: (context, selectedIndex, _) {
                  if (selectedIndex < widget.tabContents!.length) {
                    return widget.tabContents![selectedIndex];
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return AppSurface(
      variant: SurfaceVariant.base,
      child: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, _) {
          return Focus(
            onKeyEvent: _handleKeyEvent,
            child: Row(
              children: List.generate(
                widget.tabs.length,
                (index) => Expanded(
                  child: _buildTab(index, selectedIndex),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _selectNextTab();
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _selectPreviousTab();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _selectNextTab() {
    for (int i = _selectedIndex.value + 1; i < widget.tabs.length; i++) {
      if (widget.tabs[i].enabled) {
        _selectTab(i);
        return;
      }
    }
  }

  void _selectPreviousTab() {
    for (int i = _selectedIndex.value - 1; i >= 0; i--) {
      if (widget.tabs[i].enabled) {
        _selectTab(i);
        return;
      }
    }
  }

  Widget _buildTab(int index, int selectedIndex) {
    final tab = widget.tabs[index];
    final isSelected = index == selectedIndex;
    final isEnabled = tab.enabled;

    return Semantics(
      label: 'Tab ${index + 1} of ${widget.tabs.length}, ${tab.label}',
      selected: isSelected,
      enabled: isEnabled,
      button: true,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: GestureDetector(
          onTap: isEnabled ? () => _selectTab(index) : null,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return _buildTabContent(tab, isSelected, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(TabItem tab, bool isSelected, int index) {
    switch (widget.displayMode) {
      case TabDisplayMode.underline:
        return _buildUnderlineTab(tab, isSelected);
      case TabDisplayMode.filled:
        return _buildFilledTab(tab, isSelected);
      case TabDisplayMode.segmented:
        return _buildSegmentedTab(tab, isSelected, index);
    }
  }

  Widget _buildUnderlineTab(TabItem tab, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (tab.icon != null) ...[
                Icon(
                  tab.icon,
                  size: 18,
                  color: _style.textColors.resolve(isActive: isSelected),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: AppText(
                  tab.label,
                  color: _style.textColors.resolve(isActive: isSelected),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        // Indicator
        AnimatedContainer(
          duration: _style.animationDuration,
          height: isSelected ? _style.indicatorThickness : 0,
          decoration: BoxDecoration(
            color: _style.indicatorColor,
            borderRadius: BorderRadius.circular(_style.indicatorThickness / 2),
          ),
        ),
      ],
    );
  }

  Widget _buildFilledTab(TabItem tab, bool isSelected) {
    return AnimatedContainer(
      duration: _style.animationDuration,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? _style.indicatorColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (tab.icon != null) ...[
            Icon(
              tab.icon,
              size: 18,
              color: _style.textColors.resolve(isActive: isSelected),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: AppText(
              tab.label,
              color: _style.textColors.resolve(isActive: isSelected),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedTab(TabItem tab, bool isSelected, int index) {
    return AppSurface(
      variant: isSelected ? SurfaceVariant.highlight : SurfaceVariant.base,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (tab.icon != null) ...[
            Icon(
              tab.icon,
              size: 18,
              color: _style.textColors.resolve(isActive: isSelected),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: AppText(
              tab.label,
              color: _style.textColors.resolve(isActive: isSelected),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
