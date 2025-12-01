# UI Kit Library

A high-cohesion, theme-driven UI component library for the USP Client POC project. This package follows **Atomic Design** principles to provide a robust and reusable set of widgets, designed for scalability and maintainability.

## 🏗 Architecture

This project is structured using **Atomic Design**:

- **Atoms** (`lib/src/atoms`): Basic building blocks (Icons, Typography, Colors, Buttons, simple inputs). High stability, low complexity.
- **Molecules** (`lib/src/molecules`): Groups of atoms functioning together (Form fields with labels, Search bars, Card headers).
- **Organisms** (`lib/src/organisms`): Complex UI components composed of groups of molecules and/or atoms (Forms, Navigation bars, Product cards).
- **Layout** (`lib/src/layout`): Layout-specific components and wrappers.
- **Foundation** (`lib/src/foundation`): Core utilities, theme definitions, generated assets, and constants.

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

## 🛠 Development

### Code Generation

This project relies heavily on code generation for Assets (`flutter_gen`) and Themes (`theme_tailor`).

To run the code generator:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Assets

Assets are managed in the `assets/` directory and code-generated into safe Dart accessors.

- **Images**: `assets/images/`
- **Icons**: `assets/icons/`
- **Fonts**: `assets/fonts/`
- **Animations**: `assets/anims/` (Rive files)

**Usage:**
Code is generated in `lib/src/foundation/gen/`.

### Widgetbook (Component Catalog)

We use [Widgetbook](https://www.widgetbook.io/) to document and test components in isolation.

To run Widgetbook:

1.  Navigate to the widgetbook directory:
    ```bash
    cd widgetbook
    ```
2.  Run the app:
    ```bash
    flutter run -d chrome
    ```
    (Or choose your preferred device/emulator)

To generate Widgetbook use cases:
```bash
cd widgetbook
dart run build_runner build --delete-conflicting-outputs
```

## 🧪 Testing

### Unit & Widget Tests
Run standard Flutter tests:

```bash
flutter test
```

### Golden Tests
We use `alchemist` for visual regression testing (Golden Tests).

To run golden tests:
```bash
flutter test --tags golden
```
*(Note: Ensure you are on the correct platform for golden generation if required)*

## 📚 Documentation

Detailed specifications and plans can be found in the `specs/` directory:
- `specs/001-ui-kit-init`: Initial setup and charter.
- `specs/002-unified-design-system`: Design system specifications.
- `specs/003-ui-kit-molecules`: Component specific specs.

## 📦 Dependencies

Key packages used:
- **Styling**: `theme_tailor_annotation`
- **Assets**: `flutter_svg`, `rive`
- **Animation**: `flutter_animate`
- **Utilities**: `gap`, `equatable`