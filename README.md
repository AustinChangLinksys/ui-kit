# UI Kit Library

A high-cohesion, theme-driven UI component library for the USP Client POC project. This package implements the **Unified Design System (v2.0)**, following **Atomic Design** principles to provide a robust, scalable, and maintainable set of widgets.

It features a **Data-Driven Strategy (DDS)** that allows runtime switching between distinct visual languages (Glassmorphism, Neo-Brutalism, Flat, Neumorphic) without changing business logic.

## 🏗 Architecture

This project is structured using **Atomic Design** with strict architectural boundaries:

- **Foundation** (`lib/src/foundation`): The brain of the system. Contains `AppDesignTheme` contracts, `Specs` (Layout, Interaction, Typography), and Tokens.
- **Atoms** (`lib/src/atoms`): The primitives.
    - **`AppSurface`**: The core renderer handling physics, borders, shadows, and blur.
    - Includes `AppText`, `AppGap`, `AppSkeleton`.
- **Molecules** (`lib/src/molecules`): Semantic components composed of atoms.
    - Buttons, Inputs, Toggles, Cards, Navigation.
- **Organisms** (`lib/src/organisms`): Complex, standalone UI sections.
- **Layout** (`lib/src/layout`): Responsive wrappers.

## 🌟 Key Features (v2.0)

* **Multi-Paradigm Support**: Seamlessly switch between **Glass** (Liquid), **Brutal** (Mechanical), **Flat** (Standard), and **Neumorphic** (Tactile) themes.
* **Physics-Based Interaction**: Components inherit physical behaviors (Scale, Glow, Offset) from the active theme via `InteractionSpec`.
* **Smart Layouts**: Spacing and margins automatically adapt to the theme's density using `spacingFactor`.
* **Safe Mode Testing**: Automated Golden Tests covering the full 8-style matrix (4 themes × Light/Dark).

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

## ✨ Widgetbook Stories Overview

Below is the summary of components available in our system:

### Atoms (Basic Building Blocks)

  - **AppSurface**: The core container showcasing different levels (Base, Elevated, Highlight) and interactive physics.
  - **AppText**: Supports the full Material 3 typography scale and semantic shortcuts (`.headline`, `.body`, `.tiny`).
  - **AppGap**: Smart spacing component demonstrating various sizes (xxs-xxxl) and responsive gutters.
  - **AppSkeleton**: Smart loading placeholder showcasing Pulse (Glass) and Blink (Brutal) animations.
  - **Assets**: Showcases `AppIcon` and `ThemeAwareSvg` with automatic color adaptation.

### Molecules (Functional Components)

  - **Buttons**:
      - **AppButton**: Supports Size Variants (S/M/L), Loading states, and icon combinations.
      - **AppIconButton**: Enforced 1:1 aspect ratio, shape adapts automatically to theme (Circle/Square).
  - **Forms**:
      - **AppTextField**: Supports Outline, Underline, and Filled variants, plus Focus/Error states.
      - **AppSlider**: Supports continuous sliding and discrete steps (Divisions).
      - **AppSwitch**: Demonstrates the Renderer Pattern (Texture/Text/Icon/Dot).
      - **AppCheckbox / AppRadio**: State-driven selection controls.
  - **Display**:
      - **AppBadge**: Status badge supporting custom color tinting.
      - **AppTag**: Label component supporting interaction and deletion.
      - **AppAvatar**: Enforced circular avatar supporting image cropping and text fallback.
      - **AppTooltip**: Supports multi-directional positioning and rich content popovers.

### Navigation

  - **AppNavigationBar**: Bottom navigation bar showcasing the layout difference between Glass (Floating) and Brutal (Fixed).
  - **AppNavigationRail**: Vertical side navigation for desktop/tablet layouts.

### Examples (Scenarios)

  - **DashboardPage**: A complete dashboard example (Kitchen Sink) integrating all components to demonstrate RWD layout and overall theme switching effects.
  - **MockupPage**: Basic typography and layout example.

## 📚 Documentation

Detailed architecture decisions can be found in the `specs/` directory:

  - `specs/002-unified-design-system`: Core Architecture & Data Model.
  - `specs/003-ui-kit-molecules`: Component Implementation Plans.

## 📦 Dependencies

Key packages used:

  - **Styling**: `theme_tailor_annotation`
  - **Layout**: `flutter_portal`, `gap`
  - **Testing**: `alchemist`, `widgetbook`
  - **Utils**: `equatable`, `flutter_animate`

