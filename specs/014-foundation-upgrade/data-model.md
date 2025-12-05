# Implementation Plan: System Foundation Upgrades

**Feature Branch**: `014-foundation-upgrade`
**Created**: 2025-12-04
**Status**: In Progress
**Input**: User description for System Foundation Upgrades.

## 1. Technical Context

This plan addresses the refactoring and expansion of core UI Kit components to support a multi-paradigm visual style, specifically focusing on dynamic motion, global visual effects, and adaptive iconography.

### 1.1 Existing Architecture Overview

The UI Kit currently utilizes Flutter's `ThemeExtension` mechanism, with `AppDesignTheme` serving as the central abstract class for design system properties. `AppTheme.of(context)` provides access to the concrete theme implementations (e.g., `GlassDesignTheme`, `BrutalDesignTheme`). The `theme_tailor` package is used for automated generation of `ThemeExtension` classes.

**Current State of Key Areas:**

*   **Motion/Durations**: There is no centralized `AppDuration` class as suggested in the spec's initial description. Animation `Duration` values are currently hardcoded directly within individual concrete theme definitions (e.g., `GlassDesignTheme.dart`) as properties of various style specifications (e.g., `SurfaceStyle`, `ToastStyle`). This approach lacks a unified motion strategy across themes.
*   **Theme System**: The `UnifiedTheme` concept in the specification maps directly to the existing `AppTheme` and `AppDesignTheme` structure. `AppDesignTheme` is the ideal place to introduce new theme-dependent properties like `motion` and `visualEffects`.
*   **Iconography**: The `AppIcon` component (`lib/src/atoms/icons/app_icon.dart`) currently supports rendering both SVG assets (via `SvgGenImage`) and font icons (`IconData`). It handles sizing and coloring. The component uses `SvgGenImage` imported from `foundation/gen/assets.gen.dart`, suggesting `flutter_gen` for asset management.
*   **Global Effects Layer Injection**: The main application entry point, `generative_ui/example/lib/main.dart`, uses `MaterialApp` directly. The `builder` property of `MaterialApp` will be the designated injection point for the `GlobalEffectsOverlay`.

### 1.2 Identified Gaps & Refinements

*   **AppDuration vs. Hardcoded Durations**: The specification mentioned upgrading `AppDuration`, but the codebase reveals hardcoded durations. The refactor will effectively introduce the `AppMotion` concept to centralize and formalize motion definitions, replacing these disparate hardcoded values.
*   **UnifiedTheme Mapping**: `UnifiedTheme` in the spec will be implemented using the `AppTheme` / `AppDesignTheme` existing architecture.

## 2. Constitution Check

This plan adheres to the UI Component Library Charter (Version 2.0.0).

*   **3.1 Inversion of Control (IoC)** & **3.2 Data-Driven Strategy (DDS)**:
    *   The `MotionSpec` and `AppMotion` strategy adhere to IoC by allowing the Theme to define motion characteristics. Components will "ask how" to animate via `UnifiedTheme.motion` instead of dictating.
    *   Defining `MotionSpec` as a data structure to encapsulate `Duration` and `Curve` explicitly follows the DDS principle, eliminating `if/else` logic for motion styles.
*   **4.1 The Contract: AppDesignTheme**: `AppMotion` will be a new property on `AppDesignTheme`, making motion properties part of the central theme contract.
*   **4.4 Automation & Tooling**: The new `AppMotion` will be integrated with `theme_tailor` if its properties need to be theme-generated, ensuring consistency with existing practices.
*   **5.3 Composition over Inheritance**: The `GlobalEffectsOverlay` will be composed at the `MaterialApp` level, not inherited, and `AppIcon` will leverage composition for style variations.
*   **6.1 Component Expansion Protocol**: The goal for `AppIcon` is that it should not require `runtimeType` checks, and divergent logic will be moved into theme specs (e.g., an `IconStyleSpec` within `AppDesignTheme`).
*   **6.2 Style Expansion Protocol**: The design aims for new styles to modify `AppMotion` and `IconStyleSpec` within their `AppDesignTheme` implementation without touching core component code (Zero-Touch Policy).
*   **7.1 Access Control (Assets)**: `AppIcon` already uses `SvgGenImage` from `flutter_gen`, aligning with the strong typing principle.

