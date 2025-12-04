# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is **UI Kit Library** — a high-cohesion, theme-driven UI component library following **Atomic Design** principles. It implements the **Unified Design System (v2.0)** with support for multiple visual languages (Glassmorphism, Neo-Brutalism, Flat, Neumorphic, Pixel) that can be switched at runtime without changing business logic.

The repository contains three Flutter projects:
- **`./`** (root): The main UI Kit library package
- **`./widgetbook/`**: Component catalog and testing environment (Widgetbook)
- **`./editor/`**: Theme editor application

## Essential Commands

### Code Generation
All theme and asset code is generated and must be regenerated after changes:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Development & Testing

**Run all tests:**
```bash
flutter test
```

**Run a single test file:**
```bash
flutter test test/molecules/buttons/app_button_golden_test.dart
```

**Update golden files (visual regression tests):**
```bash
flutter test --update-goldens --tags golden
```

**Analyze code:**
```bash
flutter analyze
```

### Widgetbook (Component Catalog)
Interactive documentation and component showcase:
```bash
cd widgetbook
flutter run -d chrome  # Chrome recommended for Glass effects
```

### Theme Editor
Live theme customization tool:
```bash
cd editor
flutter run
```

## Architecture Overview

### Atomic Design Structure

The codebase is organized in `lib/src/` following strict architectural boundaries:

#### **Foundation** (`lib/src/foundation/`)
The core system containing design contracts and configuration:
- **`design_system.dart`**: Global entry point for system initialization (mount to `MaterialApp.builder`)
- **`theme/`**: Theme system and specifications
  - **`app_design_theme.dart`**: Main theme container (uses `@TailorMixin()` from `theme_tailor`)
  - **`design_system/specs/`**: Component-specific styles (e.g., `surface_style.dart`, `input_style.dart`)
  - **`design_system/styles/`**: Theme implementations for each visual language:
    - `glass_design_theme.dart`
    - `brutal_design_theme.dart`
    - `flat_design_theme.dart`
    - `neumorphic_design_theme.dart`
    - `pixel_design_theme.dart`
- **`tokens/`**: Design tokens (colors, spacing, typography)
  - `app_theme.dart`: Color palette and theme definitions
  - `app_spacing.dart`: Spacing values
  - `app_palette.dart`: Color definitions
  - `app_typography.dart`: Typography system
- **`gen/`**: Auto-generated code (assets and fonts via `flutter_gen`)

#### **Atoms** (`lib/src/atoms/`)
Primitive, reusable components:
- **`surfaces/`**: `AppSurface` (core renderer for physics, borders, shadows, blur)
- **`typography/`**: `AppText` (supports Material 3 typography scale)
- **`layout/`**: `AppGap`, `AppDivider`
- **`loading/`**: `AppSkeleton` (adaptive animations: Pulse for Glass, Blink for Brutal)
- **`icons/`**: `AppIcon`, `ThemeAwareSvg`
- **`images/`**: `ThemeAwareImage`, `ProductImage`

#### **Molecules** (`lib/src/molecules/`)
Semantic components composed of atoms:
- **`buttons/`**: `AppButton`, `AppIconButton`
- **`inputs/`**: `AppTextField`, `AppTextFormField`, `AppDropdown`, `AppSlider`
- **`selection/`**: `AppCheckbox`, `AppRadio`
- **`toggles/`**: `AppSwitch` (uses Renderer Pattern with `toggle_content_renderer.dart`)
- **`status/`**: `AppBadge`, `AppTag`, `AppAvatar`
- **`feedback/`**: `AppLoader`, `AppToast`
- **`display/`**: `AppTooltip`
- **`layout/`**: `AppListTile`
- **`cards/`**: `AppCard`
- **`dialogs/`**: `AppDialog`
- **`navigation/`**: `AppNavigationBar`, `AppNavigationRail`
- **`forms/`**: Form-integrated inputs
- **`inputs/network/`**: Specialized network inputs (`AppIPv4TextField`, `AppIPv6TextField`, `AppMacAddressTextField`)

#### **Organisms** (`lib/src/organisms/`)
Complex, standalone UI sections

#### **Layout** (`lib/src/layout/`)
Responsive wrappers and layout utilities

### Key Design Patterns

#### **Theme Tailor Integration**
Component styles are generated using `@TailorMixin()` from the `theme_tailor` package:
- Specs are defined in `design_system/specs/` with `@TailorMixin()` annotation
- Generated `.tailor.dart` files provide `copyWith` and `lerp` methods
- Main `AppDesignTheme` extends `ThemeExtension<AppDesignTheme>` and includes all specs

#### **Data-Driven Strategy (DDS)**
Multiple visual languages coexist without affecting business logic:
- Each theme style file (`glass_design_theme.dart`, etc.) creates separate `AppDesignTheme` instances
- Switch themes at runtime by providing different theme data to Flutter's theme system
- Spacing and layout adapt via `spacingFactor` in `AppDesignTheme`

