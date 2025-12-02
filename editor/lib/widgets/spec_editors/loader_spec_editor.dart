import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/double_property.dart';
import '../property_editors/enum_property.dart';
import '../property_editors/color_property.dart' as color_prop;

/// Editor widget for LoaderStyle properties
class LoaderSpecEditor extends StatefulWidget {
  final LoaderStyle initialStyle;
  final ValueChanged<LoaderStyle> onChanged;

  const LoaderSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<LoaderSpecEditor> createState() => _LoaderSpecEditorState();
}

class _LoaderSpecEditorState extends State<LoaderSpecEditor> {
  late LoaderStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  @override
  void didUpdateWidget(LoaderSpecEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStyle != widget.initialStyle) {
      _currentStyle = widget.initialStyle;
    }
  }

  void _updateStyle(LoaderStyle newStyle) {
    setState(() {
      _currentStyle = newStyle;
    });
    widget.onChanged(newStyle);
  }

  void _handleTypeChanged(LoaderType type) {
    final updated = _currentStyle.copyWith(type: type);
    _updateStyle(updated);
  }

  void _handleColorChanged(Color color) {
    final updated = _currentStyle.copyWith(color: color);
    _updateStyle(updated);
  }

  void _handleBackgroundColorChanged(Color? color) {
    final updated = _currentStyle.copyWith(backgroundColor: color);
    _updateStyle(updated);
  }

  void _handleStrokeWidthChanged(double value) {
    final updated = _currentStyle.copyWith(strokeWidth: value);
    _updateStyle(updated);
  }

  void _handleSizeChanged(double value) {
    final updated = _currentStyle.copyWith(size: value);
    _updateStyle(updated);
  }

  void _handleBorderRadiusChanged(double value) {
    final updated = _currentStyle.copyWith(borderRadius: value);
    _updateStyle(updated);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Loader', style: Theme.of(context).textTheme.titleMedium),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Loader Type
              EnumProperty<LoaderType>(
                label: 'Type',
                value: _currentStyle.type,
                options: LoaderType.values,
                onChanged: _handleTypeChanged,
                getDisplayName: (type) => type.toString().split('.').last,
              ),
              const Gap(16),

              // Color
              color_prop.ColorProperty(
                label: 'Color',
                value: _currentStyle.color ?? Colors.blue,
                onChanged: _handleColorChanged,
              ),
              const Gap(16),

              // Background Color (optional)
              if (_currentStyle.backgroundColor != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: color_prop.ColorProperty(
                    label: 'Background Color',
                    value: _currentStyle.backgroundColor!,
                    onChanged: _handleBackgroundColorChanged,
                  ),
                ),

              // Stroke Width
              DoubleProperty(
                label: 'Stroke Width',
                value: _currentStyle.strokeWidth,
                min: 1,
                max: 10,
                onChanged: _handleStrokeWidthChanged,
                divisions: 9,
              ),
              const Gap(16),

              // Size
              DoubleProperty(
                label: 'Size',
                value: _currentStyle.size,
                min: 20,
                max: 100,
                onChanged: _handleSizeChanged,
                divisions: 16,
              ),
              const Gap(16),

              // Border Radius
              DoubleProperty(
                label: 'Border Radius',
                value: _currentStyle.borderRadius,
                min: 0,
                max: 20,
                onChanged: _handleBorderRadiusChanged,
                divisions: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
