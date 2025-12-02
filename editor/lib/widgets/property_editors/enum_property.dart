import 'package:flutter/material.dart';

/// Widget for editing enum values with a dropdown
class EnumProperty<T> extends StatefulWidget {
  final String label;
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T)? getDisplayName;

  const EnumProperty({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.getDisplayName,
    super.key,
  });

  @override
  State<EnumProperty<T>> createState() => _EnumPropertyState<T>();
}

class _EnumPropertyState<T> extends State<EnumProperty<T>> {
  late T _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(EnumProperty<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedValue = widget.value;
    }
  }

  String _getDisplayName(T value) {
    if (widget.getDisplayName != null) {
      return widget.getDisplayName!(value);
    }
    return value.toString();
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
          DropdownButton<T>(
            value: _selectedValue,
            items: widget.options
                .map(
                  (T option) => DropdownMenuItem<T>(
                    value: option,
                    child: Text(_getDisplayName(option)),
                  ),
                )
                .toList(),
            onChanged: (T? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedValue = newValue;
                });
                widget.onChanged(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
