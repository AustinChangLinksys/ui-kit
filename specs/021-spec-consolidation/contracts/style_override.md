# API Contract: StyleOverride

**Feature**: 021-spec-consolidation
**Date**: 2025-12-08

## StyleOverride Widget API

```dart
/// InheritedWidget for providing subtree-level spec overrides.
///
/// Allows local customization of shared specs without modifying
/// the global theme or creating theme variants.
class StyleOverride extends InheritedWidget {
  // --- Properties ---

  /// Override for animation timing specs
  final AnimationSpec? animationSpec;

  /// Override for state color specs
  final StateColorSpec? stateColorSpec;

  /// Override for overlay specs
  final OverlaySpec? overlaySpec;

  // --- Constructor ---
  const StyleOverride({
    super.key,
    required super.child,
    this.animationSpec,
    this.stateColorSpec,
    this.overlaySpec,
  });

  // --- Static Accessors ---

  /// Get the nearest StyleOverride ancestor, or null if none exists.
  static StyleOverride? maybeOf(BuildContext context);

  /// Get the nearest StyleOverride ancestor.
  /// Throws if no StyleOverride is found in the widget tree.
  static StyleOverride of(BuildContext context);

  /// Resolve a specific spec type from the override chain.
  /// Returns null if no override exists for that type.
  static T? resolveSpec<T>(BuildContext context);

  // --- InheritedWidget ---
  @override
  bool updateShouldNotify(StyleOverride oldWidget);
}
```

## Usage Examples

### Basic Page-Level Override

```dart
// Fast animations for entire dashboard page
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StyleOverride(
      animationSpec: AnimationSpec.fast,
      child: Scaffold(
        body: Column(
          children: [
            AppCarousel(...),     // Uses 150ms animation
            AppExpansionPanel(...), // Uses 150ms animation
            AppBottomSheet(...),  // Uses 150ms animation
          ],
        ),
      ),
    );
  }
}
```

### Nested Overrides

```dart
// Outer page uses fast animations
StyleOverride(
  animationSpec: AnimationSpec.fast,
  child: Column(
    children: [
      // This section uses slow animations
      StyleOverride(
        animationSpec: AnimationSpec.slow,
        child: HeroSection(...),
      ),

      // These use the outer fast animation
      ContentSection(...),
      FooterSection(...),
    ],
  ),
)
```

### Partial Override (Only Animation)

```dart
// Only override animation, keep theme colors
StyleOverride(
  animationSpec: AnimationSpec(
    duration: Duration(milliseconds: 200),
    curve: Curves.bounceOut,
  ),
  // stateColorSpec: null - uses theme default
  // overlaySpec: null - uses theme default
  child: MyWidget(),
)
```

### Component Resolution Pattern

```dart
/// Example of how components should resolve specs
class AppCarousel extends StatelessWidget {
  /// Optional direct override (highest priority)
  final AnimationSpec? animationOverride;

  @override
  Widget build(BuildContext context) {
    final animation = _resolveAnimation(context);
    // Use resolved animation...
  }

  /// Resolution priority:
  /// 1. Component parameter (animationOverride)
  /// 2. StyleOverride ancestor (StyleOverride.resolveSpec)
  /// 3. Theme default (theme.carouselStyle.animation)
  AnimationSpec _resolveAnimation(BuildContext context) {
    // Priority 1: Direct override
    if (animationOverride != null) return animationOverride!;

    // Priority 2: StyleOverride ancestor
    final override = StyleOverride.resolveSpec<AnimationSpec>(context);
    if (override != null) return override;

    // Priority 3: Theme default
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    return theme.carouselStyle.animation;
  }
}
```

### Override for Specific State Colors

```dart
// Custom colors for error-focused section
StyleOverride(
  stateColorSpec: StateColorSpec(
    active: Colors.green,
    inactive: Colors.grey,
    error: Colors.red.shade700,
  ),
  child: FormSection(
    children: [
      AppTabs(...),      // Uses custom colors
      AppStepper(...),   // Uses custom colors
      AppChipGroup(...), // Uses custom colors
    ],
  ),
)
```

## Integration with Components

Components should implement the three-tier resolution pattern:

```dart
/// Standard resolution helper for any shared spec type
T resolveSpec<T>({
  required BuildContext context,
  required T? directOverride,
  required T themeDefault,
}) {
  // 1. Direct override takes precedence
  if (directOverride != null) return directOverride;

  // 2. StyleOverride ancestor
  final override = StyleOverride.resolveSpec<T>(context);
  if (override != null) return override;

  // 3. Theme default
  return themeDefault;
}
```

## Testing Considerations

```dart
// Wrap test widget with StyleOverride for controlled testing
testWidgets('carousel uses custom animation', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: StyleOverride(
        animationSpec: AnimationSpec.instant, // No animation for tests
        child: AppCarousel(...),
      ),
    ),
  );

  // Verify instant animation behavior
});
```
