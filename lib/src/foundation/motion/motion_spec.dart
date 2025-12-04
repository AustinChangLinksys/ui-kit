import 'dart:ui';
import 'package:flutter/animation.dart';

/// Represents a complete motion specification including duration and curve.
class MotionSpec {
  const MotionSpec({
    required this.duration,
    required this.curve,
  });

  /// The duration of the animation.
  final Duration duration;

  /// The easing curve of the animation.
  final Curve curve;

  MotionSpec copyWith({Duration? duration, Curve? curve}) {
    return MotionSpec(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  /// Linearly interpolates between two [MotionSpec]s.
  static MotionSpec lerp(MotionSpec? a, MotionSpec? b, double t) {
    if (a == null && b == null) return const MotionSpec(duration: Duration.zero, curve: Curves.linear);
    if (a == null) return b!;
    if (b == null) return a;

    // For curves, direct interpolation is complex and often not desired.
    // A more pragmatic approach is to switch between curves at a certain point.
    final interpolatedDuration = Duration(
        microseconds: lerpDouble(a.duration.inMicroseconds.toDouble(),
                    b.duration.inMicroseconds.toDouble(), t)
                ?.round() ??
            a.duration.inMicroseconds);
    final interpolatedCurve = t < 0.5 ? a.curve : b.curve; 

    return MotionSpec(
      duration: interpolatedDuration,
      curve: interpolatedCurve,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MotionSpec &&
          runtimeType == other.runtimeType &&
          duration == other.duration &&
          curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode;
}
