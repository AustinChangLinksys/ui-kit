import 'package:ui_kit_library/src/foundation/motion/motion_spec.dart';

/// Defines a set of motion specifications for various interaction speeds.
abstract class AppMotion {
  const AppMotion();

  /// Fast motion spec for micro-interactions (e.g., icon changes, checkboxes).
  MotionSpec get fast;

  /// Medium motion spec for typical transitions (e.g., dialogs, page transitions).
  MotionSpec get medium;

  /// Slow motion spec for subtle background changes or long transitions.
  MotionSpec get slow;

  /// Abstract method for linear interpolation of AppMotion implementations.
  AppMotion lerp(covariant AppMotion? other, double t);
}
