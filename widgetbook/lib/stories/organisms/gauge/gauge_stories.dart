import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'Speed Test Animation',
  type: AppGauge,
)
Widget appGaugeSpeedTestUseCase(BuildContext context) {
  return const Center(
    child: _SpeedTestGauge(),
  );
}

class _SpeedTestGauge extends StatefulWidget {
  const _SpeedTestGauge();

  @override
  State<_SpeedTestGauge> createState() => _SpeedTestGaugeState();
}

class _SpeedTestGaugeState extends State<_SpeedTestGauge> {
  double _currentSpeed = 0;
  double _peakSpeed = 0;
  bool _isTesting = false;
  String _status = 'Tap to start';
  Timer? _timer;
  final _random = Random();

  void _startSpeedTest() {
    if (_isTesting) return;

    setState(() {
      _isTesting = true;
      _currentSpeed = 0;
      _peakSpeed = 0;
      _status = 'Connecting...';
    });

    // Simulate connection delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() => _status = 'Testing download...');
      _runSpeedSimulation();
    });
  }

  void _runSpeedSimulation() {
    int tick = 0;
    const totalTicks = 60; // ~3 seconds at 50ms intervals

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      tick++;

      // Simulate speed test behavior: ramp up, fluctuate, then settle
      double targetSpeed;
      if (tick < 15) {
        // Ramp up phase
        targetSpeed = (tick / 15) * 80 + _random.nextDouble() * 20;
      } else if (tick < 45) {
        // Fluctuation phase - vary between 60-95
        targetSpeed = 70 + _random.nextDouble() * 25 + sin(tick * 0.3) * 10;
      } else {
        // Settling phase - converge to final value
        targetSpeed = 75 + _random.nextDouble() * 10;
      }

      setState(() {
        _currentSpeed = targetSpeed.clamp(0, 100);
        if (_currentSpeed > _peakSpeed) {
          _peakSpeed = _currentSpeed;
        }
      });

      if (tick >= totalTicks) {
        timer.cancel();
        setState(() {
          _isTesting = false;
          _status = 'Complete';
        });

        // Reset after delay
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _status = 'Tap to start');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isTesting ? null : _startSpeedTest,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppGauge(
            value: _currentSpeed,
            size: 280,
            markers: const [0, 20, 40, 60, 80, 100],
            displayIndicatorValues: true,
            centerBuilder: (context, val) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.displaySmall(
                  _currentSpeed.toStringAsFixed(1),
                ),
                AppText.bodySmall('Mbps'),
              ],
            ),
            bottomBuilder: (context, val) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppText.bodyMedium(_status),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatCard(label: 'Peak', value: '${_peakSpeed.toStringAsFixed(1)} Mbps'),
              const SizedBox(width: 16),
              _StatCard(label: 'Status', value: _isTesting ? 'Testing' : 'Idle'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      variant: SurfaceVariant.base,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          AppText.labelSmall(label),
          AppText.bodyMedium(value),
        ],
      ),
    );
  }
}

@UseCase(
  name: 'Default',
  type: AppGauge,
)
Widget appGaugeUseCase(BuildContext context) {
  final value = context.knobs.double.slider(
    label: 'Value (0 - 100)',
    initialValue: 75,
    min: 0.0,
    max: 100.0,
  );

  final showMarkers = context.knobs.boolean(
    label: 'Show Markers',
    initialValue: true,
  );

  final displayValues = context.knobs.boolean(
    label: 'Display Marker Values',
    initialValue: true,
  );

  return Center(
    child: AppGauge(
      value: value,
      size: 240,
      markers: showMarkers ? const [0, 20, 40, 60, 80, 100] : const [],
      displayIndicatorValues: displayValues,
      centerBuilder: (context, val) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.headlineLarge('${val.toInt()}'),
          AppText.bodySmall('Mbps'),
        ],
      ),
      bottomBuilder: (context, val) => AppText.bodyMedium('Signal Strength'),
    ),
  );
}

@UseCase(
  name: 'With Default Markers',
  type: AppGauge,
)
Widget appGaugeWithDefaultMarkersUseCase(BuildContext context) {
  final value = context.knobs.double.slider(
    label: 'Value (0 - 100)',
    initialValue: 65,
    min: 0.0,
    max: 100.0,
  );

  return Center(
    child: AppGauge.withDefaultMarkers(
      value: value,
      size: 280,
      centerBuilder: (context, val) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.headlineLarge('${val.toInt()}%'),
          AppText.bodySmall('Complete'),
        ],
      ),
    ),
  );
}

@UseCase(
  name: 'Minimal (No Markers)',
  type: AppGauge,
)
Widget appGaugeMinimalUseCase(BuildContext context) {
  final value = context.knobs.double.slider(
    label: 'Value (0.0 - 1.0)',
    initialValue: 0.5,
    min: 0.0,
    max: 1.0,
  );

  return Center(
    child: AppGauge(
      value: value * 100, // Convert to 0-100 range
      size: 200,
      displayIndicatorValues: false,
      centerBuilder: (context, val) => AppText.displaySmall(
        '${(val / 100 * 100).toInt()}%',
      ),
    ),
  );
}
