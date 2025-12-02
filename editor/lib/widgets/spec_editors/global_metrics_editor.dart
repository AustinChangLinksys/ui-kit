import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../property_editors/double_property.dart';

/// Editor widget for global metrics (spacing factor and animation duration)
class GlobalMetricsEditor extends StatefulWidget {
  final double spacingFactor;
  final Duration animationDuration;
  final double buttonHeight;
  final ValueChanged<({double spacingFactor, Duration animationDuration, double buttonHeight})> onChanged;

  const GlobalMetricsEditor({
    required this.spacingFactor,
    required this.animationDuration,
    required this.buttonHeight,
    required this.onChanged,
    super.key,
  });

  @override
  State<GlobalMetricsEditor> createState() => _GlobalMetricsEditorState();
}

class _GlobalMetricsEditorState extends State<GlobalMetricsEditor> {
  late double _spacingFactor;
  late Duration _animationDuration;
  late double _buttonHeight;

  @override
  void initState() {
    super.initState();
    _spacingFactor = widget.spacingFactor;
    _animationDuration = widget.animationDuration;
    _buttonHeight = widget.buttonHeight;
  }

  @override
  void didUpdateWidget(GlobalMetricsEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spacingFactor != widget.spacingFactor) {
      _spacingFactor = widget.spacingFactor;
    }
    if (oldWidget.animationDuration != widget.animationDuration) {
      _animationDuration = widget.animationDuration;
    }
    if (oldWidget.buttonHeight != widget.buttonHeight) {
      _buttonHeight = widget.buttonHeight;
    }
  }

  void _notifyChanged() {
    widget.onChanged((
      spacingFactor: _spacingFactor,
      animationDuration: _animationDuration,
      buttonHeight: _buttonHeight,
    ));
  }

  void _handleSpacingFactorChanged(double value) {
    setState(() {
      _spacingFactor = value;
    });
    _notifyChanged();
  }

  void _handleAnimationDurationChanged(double milliseconds) {
    setState(() {
      _animationDuration = Duration(milliseconds: milliseconds.toInt());
    });
    _notifyChanged();
  }

  void _handleButtonHeightChanged(double value) {
    setState(() {
      _buttonHeight = value;
    });
    _notifyChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Global Metrics',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Gap(12),
        // Spacing Factor
        DoubleProperty(
          label: 'Spacing Factor',
          value: _spacingFactor,
          min: 0.5,
          max: 2.0,
          onChanged: _handleSpacingFactorChanged,
          divisions: 15,
        ),
        const Gap(16),
        // Button Height
        DoubleProperty(
          label: 'Button Height',
          value: _buttonHeight,
          min: 32.0,
          max: 64.0,
          onChanged: _handleButtonHeightChanged,
          divisions: 16,
        ),
        const Gap(16),
        // Animation Duration (in milliseconds)
        DoubleProperty(
          label: 'Animation Duration (ms)',
          value: _animationDuration.inMilliseconds.toDouble(),
          min: 100,
          max: 1000,
          onChanged: _handleAnimationDurationChanged,
          divisions: 18,
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Current: ${_animationDuration.inMilliseconds}ms',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
