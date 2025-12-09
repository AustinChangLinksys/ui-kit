# UI Kit Library

A high-cohesion, theme-driven UI component library for the USP Client POC project. This package implements the **Unified Design System (v2.0)**, following **Atomic Design** principles to provide a robust, scalable, and maintainable set of widgets.

It features a **Data-Driven Strategy (DDS)** that allows runtime switching between distinct visual languages (Glassmorphism, Neo-Brutalism, Flat, Neumorphic, Pixel) without changing business logic.

## 🔗 Live Demos

- **[Storybook (Widgetbook)](https://austinchanglinksys.github.io/ui-kit/)** - Interactive component catalog
- **[Live Theme Editor](https://austinchanglinksys.github.io/ui-kit/editor/)** - Real-time theme customization tool

## 🏗 Architecture

This project is structured using **Atomic Design** with strict architectural boundaries, governed by the **UI Kit Constitution (v3.1.0)**:

- **Foundation** (`lib/src/foundation`): The brain of the system. Contains `AppDesignTheme` contracts, `Specs` (Layout, Interaction, Typography), and Tokens. **Crucially, it now includes the App Unified Color System (v1.2) (`AppColorScheme`, `AppThemeConfig`, `AppColorFactory`), providing a comprehensive and reactive color management layer fully compatible with Material 3.**
  - **Theme Specifications**: All theme specs use `@TailorMixin()` for automated generation
  - **Shared Specs**: `AnimationSpec`, `StateColorSpec`, `OverlaySpec` for consistent composition
  - **Zero Defaults**: All styling values provided by theme system, no hardcoded fallbacks
- **Atoms** (`lib/src/atoms`): The primitives.
    - **`AppSurface`**: The constitutional core renderer handling physics, borders, shadows, and blur
    - Includes `AppText`, `AppGap`, `AppSkeleton`, `AppIcon`, `AppDivider`
- **Molecules** (`lib/src/molecules`): Semantic components composed of atoms.
    - **Constitutionally Compliant**: All buttons use theme-based sizing, no hardcoded values
    - Buttons, Inputs, Toggles, Cards, Navigation, Feedback
- **Organisms** (`lib/src/organisms`): Complex, standalone UI sections.
    - **Theme-Aware Animations**: Components like `AppTopology` use `AnimationSpec` from themes
- **Layout** (`lib/src/layout`): Responsive wrappers.

## 🌟 Key Features (v2.0)

* **Constitutional Compliance**: All components adhere to the **UI Kit Constitution (v3.1.0)**, ensuring zero internal defaults, proper theme integration, and consistent architectural patterns across the entire library.
* **App Unified Color System (v1.2)**: A comprehensive and reactive color management layer fully compatible with Material 3. It allows seamless configuration where changes to Material colors (e.g., Primary) automatically propagate to derived Style colors (e.g., Glow), while also supporting explicit style overrides.
* **Multi-Paradigm Support**: Seamlessly switch between **Glass** (Liquid), **Brutal** (Mechanical), **Flat** (Standard), **Neumorphic** (Tactile), and **Pixel** (Retro) themes, now all powered by the Unified Color System.
* **Theme-Aware Animation System**: All animations use `AnimationSpec` from the theme system, with theme-specific behaviors (e.g., Pixel mode instant snapping, Glass mode fluid transitions).
* **Physics-Based Interaction**: Components inherit physical behaviors (Scale, Glow, Offset) from the active theme via `InteractionSpec`.
* **Smart Layouts**: Spacing and margins automatically adapt to the theme's density using `spacingFactor`.
* **Safe Mode Testing**: Automated Golden Tests covering the full 10-style matrix (5 themes × Light/Dark).

## 🚀 Getting Started

### Prerequisites
- Flutter SDK: `>=3.22.0`
- Dart SDK: `>=3.2.0 <4.0.0`

### Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  ui_kit_library:
    path: packages/ui_kit # Or git url
```

### Basic Usage

Initialize the Design System in your `MaterialApp`:

```dart
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DesignSystem.init,
      theme: ThemeData(
        extensions: [GlassDesignTheme.light()],
      ),
      darkTheme: ThemeData(
        extensions: [GlassDesignTheme.dark()],
      ),
      home: HomePage(),
    );
  }
}
```

### Available Design Themes

| Theme | Light | Dark | Visual Style |
|-------|-------|------|--------------|
| **Glass** | `GlassDesignTheme.light()` | `GlassDesignTheme.dark()` | Glassmorphism with blur and translucency |
| **Brutal** | `BrutalDesignTheme.light()` | `BrutalDesignTheme.dark()` | Neo-Brutalism with bold borders |
| **Flat** | `FlatDesignTheme.light()` | `FlatDesignTheme.dark()` | Clean Material-style surfaces |
| **Neumorphic** | `NeumorphicDesignTheme.light()` | `NeumorphicDesignTheme.dark()` | Soft shadows and embossed effects |
| **Pixel** | `PixelDesignTheme.light()` | `PixelDesignTheme.dark()` | Retro 8-bit with instant animations |

### String-Based Theme Selection

For dynamic theme switching (e.g., from user preferences or remote config), use a helper function:

```dart
/// Parse theme name string to AppDesignTheme
AppDesignTheme getDesignTheme(String themeName, {bool isDark = false}) {
  switch (themeName.toLowerCase()) {
    case 'glass':
      return isDark ? GlassDesignTheme.dark() : GlassDesignTheme.light();
    case 'brutal':
      return isDark ? BrutalDesignTheme.dark() : BrutalDesignTheme.light();
    case 'flat':
      return isDark ? FlatDesignTheme.dark() : FlatDesignTheme.light();
    case 'neumorphic':
      return isDark ? NeumorphicDesignTheme.dark() : NeumorphicDesignTheme.light();
    case 'pixel':
      return isDark ? PixelDesignTheme.dark() : PixelDesignTheme.light();
    default:
      return isDark ? FlatDesignTheme.dark() : FlatDesignTheme.light();
  }
}

