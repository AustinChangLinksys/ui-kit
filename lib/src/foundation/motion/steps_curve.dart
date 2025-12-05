import 'package:flutter/animation.dart';

class StepsCurve extends Curve {
  final int steps;
  const StepsCurve(this.steps);

  @override
  double transform(double t) {
    return (t * steps).floor() / steps;
  }
}
