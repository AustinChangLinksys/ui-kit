import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/double_property.dart';
import '../property_editors/bool_property.dart';

/// Editor widget for NavigationStyle properties
class NavigationSpecEditor extends StatefulWidget {
  final NavigationStyle initialStyle;
  final ValueChanged<NavigationStyle> onChanged;

  const NavigationSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<NavigationSpecEditor> createState() => _NavigationSpecEditorState();
}

class _NavigationSpecEditorState extends State<NavigationSpecEditor> {
  late NavigationStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  @override
  void didUpdateWidget(NavigationSpecEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStyle != widget.initialStyle) {
      _currentStyle = widget.initialStyle;
    }
  }

  void _updateStyle(NavigationStyle newStyle) {
    setState(() {
      _currentStyle = newStyle;
    });
    widget.onChanged(newStyle);
  }

  void _handleHeightChanged(double value) {
    final updated = _currentStyle.copyWith(
      height: value,
    );
    _updateStyle(updated);
  }

  void _handleIsFloatingChanged(bool value) {
    final updated = _currentStyle.copyWith(
      isFloating: value,
    );
    _updateStyle(updated);
  }

  void _handleFloatingMarginChanged(double value) {
    final updated = _currentStyle.copyWith(
      floatingMargin: value,
    );
    _updateStyle(updated);
  }

  void _handleItemSpacingChanged(double value) {
    final updated = _currentStyle.copyWith(
      itemSpacing: value,
    );
    _updateStyle(updated);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Navigation', style: Theme.of(context).textTheme.titleMedium),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Height
              DoubleProperty(
                label: 'Height',
                value: _currentStyle.height,
                min: 40,
                max: 150,
                onChanged: _handleHeightChanged,
                divisions: 22,
              ),
              const Gap(16),

              // Is Floating
              BoolProperty(
                label: 'Floating Navigation',
                value: _currentStyle.isFloating,
                onChanged: _handleIsFloatingChanged,
              ),
              const Gap(16),

              // Floating Margin
              DoubleProperty(
                label: 'Floating Margin',
                value: _currentStyle.floatingMargin,
                min: 0,
                max: 32,
                onChanged: _handleFloatingMarginChanged,
                divisions: 32,
              ),
              const Gap(16),

              // Item Spacing
              DoubleProperty(
                label: 'Item Spacing',
                value: _currentStyle.itemSpacing,
                min: 0,
                max: 16,
                onChanged: _handleItemSpacingChanged,
                divisions: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
