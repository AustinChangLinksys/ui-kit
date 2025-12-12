# Theme Integration Contracts: Enhanced AppPageView System

**Feature**: 023-styled-pageview-migration
**Contract Type**: Theme System Integration Specifications
**Date**: 2025-12-10

## Overview

This document defines the formal contracts for theme integration across the enhanced AppPageView system, ensuring consistent styling, proper theme extension composition, and support for all visual languages in the UI Kit.

## Theme Extension Architecture

### Primary Theme Extensions

#### PageLayoutStyle

Core theme extension for page layout styling and behavior.

```dart
@TailorMixin()
class PageLayoutStyle extends ThemeExtension<PageLayoutStyle> {
  const PageLayoutStyle({
    required this.animation,
    required this.surfaceStyle,
    required this.contentPadding,
    required this.borderRadius,
    required this.overlaySpec,
    required this.safeAreaHandling,
  });

  /// Animation specifications for page transitions and micro-interactions
  /// MUST be provided by all theme implementations
  /// Pixel theme MUST use AnimationSpec.instant for snap behavior
  final AnimationSpec animation;

  /// Surface styling for page background and containers
  /// MUST compose existing SurfaceStyle from UI Kit foundation
  /// Glass theme MUST include blur and transparency
  final SurfaceStyle surfaceStyle;

  /// Default content padding for page layout
  /// MUST respect responsive system margins
  /// Mobile: 16px, Tablet: 24px, Desktop: 32px minimum
  final EdgeInsets contentPadding;

  /// Default border radius for page elements
  /// Pixel theme MUST use 0 radius for sharp edges
  /// Glass theme SHOULD use larger radius for softer appearance
  final BorderRadius borderRadius;

  /// Overlay specifications for modal elements
  /// MUST compose OverlaySpec for consistency
  /// Glass theme MUST include blur effects
  final OverlaySpec overlaySpec;

  /// Safe area handling behavior
  /// MUST define safe area padding strategy
  final SafeAreaHandling safeAreaHandling;
}

enum SafeAreaHandling { automatic, manual, disabled }
```

#### AppBarStyle

Dedicated theme extension for AppBar styling across visual languages.

```dart
@TailorMixin()
class AppBarStyle extends ThemeExtension<AppBarStyle> {
  const AppBarStyle({
    required this.colors,
    required this.textStyle,
    required this.iconTheme,
    required this.elevation,
    required this.height,
    required this.borderRadius,
    required this.animation,
    required this.sliver,
  });

  /// Color specifications for different AppBar states
  /// MUST compose StateColorSpec for state-based color resolution
  /// MUST support active/inactive/disabled/error/hover/pressed states
  final StateColorSpec colors;

  /// Text styling for AppBar title and actions
  /// MUST use appTextTheme tokens, not hardcoded TextStyle
  /// Brutal theme MAY use titleMedium for bolder headers
  final TextStyle textStyle;

  /// Icon theming for AppBar icons and actions
  /// MUST sync with colors.resolve() for consistency
  final IconThemeData iconTheme;

  /// AppBar elevation for shadow effects
  /// Glass theme MUST use minimal elevation
  /// Neumorphic theme MUST use subtle shadow elevation
  /// Pixel theme SHOULD use 0 elevation
  final double elevation;

  /// Default AppBar height
  /// MUST accommodate safe area requirements
  /// MUST support custom toolbarHeight override
  final double height;

  /// Border radius for AppBar container
  /// MUST coordinate with pageLayoutStyle.borderRadius
  final BorderRadius borderRadius;

  /// Animation specifications for AppBar transitions
  /// MUST compose AnimationSpec for consistency
  final AnimationSpec animation;

  /// Sliver-specific styling configuration
  /// MUST support collapsible and pinned behaviors
  final SliverAppBarStyle sliver;
}

@TailorMixin()
class SliverAppBarStyle extends ThemeExtension<SliverAppBarStyle> {
  const SliverAppBarStyle({
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.animation,
    required this.snapBehavior,
    required this.floatingBehavior,
  });

  final double expandedHeight;
  final double collapsedHeight;
  final AnimationSpec animation;
  final bool snapBehavior;
  final bool floatingBehavior;
}
```

#### BottomBarStyle

Theme extension for bottom action bar styling.

