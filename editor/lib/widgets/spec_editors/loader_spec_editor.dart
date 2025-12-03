import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/double_property.dart';
import '../property_editors/enum_property.dart';
import 'color_info_display.dart';

/// Editor widget for LoaderStyle properties
/// Allows editing of all 8 LoaderStyle parameters:
/// type, color, backgroundColor, strokeWidth, size, period, shadows, borderRadius
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

  void _handleStrokeWidthChanged(double value) {
    final updated = _currentStyle.copyWith(strokeWidth: value);
    _updateStyle(updated);
  }

  void _handleSizeChanged(double value) {
    final updated = _currentStyle.copyWith(size: value);
    _updateStyle(updated);
  }

  void _handlePeriodChanged(double milliseconds) {
    final updated = _currentStyle.copyWith(
      period: Duration(milliseconds: milliseconds.toInt()),
    );
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
      subtitle: Text(
        '8 parameters',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
      ),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Loader Type
              EnumProperty<LoaderType>(
                label: 'Type',
                value: _currentStyle.type,
                options: LoaderType.values,
                onChanged: _handleTypeChanged,
                getDisplayName: (type) => type.toString().split('.').last,
              ),
              const Gap(16),

              // 2. Color - Read-only (managed via Colors tab)
              ColorInfoDisplay(
                label: 'Color',
                color: _currentStyle.color ?? Colors.blue,
                sourceColor: 'scheme.primary (all themes)',
                note: 'Modify in Colors tab → Primary',
              ),
              const Gap(16),

              // 3. Background Color (optional) - Read-only (managed via Colors tab)
              if (_currentStyle.backgroundColor != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ColorInfoDisplay(
                    label: 'Background Color',
                    color: _currentStyle.backgroundColor!,
                    sourceColor: 'Set via theme implementation',
                    note: 'Modify in Colors tab to change scheme colors',
                  ),
                ),

              // 4. Stroke Width
              DoubleProperty(
                label: 'Stroke Width',
                value: _currentStyle.strokeWidth,
                min: 1,
                max: 10,
                onChanged: _handleStrokeWidthChanged,
                divisions: 9,
              ),
              const Gap(16),

              // 5. Size
              DoubleProperty(
                label: 'Size',
                value: _currentStyle.size,
                min: 20,
                max: 100,
                onChanged: _handleSizeChanged,
                divisions: 16,
              ),
              const Gap(16),

              // 6. Period (Animation duration in milliseconds)
              DoubleProperty(
                label: 'Period (milliseconds)',
                value: _currentStyle.period.inMilliseconds.toDouble(),
                min: 400,
                max: 3000,
                onChanged: _handlePeriodChanged,
                divisions: 26,
              ),
              const Gap(16),

              // 7. Shadows (read-only info)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Box Shadows',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${_currentStyle.shadows.length} shadow(s)',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      'Shadows set via theme implementations',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),
              const Gap(16),

              // 8. Border Radius
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
