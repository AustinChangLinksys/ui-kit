import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/motion/app_motion.dart';
import 'package:ui_kit_library/src/foundation/motion/motion_spec.dart';

/// AppMotion implementation for the Flat (Standard) theme.
class FlatMotion extends AppMotion {
  const FlatMotion(); 

  @override
  MotionSpec get fast => const MotionSpec(duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
  @override
  MotionSpec get medium => const MotionSpec(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  @override
  MotionSpec get slow => const MotionSpec(duration: Duration(milliseconds: 600), curve: Curves.easeOut);

  @override
  FlatMotion lerp(covariant AppMotion? other, double t) {
    if (other is! FlatMotion) return this;
    return t < 0.5 ? this : other; 
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlatMotion &&
          runtimeType == other.runtimeType);

  @override
  int get hashCode => runtimeType.hashCode;
}