```dart
@TailorMixin()
class BottomBarStyle extends ThemeExtension<BottomBarStyle> {
  const BottomBarStyle({
    required this.colors,
    required this.destructiveColors,
    required this.textStyle,
    required this.buttonHeight,
    required this.borderRadius,
    required this.padding,
    required this.animation,
    required this.elevation,
    required this.safeAreaPadding,
  });

  /// Standard button color specifications
  /// MUST compose StateColorSpec for state management
  final StateColorSpec colors;

  /// Destructive action color specifications
  /// MUST use signalStrong/signalWeak for warning colors
  /// MUST be harmonized with seed color per charter requirements
  final StateColorSpec destructiveColors;

  /// Text styling for button labels
  /// MUST use appTextTheme.labelLarge or appropriate token
  final TextStyle textStyle;

  /// Standard button height for bottom bar actions
  /// MUST meet minimum touch target requirements (44px/48px)
  final double buttonHeight;

  /// Border radius for bottom bar and buttons
  /// Pixel theme MUST use 0 radius
  final BorderRadius borderRadius;

  /// Internal padding for bottom bar container
  /// MUST account for safe area requirements
  final EdgeInsets padding;

  /// Animation specifications for show/hide transitions
  /// MUST compose AnimationSpec
  final AnimationSpec animation;

  /// Bottom bar elevation for shadow effects
  /// Glass theme MUST use minimal elevation with blur
  final double elevation;

  /// Safe area bottom padding behavior
  /// MUST handle home indicator and navigation areas
  final double safeAreaPadding;
}
```

#### MenuStyle

Theme extension for responsive menu system styling.

```dart
@TailorMixin()
class MenuStyle extends ThemeExtension<MenuStyle> {
  const MenuStyle({
    required this.colors,
    required this.textStyle,
    required this.iconTheme,
    required this.itemHeight,
    required this.borderRadius,
    required this.padding,
    required this.animation,
    required this.desktop,
    required this.mobile,
    required this.overlaySpec,
  });

  /// Menu item color specifications
  /// MUST compose StateColorSpec for hover/selected/pressed states
  final StateColorSpec colors;

  /// Text styling for menu item labels
  /// MUST use appTextTheme.bodyMedium or appropriate token
  final TextStyle textStyle;

  /// Icon theming for menu item icons
  /// MUST sync with colors for consistency
  final IconThemeData iconTheme;

  /// Standard menu item height
  /// MUST meet accessibility touch target requirements
  final double itemHeight;

  /// Border radius for menu items and containers
  /// MUST coordinate with overall page styling
  final BorderRadius borderRadius;

  /// Internal padding for menu items
  /// MUST provide comfortable spacing for interaction
  final EdgeInsets padding;

  /// Animation specifications for menu transitions
  /// MUST compose AnimationSpec for show/hide animations
  final AnimationSpec animation;

  /// Desktop-specific menu styling
  /// MUST define sidebar appearance and behavior
  final DesktopMenuStyle desktop;

  /// Mobile-specific menu styling
  /// MUST define bottom sheet appearance and behavior
  final MobileMenuStyle mobile;

  /// Overlay specifications for mobile menu modal
  /// MUST compose OverlaySpec for consistency
  final OverlaySpec overlaySpec;
}

@TailorMixin()
class DesktopMenuStyle extends ThemeExtension<DesktopMenuStyle> {
  const DesktopMenuStyle({
    required this.width,
    required this.maxWidth,
    required this.surfaceStyle,
    required this.borderStyle,
    required this.elevation,
  });

  final double width;
  final double maxWidth;
  final SurfaceStyle surfaceStyle;
  final BorderSide borderStyle;
  final double elevation;
}

@TailorMixin()
class MobileMenuStyle extends ThemeExtension<MobileMenuStyle> {
  const MobileMenuStyle({
    required this.maxHeight,
    required this.borderRadius,
    required this.dragHandleStyle,
    required this.animation,
  });

  final double maxHeight;
  final BorderRadius borderRadius;
  final DragHandleStyle dragHandleStyle;
  final AnimationSpec animation;
}
```

## Visual Language Implementation Contracts

### Glass Theme Requirements

Glass theme MUST implement specific visual characteristics:

```dart
// Example Glass theme implementation
PageLayoutStyle glassPageLayoutStyle = PageLayoutStyle(
  animation: AnimationSpec.slow, // Fluid, longer animations
  surfaceStyle: SurfaceStyle(
    backgroundColor: scheme.surface.withOpacity(0.8), // Transparency required
    blur: 10.0, // Background blur required
    borderRadius: BorderRadius.circular(16), // Softer edges
  ),
  overlaySpec: OverlaySpec.glass, // Glass-specific overlay with blur
  // ...
);

AppBarStyle glassAppBarStyle = AppBarStyle(
  colors: StateColorSpec(
    activeColor: scheme.surface.withOpacity(0.9), // Semi-transparent
    // ...
  ),
  elevation: 0, // Minimal elevation, rely on blur
  animation: AnimationSpec.slow, // Floating physics
  // ...
);
```

