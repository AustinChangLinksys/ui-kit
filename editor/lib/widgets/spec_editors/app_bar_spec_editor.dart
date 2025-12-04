import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/double_property.dart';
import 'surface_style_editor.dart';

/// Editor widget for AppBarStyle properties
class AppBarSpecEditor extends StatefulWidget {
  final AppBarStyle initialStyle;
  final ValueChanged<AppBarStyle> onChanged;

  const AppBarSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<AppBarSpecEditor> createState() => _AppBarSpecEditorState();
}

class _AppBarSpecEditorState extends State<AppBarSpecEditor> {
  late AppBarStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  @override
  void didUpdateWidget(AppBarSpecEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStyle != widget.initialStyle) {
      _currentStyle = widget.initialStyle;
    }
  }

  void _updateStyle(AppBarStyle newStyle) {
    setState(() {
      _currentStyle = newStyle;
    });
    widget.onChanged(newStyle);
  }

  void _handleHeightChanged(double value) {
    _updateStyle(_currentStyle.copyWith(height: value));
  }

  void _handleCollapsedHeightChanged(double value) {
    _updateStyle(_currentStyle.copyWith(collapsedHeight: value));
  }

  void _handleExpandedHeightChanged(double value) {
    _updateStyle(_currentStyle.copyWith(expandedHeight: value));
  }

  void _handleFlexibleSpaceBlurChanged(double value) {
    _updateStyle(_currentStyle.copyWith(flexibleSpaceBlur: value));
  }

  void _handleContainerStyleChanged(SurfaceStyle style) {
    _updateStyle(_currentStyle.copyWith(containerStyle: style));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('App Bar', style: Theme.of(context).textTheme.titleMedium),
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
                min: 48,
                max: 80,
                onChanged: _handleHeightChanged,
                divisions: 32,
              ),
              const Gap(16),

              // Collapsed Height
              DoubleProperty(
                label: 'Collapsed Height',
                value: _currentStyle.collapsedHeight,
                min: 48,
                max: 80,
                onChanged: _handleCollapsedHeightChanged,
                divisions: 32,
              ),
              const Gap(16),

              // Expanded Height
              DoubleProperty(
                label: 'Expanded Height',
                value: _currentStyle.expandedHeight,
                min: 150,
                max: 300,
                onChanged: _handleExpandedHeightChanged,
                divisions: 30,
              ),
              const Gap(16),

              // Flexible Space Blur (Glass mode)
              DoubleProperty(
                label: 'Flexible Space Blur',
                value: _currentStyle.flexibleSpaceBlur,
                min: 0,
                max: 50,
                onChanged: _handleFlexibleSpaceBlurChanged,
                divisions: 50,
              ),
              const Gap(24),

              // Container Style
              Text(
                'Container Style',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(8),
              SurfaceStyleEditor(
                title: 'AppBar Container',
                initialStyle: _currentStyle.containerStyle,
                onChanged: _handleContainerStyleChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