## 3. Phase 0: Research

This phase consolidates architectural decisions based on the technical context.

### 3.1 Decision: Unified Motion System Implementation

*   **Rationale**: To centralize animation logic and adhere to IoC/DDS, replacing scattered hardcoded `Duration` values.
*   **Approach**:
    1.  Define `MotionSpec` as a value object encapsulating `Duration` and `Curve`.
    2.  Define `AppMotion` abstract class (or interface) with `fast`, `medium`, `slow` getters returning `MotionSpec`.
    3.  Implement concrete `FlatMotion`, `GlassMotion`, `PixelMotion` classes that extend `AppMotion`.
    4.  Add an `AppMotion motion` property to `AppDesignTheme` (and its concrete implementations like `GlassDesignTheme`).
    5.  Update `AppTheme.of(context)` to expose this `motion` property.

### 3.2 Decision: Global Visual Effects Layer Injection

*   **Rationale**: To provide a top-level, theme-adaptive visual atmosphere for the entire application.
*   **Approach**:
    1.  Create a `GlobalEffectsOverlay` widget.
    2.  This widget will read the current theme's `visualEffects` property (new property on `AppDesignTheme`).
    3.  If `visualEffects` dictates an effect (e.g., Noise, CRT), `GlobalEffectsOverlay` will render it.
    4.  Inject `GlobalEffectsOverlay` using `MaterialApp.builder` in the main application file (`generative_ui/example/lib/main.dart`). This ensures it overlays all content, including navigation.
    5.  Utilize `IgnorePointer` within `GlobalEffectsOverlay` to ensure it does not interfere with user interaction, adhering to the spec's requirement.

### 3.3 Decision: Style-Adaptive Iconography

*   **Rationale**: To enable `AppIcon` to dynamically adapt its visual style based on the active theme without manual `if/else` in component usage.
*   **Approach**:
    1.  Introduce a new `AppIconStyle` (or similar) property to `AppDesignTheme`. This property will specify the preferred icon rendering strategy for the current theme (e.g., `vectorFilled`, `thinStroke`, `bitmap`).
    2.  Modify the existing `AppIcon` widget. It will take a generic icon identifier (e.g., an enum, or a key that maps to assets).
    3.  Inside `AppIcon`'s `build` method, it will query `AppTheme.of(context).iconStyle` to determine *how* to render the icon.
    4.  Asset naming convention and `flutter_gen` will be crucial. For example, `assets.icons.home.svg` for flat, `assets.icons.home_stroke.svg` for glass, `assets.icons.home_pixel.png` for pixel. `AppIcon` will construct the correct path based on the theme's `AppIconStyle`.

## 4. Phase 1: Design & Contracts

### 4.1 Data Model (`data-model.md`)

This section defines the new data structures.

