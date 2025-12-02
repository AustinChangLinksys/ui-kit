import 'package:flutter/material.dart';

/// Widget for editing double (numeric) values with slider and keyboard input
class DoubleProperty extends StatefulWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final int? divisions;

  const DoubleProperty({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.divisions,
    super.key,
  });

  @override
  State<DoubleProperty> createState() => _DoublePropertyState();
}

class _DoublePropertyState extends State<DoubleProperty> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.value.toStringAsFixed(2));
  }

  @override
  void didUpdateWidget(DoubleProperty oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _textController.text = widget.value.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleTextChanged(String text) {
    final parsed = double.tryParse(text);
    if (parsed != null) {
      final clamped = parsed.clamp(widget.min, widget.max);
      widget.onChanged(clamped);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label and value display
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label, style: Theme.of(context).textTheme.labelMedium),
              Text(
                widget.value.toStringAsFixed(2),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Slider
        Slider(
          value: widget.value.clamp(widget.min, widget.max),
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          onChanged: widget.onChanged,
        ),
        const SizedBox(height: 8),
        // Text field for precise input
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Value',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: _handleTextChanged,
          ),
        ),
      ],
    );
  }
}
