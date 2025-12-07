import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'test_theme_matrix.dart';
import 'golden_test_scenarios.dart';

/// Automatically generate a 4x2 matrix (Glass, Brutal, Flat, Neu) x (Light, Dark)
/// and add headers
GoldenTestGroup buildThemeMatrix({
  required String name, // Case name, e.g. "Loading State"
  required Widget child, // Widget to test
  double width = 200.0, // Cell width
  double height = 100.0, // Cell height
  bool disableAnimation = true,
}) {
  return GoldenTestGroup(
    columns: 2, // Fixed two columns: Left Light, Right Dark
    children: kTestThemeMatrix.entries.map((entry) {
      final themeName = entry.key; // e.g. "Glass_Light"
      final themeData = entry.value;

      // Use Column with Header
      return buildSafeScenario(
        name: themeName, // Pass to helper
        theme: themeData,
        child: child,
        width: width,
        height: height,
        disableAnimation: disableAnimation,
      );
    }).toList(),
  );
}

/// Same as buildThemeMatrix but uses a builder function to create fresh widgets
/// for each scenario. This ensures each theme gets its own widget instance and State.
GoldenTestGroup buildThemeMatrixWithBuilder({
  required String name,
  required Widget Function() childBuilder, // Builder instead of widget
  double width = 200.0,
  double height = 100.0,
  bool disableAnimation = true,
}) {
  return GoldenTestGroup(
    columns: 2,
    children: kTestThemeMatrix.entries.map((entry) {
      final themeName = entry.key;
      final themeData = entry.value;

      return buildSafeScenario(
        name: themeName,
        theme: themeData,
        child: childBuilder(), // Call builder for each scenario
        width: width,
        height: height,
        disableAnimation: disableAnimation,
      );
    }).toList(),
  );
}
