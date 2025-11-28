# 📜 Flutter UI Component Library Charter (ui_kit)

**Version**: 2.0.0
**Effective Date**: 2025-11-28
**Scope**: All contributors and maintainers of the UI Library

---

## 1. Vision & Scope
This library aims to provide a **High Cohesion, Logic-Free, Theme-Driven** set of UI components. It serves as the **Single Source of Truth** for the application's visual presentation, supporting **Multi-Paradigm Visual Styles** (e.g., Glassmorphism, Neo-Brutalism).

* **Scope**: Atomic components (Atoms), composite components (Molecules), theme definitions (Theming), icon assets (Assets), and basic layout logic (Layout).
* **Out of Scope**: API connectivity, state management (Bloc/Provider), routing logic (Routing), and business data models (Data Models).

---

## 2. Architectural Boundaries

### 2.1 Physical Isolation
* The library must exist as an **independent Dart Package**, physically enforced to decouple it from the main app.

### 2.2 Dependency Hygiene
* ❌ **Forbidden**: Dependencies containing business logic or backend connectivity are strictly prohibited (e.g., `bloc`, `provider`, `riverpod`, `http`, `dio`, `firebase`, `shared_preferences`).
* ✅ **Allowed**: UI and utility packages only (e.g., `flutter`, `intl`, `vector_math`, `google_fonts`, `flutter_svg`, `rive`, `theme_tailor`, `flutter_animate`, `flutter_gen`).

### 2.3 Directory Structure
Adopts a variation of **Atomic Design**:
* `src/foundation/`: Base styles (Theme Contracts, Specs, Colors, Typography).
* `src/atoms/`: Indivisible minimal units (AppSurface, Button, Icon).
* `src/molecules/`: Simple combinations (ListTile, InputField, Toggles).
* `src/organisms/`: Complex blocks (AppBar, ProductCard).
* `src/layout/`: Responsive layout helpers.

---

## 3. Architectural Core Principles

To maintain long-term maintainability and support multi-style switching, all development must adhere to the following philosophies.

### 3.1 Inversion of Control (IoC)
* **Definition**: Components must not determine their own specific appearance, nor should they inquire about the identity of the current theme. Control is inverted to the **Theme**.
* **Practice**:
    * **Ask "How", not "Who"**: Components ask the Theme "How should I look?" (e.g., color, shape), never "Who are you?" (e.g., "Are you Brutal style?").
    * **Theme as Configuration**: `AppDesignTheme` acts as a rendering configuration file containing all visual parameters.

### 3.2 Data-Driven Strategy (DDS)
* **Definition**: Eliminate hard-coded logic branches when handling structural or behavioral differences between styles. Use data structures (Specs) instead.
* **Practice**:
    * **Spec over Logic**: Instead of writing `if/else` or `switch` statements for style differences, define a **Spec** or **Enum** in the Theme (e.g., `ToggleStyle`, `InteractionSpec`).
    * **Renderer Pattern**: Components render content based on data within the Spec. Adding a new style involves injecting new data, not modifying component code.

---

## 4. Theming & Styling

### 4.1 The Contract: AppDesignTheme
* **Single Source of Truth**: `AppDesignTheme` is the sole source for the visual language. All visual properties (colors, radii, animation curves, spacing factors) must be retrieved from here.
* **Token-First**: Hardcoding `Color(0xFF...)` or `Colors.red` inside components is strictly prohibited.

### 4.2 Config Separation
* **AppPalette**: Brand colors and the base palette should be defined in `AppPalette` (Config) and injected via the `AppTheme` Factory. The Theme implementation layer is responsible for "logic mapping," not "defining color values."

### 4.3 Semantic Architecture
* **Intent Naming**: `ThemeExtension` variables must describe "usage" (e.g., `success`, `surfaceContainer`), **NOT** "appearance" (e.g., `green`, `orange`).

### 4.4 Automation & Tooling
* **Theme Tailor**: The `theme_tailor` package must be used to generate `ThemeExtension` classes.
* **Annotation**: The **`@TailorMixin`** annotation (replacing the deprecated `@Tailor`) must be used for automatic generation.
* **Prohibition**: Hand-writing `copyWith` and `lerp` methods is prohibited to reduce maintenance errors.

### 4.5 Typography
* Follow the **DRY Principle**. Create a unified `BaseTextStyle` to manage `fontFamily` and package paths. Do not repeat font parameters in individual styles.

---

## 5. Component Design & Primitives

### 5.1 The Primitive: AppSurface
* **Mandatory Usage**: All containers possessing visual background, borders, shadows, blur, or interaction effects **MUST** use `AppSurface` as the root or child node.
* **No Native Containers**: Business components must not directly use Flutter's native `Container` + `BoxDecoration` for visual styling.

### 5.2 Dumb Components
* Components receive data via **Constructor** and pass events via **Callback** (`VoidCallback`, `ValueChanged`).
* Components must not hold business state, only UI transient state (e.g., ScrollOffset).