// Usage with SharedPreferences or remote config
final themeName = prefs.getString('theme') ?? 'flat';
final isDark = prefs.getBool('darkMode') ?? false;

MaterialApp(
  builder: DesignSystem.init,
  theme: ThemeData(
    extensions: [getDesignTheme(themeName, isDark: false)],
  ),
  darkTheme: ThemeData(
    extensions: [getDesignTheme(themeName, isDark: true)],
  ),
  themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
  // ...
);
```

### Remote Theme Configuration

For server-driven theming (e.g., Firebase Remote Config, REST API), use `CustomDesignTheme.fromJson`:

```dart
import 'package:ui_kit_library/ui_kit.dart';

// Complete JSON from remote config (includes style selection)
final themeJson = {
  'style': 'glass',             // 'glass', 'flat', 'brutal', 'neumorphic', 'pixel'
  'brightness': 'light',        // 'light' or 'dark'
  'seedColor': '#6750A4',       // Hex color (6 or 8 digits)
  'primary': '#2196F3',         // Override Material primary
  'secondary': '#FF9800',       // Override Material secondary
  'customSignalStrong': '#4CAF50', // Override signal colors
  'customGlowColor': '#E91E63',    // Override glow effect
};

// Single entry point - creates the appropriate theme
final theme = CustomDesignTheme.fromJson(themeJson);

MaterialApp(
  builder: DesignSystem.init,
  theme: ThemeData(extensions: [theme]),
  // ...
);
```

#### Alternative: Separate Style and Config

```dart
// When style selection is separate from config
final style = prefs.getString('style') ?? 'flat';
final config = AppThemeConfig.fromJson(colorConfigJson);

final theme = CustomDesignTheme.fromConfig(
  style: style,
  config: config,
);
```

#### Complete JSON Example

```json
{
  "style": "glass",
  "brightness": "light",
  "seedColor": "#6750A4",
  "primary": "#2196F3",
  "secondary": "#FF9800",
  "tertiary": "#9C27B0",
  "surface": "#FAFAFA",
  "error": "#F44336",
  "customSignalStrong": "#4CAF50",
  "customSignalWeak": "#FFC107",
  "customOverlayColor": "#000000",
  "customGlowColor": "#E91E63",
  "customHighContrastBorder": "#212121"
}
```

#### CustomDesignTheme JSON Schema

| Property | Type | Description |
|----------|------|-------------|
| `style` | `String` | Design style: `'glass'`, `'flat'`, `'brutal'`, `'neumorphic'`, `'pixel'` |
| `brightness` | `String` | `'light'` or `'dark'` |
| `seedColor` | `String\|int` | Base color for generation (hex `#RRGGBB` or `#AARRGGBB`, or int) |
| `primary` | `String\|int` | Override Material primary color |
| `secondary` | `String\|int` | Override Material secondary color |
| `tertiary` | `String\|int` | Override Material tertiary color |
| `surface` | `String\|int` | Override surface color |
| `error` | `String\|int` | Override error color |
| `customSignalStrong` | `String\|int` | Override signal strong (success) color |
| `customSignalWeak` | `String\|int` | Override signal weak (warning) color |
| `customOverlayColor` | `String\|int` | Override overlay/scrim color |
| `customGlowColor` | `String\|int` | Override glow effect color |
| `customHighContrastBorder` | `String\|int` | Override high contrast border color |

#### Configuration Priority

The theme system follows **Configuration Injection** (Constitution 3.4):

1. **High Priority (Override)**: Explicit values in `AppThemeConfig` always take precedence
2. **Low Priority (Derived)**: Factory-generated values from `seedColor` are used when no override exists

This supports both **"Lazy Mode"** (seed-based generation) and **"Expert Mode"** (full customization).

### Custom Design Style

Create your own design theme by extending `AppDesignTheme`:

```dart
import 'package:ui_kit_library/ui_kit.dart';

class CustomDesignTheme extends AppDesignTheme {
  factory CustomDesignTheme.light() {
    final scheme = ColorScheme.fromSeed(seedColor: Colors.teal);

    return CustomDesignTheme._(
      // Core surfaces - required
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.outline,
        borderWidth: 2.0,
        borderRadius: 16.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerLow,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.primary,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: const [],
        blurStrength: 0.0,
        contentColor: scheme.onPrimary,
      ),
      // ... other required surfaces and specs

      // Animation using shared spec
      animation: AnimationSpec.standard,

      // Sheet style with OverlaySpec composition
      sheetStyle: SheetStyle(
        overlay: OverlaySpec.standard,
        borderRadius: 24.0,
        width: 320.0,
        dragHandleHeight: 4.0,
        enableDithering: false,
      ),

      // Tabs with StateColorSpec composition
      tabsStyle: TabsStyle(
        textColors: StateColorSpec(
          active: scheme.primary,
          inactive: scheme.onSurfaceVariant,
        ),
        indicatorColor: scheme.primary,
        tabBackgroundColor: scheme.surface,
        animationDuration: const Duration(milliseconds: 250),
        indicatorThickness: 2.0,
      ),

      // ... other component styles
    );
  }

  const CustomDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    // ... all required parameters
  });
}
```

#### Key Points for Custom Themes

