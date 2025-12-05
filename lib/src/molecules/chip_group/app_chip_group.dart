import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Configuration for individual chip items
class ChipItem {
  /// Label displayed on the chip
  final String label;

  /// Optional icon for the chip
  final IconData? icon;

  /// Whether this chip is enabled
  final bool enabled;

  const ChipItem({
    required this.label,
    this.icon,
    this.enabled = true,
  });
}

/// Selection mode for chip group
enum ChipSelectionMode {
  /// Only one chip can be selected at a time
  single,

  /// Multiple chips can be selected
  multiple,
}

/// AppChipGroup provides quick filtering interface with selectable chips
///
/// Features:
/// - Theme-aware styling with AppSurface for chip backgrounds
/// - Single or multiple selection modes
/// - Keyboard navigation support
/// - Accessibility: proper semantics for selection state
///
/// Usage:
/// ```dart
/// AppChipGroup(
///   chips: [
///     ChipItem(label: 'All'),
///     ChipItem(label: 'Active'),
///     ChipItem(label: 'Completed'),
///   ],
///   selectedIndices: {0},
///   onSelectionChanged: (indices) => print('Selected: $indices'),
/// )
/// ```
class AppChipGroup extends StatefulWidget {
  /// List of chip items
  final List<ChipItem> chips;

  /// Currently selected chip indices
  final Set<int> selectedIndices;

  /// Selection mode (single or multiple)
  final ChipSelectionMode selectionMode;

  /// Callback when selection changes
  final ValueChanged<Set<int>>? onSelectionChanged;

  /// Optional style override
  final ChipGroupStyle? style;

  /// Spacing between chips
  final double spacing;

  /// Whether chips should wrap to next line
  final bool wrap;

  const AppChipGroup({
    super.key,
    required this.chips,
    this.selectedIndices = const {},
    this.selectionMode = ChipSelectionMode.single,
    this.onSelectionChanged,
    this.style,
    this.spacing = 8.0,
    this.wrap = true,
  });

  @override
  State<AppChipGroup> createState() => _AppChipGroupState();
}

class _AppChipGroupState extends State<AppChipGroup> {
  late ChipGroupStyle _style;
  late Set<int> _selectedIndices;

  @override
  void initState() {
    super.initState();
    _selectedIndices = Set.from(widget.selectedIndices);
  }

  @override
  void didUpdateWidget(AppChipGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndices != oldWidget.selectedIndices) {
      _selectedIndices = Set.from(widget.selectedIndices);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Constitution 4.1: AppDesignTheme is single source of truth
    final theme = Theme.of(context).extension<AppDesignTheme>();
    assert(
      theme != null,
      'AppChipGroup requires DesignSystem initialization. '
      'Call DesignSystem.init() in MaterialApp.builder.',
    );
    _style = widget.style ?? theme!.chipGroupStyle;
  }

  void _toggleChip(int index) {
    if (!widget.chips[index].enabled) return;

    setState(() {
      if (widget.selectionMode == ChipSelectionMode.single) {
        _selectedIndices = {index};
      } else {
        if (_selectedIndices.contains(index)) {
          _selectedIndices.remove(index);
        } else {
          _selectedIndices.add(index);
        }
      }
    });

    widget.onSelectionChanged?.call(Set.from(_selectedIndices));
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Filter chips, ${widget.chips.length} options',
      child: widget.wrap
          ? Wrap(
              spacing: widget.spacing,
              runSpacing: widget.spacing,
              children: _buildChips(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildChipsWithSpacing(),
              ),
            ),
    );
  }

  List<Widget> _buildChips() {
    return List.generate(
      widget.chips.length,
      (index) => _buildChip(index),
    );
  }

  List<Widget> _buildChipsWithSpacing() {
    final chips = <Widget>[];
    for (int i = 0; i < widget.chips.length; i++) {
      chips.add(_buildChip(i));
      if (i < widget.chips.length - 1) {
        chips.add(SizedBox(width: widget.spacing));
      }
    }
    return chips;
  }

  Widget _buildChip(int index) {
    final chip = widget.chips[index];
    final isSelected = _selectedIndices.contains(index);
    final isEnabled = chip.enabled;

    return Semantics(
      label: chip.label,
      selected: isSelected,
      enabled: isEnabled,
      button: true,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: GestureDetector(
          onTap: isEnabled ? () => _toggleChip(index) : null,
          child: AppSurface(
            variant: isSelected ? SurfaceVariant.highlight : SurfaceVariant.elevated,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isSelected
                    ? _style.selectedBackground
                    : _style.unselectedBackground,
                borderRadius: BorderRadius.circular(_style.borderRadius),
                border: isSelected
                    ? Border.all(color: _style.selectedBorderColor, width: 2)
                    : null,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (chip.icon != null) ...[
                    Icon(
                      chip.icon,
                      size: 16,
                      color: isSelected
                          ? _style.selectedText
                          : _style.unselectedText,
                    ),
                    const SizedBox(width: 6),
                  ],
                  AppText(
                    chip.label,
                    color: isSelected
                        ? _style.selectedText
                        : _style.unselectedText,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