**Glass Theme Contracts**:
- Background opacity MUST be < 1.0 for translucency
- Blur effects MUST be applied to background surfaces
- Animations MUST use fluid curves (easeOutExpo) with longer durations
- Elevation MUST be minimal, relying on blur for depth
- Colors MUST have reduced opacity for glass effect

### Pixel Theme Requirements

Pixel theme MUST implement retro/pixelated characteristics:

```dart
// Example Pixel theme implementation
PageLayoutStyle pixelPageLayoutStyle = PageLayoutStyle(
  animation: AnimationSpec.instant, // No interpolation, snap behavior
  surfaceStyle: SurfaceStyle(
    backgroundColor: scheme.surface, // Solid colors required
    blur: 0.0, // No blur effects
    borderRadius: BorderRadius.zero, // Sharp corners required
    border: Border.all(
      color: scheme.outline,
      width: 2.0, // Thick borders
    ),
  ),
  // ...
);

AppBarStyle pixelAppBarStyle = AppBarStyle(
  textStyle: appTextTheme.labelLarge!.copyWith(
    fontFamily: 'Courier', // Monospace fonts preferred
  ),
  borderRadius: BorderRadius.zero, // No rounded corners
  elevation: 0, // No shadows
  animation: AnimationSpec.instant, // Immediate state changes
  // ...
);
```

**Pixel Theme Contracts**:
- Border radius MUST be 0 for all elements
- Animations MUST use instant timing (0ms) or stepped curves
- Colors MUST be solid (no transparency or gradients)
- Fonts SHOULD use monospace typefaces where appropriate
- Shadows and blur effects MUST be disabled

### Brutal Theme Requirements

Brutal theme MUST implement bold, high-contrast characteristics:

```dart
// Example Brutal theme implementation
PageLayoutStyle brutalPageLayoutStyle = PageLayoutStyle(
  animation: AnimationSpec.fast, // Quick, snappy animations
  surfaceStyle: SurfaceStyle(
    backgroundColor: scheme.surface,
    borderRadius: BorderRadius.circular(4), // Minimal rounding
    border: Border.all(
      color: scheme.outline,
      width: 3.0, // Thick, prominent borders
    ),
    boxShadow: [
      BoxShadow(
        color: scheme.shadow,
        offset: Offset(4, 4), // Offset shadows for impact
        blurRadius: 0, // Sharp shadows
      ),
    ],
  ),
  // ...
);

AppBarStyle brutalAppBarStyle = AppBarStyle(
  textStyle: appTextTheme.titleMedium!, // Bolder text for impact
  colors: StateColorSpec(
    activeColor: scheme.primary,
    inactiveColor: scheme.surface,
    // High contrast color pairs
  ),
  elevation: 8.0, // Strong shadows
  // ...
);
```

**Brutal Theme Contracts**:
- Borders MUST be thick (≥2px) with high contrast colors
- Shadows MUST use offset positioning with minimal blur
- Text MUST use bold weights for emphasis
- Colors MUST provide high contrast ratios
- Elements MUST have strong visual hierarchy

### Neumorphic Theme Requirements

Neumorphic theme MUST implement soft, embossed characteristics:

```dart
// Example Neumorphic theme implementation
PageLayoutStyle neumorphicPageLayoutStyle = PageLayoutStyle(
  animation: AnimationSpec.standard, // Smooth, natural animations
  surfaceStyle: SurfaceStyle(
    backgroundColor: scheme.surface,
    borderRadius: BorderRadius.circular(20), // Soft, pill-like shapes
    boxShadow: [
      // Dual shadow system required
      BoxShadow(
        color: scheme.shadow.withOpacity(0.2),
        offset: Offset(8, 8),
        blurRadius: 16,
      ),
      BoxShadow(
        color: Colors.white.withOpacity(0.1),
        offset: Offset(-8, -8),
        blurRadius: 16,
      ),
    ],
  ),
  // ...
);
```

**Neumorphic Theme Contracts**:
- Shadows MUST use dual-shadow system (light + dark)
- Border radius MUST be generous for soft appearance
- Colors MUST use subtle variations of base surface color
- Elevation changes MUST invert shadow directions for emboss/deboss
- Animations MUST be smooth and natural

