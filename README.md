# UI Kit Library

A high-cohesion, theme-driven UI component library for the USP Client POC project. This package implements the **Unified Design System (v2.0)**, following **Atomic Design** principles to provide a robust, scalable, and maintainable set of widgets.

It features a **Data-Driven Strategy (DDS)** that allows runtime switching between distinct visual languages (Glassmorphism, Neo-Brutalism, Flat, Neumorphic, Pixel) without changing business logic.

## 🔗 Live Demos

- **[Storybook (Widgetbook)](https://austinchanglinksys.github.io/ui-kit/)** - Interactive component catalog
- **[Live Theme Editor](https://austinchanglinksys.github.io/ui-kit/editor/)** - Real-time theme customization tool

## 🏗 Architecture

This project is structured using **Atomic Design** with strict architectural boundaries:

- **Foundation** (`lib/src/foundation`): The brain of the system. Contains `AppDesignTheme` contracts, `Specs` (Layout, Interaction, Typography), and Tokens. **Crucially, it now includes the App Unified Color System (v1.2) (`AppColorScheme`, `AppThemeConfig`, `AppColorFactory`), providing a comprehensive and reactive color management layer fully compatible with Material 3.**
- **Atoms** (`lib/src/atoms`): The primitives.
    - **`AppSurface`**: The core renderer handling physics, borders, shadows, and blur.
    - Includes `AppText`, `AppGap`, `AppSkeleton`, `AppIcon`, `AppDivider`.
- **Molecules** (`lib/src/molecules`): Semantic components composed of atoms.
    - Buttons, Inputs, Toggles, Cards, Navigation, Feedback.
- **Organisms** (`lib/src/organisms`): Complex, standalone UI sections.
- **Layout** (`lib/src/layout`): Responsive wrappers.

## 🌟 Key Features (v2.0)

* **App Unified Color System (v1.2)**: A comprehensive and reactive color management layer fully compatible with Material 3. It allows seamless configuration where changes to Material colors (e.g., Primary) automatically propagate to derived Style colors (e.g., Glow), while also supporting explicit style overrides.
* **Multi-Paradigm Support**: Seamlessly switch between **Glass** (Liquid), **Brutal** (Mechanical), **Flat** (Standard), **Neumorphic** (Tactile), and **Pixel** (Retro) themes, now all powered by the Unified Color System.
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
````

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
  - **Nodes**: `OrbitNode`, `PulseNode`, `LiquidNode` with status-driven styles.
  - **Links**: Dynamic link rendering visualizing signal strength.

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
| **AppButton** | Molecule | Interactive button with various styles. | `onPressed`, `label`, `icon`, `variant` (primary/secondary/ghost), `size`, `isLoading`, `isDisabled` |
| **AppIconButton** | Molecule | Icon-only button. | `onPressed`, `icon`, `variant`, `size`, `isLoading`, `tooltip` |
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

## 📚 Documentation

Detailed architecture decisions can be found in the `specs/` directory:

  - `specs/002-unified-design-system`: Core Architecture & Data Model.
  - `specs/003-ui-kit-molecules`: Component Implementation Plans.
  - **`specs/017-unified-color-system`**: Details the App Unified Color System (v1.2), covering Material 3 integration, seamless configuration, and multi-theme support.
  - **`specs/019-legacy-migration`**: Migration strategy for legacy components (`AppSlideAction`, `AppExpandableFab`, `AppGauge`) with IoC compliance.

## 📦 Dependencies

Key packages used:

  - **Styling**: `theme_tailor_annotation`
  - **Layout**: `flutter_portal`, `gap`
  - **Testing**: `alchemist`, `widgetbook`
  - **Utils**: `equatable`, `flutter_animate`
