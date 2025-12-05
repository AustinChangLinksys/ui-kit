import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/motion/app_motion.dart';
import 'package:ui_kit_library/src/foundation/motion/motion_spec.dart';
import 'package:ui_kit_library/src/foundation/motion/steps_curve.dart';

/// AppMotion implementation for the Pixel (Instant/Mechanical) theme.
class PixelMotion extends AppMotion {
  const PixelMotion(); 

  @override
  MotionSpec get fast => const MotionSpec(duration: Duration(milliseconds: 0), curve: Curves.linear); // Instant
  @override
  MotionSpec get medium => const MotionSpec(duration: Duration(milliseconds: 150), curve: StepsCurve(2)); // Stepped
  @override
  MotionSpec get slow => const MotionSpec(duration: Duration(milliseconds: 300), curve: StepsCurve(4));

  @override
  PixelMotion lerp(covariant AppMotion? other, double t) {
    if (other is! PixelMotion) return this;
    return t < 0.5 ? this : other;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PixelMotion &&
          runtimeType == other.runtimeType);

  @override
  int get hashCode => runtimeType.hashCode;
}