## Theme Composition Requirements

### Shared Spec Integration

All theme extensions MUST compose shared specs instead of duplicating properties:

```dart
// ✅ CORRECT: Compose shared specs
@TailorMixin()
class PageLayoutStyle extends ThemeExtension<PageLayoutStyle> {
  const PageLayoutStyle({
    required this.animation, // Compose AnimationSpec
    required this.surfaceColors, // Compose StateColorSpec
    required this.overlaySpec, // Compose OverlaySpec
    required this.customPageProperty, // Component-specific only
  });

  final AnimationSpec animation;
  final StateColorSpec surfaceColors;
  final OverlaySpec overlaySpec;
  final double customPageProperty;
}

// ❌ INCORRECT: Duplicate shared properties
@TailorMixin()
class PageLayoutStyle extends ThemeExtension<PageLayoutStyle> {
  const PageLayoutStyle({
    required this.animationDuration, // Duplicated!
    required this.animationCurve, // Duplicated!
    required this.activeColor, // Duplicated!
    required this.inactiveColor, // Duplicated!
  });
}
```

### Color System Integration

All color usage MUST comply with AppColorScheme semantic layers:

```dart
// Theme extension color usage examples
AppBarStyle(
  colors: StateColorSpec(
    // ✅ CORRECT: Use semantic colors
    activeColor: scheme.primary, // Material standard
    inactiveColor: scheme.surface, // Material standard
    // OR
    activeColor: scheme.styleBackground, // Semantic layer
    inactiveColor: scheme.subtleBorder, // Semantic layer

    // ❌ INCORRECT: Hardcoded colors
    activeColor: Colors.blue, // Violates charter
    inactiveColor: Color(0xFF123456), // Violates charter
  ),
);
```

**Color System Contracts**:
- MUST use AppColorScheme or Material ColorScheme properties
- MUST NOT use hardcoded Color values (Colors.red, Color(0xFF...))
- Signal colors MUST be harmonized with seed color
- State colors MUST follow resolution priority: error → disabled → pressed → hover → active/inactive

### Typography Integration

All text styling MUST use appTextTheme tokens:

```dart
// ✅ CORRECT: Use typography tokens
AppBarStyle(
  textStyle: appTextTheme.headlineLarge!, // Base token
  // OR with theme-specific customization
  textStyle: appTextTheme.headlineLarge!.copyWith(
    fontFamily: 'Courier', // Pixel theme customization
    fontWeight: FontWeight.w700, // Brutal theme customization
  ),
);

// ❌ INCORRECT: Hardcoded text styling
AppBarStyle(
  textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Arial',
  ),
);
```

## Theme Integration Testing Contracts

### Golden Test Matrix Requirements

All theme extensions MUST support full golden test matrix:

```dart
// Required test coverage for each theme extension
void main() {
  setUpAll(() async {
    await loadAppFonts(); // Required for proper font rendering
  });

  group('PageLayoutStyle Golden Tests', () {
    goldenTest(
      'PageLayoutStyle - All Theme Variations',
      fileName: 'page_layout_style_matrix',
      builder: () => buildThemeMatrix(
        name: 'Page Layout',
        width: 400.0,
        height: 300.0,
        child: PageLayoutStyleShowcase(),
      ),
    );
  });
}
```

**Testing Contracts**:
- MUST test all 4 themes × 2 brightness modes (8 combinations)
- MUST use buildThemeMatrix for consistent testing
- MUST verify proper color resolution across themes
- MUST validate animation specifications work correctly
- MUST ensure responsive behavior functions properly

### Theme Switching Validation

Components MUST respond correctly to runtime theme changes:

```dart
// Theme switching test requirements
testWidgets('AppPageView responds to theme changes', (tester) async {
  // Test theme switching without rebuilding widget tree
  await tester.pumpWidget(
    MaterialApp(
      theme: createGlassTheme(),
      home: TestAppPageView(),
    ),
  );

  // Verify glass theme rendering
  expect(find.byType(BackdropFilter), findsOneWidget);

  // Switch to pixel theme
  await tester.pumpWidget(
    MaterialApp(
      theme: createPixelTheme(),
      home: TestAppPageView(),
    ),
  );

  // Verify pixel theme rendering (no blur)
  expect(find.byType(BackdropFilter), findsNothing);
});
```

This comprehensive theme integration contract ensures consistent, maintainable, and properly integrated theming across the enhanced AppPageView system while supporting all visual languages in the UI Kit.