// test/test_utils/golden_test_scenarios.dart

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

/// Unified Golden Test scenario builder for the project
///
/// Features:
/// 1. Forced size constraint (SizedBox) - prevents Layout Overflow / Infinite Size
/// 2. Automatic background color injection (ColoredBox) - ensures Glass/Neumorphic visibility
/// 3. Automatic theme injection (Theme)
/// 4. Animation disabled by default (TickerMode) - prevents Skeleton/Loading from causing Timeout
GoldenTestScenario buildSafeScenario({
  required String name,
  required ThemeData theme,
  required Widget child,
  double width = 200.0, // Default to ample space
  double height = 100.0,
  bool disableAnimation = true, // Animations disabled by default, ensuring test stability
}) {
  return GoldenTestScenario(
    name: name,
    child: SizedBox(
      width: width,
      height: height,
      child: ColoredBox(
        color: theme.scaffoldBackgroundColor,
        child: Theme(
          data: theme,
          child: Center(
            child: TickerMode(
              enabled: !disableAnimation,
              child: child,
            ),
          ),
        ),
      ),
    ),
  );
}
