import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class NoiseOverlay extends StatefulWidget {
  final int? seed;

  const NoiseOverlay({super.key, this.seed});

  @override
  State<NoiseOverlay> createState() => _NoiseOverlayState();
}

class _NoiseOverlayState extends State<NoiseOverlay>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late final math.Random _random = math.Random(widget.seed);
  ui.Image? _noiseImage;
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _generateNoiseImage();
    _ticker = createTicker((elapsed) {
      setState(() {
        // Shift offset to animate noise
        _offset = _random.nextDouble() * 100; 
      });
    });
    _ticker.start();
  }

  Future<void> _generateNoiseImage() async {
    // Create a small noise texture to tile
    const int size = 64;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint()..color = Colors.white.withValues(alpha: 0.1);

    for (int i = 0; i < size * size * 0.4; i++) { // 40% density
      final double x = _random.nextDouble() * size;
      final double y = _random.nextDouble() * size;
      canvas.drawRect(Rect.fromLTWH(x, y, 1, 1), paint);
    }

    final ui.Image image = await recorder.endRecording().toImage(size, size);
    if (mounted) {
      setState(() {
        _noiseImage = image;
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _noiseImage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Reduced Motion check
    final isReducedMotion = MediaQuery.of(context).disableAnimations;
    if (isReducedMotion) return const SizedBox.shrink();

    if (_noiseImage == null) return const SizedBox.shrink();

    return CustomPaint(
      painter: _NoiseTexturePainter(
        image: _noiseImage!,
        offset: _offset,
        opacity: 0.05, // Very subtle
      ),
      size: Size.infinite,
    );
  }
}

class _NoiseTexturePainter extends CustomPainter {
  final ui.Image image;
  final double offset;
  final double opacity;

  _NoiseTexturePainter({
    required this.image,
    required this.offset,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black.withValues(alpha: opacity)
      ..blendMode = BlendMode.overlay
      ..shader = ImageShader(
        image,
        TileMode.repeated,
        TileMode.repeated,
        Matrix4.translationValues(offset, offset, 0.0).storage,
      );

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _NoiseTexturePainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.image != image;
  }
}