1. **Compose Shared Specs**: Use `AnimationSpec`, `StateColorSpec`, `OverlaySpec` instead of duplicating properties
2. **Full Compliance**: Implement all required fields in `AppDesignTheme`
3. **No Runtime Checks**: Components should adapt based on spec values, not theme type checks
4. **Use AppColorScheme**: Derive colors from `ColorScheme` for Material 3 compatibility

See existing theme files in `lib/src/foundation/theme/design_system/styles/` for complete examples.

## ⚖️ Constitutional Compliance

This UI Kit follows the **UI Kit Constitution (v3.1.0)**, a comprehensive set of architectural principles and coding standards that ensure:

- **Zero Internal Defaults**: Components receive all styling from the theme system, never hardcoded values
- **@TailorMixin Integration**: All theme extensions use automated generation via `theme_tailor`
- **AnimationSpec Composition**: Animations use shared specifications instead of hardcoded durations
- **AppSurface Architecture**: Visual containers use `AppSurface` rather than native Flutter containers
- **Data-Driven Strategy**: Components render based on theme specs, not runtime type checks

### Constitution Reviews

Components undergo rigorous constitutional compliance reviews using the `/uikit.review` tool:

```bash
# Review a specific component
/uikit.review lib/src/molecules/buttons/app_button.dart

# Review a theme specification
/uikit.review lib/src/foundation/theme/design_system/specs/topology_style.dart
```

**Recent compliance achievements:**
- **AppButton**: 100% compliant (fixed hardcoded sizing)
- **AppIconButton**: 100% compliant (fixed hardcoded sizing and colors)
- **AppTopology**: 100% compliant (integrated theme animation system)
- **TopologyStyle**: 100% compliant (constitutional exemplar)

## 🛠 Development

### Code Generation

This project relies on code generation for Assets (`flutter_gen`) and Theme Extensions (`theme_tailor`).

To run the code generator:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Widgetbook (Component Catalog)