```dart
import 'dart:ui'; // For lerpDouble
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

// Assuming StepsCurve is a custom curve or imported from a package
class StepsCurve extends Curve {
  final int steps;
  const StepsCurve(this.steps);

  @override
  double transform(double t) {
    return (t * steps).floor() / steps;
  }
}

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
  static MotionSpec lerp(MotionSpec a, MotionSpec b, double t) {
    // For curves, direct interpolation is complex and often not desired.
    // A more pragmatic approach is to switch between curves at a certain point.
    // For ThemeExtension lerp, it often means interpolating underlying values
    // or picking one if direct interpolation isn't meaningful.
    final interpolatedDuration = Duration(microseconds: lerpDouble(a.duration.inMicroseconds, b.duration.inMicroseconds, t)?.round() ?? a.duration.inMicroseconds);
    final interpolatedCurve = t < 0.5 ? a.curve : b.curve; // Simple switch for curve
    // Or, one could define a custom lerp for common curves like easeInOut, etc.
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

/// Defines a set of motion specifications for various interaction speeds.
abstract class AppMotion {
  /// Fast motion spec for micro-interactions (e.g., icon changes, checkboxes).
  MotionSpec get fast;

  /// Medium motion spec for typical transitions (e.g., dialogs, page transitions).
  MotionSpec get medium;

  /// Slow motion spec for subtle background changes or long transitions.
  MotionSpec get slow;

  /// Abstract method for linear interpolation of AppMotion implementations.
  AppMotion lerp(covariant AppMotion other, double t);
}

/// AppMotion implementation for the Flat (Standard) theme.
class FlatMotion extends AppMotion {
  const FlatMotion(); // Added const constructor

  @override
  MotionSpec get fast => const MotionSpec(duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
  @override
  MotionSpec get medium => const MotionSpec(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  @override
  MotionSpec get slow => const MotionSpec(duration: Duration(milliseconds: 600), curve: Curves.easeOut);

  @override
  FlatMotion lerp(covariant AppMotion other, double t) {
    if (other is! FlatMotion) return this;
    return t < 0.5 ? this : other; // Use this or other directly
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlatMotion &&
          runtimeType == other.runtimeType);

  @override
  int get hashCode => runtimeType.hashCode;
}

/// AppMotion implementation for the Glass (Fluid) theme.
class GlassMotion extends AppMotion {
  const GlassMotion(); // Added const constructor

  @override
  MotionSpec get fast => const MotionSpec(duration: Duration(milliseconds: 250), curve: Curves.easeOutCubic);
  @override
  MotionSpec get medium => const MotionSpec(duration: Duration(milliseconds: 500), curve: Curves.easeOutExpo);
  @override
  MotionSpec get slow => const MotionSpec(duration: Duration(milliseconds: 900), curve: Curves.easeOutQuint);

  @override
  GlassMotion lerp(covariant AppMotion other, double t) {
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

/// AppMotion implementation for the Pixel (Instant/Mechanical) theme.
class PixelMotion extends AppMotion {
  const PixelMotion(); // Added const constructor

  @override
  MotionSpec get fast => const MotionSpec(duration: Duration(milliseconds: 0), curve: Curves.linear); // Instant
  @override
  MotionSpec get medium => const MotionSpec(duration: Duration(milliseconds: 150), curve: StepsCurve(2)); // Stepped
  @override
  MotionSpec get slow => const MotionSpec(duration: Duration(milliseconds: 300), curve: StepsCurve(4));

  @override
  PixelMotion lerp(covariant AppMotion other, double t) {
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


/// Defines the preferred rendering style for icons within a theme.
enum AppIconStyle {
  /// Standard vector SVG (e.g., rounded, filled).
  vectorFilled,
  /// Thin stroke vector SVG, potentially with glow.
  thinStroke,
  /// Pixelated bitmap or aliased SVG.
  pixelated,
}

/// Defines the type of global visual effect to apply to the entire app.
enum GlobalEffectsType {
  /// No global visual effect.
  none,
  /// Applies a subtle noise overlay (e.g., film grain).
  noiseOverlay,
  /// Applies a CRT monitor simulation effect.
  crtShader,
}

/// Represents a generic identifier for an icon, allowing for theme-based resolution.
/// This could be an enum, a string key, or a more complex object.
/// For the current implementation, this is a placeholder to represent the concept.
///
/// In practice, `AppIcon` will likely take an enum or a dedicated class
/// (e.g., `AppIcons.home`, `AppIcons.settings`) that maps to underlying asset paths.
abstract class AppIconData {}

// Example concrete implementation (could be automatically generated or manually defined)
enum AppIcons implements AppIconData {
  home,
  settings,
  // ... other icons
}
