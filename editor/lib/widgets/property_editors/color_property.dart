import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

/// Widget for editing Color values with color picker
class ColorProperty extends StatefulWidget {
  final String label;
  final Color value;
  final ValueChanged<Color> onChanged;

  const ColorProperty({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  State<ColorProperty> createState() => _ColorPropertyState();
}

class _ColorPropertyState extends State<ColorProperty> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.value;
  }

  @override
  void didUpdateWidget(ColorProperty oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedColor = widget.value;
    }
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.label),
          content: SingleChildScrollView(
            child: ColorPicker(
              color: _selectedColor,
              onColorChanged: (Color color) {
                _selectedColor = color;
              },
              width: 40,
              height: 40,
              borderRadius: 4,
              spacing: 15,
              runSpacing: 15,
              wheelDiameter: 155,
              heading: Text(
                'Select color',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subheading: Text(
                'Select color shade',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              wheelSubheading: Text(
                'Color',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              showMaterialName: true,
              showColorCode: true,
              showColorName: true,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
                ColorPickerType.bw: false,
                ColorPickerType.custom: true,
                ColorPickerType.wheel: true,
              },
              customColorSwatchesAndNames: const {},
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.onChanged(_selectedColor);
                Navigator.pop(context);
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const Spacer(),
          GestureDetector(
            onTap: _showColorPicker,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: widget.value,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
