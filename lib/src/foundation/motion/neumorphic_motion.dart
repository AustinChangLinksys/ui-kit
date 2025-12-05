import 'package:ui_kit_library/src/foundation/motion/app_motion.dart';
import 'package:ui_kit_library/src/foundation/motion/motion_spec.dart';
import 'package:flutter/material.dart';

class NeumorphicMotion extends AppMotion {
  const NeumorphicMotion();

  @override
  MotionSpec get fast => const MotionSpec(duration: Duration(milliseconds: 200), curve: Curves.easeOutExpo);
  @override
  MotionSpec get medium => const MotionSpec(duration: Duration(milliseconds: 400), curve: Curves.easeOutExpo);
  @override
  MotionSpec get slow => const MotionSpec(duration: Duration(milliseconds: 700), curve: Curves.easeOutExpo);

  @override
  NeumorphicMotion lerp(covariant AppMotion? other, double t) {
    if (other is! NeumorphicMotion) return this;
    return t < 0.5 ? this : other;
  }
}
