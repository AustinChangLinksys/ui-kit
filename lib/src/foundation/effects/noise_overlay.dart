import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Noise overlay effect for Glass theme.
/// Uses a pre-generated cached texture for performance.
class NoiseOverlay extends StatefulWidget {
  final int? seed;

  /// Opacity of the noise effect (0.0 - 1.0)
  /// Default is 0.06 for subtle film grain effect
  final double opacity;

  const NoiseOverlay({
    super.key,
    this.seed,
    this.opacity = 0.06,
  });

  @override
  State<NoiseOverlay> createState() => _NoiseOverlayState();
}

class _NoiseOverlayState extends State<NoiseOverlay> {
  ui.Image? _noiseTexture;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _generateNoiseTexture();
  }

  @override
  void dispose() {
    _noiseTexture?.dispose();
    super.dispose();
  }

  /// Generate a small tileable noise texture (once)
  Future<void> _generateNoiseTexture() async {
    if (_isGenerating) return;
    _isGenerating = true;

    const int size = 64; // Small texture that tiles
    final random = math.Random(widget.seed ?? 42);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // No background - transparent base

    // Draw noise pattern
    // White dots subtle, black dots more prominent for film grain
    final whitePaint = Paint()..color = Colors.white.withValues(alpha: 0.3);
    final blackPaint = Paint()..color = Colors.black.withValues(alpha: 0.7);

    // Film grain effect
    for (int i = 0; i < size * size ~/ 5; i++) {
      final x = random.nextDouble() * size;
      final y = random.nextDouble() * size;
      final dotSize = 0.8 + random.nextDouble() * 0.6;
      final useDark = random.nextBool();

      canvas.drawRect(
        Rect.fromLTWH(x, y, dotSize, dotSize),
        useDark ? blackPaint : whitePaint,
      );
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(size, size);

    if (mounted) {
      setState(() {
        _noiseTexture = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Adjust opacity based on brightness
    // Dark mode needs stronger effect to be visible
    final brightness = Theme.of(context).brightness;
    final effectiveOpacity = brightness == Brightness.dark
        ? widget.opacity * 2.5  // Stronger for dark mode
        : widget.opacity;       // Subtle for light mode

    if (_noiseTexture == null) {
      // Show static fallback while texture loads
      return CustomPaint(
        painter: _StaticNoisePainter(
          seed: widget.seed ?? 42,
          opacity: effectiveOpacity,
        ),
        size: Size.infinite,
      );
    }

    return CustomPaint(
      painter: _TiledNoisePainter(
        texture: _noiseTexture!,
        opacity: effectiveOpacity,
      ),
      size: Size.infinite,
    );
  }
}

/// Paints a tiled noise texture (very fast, uses GPU)
class _TiledNoisePainter extends CustomPainter {
  final ui.Image texture;
  final double opacity;

  _TiledNoisePainter({
    required this.texture,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = ImageShader(
        texture,
        TileMode.repeated,
        TileMode.repeated,
        Matrix4.identity().storage,
      )
      ..colorFilter = ColorFilter.mode(
        Colors.white.withValues(alpha: opacity),
        BlendMode.modulate,
      );

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _TiledNoisePainter oldDelegate) {
    return oldDelegate.texture != texture || oldDelegate.opacity != opacity;
  }
}

/// Static fallback noise painter (used only during initial load)
class _StaticNoisePainter extends CustomPainter {
  final int seed;
  final double opacity;

  _StaticNoisePainter({
    required this.seed,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(seed);
    final paint = Paint()..color = Colors.white.withValues(alpha: opacity * 0.5);
    final darkPaint = Paint()..color = Colors.black.withValues(alpha: opacity * 0.4);

    // Sparse noise for performance (larger grid)
    const double gridSize = 8.0;
    final int cols = (size.width / gridSize).ceil();
    final int rows = (size.height / gridSize).ceil();

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (random.nextDouble() < 0.2) {
          final x = col * gridSize + random.nextDouble() * gridSize;
          final y = row * gridSize + random.nextDouble() * gridSize;
          canvas.drawRect(
            Rect.fromLTWH(x, y, 1.5, 1.5),
            random.nextBool() ? darkPaint : paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StaticNoisePainter oldDelegate) => false;
}
