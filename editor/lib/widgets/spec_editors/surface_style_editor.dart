import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/color_property.dart' as color_prop;
import '../property_editors/double_property.dart';

/// Editor widget for SurfaceStyle properties
/// Allows editing of backgroundColor, borderColor, borderWidth, borderRadius, blurStrength, shadowOpacity
class SurfaceStyleEditor extends StatefulWidget {
  final String title;
  final SurfaceStyle initialStyle;
  final ValueChanged<SurfaceStyle> onChanged;

  const SurfaceStyleEditor({
    required this.title,
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<SurfaceStyleEditor> createState() => _SurfaceStyleEditorState();
}

class _SurfaceStyleEditorState extends State<SurfaceStyleEditor> {
  late SurfaceStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  @override
  void didUpdateWidget(SurfaceStyleEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStyle != widget.initialStyle) {
      _currentStyle = widget.initialStyle;
    }
  }

  void _updateStyle(SurfaceStyle newStyle) {
    setState(() {
      _currentStyle = newStyle;
    });
    widget.onChanged(newStyle);
  }

  void _handleBackgroundColorChanged(Color color) {
    final updated = _currentStyle.copyWith(backgroundColor: color);
    _updateStyle(updated);
  }

  void _handleBorderColorChanged(Color color) {
    final updated = _currentStyle.copyWith(borderColor: color);
    _updateStyle(updated);
  }

  void _handleBorderWidthChanged(double value) {
    final updated = _currentStyle.copyWith(borderWidth: value);
    _updateStyle(updated);
  }

  void _handleBorderRadiusChanged(double value) {
    final updated = _currentStyle.copyWith(borderRadius: value);
    _updateStyle(updated);
  }

  void _handleBlurStrengthChanged(double value) {
    final updated = _currentStyle.copyWith(blurStrength: value);
    _updateStyle(updated);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Background Color
              color_prop.ColorProperty(
                label: 'Background Color',
                value: _currentStyle.backgroundColor,
                onChanged: _handleBackgroundColorChanged,
              ),
              const Gap(16),

              // Border Color
              color_prop.ColorProperty(
                label: 'Border Color',
                value: _currentStyle.borderColor,
                onChanged: _handleBorderColorChanged,
              ),
              const Gap(16),

              // Border Width
              DoubleProperty(
                label: 'Border Width',
                value: _currentStyle.borderWidth,
                min: 0,
                max: 10,
                onChanged: _handleBorderWidthChanged,
                divisions: 20,
              ),
              const Gap(16),

              // Border Radius
              DoubleProperty(
                label: 'Border Radius',
                value: _currentStyle.borderRadius,
                min: 0,
                max: 32,
                onChanged: _handleBorderRadiusChanged,
                divisions: 32,
              ),
              const Gap(16),

              // Blur Strength (for glass effect)
              DoubleProperty(
                label: 'Blur Strength',
                value: _currentStyle.blurStrength,
                min: 0,
                max: 20,
                onChanged: _handleBlurStrengthChanged,
                divisions: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
