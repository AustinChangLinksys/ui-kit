import 'package:flutter/material.dart';

/// Widget for editing boolean values with a switch
class BoolProperty extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const BoolProperty({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  State<BoolProperty> createState() => _BoolPropertyState();
}

class _BoolPropertyState extends State<BoolProperty> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(BoolProperty oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
  }

  void _handleChanged(bool newValue) {
    setState(() {
      _value = newValue;
    });
    widget.onChanged(newValue);
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
          Switch(
            value: _value,
            onChanged: _handleChanged,
          ),
        ],
      ),
    );
  }
}