#### **Interaction Spec Pattern**
Components inherit physical behaviors from the active theme:
- `InteractionSpec` defines scale, glow, offset animations
- Components use `InteractionSpec` from `AppDesignTheme` to apply consistent interactions
- Different themes provide different physical behaviors

#### **Test Matrix**
Golden tests use `alchemist` to verify all 8 style combinations simultaneously:
- 4 themes × 2 brightness modes (Light/Dark)
- Single test file verifies entire design system consistency

## Important Implementation Details

### AppSurface Pattern
The core renderer that all surface-based components use:
- Handles physics, borders, shadows, and blur effects
- Three hierarchy levels: `surfaceBase`, `surfaceElevated`, `surfaceHighlight`
- Different themes apply different visual treatments to the same hierarchy

### Typography System
`AppText` supports the full Material 3 typography scale with semantic shortcuts:
- Material 3 standards: displayLarge, displayMedium, headlineSmall, etc.
- Semantic shortcuts: `.headline()`, `.body()`, `.tiny()`
- Type-safe to prevent misuse

### Assets Generation
Assets are auto-generated via `flutter_gen`:
- Icon fonts and SVGs are processed automatically
- Output location: `lib/src/foundation/gen/`
- Configuration in `pubspec.yaml` under `flutter_gen:`

### Network Input Fields
Specialized validators for network configuration:
- `AppIPv4TextField`: IPv4 address validation
- `AppIPv6TextField`: IPv6 address validation
- `AppMacAddressTextField`: MAC address validation
- Located in `lib/src/molecules/inputs/network/`

## Testing Strategy

### Golden Tests
Visual regression testing for all components across all theme combinations:
- Location: `test/**/*_golden_test.dart`
- Run: `flutter test --update-goldens --tags golden`
- Uses `alchemist` for matrix testing

### Unit & Widget Tests
Standard logic and behavior tests:
- Location: `test/`
- Run: `flutter test`

## Common Development Tasks

### Adding a New Component
1. Create the widget in appropriate atomic tier (`atoms/`, `molecules/`, `organisms/`)
2. Create corresponding story in `widgetbook/lib/widgetbook.dart`
3. If component needs theme styling:
   - Define a `*Style` spec in `foundation/theme/design_system/specs/`
   - Annotate with `@TailorMixin()`
   - Add to `AppDesignTheme` in `app_design_theme.dart`
   - Regenerate: `dart run build_runner build --delete-conflicting-outputs`
4. Create golden test in `test/` mirroring the component hierarchy
5. Update the widgetbook and run `flutter test --update-goldens --tags golden`

### Adding Theme Support to a Component
1. Access `AppDesignTheme` from context: `Theme.of(context).extension<AppDesignTheme>()`
2. Use the appropriate spec for styling (e.g., `theme.inputStyle`, `theme.toggleStyle`)
3. Apply `InteractionSpec` if the component is interactive
4. Test across all themes by running golden tests

### Modifying Token Values
Tokens are defined in `foundation/tokens/` and distributed via `AppDesignTheme`:
1. Update the token value in the appropriate theme implementation file
2. Regenerate code: `dart run build_runner build --delete-conflicting-outputs`
3. Run golden tests to verify visual impact

## Dependencies

**Key packages:**
- `theme_tailor_annotation` & `theme_tailor`: Automatic theme extension generation
- `flutter_gen` & `flutter_gen_runner`: Asset code generation
- `widgetbook` & `widgetbook_annotation`: Component catalog and testing
- `alchemist`: Golden/visual regression testing
- `flutter_animate`: Micro-interactions
- `flutter_portal`: Overlay and portal patterns
- `flutter_svg`, `rive`: Asset support
- `equatable`: Value equality for data classes

## Specifications & Documentation

Design decisions and architecture documentation are in `specs/`:
- `specs/002-unified-design-system`: Core architecture and data model
- `specs/003-ui-kit-molecules`: Component implementation details
- Additional specs for features like forms, network inputs, and theme editor

## Active Technologies
- Dart 3.x / Flutter 3.x + flutter, theme_tailor_annotation, equatable, flutter_animate, alchemist (testing) (011-phase2-components)
- N/A (UI library, no persistence) (011-phase2-components)
- Dart 3.x / Flutter 3.x (SDK >=3.0.0 <4.0.0, Flutter >=3.13.0) (012-genui-phase3-aws-client)
- N/A (in-memory conversation history; no persistence required per spec) (012-genui-phase3-aws-client)
- N/A (conversation state in memory only) (013-genui-phase4-client-architect)

## Recent Changes
- 011-phase2-components: Added Dart 3.x / Flutter 3.x + flutter, theme_tailor_annotation, equatable, flutter_animate, alchemist (testing)
