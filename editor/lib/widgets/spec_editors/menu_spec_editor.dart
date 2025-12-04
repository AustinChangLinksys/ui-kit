import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/double_property.dart';
import 'surface_style_editor.dart';

/// Editor widget for AppMenuStyle properties
class MenuSpecEditor extends StatefulWidget {
  final AppMenuStyle initialStyle;
  final ValueChanged<AppMenuStyle> onChanged;

  const MenuSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<MenuSpecEditor> createState() => _MenuSpecEditorState();
}

class _MenuSpecEditorState extends State<MenuSpecEditor> {
  late AppMenuStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  @override
  void didUpdateWidget(MenuSpecEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStyle != widget.initialStyle) {
      _currentStyle = widget.initialStyle;
    }
  }

  void _updateStyle(AppMenuStyle newStyle) {
    setState(() {
      _currentStyle = newStyle;
    });
    widget.onChanged(newStyle);
  }

  void _handleItemHeightChanged(double value) {
    _updateStyle(_currentStyle.copyWith(itemHeight: value));
  }

  void _handleItemHorizontalPaddingChanged(double value) {
    _updateStyle(_currentStyle.copyWith(itemHorizontalPadding: value));
  }

  void _handleIconSizeChanged(double value) {
    _updateStyle(_currentStyle.copyWith(iconSize: value));
  }

  void _handleIconLabelSpacingChanged(double value) {
    _updateStyle(_currentStyle.copyWith(iconLabelSpacing: value));
  }

  void _handleContainerStyleChanged(SurfaceStyle style) {
    _updateStyle(_currentStyle.copyWith(containerStyle: style));
  }

  void _handleItemStyleChanged(SurfaceStyle style) {
    _updateStyle(_currentStyle.copyWith(itemStyle: style));
  }

  void _handleItemHoverStyleChanged(SurfaceStyle style) {
    _updateStyle(_currentStyle.copyWith(itemHoverStyle: style));
  }

  void _handleDestructiveItemStyleChanged(SurfaceStyle style) {
    _updateStyle(_currentStyle.copyWith(destructiveItemStyle: style));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Popup Menu', style: Theme.of(context).textTheme.titleMedium),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item Height (48dp minimum for a11y)
              DoubleProperty(
                label: 'Item Height',
                value: _currentStyle.itemHeight,
                min: 40,
                max: 64,
                onChanged: _handleItemHeightChanged,
                divisions: 24,
              ),
              const Gap(16),

              // Item Horizontal Padding
              DoubleProperty(
                label: 'Item Horizontal Padding',
                value: _currentStyle.itemHorizontalPadding,
                min: 8,
                max: 24,
                onChanged: _handleItemHorizontalPaddingChanged,
                divisions: 16,
              ),
              const Gap(16),

              // Icon Size
              DoubleProperty(
                label: 'Icon Size',
                value: _currentStyle.iconSize,
                min: 16,
                max: 32,
                onChanged: _handleIconSizeChanged,
                divisions: 16,
              ),
              const Gap(16),

              // Icon Label Spacing
              DoubleProperty(
                label: 'Icon-Label Spacing',
                value: _currentStyle.iconLabelSpacing,
                min: 4,
                max: 20,
                onChanged: _handleIconLabelSpacingChanged,
                divisions: 16,
              ),
              const Gap(24),

              // Container Style
              Text(
                'Surface Styles',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(8),
              SurfaceStyleEditor(
                title: 'Menu Container',
                initialStyle: _currentStyle.containerStyle,
                onChanged: _handleContainerStyleChanged,
              ),
              const Gap(12),
              SurfaceStyleEditor(
                title: 'Menu Item',
                initialStyle: _currentStyle.itemStyle,
                onChanged: _handleItemStyleChanged,
              ),
              const Gap(12),
              SurfaceStyleEditor(
                title: 'Item Hover',
                initialStyle: _currentStyle.itemHoverStyle,
                onChanged: _handleItemHoverStyleChanged,
              ),
              const Gap(12),
              SurfaceStyleEditor(
                title: 'Destructive Item',
                initialStyle: _currentStyle.destructiveItemStyle,
                onChanged: _handleDestructiveItemStyleChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
