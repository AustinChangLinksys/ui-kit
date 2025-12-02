import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../property_editors/double_property.dart';

/// Editor widget for global metrics (spacing factor and animation duration)
class GlobalMetricsEditor extends StatefulWidget {
  final double spacingFactor;
  final Duration animationDuration;
  final ValueChanged<({double spacingFactor, Duration animationDuration})> onChanged;

  const GlobalMetricsEditor({
    required this.spacingFactor,
    required this.animationDuration,
    required this.onChanged,
    super.key,
  });

  @override
  State<GlobalMetricsEditor> createState() => _GlobalMetricsEditorState();
}

class _GlobalMetricsEditorState extends State<GlobalMetricsEditor> {
  late double _spacingFactor;
  late Duration _animationDuration;

  @override
  void initState() {
    super.initState();
    _spacingFactor = widget.spacingFactor;
    _animationDuration = widget.animationDuration;
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
  }

  void _handleSpacingFactorChanged(double value) {
    setState(() {
      _spacingFactor = value;
    });
    widget.onChanged((
      spacingFactor: _spacingFactor,
      animationDuration: _animationDuration,
    ));
  }

  void _handleAnimationDurationChanged(double milliseconds) {
    setState(() {
      _animationDuration = Duration(milliseconds: milliseconds.toInt());
    });
    widget.onChanged((
      spacingFactor: _spacingFactor,
      animationDuration: _animationDuration,
    ));
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
