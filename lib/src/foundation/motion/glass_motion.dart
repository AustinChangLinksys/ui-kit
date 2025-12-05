import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/motion/app_motion.dart';
import 'package:ui_kit_library/src/foundation/motion/motion_spec.dart';

/// AppMotion implementation for the Glass (Fluid) theme.
class GlassMotion extends AppMotion {
  const GlassMotion(); 

  @override
  MotionSpec get fast => const MotionSpec(duration: Duration(milliseconds: 250), curve: Curves.easeOutCubic);
  @override
  MotionSpec get medium => const MotionSpec(duration: Duration(milliseconds: 500), curve: Curves.easeOutExpo);
  @override
  MotionSpec get slow => const MotionSpec(duration: Duration(milliseconds: 900), curve: Curves.easeOutQuint);

  @override
  GlassMotion lerp(covariant AppMotion? other, double t) {
    if (other is! GlassMotion) return this;
    return t < 0.5 ? this : other;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlassMotion &&
          runtimeType == other.runtimeType);

  @override
  int get hashCode => runtimeType.hashCode;
}
