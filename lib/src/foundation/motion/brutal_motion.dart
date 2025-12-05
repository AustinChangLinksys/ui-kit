import 'package:ui_kit_library/src/foundation/motion/app_motion.dart';
import 'package:ui_kit_library/src/foundation/motion/motion_spec.dart';
import 'package:flutter/material.dart';

class BrutalMotion extends AppMotion {
  const BrutalMotion();

  @override
  MotionSpec get fast => const MotionSpec(duration: Duration(milliseconds: 75), curve: Curves.linear);
  @override
  MotionSpec get medium => const MotionSpec(duration: Duration(milliseconds: 150), curve: Curves.linear);
  @override
  MotionSpec get slow => const MotionSpec(duration: Duration(milliseconds: 300), curve: Curves.linear);

  @override
  BrutalMotion lerp(covariant AppMotion? other, double t) {
    if (other is! BrutalMotion) return this;
    return t < 0.5 ? this : other;
  }
}
