import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Slider',
  type: AppSlider,
)
Widget buildInteractiveSlider(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0), // Leave margin for Thumb
      child: _SliderWrapper(
        initialValue: context.knobs.double.slider(
          label: 'Initial Value',
          min: 0,
          max: 100,
          initialValue: 50,
        ),
        // intOrNull allows user to switch between "continuous" and "discrete" modes
        divisions: context.knobs.intOrNull.slider(
          label: 'Divisions',
          min: 2,
          max: 20,
          initialValue: null, 
        ),
        isDisabled: context.knobs.boolean(
          label: 'Disabled',
          initialValue: false,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'All States (Static)',
  type: AppSlider,
)
Widget buildSliderStates(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32.0),
    child: Center(
      child: Column(
        children: [
          const _Header('Continuous'),
          AppSlider(value: 0.0, onChanged: (_) {}),
          const SizedBox(height: 16),
          AppSlider(value: 0.5, onChanged: (_) {}),
          const SizedBox(height: 16),
          AppSlider(value: 1.0, onChanged: (_) {}),
          
          const SizedBox(height: 32),
          const _Header('Discrete (5 Steps)'),
          AppSlider(value: 1, min: 0, max: 5, divisions: 5, onChanged: (_) {}),
          const SizedBox(height: 16),
          AppSlider(value: 2.5, min: 0, max: 5, divisions: 5, onChanged: (_) {}), // Will automatically Snap
          
          const SizedBox(height: 32),
          const _Header('Disabled'),
          const AppSlider(value: 0.5, onChanged: null),
        ],
      ),
    ),
  );
}

// --- Helpers ---

class _SliderWrapper extends StatefulWidget {
  final double initialValue;
  final int? divisions;
  final bool isDisabled;

  const _SliderWrapper({
    required this.initialValue,
    required this.divisions,
    required this.isDisabled,
  });

  @override
  State<_SliderWrapper> createState() => _SliderWrapperState();
}

class _SliderWrapperState extends State<_SliderWrapper> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  // Reset value when Knob changes
  @override
  void didUpdateWidget(covariant _SliderWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Display current value for debugging
        Text(
          _value.toStringAsFixed(1),
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        AppSlider(
          value: _value,
          min: 0,
          max: 100,
          divisions: widget.divisions,
          onChanged: widget.isDisabled
              ? null
              : (v) => setState(() => _value = v),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String text;
  const _Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
      ),
    );
  }
}