We use [Widgetbook](https://www.widgetbook.io/) for interactive documentation and isolation testing.

**To run Widgetbook:**

1.  Navigate to the widgetbook directory:
    ```bash
    cd widgetbook
    ```
2.  Run the app (Web is recommended for Glass effects):
    ```bash
    flutter run -d chrome
    ```

**To deploy:**
The Widgetbook is automatically deployed to GitHub Pages via GitHub Actions.

## 🧪 Testing

### Unit & Widget Tests

Run standard logic tests:

```bash
flutter test
```

### Golden Tests (Visual Regression)

We use `alchemist` with a custom **Test Matrix** to verify all 8 styles simultaneously.

To update golden files:

```bash
flutter test --update-goldens --tags golden
```

## 🎨 Surface Texture Support

The UI Kit supports surface textures for enhanced visual depth and style. Textures are rendered as semi-transparent overlays on surface backgrounds.

### Available Textures

- **Pixel Grid** (4x4): Dot pattern for pixel/retro styles
- **Diagonal Lines** (4x4): Caution stripe pattern
- **Noise** (8x8): Monochrome grain for glassmorphic effects
- **Wood** (8x8): Natural wood grain pattern
- **Metal** (8x8): Brushed metal with scratches
- **Fabric** (8x8): Woven cloth pattern
- **Checkerboard** (8x8): Black and white squares
- **Pixel Art** (8x8): Retro 8-bit style pattern

### Recommended Opacity Values

Texture opacity should be tuned based on the surface background brightness:

| Scenario | Light Mode | Dark Mode | Notes |
|----------|-----------|-----------|-------|
| **Glass Effects** | 0.08 - 0.12 | 0.12 - 0.18 | Subtle grain (most themes) |
| **Fabric/Woven** | 0.15 - 0.20 | 0.20 - 0.30 | Visible texture |
| **Metal** | 0.18 - 0.25 | 0.25 - 0.35 | Scratches visible |
| **Wood** | 0.20 - 0.30 | 0.30 - 0.40 | Wood grain prominent |
| **Pixel/Retro** | 0.25 - 0.35 | 0.35 - 0.45 | Strong retro effect |

**Light Mode**: Use lower opacity (more subtle) to avoid visual clutter on bright backgrounds.
**Dark Mode**: Use higher opacity (more visible) to maintain texture visibility on dark backgrounds.

### Implementation in Themes

Textures are configured per theme variant in their respective `factory` constructors:

```dart
// Example: Glass Light Mode
surfaceBase: SurfaceStyle(
  backgroundColor: glassBaseColor,
  texture: AppTextures.noise,
  textureOpacity: 0.10, // Light mode: subtle
),

// Example: Glass Dark Mode
surfaceBase: SurfaceStyle(
  backgroundColor: glassBaseColor,
  texture: AppTextures.noise,
  textureOpacity: 0.15, // Dark mode: more visible
),
```

---

## ✨ Widgetbook Stories Overview

Below is the summary of components available in our system:

### Atoms (Basic Building Blocks)

  - **AppSurface**: The core container showcasing different levels (Base, Elevated, Highlight) and interactive physics.
  - **AppText**: Supports the full Material 3 typography scale and semantic shortcuts (`.headline`, `.body`, `.tiny`).
  - **AppGap**: Smart spacing component demonstrating various sizes (xxs-xxxl) and responsive gutters.
  - **AppSkeleton**: Smart loading placeholder showcasing Pulse (Glass) and Blink (Brutal) animations.
  - **AppIcon**: Supports SVG and Font icons with theme-aware tinting.
  - **AppDivider**: Visual separator supporting horizontal and vertical axes.

### Molecules (Functional Components)

  - **Buttons**:
      - **AppButton**: Supports Size Variants (S/M/L), Loading states, and icon combinations.
      - **AppIconButton**: Enforced 1:1 aspect ratio, shape adapts automatically to theme (Circle/Square).
  - **Forms & Inputs**:
      - **AppTextFormField**: Form-integrated input with validation support.
      - **AppTextField**: Supports Outline, Underline, and Filled variants, plus Focus/Error states.
      - **AppNumberTextField**: Specialized input for formatted numeric data.
      - **Network Inputs**: `AppIpv4TextField`, `AppIPv6TextField`, `AppMacAddressTextField`.
      - **AppDropdown**: Theme-aware selection menu mimicking text fields.
      - **AppSlider**: Supports continuous sliding and discrete steps (Divisions).
      - **AppSwitch**: Demonstrates the Renderer Pattern (Texture/Text/Icon/Dot).
      - **AppCheckbox / AppRadio**: State-driven selection controls.
  - **Display & Feedback**:
      - **AppLoader**: Theme-adaptive loading indicator (Circular/Linear).
      - **AppToast**: Overlay notification messages (Success/Error/Info/Warning).
      - **AppBadge**: Status badge supporting custom color tinting.
      - **AppTag**: Label component supporting interaction and deletion.
      - **AppAvatar**: Enforced circular avatar supporting image cropping and text fallback.
      - **AppTooltip**: Supports multi-directional positioning and rich content popovers.
  - **Layout**:
      - **AppListTile**: Standardized list row with slots for leading/trailing content.
      - **AppSlideAction**: Swipeable list item with theme-aware physics (Fluid/Snap).

### Navigation

  - **AppNavigationBar**: Bottom navigation bar showcasing the layout difference between Glass (Floating) and Brutal (Fixed).
  - **AppNavigationRail**: Vertical side navigation for desktop/tablet layouts.
  - **AppTabs**: Tab switching supporting Underline, Filled, and Segmented styles.
  - **AppStepper**: Multi-step progress indicator (Horizontal/Vertical).
  - **AppBreadcrumb**: Hierarchical navigation path display.
  - **AppCarousel**: Sequential item browsing with auto-play and snap behavior.
  - **AppChipGroup**: Quick filtering interface with single/multiple selection.
  - **AppSideSheet / AppDrawer**: Side navigation panel (Overlay/Persistent).
  - **AppBottomSheet**: Bottom slide-up panel.

### Organisms (Complex Components)

  - **AppUnifiedBar**: Theme-aware standard AppBar implementing `PreferredSizeWidget`.
  - **AppUnifiedSliverBar**: Collapsible sliver AppBar with pinned/floating/snap behaviors.
  - **AppPopupMenu**: Theme-aware popup menu with overlay management.
  - **AppDialog**: Modal dialog with structured button API and isDestructive flag.
  - **AppExpandableFab**: Radial menu with overlay and theme-specific expansion animations.
  - **AppGauge**: Data visualization meter supporting Gradient, Segmented, and Solid styles.

### Topology Visualization

  - **TopologyGraphView**: Interactive mesh network visualization with auto-layout.
  - **TopologyTreeView**: Hierarchical view of network nodes.
  - **AppTopology**: **100% Constitutional Compliance** - Main entry point with theme-aware view transitions using `AnimationSpec`.
  - **Nodes**: `OrbitNode`, `PulseNode`, `LiquidNode` with status-driven styles.
  - **Links**: Dynamic link rendering visualizing signal strength with theme-based animations.

### Data Display

  - **AppDataTable**: Responsive data table with `CardRenderer` (Mobile) and `GridRenderer` (Desktop).

### Examples (Scenarios)

  - **DashboardPage**: A complete dashboard example (Kitchen Sink) integrating all components to demonstrate RWD layout and overall theme switching effects.
  - **MockupPage**: Basic typography and layout example.

### 🧩 Component Reference

| Component | Category | Description | Key Controllable Parameters |
| :--- | :--- | :--- | :--- |
| **AppSurface** | Atom | Core container with theme-aware physics, shadows, and borders. | `child`, `width`, `height`, `padding`, `margin`, `color`, `onTap`, `variant` (base/elevated/highlight) |
| **AppText** | Atom | Typography component supporting Material 3 scale. | `data`, `style` (variant), `color`, `textAlign`, `maxLines`, `overflow` |
| **AppGap** | Atom | Responsive spacing component. | `size` (xxs-xxxl), `customSize` |
| **AppDivider** | Atom | Visual separator. | `direction` (horizontal/vertical), `thickness`, `color`, `indent`, `endIndent` |
| **AppIcon** | Atom | Theme-aware icon renderer. | `icon`, `size`, `color`, `semanticLabel` |
| **AppSkeleton** | Atom | Loading placeholder with theme animations. | `width`, `height`, `shape` (circle/rect), `style` |
| **AppButton** | Molecule | **100% Constitutional Compliance** - Interactive button with theme-based sizing. | `onPressed`, `label`, `icon`, `variant` (primary/secondary/ghost), `size`, `isLoading`, `isDisabled` |
| **AppIconButton** | Molecule | **100% Constitutional Compliance** - Icon-only button with theme-based sizing. | `onPressed`, `icon`, `variant`, `size`, `isLoading`, `tooltip` |
| **AppTextFormField** | Molecule | Form field with validation. | `controller`, `validator`, `label`, `hint`, `obscureText`, `keyboardType`, `onChanged`, `enabled` |
| **AppTextField** | Molecule | Basic text input. | `controller`, `label`, `hint`, `errorText`, `onChanged`, `enabled`, `prefix/suffixIcon` |
| **AppNumberTextField** | Molecule | Numeric input with formatting. | `controller`, `label`, `onChanged`, `allowDecimals`, `min/max` |
| **AppPasswordInput** | Molecule | Password input with visibility toggle & strength rules. | `controller`, `label`, `rules` (List<AppPasswordRule>), `onChanged` |
| **AppPinInput** | Molecule | PIN code input. | `controller`, `length`, `onCompleted`, `onChanged`, `obscureText` |
| **AppRangeInput** | Molecule | Range selection input. | `controller` (start/end), `min/max`, `labels`, `onChanged` |
| **AppIpv4TextField** | Molecule | IPv4 address input. | `controller`, `label`, `onChanged`, `errorText` |
| **AppIpv6TextField** | Molecule | IPv6 address input. | `controller`, `label`, `onChanged`, `errorText` |
| **AppMacAddressTextField** | Molecule | MAC address input. | `controller`, `label`, `onChanged`, `errorText` |
| **AppDropdown** | Molecule | Selection menu. | `items`, `value`, `onChanged`, `label`, `hint`, `validator` |
| **AppSwitch** | Molecule | Binary toggle switch. | `value`, `onChanged`, `label`, `enabled` |
| **AppCheckbox** | Molecule | Selection checkbox. | `value`, `onChanged`, `label`, `tristate` |
| **AppRadio** | Molecule | Radio button. | `value`, `groupValue`, `onChanged`, `label` |
| **AppSlider** | Molecule | Range slider. | `value`, `onChanged`, `min`, `max`, `divisions`, `label` |
| **AppLoader** | Molecule | Loading indicator. | `progress` (0.0-1.0 or null), `size`, `color` |
| **AppToast** | Molecule | Overlay notification. | `message`, `type` (success/error/info/warning), `duration`, `onDismiss` |
| **AppBadge** | Molecule | Status indicator. | `label`, `color`, `child` (optional wrapper), `position` |
| **AppTag** | Molecule | Interactive label/chip. | `label`, `icon`, `onDeleted`, `onTap`, `color` |
| **AppAvatar** | Molecule | User profile image. | `image`, `initials`, `size`, `onTap` |
| **AppTooltip** | Molecule | Info popover. | `message`, `child`, `direction`, `waitDuration` |
| **AppListTile** | Molecule | List row item. | `title`, `subtitle`, `leading`, `trailing`, `onTap`, `selected` |
| **AppSlideAction** | Molecule | Swipeable list item. | `child`, `actions` (leading/trailing), `actionWidth` |
| **AppCard** | Molecule | Container for grouped content. | `child`, `padding`, `margin`, `onTap`, `elevation` |
| **AppExpansionPanel** | Molecule | Expandable content panel. | `title`, `children`, `isExpanded`, `onExpansionChanged` |
| **AppTabs** | Molecule | Tab navigation. | `tabs` (items), `controller`, `onTap`, `variant` (underline/filled/segmented) |
| **AppStepper** | Molecule | Progress steps. | `steps`, `currentStep`, `onStepTapped`, `orientation` (horizontal/vertical) |
| **AppBreadcrumb** | Molecule | Path navigation. | `items`, `onItemTapped` |
| **AppCarousel** | Molecule | Item slider. | `children`, `height`, `viewportFraction`, `autoPlay`, `onPageChanged` |
| **AppChipGroup** | Molecule | Filter/selection chips. | `items`, `selectedItems`, `onChanged`, `mode` (single/multiple) |
| **AppBottomSheet** | Molecule | Bottom modal/persistent sheet. | `builder`, `isScrollControlled`, `enableDrag` |
| **AppSideSheet** | Molecule | Side drawer/sheet. | `builder`, `position` (left/right), `width` |
| **AppNavigationBar** | Molecule | Bottom nav bar. | `items`, `currentIndex`, `onTap` |
| **AppNavigationRail** | Molecule | Side nav rail. | `destinations`, `selectedIndex`, `onDestinationSelected`, `extended` |
| **AppUnifiedBar** | Organism | Standard AppBar. | `title`, `leading`, `actions`, `bottom`, `centerTitle` |
| **AppUnifiedSliverBar** | Organism | Sliver AppBar. | `title`, `leading`, `actions`, `pinned`, `floating`, `snap` |
| **AppDialog** | Organism | Modal dialog. | `title`, `content`, `actions`, `isDestructive` |
| **AppPopupMenu** | Organism | Context menu. | `items`, `onSelected`, `child`, `offset` |
| **AppExpandableFab** | Organism | Radial action menu. | `items`, `icon`, `onOpen`, `onClose` |
| **AppGauge** | Organism | Visualization meter. | `value`, `min`, `max`, `style` (solid/gradient/segmented) |
| **TopologyGraphView** | Organism | Network mesh graph. | `nodes`, `links`, `onNodeTap`, `onLinkTap` |
| **AppDataTable** | Organism | Responsive data table. | `columns`, `rows`, `sortColumnIndex`, `sortAscending`, `onSelectAll` |

---

## 🎨 Widget Styles Reference

All component styles are defined in `lib/src/foundation/theme/design_system/specs/` and accessed via `AppDesignTheme`. Styles use `@TailorMixin` for theme extension generation.

### Shared Specs (Composable Building Blocks)

These specs are designed to be composed into component styles, reducing duplication and ensuring consistency.

#### AnimationSpec
Shared animation timing specification. Composes into component styles for consistent motion.

- **Parameters**:
  - `duration` (`Duration`, required) - Animation duration
  - `curve` (`Curve`, required) - Animation curve

- **Presets**: `instant` (0ms), `fast` (150ms), `standard` (300ms), `slow` (500ms)

- **Methods**: `withOverride({duration?, curve?})`

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `duration` | `Duration` | ✓ | - | Animation duration |
| `curve` | `Curve` | ✓ | - | Animation curve (easing) |

---

#### StateColorSpec
State-based color specification with `resolve()` method for ergonomic color selection.

- **Parameters**:
  - `active` (`Color`, required) - Color when active/selected
  - `inactive` (`Color`, required) - Color when inactive/unselected
  - `hover` (`Color?`) - Color on hover (optional)
  - `pressed` (`Color?`) - Color when pressed (optional)
  - `disabled` (`Color?`) - Color when disabled (optional)
  - `error` (`Color?`) - Color for error state (optional)

- **Methods**:
  - `resolve({isActive, isHovered?, isPressed?, isDisabled?, hasError?})` - Returns appropriate color based on state
  - `withOverride({active?, inactive?, hover?, pressed?, disabled?, error?})`

- **Priority**: error > disabled > pressed > hover > active/inactive

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `active` | `Color` | ✓ | - | Active/selected state color |
| `inactive` | `Color` | ✓ | - | Inactive/unselected state color |
| `hover` | `Color?` | - | `null` | Hover state color |
| `pressed` | `Color?` | - | `null` | Pressed state color |
| `disabled` | `Color?` | - | `null` | Disabled state color |
| `error` | `Color?` | - | `null` | Error state color |

---

#### OverlaySpec
Overlay/backdrop specification for modal components (sheets, dialogs). Composes `AnimationSpec`.

- **Parameters**:
  - `scrimColor` (`Color`, required) - Backdrop color
  - `blurStrength` (`double`) - Blur sigma (Glass theme uses blur)
  - `animation` (`AnimationSpec`, required) - Overlay transition timing

- **Presets**: `standard`, `glass`, `pixel`

- **Methods**: `withOverride({scrimColor?, blurStrength?, animation?})`

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `scrimColor` | `Color` | ✓ | - | Scrim/backdrop color |
| `blurStrength` | `double` | - | `0.0` | Blur effect strength |
| `animation` | `AnimationSpec` | ✓ | - | Overlay animation timing |

---

### Component Styles

#### SurfaceStyle
Core visual appearance for container components.

- **Parameters**:
  - `backgroundColor` (`Color`, required) - Background color
  - `borderColor` (`Color`, required) - Border color
  - `borderWidth` (`double`) - Border thickness
  - `borderRadius` (`double`) - Corner radius
  - `shadows` (`List<BoxShadow>`) - Shadow effects
  - `blurStrength` (`double`) - Backdrop blur (Glass)
  - `contentColor` (`Color`, required) - Default text/icon color
  - `interaction` (`InteractionSpec?`) - Physical interaction effects
  - `texture` (`ImageProvider?`) - Surface texture
  - `textureOpacity` (`double`) - Texture overlay opacity

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `backgroundColor` | `Color` | ✓ | - | Surface background |
| `borderColor` | `Color` | ✓ | - | Border color |
| `borderWidth` | `double` | - | `0.0` | Border thickness |
| `borderRadius` | `double` | - | `0.0` | Corner radius |
| `shadows` | `List<BoxShadow>` | - | `[]` | Drop shadows |
| `blurStrength` | `double` | - | `0.0` | Backdrop blur sigma |
| `contentColor` | `Color` | ✓ | - | Content color |
| `texture` | `ImageProvider?` | - | `null` | Surface texture |
| `textureOpacity` | `double` | - | `1.0` | Texture opacity |

---

#### SheetStyle
Unified style for bottom sheets and side sheets. Composes `OverlaySpec`.

- **Parameters**:
  - `overlay` (`OverlaySpec`, required) - Backdrop appearance and animation
  - `borderRadius` (`double`, required) - Corner radius
  - `width` (`double?`) - Sheet width (side sheets)
  - `dragHandleHeight` (`double`) - Drag handle indicator height
  - `enableDithering` (`bool`) - Enable dither pattern (Pixel)

- **Methods**: `withOverride({overlay?, borderRadius?, width?, dragHandleHeight?, enableDithering?})`

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `overlay` | `OverlaySpec` | ✓ | - | Overlay spec (scrim, blur, animation) |
| `borderRadius` | `double` | ✓ | - | Corner radius |
| `width` | `double?` | - | `null` | Sheet width (side sheets) |
| `dragHandleHeight` | `double` | - | `4.0` | Drag handle height |
| `enableDithering` | `bool` | - | `false` | Pixel theme dithering |

---

#### DialogStyle
Modal dialog appearance. Composes `OverlaySpec` and `SurfaceStyle`.

- **Parameters**:
  - `containerStyle` (`SurfaceStyle`, required) - Dialog container appearance
  - `overlay` (`OverlaySpec`, required) - Backdrop specification
  - `maxWidth` (`double`) - Maximum dialog width
  - `padding` (`EdgeInsets`) - Content padding
  - `buttonSpacing` (`double`) - Gap between action buttons
  - `buttonAlignment` (`MainAxisAlignment`) - Button row alignment

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `containerStyle` | `SurfaceStyle` | ✓ | - | Dialog box appearance |
| `overlay` | `OverlaySpec` | ✓ | - | Backdrop specification |
| `maxWidth` | `double` | - | `400.0` | Maximum width |
| `padding` | `EdgeInsets` | - | `all(24.0)` | Content padding |
| `buttonSpacing` | `double` | - | `8.0` | Button gap |
| `buttonAlignment` | `MainAxisAlignment` | - | `end` | Button alignment |

---

#### TabsStyle
Tab navigation appearance. Composes `StateColorSpec`.

- **Parameters**:
  - `textColors` (`StateColorSpec`, required) - Tab text colors (active/inactive)
  - `indicatorColor` (`Color`, required) - Active indicator color
  - `tabBackgroundColor` (`Color`, required) - Tab button background
  - `animationDuration` (`Duration`, required) - Indicator transition duration
  - `indicatorThickness` (`double`, required) - Indicator line thickness

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `textColors` | `StateColorSpec` | ✓ | - | Text colors by state |
| `indicatorColor` | `Color` | ✓ | - | Active indicator color |
| `tabBackgroundColor` | `Color` | ✓ | - | Tab background |
| `animationDuration` | `Duration` | ✓ | - | Animation duration |
| `indicatorThickness` | `double` | ✓ | - | Indicator thickness |

---

#### CarouselStyle
Carousel/slider appearance. Composes `AnimationSpec` and `StateColorSpec`.

- **Parameters**:
  - `navButtonColors` (`StateColorSpec`, required) - Navigation button colors
  - `previousIcon` (`IconData`, required) - Previous button icon
  - `nextIcon` (`IconData`, required) - Next button icon
  - `animation` (`AnimationSpec`, required) - Item transition timing
  - `useSnapScroll` (`bool`) - Snap scroll behavior (Pixel)
  - `navButtonSize` (`double`) - Navigation button size

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `navButtonColors` | `StateColorSpec` | ✓ | - | Nav button colors |
| `previousIcon` | `IconData` | ✓ | - | Previous icon |
| `nextIcon` | `IconData` | ✓ | - | Next icon |
| `animation` | `AnimationSpec` | ✓ | - | Transition animation |
| `useSnapScroll` | `bool` | - | `false` | Snap scroll mode |
| `navButtonSize` | `double` | - | `48.0` | Button size |

---

#### InputStyle
Text input field appearance with variant support.

- **Parameters**:
  - `outlineStyle` (`SurfaceStyle`, required) - Outlined variant appearance
  - `underlineStyle` (`SurfaceStyle`, required) - Underlined variant appearance
  - `filledStyle` (`SurfaceStyle`, required) - Filled variant appearance
  - `focusModifier` (`SurfaceStyle`, required) - Focus state overlay
  - `errorModifier` (`SurfaceStyle`, required) - Error state overlay

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `outlineStyle` | `SurfaceStyle` | ✓ | - | Outline variant style |
| `underlineStyle` | `SurfaceStyle` | ✓ | - | Underline variant style |
| `filledStyle` | `SurfaceStyle` | ✓ | - | Filled variant style |
| `focusModifier` | `SurfaceStyle` | ✓ | - | Focus state modifier |
| `errorModifier` | `SurfaceStyle` | ✓ | - | Error state modifier |

---

#### ToggleStyle
Switch/toggle appearance with content renderer support.

- **Parameters**:
  - `activeType` (`ToggleContentType`) - Content type when active
  - `inactiveType` (`ToggleContentType`) - Content type when inactive
  - `activeText` / `inactiveText` (`String?`) - Text content
  - `activeIcon` / `inactiveIcon` (`IconData?`) - Icon content
  - `activeTrackStyle` (`SurfaceStyle?`) - Track when on
  - `inactiveTrackStyle` (`SurfaceStyle?`) - Track when off
  - `thumbStyle` (`SurfaceStyle?`) - Thumb appearance

- **Content Types**: `none`, `text`, `icon`, `grip`, `dot`

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `activeType` | `ToggleContentType` | - | `none` | Active content type |
| `inactiveType` | `ToggleContentType` | - | `none` | Inactive content type |
| `activeTrackStyle` | `SurfaceStyle?` | - | `null` | Active track style |
| `inactiveTrackStyle` | `SurfaceStyle?` | - | `null` | Inactive track style |
| `thumbStyle` | `SurfaceStyle?` | - | `null` | Thumb style |

---

#### TableStyle
Data table appearance. Composes `AnimationSpec`.

- **Parameters**:
  - `headerBackground` (`Color?`) - Header row background
  - `rowBackground` (`Color`) - Data row background
  - `gridColor` (`Color`) - Grid line color
  - `gridWidth` (`double`) - Grid line width
  - `showVerticalGrid` (`bool`) - Show vertical grid lines
  - `cellPadding` (`EdgeInsetsGeometry`) - Cell padding
  - `rowHeight` (`double`) - Row height
  - `headerTextStyle` / `cellTextStyle` (`TextStyle`) - Text styles
  - `invertRowOnHover` (`bool`) - Invert colors on hover (Pixel)
  - `glowRowOnHover` (`bool`) - Glow effect on hover (Glass)
  - `hoverRowBackground` / `hoverRowContentColor` (`Color?`) - Hover colors
  - `modeTransition` (`AnimationSpec`) - Mode switch animation

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `headerBackground` | `Color?` | - | - | Header background |
| `rowBackground` | `Color` | ✓ | - | Row background |
| `gridColor` | `Color` | ✓ | - | Grid line color |
| `gridWidth` | `double` | ✓ | - | Grid line width |
| `showVerticalGrid` | `bool` | ✓ | - | Vertical grid lines |
| `cellPadding` | `EdgeInsetsGeometry` | ✓ | - | Cell padding |
| `rowHeight` | `double` | ✓ | - | Row height |
| `modeTransition` | `AnimationSpec` | ✓ | - | Mode transition animation |

---

#### GaugeStyle
Gauge/meter visualization. Composes `AnimationSpec`.

- **Parameters**:
  - `type` (`GaugeRenderType`) - Rendering style: `gradient`, `segmented`, `solid`
  - `cap` (`GaugeCapType`) - Line cap style: `round`, `butt`, `comet`, `bead`
  - `trackColor` (`Color`) - Background track color
  - `indicatorColor` (`Color`) - Progress indicator color
  - `showTicks` (`bool`) - Show tick marks
  - `strokeWidth` (`double`) - Arc stroke width
  - `enableGlow` (`bool`) - Enable glow effect
  - `animation` (`AnimationSpec`) - Value transition animation

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `type` | `GaugeRenderType` | ✓ | - | Render type |
| `cap` | `GaugeCapType` | ✓ | - | Cap style |
| `trackColor` | `Color` | ✓ | - | Track color |
| `indicatorColor` | `Color` | ✓ | - | Indicator color |
| `showTicks` | `bool` | ✓ | - | Show ticks |
| `strokeWidth` | `double` | ✓ | - | Stroke width |
| `enableGlow` | `bool` | ✓ | - | Enable glow |
| `animation` | `AnimationSpec` | ✓ | - | Animation timing |

---

### Quick Reference Table

| Style | Composes | Used By | Key Features |
|-------|----------|---------|--------------|
| **AnimationSpec** | - | All animated components | Duration, Curve, Presets |
| **StateColorSpec** | - | Tabs, Carousel, Chips, Breadcrumb | State-based color resolution |
| **OverlaySpec** | AnimationSpec | Sheet, Dialog, ExpandableFab | Scrim, Blur, Animation |
| **SurfaceStyle** | InteractionSpec | AppSurface, Cards, Inputs | Background, Border, Shadow |
| **SheetStyle** | OverlaySpec | AppBottomSheet, AppSideSheet | Unified sheet styling |
| **DialogStyle** | OverlaySpec, SurfaceStyle | AppDialog | Modal dialog appearance |
| **TabsStyle** | StateColorSpec | AppTabs | Tab navigation |
| **CarouselStyle** | AnimationSpec, StateColorSpec | AppCarousel | Item slider |
| **InputStyle** | SurfaceStyle | AppTextField, Form inputs | Input field variants |
| **ToggleStyle** | SurfaceStyle | AppSwitch | Toggle with renderers |
| **TableStyle** | AnimationSpec | AppDataTable | Data table styling |
| **GaugeStyle** | AnimationSpec | AppGauge | Meter visualization |

---

### Integration Status

Shows which styles have been migrated to use shared specs (`@TailorMixin`, `AnimationSpec`, `StateColorSpec`, `OverlaySpec`).

#### ✅ Fully Integrated

| Style | @TailorMixin | AnimationSpec | StateColorSpec | OverlaySpec |
|-------|:------------:|:-------------:|:--------------:|:-----------:|
| SheetStyle | ✅ | ✅ | - | ✅ |
| DialogStyle | ✅ | ✅ | - | ✅ |
| TabsStyle | ✅ | - | ✅ | - |
| BreadcrumbStyle | ✅ | - | ✅ | - |
| ChipGroupStyle | ✅ | - | ✅ | - |
| CarouselStyle | ✅ | ✅ | ✅ | - |
| ExpansionPanelStyle | ✅ | ✅ | - | - |
| SlideActionStyle | ✅ | ✅ | - | - |
| TableStyle | ✅ | ✅ | - | - |
| GaugeStyle | ✅ | ✅ | - | - |
| ExpandableFabStyle | ✅ | ✅ | - | ✅ |
| **TopologySpec** ⭐ | ✅ | ✅ | - | - |
| LoaderStyle | ✅ | - | - | - |
| ToastStyle | ✅ | - | - | - |

**⭐ TopologySpec**: Constitutional exemplar with perfect compliance (100% score)

#### ⏳ Pending Integration

| Style | Issue | Target Integration |
|-------|-------|-------------------|
| **NavigationStyle** | No @TailorMixin, manual lerp | AnimationSpec, StateColorSpec |
| **StepperStyle** | Standalone Duration field | AnimationSpec |
| **SkeletonStyle** | No @TailorMixin | AnimationSpec |
| **AppBarStyle** | Equatable, manual lerp | @TailorMixin (optional) |
| **AppMenuStyle** | Equatable, manual lerp | @TailorMixin, AnimationSpec (optional) |
| **DividerStyle** | Equatable | @TailorMixin (optional) |
| **InputStyle** | Equatable | @TailorMixin (optional) |
| **ToggleStyle** | Plain class | @TailorMixin (optional) |

> See `specs/021-spec-consolidation/tasks.md` Phase 11-14 for detailed integration tasks.

---

## 📚 Documentation

Detailed architecture decisions can be found in the `specs/` directory:

  - **`.specify/memory/constitution.md`**: The **UI Kit Constitution (v3.1.0)** - comprehensive architectural principles and coding standards
  - `specs/002-unified-design-system`: Core Architecture & Data Model.
  - `specs/003-ui-kit-molecules`: Component Implementation Plans.
  - **`specs/017-unified-color-system`**: Details the App Unified Color System (v1.2), covering Material 3 integration, seamless configuration, and multi-theme support.
  - **`specs/019-legacy-migration`**: Migration strategy for legacy components (`AppSlideAction`, `AppExpandableFab`, `AppGauge`) with IoC compliance.

### Constitution Reviews

Use the built-in `/uikit.review` tool to verify constitutional compliance for any component or theme specification. The tool provides detailed compliance reports with specific line references and actionable fixes.

## 📦 Dependencies

Key packages used:

  - **Styling**: `theme_tailor_annotation`
  - **Layout**: `flutter_portal`, `gap`
  - **Testing**: `alchemist`, `widgetbook`
  - **Utils**: `equatable`, `flutter_animate`