### 5.3 Composition over Inheritance
* Use the **Slots Pattern** (e.g., `child`, `leading`, `trailing`, `content`).
* Avoid `MyRedButton`; prefer `MyButton(style: MyButtonStyle.danger())`.

---

## 6. Expansion Protocols

### 6.1 Component Expansion Protocol
When developing new UI components:
1.  **Composition First**: Prioritize using `AppSurface`.
2.  **No Runtime Type Checks**: Code **MUST NOT** contain checks like `if (theme is BrutalDesignTheme)`.
3.  **Renderer Separation**: Complex drawing logic (e.g., specific Toggle icons) **MUST** be extracted into an independent **Renderer Widget** (e.g., `ToggleContentRenderer`), driven by the Theme Spec.

### 6.2 Style Expansion Protocol
When introducing a new design language (e.g., Neumorphic):
1.  **Zero-Touch Policy**: Adding a new style **MUST NOT** require modifying the source code of existing components.
2.  **Full Compliance**: New styles must fully implement `AppDesignTheme`. Unsupported features (e.g., Blur in Brutalism) must provide **Graceful Degradation** (e.g., `blurStrength: 0.0`).
3.  **Semantic Consistency**: Strictly adhere to `SurfaceVariant` semantics (Base/Elevated/Highlight).

---

## 7. Assets Management

### 7.1 Access Control
* **Strong Typing**: String paths are prohibited. Use objects generated by **`flutter_gen`** (e.g., `MyAssets.icons.home`).

### 7.2 Formats
* **Icons**: Use **SVG**. Remove color attributes (`fill`) within the file; control color via `IconTheme`.
* **Product Images**: Prefer **WebP**.
* **Dark Mode**: Use `ColorFilter` for icons. For product images, use `ColorFiltered` with a semi-transparent black overlay (Dimming).

---

## 8. Animation Strategy

### 8.1 Technology Selection
* **Level 1 (Micro-interactions)**: Use **`flutter_animate`** or native code.
* **Level 2 (State-Driven)**: Complex state icons use **Rive (.riv)**.
* **Prohibited**: **Lottie** is not used due to file size and maintenance costs.

### 8.2 Rive Standards
* Use **State Machines** to encapsulate multiple states in a single file. Export as binary `.riv`.

---

## 9. Layout & Responsiveness

### 9.1 No Global State
* **Strictly Prohibited**: Using Singletons to store screen size. All layout calculations must rely on `BuildContext` and `MediaQuery`.

### 9.2 Centralized Config
* Breakpoints, Columns, and Gutters must be defined in **ThemeExtension** (`AppLayout`), not scattered across Widgets.

---

## 10. Accessibility & Internationalization

### 10.1 A11y
* Interactive components must wrap `Semantics` and declare correct `label`, `value`, and `onTap`.
* Touch targets must be at least **44x44 (iOS)** or **48x48 (Android)**.

### 10.2 i18n
* **No String Policy**: The library **MUST NOT** contain hardcoded display text. All labels must be passed from the outside.
* **RTL Support**: Use `Directionality`-safe properties (e.g., `EdgeInsetsDirectional.start`).

---

## 11. Performance

* **Repaint Boundary**: Wrap frequently changing components (e.g., Loaders) in `RepaintBoundary`.
* **Expensive Operations**: Use `Opacity` and `BackdropFilter` sparingly.

---

## 12. Quality Assurance & Testing

### 12.1 Widgetbook
* **Mandatory**: All public components must have a UseCase in Widgetbook with configurable Knobs.
* **Visual Verification**: Before submission, components must be verified by switching through all Design Languages (Glass, Brutal, etc.) to ensure no breakage.

### 12.2 Golden Tests
* **Test Matrix**: Core components must include screenshot tests covering:
    * **Theme**: Light / Dark.
    * **Styles**: Glass / Brutal / Flat.
    * **Text Scale**: Standard (1.0) / Accessibility (1.5).
* **Zero Overflow**: At 1.5x text scale, screenshots must not show overflow warnings, and text must not obscure critical operation areas.

---

## 13. Governance

### 13.1 Constitution Version
2.0.0

### 13.2 Ratification Date
2025-11-28

### 13.3 Amendment Procedure
Amendments to this constitution require a consensus among core maintainers. Proposed changes must be thoroughly documented, reviewed, and approved before being incorporated. Minor clarifications and typo fixes may be applied by any maintainer.

### 13.4 Compliance Review
Adherence to these principles will be reviewed periodically during code reviews, architectural discussions, and sprint retrospectives. Non-compliance must be addressed and resolved promptly.

---

## Appendix: Code Review Checklist

Reviewers shall inspect code based on the following:

- [ ] **Architecture**: Is `AppSurface` used instead of `Container`?
- [ ] **IoC/DDS**: Are `runtimeType` checks avoided? Is divergent logic moved to Theme Specs?
- [ ] **Automation**: Is `@TailorMixin` used for the theme class?
- [ ] **Completeness**: Is a Widgetbook Story added covering all interaction states?
- [ ] **Semantics**: Are `SurfaceVariant` and `spacingFactor` used correctly?
- [ ] **Verification**: Has the component been visually verified across all Design Languages?