import 'package:flutter/material.dart';

/// CRT monitor effect overlay for Pixel theme.
///
/// Renders classic CRT monitor effects including:
/// - Horizontal scanlines
/// - RGB phosphor subpixel pattern
/// - Edge vignette darkening
/// - Screen curvature highlight
class CrtOverlay extends StatelessWidget {
  /// Spacing between scanlines in logical pixels.
  final double scanlineSpacing;

  /// Opacity of the scanlines (0.0 - 1.0).
  final double scanlineOpacity;

  /// Opacity of the RGB phosphor effect (0.0 - 1.0).
  final double phosphorOpacity;

  /// Opacity of the vignette edge darkening (0.0 - 1.0).
  final double vignetteOpacity;

  const CrtOverlay({
    super.key,
    this.scanlineSpacing = 3.0,
    this.scanlineOpacity = 0.15,
    this.phosphorOpacity = 0.08,
    this.vignetteOpacity = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildScanlines(),
        _buildPhosphor(),
        _buildVignette(),
        _buildScreenHighlight(),
      ],
    );
  }

  Widget _buildScanlines() {
    return CustomPaint(
      painter: _ScanlinePainter(
        lineSpacing: scanlineSpacing,
        lineOpacity: scanlineOpacity,
      ),
      size: Size.infinite,
    );
  }

  Widget _buildPhosphor() {
    return CustomPaint(
      painter: _PhosphorPainter(opacity: phosphorOpacity),
      size: Size.infinite,
    );
  }

  Widget _buildVignette() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: vignetteOpacity),
          ],
          stops: const [0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildScreenHighlight() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.03),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3],
        ),
      ),
    );
  }
}

/// Paints horizontal scanlines for CRT effect.
class _ScanlinePainter extends CustomPainter {
  final double lineSpacing;
  final double lineOpacity;

  const _ScanlinePainter({
    required this.lineSpacing,
    required this.lineOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: lineOpacity)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScanlinePainter oldDelegate) =>
      oldDelegate.lineSpacing != lineSpacing ||
      oldDelegate.lineOpacity != lineOpacity;
}

/// Paints RGB phosphor subpixel pattern for CRT effect.
class _PhosphorPainter extends CustomPainter {
  final double opacity;

  const _PhosphorPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final redPaint = Paint()..color = Colors.red.withValues(alpha: opacity);
    final greenPaint = Paint()..color = Colors.green.withValues(alpha: opacity);
    final bluePaint = Paint()..color = Colors.blue.withValues(alpha: opacity);

    const double pixelWidth = 3.0;
    const double subPixelWidth = 1.0;

    for (double x = 0; x < size.width; x += pixelWidth) {
      canvas.drawRect(
        Rect.fromLTWH(x, 0, subPixelWidth, size.height),
        redPaint,
      );
      canvas.drawRect(
        Rect.fromLTWH(x + subPixelWidth, 0, subPixelWidth, size.height),
        greenPaint,
      );
      canvas.drawRect(
        Rect.fromLTWH(x + subPixelWidth * 2, 0, subPixelWidth, size.height),
        bluePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PhosphorPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
