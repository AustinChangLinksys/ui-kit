import 'package:flutter/material.dart';

/// Configuration for the floating action button in AppPageView
///
/// This configuration provides easy integration with both standard FABs
/// and the UI Kit's AppExpandableFab component.
///
/// Example usage:
/// ```dart
/// AppPageView(
///   fabConfig: PageFabConfig.standard(
///     icon: Icons.add,
///     onPressed: () => _addItem(),
///   ),
///   child: MyContent(),
/// )
/// ```
///
/// For expandable FAB:
/// ```dart
/// AppPageView(
///   fabConfig: PageFabConfig.expandable(
///     children: [
///       FloatingActionButton(
///         heroTag: "fab1",
///         onPressed: () => _action1(),
///         child: const Icon(Icons.edit),
///       ),
///       FloatingActionButton(
///         heroTag: "fab2",
///         onPressed: () => _action2(),
///         child: const Icon(Icons.delete),
///       ),
///     ],
///   ),
///   child: MyContent(),
/// )
/// ```
class PageFabConfig {
  /// The type of FAB to display
  final PageFabType type;

  /// Icon for standard FAB or closed state of expandable FAB
  final IconData? icon;

  /// Icon for open state of expandable FAB
  final IconData? activeIcon;

  /// Callback for standard FAB
  final VoidCallback? onPressed;

  /// Child actions for expandable FAB
  final List<Widget>? children;

  /// Whether the expandable FAB should start open
  final bool initiallyOpen;

  /// Callback when expandable FAB is toggled
  final VoidCallback? onToggle;

  /// Custom location for the FAB
  final FloatingActionButtonLocation? location;

  /// Custom animator for the FAB
  final FloatingActionButtonAnimator? animator;

  /// Whether the FAB is enabled
  final bool enabled;

  /// Tooltip text for the FAB
  final String? tooltip;

  /// Hero tag for the FAB (useful when multiple FABs exist)
  final Object? heroTag;

  const PageFabConfig._({
    required this.type,
    this.icon,
    this.activeIcon,
    this.onPressed,
    this.children,
    this.initiallyOpen = false,
    this.onToggle,
    this.location,
    this.animator,
    this.enabled = true,
    this.tooltip,
    this.heroTag,
  });

  /// Creates a standard floating action button configuration
  factory PageFabConfig.standard({
    required IconData icon,
    required VoidCallback onPressed,
    FloatingActionButtonLocation? location,
    FloatingActionButtonAnimator? animator,
    bool enabled = true,
    String? tooltip,
    Object? heroTag,
  }) {
    return PageFabConfig._(
      type: PageFabType.standard,
      icon: icon,
      onPressed: onPressed,
      location: location,
      animator: animator,
      enabled: enabled,
      tooltip: tooltip,
      heroTag: heroTag,
    );
  }

  /// Creates an expandable floating action button configuration
  factory PageFabConfig.expandable({
    required List<Widget> children,
    IconData? icon,
    IconData? activeIcon,
    bool initiallyOpen = false,
    VoidCallback? onToggle,
    FloatingActionButtonLocation? location,
    FloatingActionButtonAnimator? animator,
    bool enabled = true,
    String? tooltip,
    Object? heroTag,
  }) {
    return PageFabConfig._(
      type: PageFabType.expandable,
      icon: icon,
      activeIcon: activeIcon,
      children: children,
      initiallyOpen: initiallyOpen,
      onToggle: onToggle,
      location: location,
      animator: animator,
      enabled: enabled,
      tooltip: tooltip,
      heroTag: heroTag,
    );
  }

  /// Creates a mini floating action button configuration
  factory PageFabConfig.mini({
    required IconData icon,
    required VoidCallback onPressed,
    FloatingActionButtonLocation? location,
    FloatingActionButtonAnimator? animator,
    bool enabled = true,
    String? tooltip,
    Object? heroTag,
  }) {
    return PageFabConfig._(
      type: PageFabType.mini,
      icon: icon,
      onPressed: onPressed,
      location: location,
      animator: animator,
      enabled: enabled,
      tooltip: tooltip,
      heroTag: heroTag,
    );
  }

  /// Creates a custom FAB configuration with a provided widget
  factory PageFabConfig.custom({
    required Widget fab,
    FloatingActionButtonLocation? location,
    FloatingActionButtonAnimator? animator,
  }) {
    return PageFabConfig._(
      type: PageFabType.custom,
      location: location,
      animator: animator,
    );
  }
}

/// Types of floating action buttons supported
enum PageFabType {
  /// Standard FAB with a single action
  standard,

  /// Mini FAB (smaller size)
  mini,

  /// Expandable FAB with multiple satellite actions
  expandable,

  /// Custom FAB widget
  custom,
}