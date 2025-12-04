import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/double_property.dart';
import '../property_editors/color_property.dart' as color_property;
import 'surface_style_editor.dart';

/// Editor widget for DialogStyle properties
class DialogSpecEditor extends StatefulWidget {
  final DialogStyle initialStyle;
  final ValueChanged<DialogStyle> onChanged;

  const DialogSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<DialogSpecEditor> createState() => _DialogSpecEditorState();
}

class _DialogSpecEditorState extends State<DialogSpecEditor> {
  late DialogStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  @override
  void didUpdateWidget(DialogSpecEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStyle != widget.initialStyle) {
      _currentStyle = widget.initialStyle;
    }
  }

  void _updateStyle(DialogStyle newStyle) {
    setState(() {
      _currentStyle = newStyle;
    });
    widget.onChanged(newStyle);
  }

  void _handleBarrierColorChanged(Color value) {
    _updateStyle(_currentStyle.copyWith(barrierColor: value));
  }

  void _handleBarrierBlurChanged(double value) {
    _updateStyle(_currentStyle.copyWith(barrierBlur: value));
  }

  void _handleMaxWidthChanged(double value) {
    _updateStyle(_currentStyle.copyWith(maxWidth: value));
  }

  void _handleButtonSpacingChanged(double value) {
    _updateStyle(_currentStyle.copyWith(buttonSpacing: value));
  }

  void _handleContainerStyleChanged(SurfaceStyle style) {
    _updateStyle(_currentStyle.copyWith(containerStyle: style));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Dialog', style: Theme.of(context).textTheme.titleMedium),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barrier Color
              color_property.ColorProperty(
                label: 'Barrier Color',
                value: _currentStyle.barrierColor,
                onChanged: _handleBarrierColorChanged,
              ),
              const Gap(16),

              // Barrier Blur (Glass mode)
              DoubleProperty(
                label: 'Barrier Blur',
                value: _currentStyle.barrierBlur,
                min: 0,
                max: 30,
                onChanged: _handleBarrierBlurChanged,
                divisions: 30,
              ),
              const Gap(16),

              // Max Width
              DoubleProperty(
                label: 'Max Width',
                value: _currentStyle.maxWidth,
                min: 280,
                max: 560,
                onChanged: _handleMaxWidthChanged,
                divisions: 28,
              ),
              const Gap(16),

              // Button Spacing
              DoubleProperty(
                label: 'Button Spacing',
                value: _currentStyle.buttonSpacing,
                min: 0,
                max: 24,
                onChanged: _handleButtonSpacingChanged,
                divisions: 24,
              ),
              const Gap(24),

              // Container Style
              Text(
                'Container Style',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(8),
              SurfaceStyleEditor(
                title: 'Dialog Container',
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
