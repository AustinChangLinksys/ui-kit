Here is the fully updated **Version 2.0.0** of the **UI Kit Constitution**.

I have incorporated the **Test Isolation Protocol** into **Section 12.2** to align with our SOP and resolve the Golden Test stability issues. I also ensured that **Section 5.1** and **Appendix A** correctly reflect the principle of **Composition** rather than inheritance.

---

# 📜 Flutter UI Component Library Charter (ui_kit)

**Version**: 2.0.0
**Effective Date**: 2025-11-28
**Scope**: All contributors and maintainers of the UI Library

---

## 1\. Vision & Scope

This library aims to provide a **High Cohesion, Logic-Free, Theme-Driven** set of UI components. It serves as the **Single Source of Truth** for the application's visual presentation, supporting **Multi-Paradigm Visual Styles** (e.g., Glassmorphism, Neo-Brutalism).

- **Scope**: Atomic components (Atoms), composite components (Molecules), theme definitions (Theming), icon assets (Assets), and basic layout logic (Layout).
- **Out of Scope**: API connectivity, state management (Bloc/Provider), routing logic (Routing), and business data models (Data Models).

---

## 2\. Architectural Boundaries

### 2.1 Physical Isolation

- The library must exist as an **independent Dart Package**, physically enforced to decouple it from the main app.

### 2.2 Dependency Hygiene

- ❌ **Forbidden**: Dependencies containing business logic or backend connectivity are strictly prohibited (e.g., `bloc`, `provider`, `riverpod`, `http`, `dio`, `firebase`, `shared_preferences`).
- ✅ **Allowed**: UI and utility packages only (e.g., `flutter`, `intl`, `vector_math`, `google_fonts`, `flutter_svg`, `rive`, `theme_tailor`, `flutter_animate`, `flutter_gen`).

### 2.3 Directory Structure

Adopts a variation of **Atomic Design**:

- `src/foundation/`: Base styles (Theme Contracts, Specs, Colors, Typography).
- `src/atoms/`: Indivisible minimal units (AppSurface, Button, Icon).
- `src/molecules/`: Simple combinations (ListTile, InputField, Toggles).
- `src/organisms/`: Complex blocks (AppBar, ProductCard).
- `src/layout/`: Responsive layout helpers.

---

## 3\. Architectural Core Principles

To maintain long-term maintainability and support multi-style switching, all development must adhere to the following philosophies.

### 3.1 Inversion of Control (IoC)

- **Definition**: Components must not determine their own specific appearance, nor should they inquire about the identity of the current theme. Control is inverted to the **Theme**.
- **Practice**:
  - **Ask "How", not "Who"**: Components ask the Theme "How should I look?" (e.g., color, shape), never "Who are you?" (e.g., "Are you Brutal style?").
  - **Theme as Configuration**: `AppDesignTheme` acts as a rendering configuration file containing all visual parameters.

### 3.2 Data-Driven Strategy (DDS)

- **Definition**: Eliminate hard-coded logic branches when handling structural or behavioral differences between styles. Use data structures (Specs) instead.
- **Practice**:
  - **Spec over Logic**: Instead of writing `if/else` or `switch` statements for style differences, define a **Spec** or **Enum** in the Theme (e.g., `ToggleStyle`, `InteractionSpec`).
  - **Renderer Pattern**: Components render content based on data within the Spec. Adding a new style involves injecting new data, not modifying component code.

---

## 4\. Theming & Styling

### 4.1 The Contract: AppDesignTheme

- **Single Source of Truth**: `AppDesignTheme` is the sole source for the visual language. All visual properties (colors, radii, animation curves, spacing factors) must be retrieved from here.
- **Token-First**: Hardcoding `Color(0xFF...)` or `Colors.red` inside components is strictly prohibited.

### 4.2 Config Separation

- **AppPalette**: Brand colors and the base palette should be defined in `AppPalette` (Config) and injected via the `AppTheme` Factory. The Theme implementation layer is responsible for "logic mapping," not "defining color values."

### 4.3 Semantic Architecture

- **Intent Naming**: `ThemeExtension` variables must describe "usage" (e.g., `success`, `surfaceContainer`), **NOT** "appearance" (e.g., `green`, `orange`).

### 4.4 Automation & Tooling

- **Theme Tailor**: The `theme_tailor` package must be used to generate `ThemeExtension` classes.
- **Annotation**: The **`@TailorMixin`** annotation (replacing the deprecated `@Tailor`) must be used for automatic generation.
- **Prohibition**: Hand-writing `copyWith` and `lerp` methods is prohibited to reduce maintenance errors.

### 4.5 Typography

- Follow the **DRY Principle**. Create a unified `BaseTextStyle` to manage `fontFamily` and package paths. Do not repeat font parameters in individual styles.

---

## 5\. Component Design & Primitives

### 5.1 The Primitive: AppSurface

- **Mandatory Usage (Composition)**: All containers possessing visual background, borders, shadows, blur, or interaction effects **MUST** compose `AppSurface` as the root or child node.
- **No Native Containers**: Business components must not directly use Flutter's native `Container` + `BoxDecoration` for visual styling.

### 5.2 Dumb Components

- Components receive data via **Constructor** and pass events via **Callback** (`VoidCallback`, `ValueChanged`).
- Components must not hold business state, only UI transient state (e.g., ScrollOffset).

### 5.3 Composition over Inheritance

- Use the **Slots Pattern** (e.g., `child`, `leading`, `trailing`, `content`).
- Avoid `MyRedButton`; prefer `MyButton(style: MyButtonStyle.danger())`.

---

## 6\. Expansion Protocols

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

## 7\. Assets Management

### 7.1 Access Control

- **Strong Typing**: String paths are prohibited. Use objects generated by **`flutter_gen`** (e.g., `MyAssets.icons.home`).

### 7.2 Formats

- **Icons**: Use **SVG**. Remove color attributes (`fill`) within the file; control color via `IconTheme`.
- **Product Images**: Prefer **WebP**.
- **Dark Mode**: Use `ColorFilter` for icons. For product images, use `ColorFiltered` with a semi-transparent black overlay (Dimming).

---

## 8\. Animation Strategy

### 8.1 Technology Selection

- **Level 1 (Micro-interactions)**: Use **`flutter_animate`** or native code.
- **Level 2 (State-Driven)**: Complex state icons use **Rive (.riv)**.
- **Prohibited**: **Lottie** is not used due to file size and maintenance costs.

### 8.2 Rive Standards

- Use **State Machines** to encapsulate multiple states in a single file. Export as binary `.riv`.

---

## 9\. Layout & Responsiveness

### 9.1 No Global State

- **Strictly Prohibited**: Using Singletons to store screen size. All layout calculations must rely on `BuildContext` and `MediaQuery`.

### 9.2 Centralized Config

- Breakpoints, Columns, and Gutters must be defined in **ThemeExtension** (`AppLayout`), not scattered across Widgets.

---

## 10\. Accessibility & Internationalization

### 10.1 A11y

- Interactive components must wrap `Semantics` and declare correct `label`, `value`, and `onTap`.
- Touch targets must be at least **44x44 (iOS)** or **48x48 (Android)**.

### 10.2 i18n

- **No String Policy**: The library **MUST NOT** contain hardcoded display text. All labels must be passed from the outside.
- **RTL Support**: Use `Directionality`-safe properties (e.g., `EdgeInsetsDirectional.start`).

---

## 11\. Performance

- **Repaint Boundary**: Wrap frequently changing components (e.g., Loaders) in `RepaintBoundary`.
- **Expensive Operations**: Use `Opacity` and `BackdropFilter` sparingly.

---

## 12\. Quality Assurance & Testing

### 12.1 Widgetbook

- **Mandatory**: All public components must have a UseCase in Widgetbook with configurable Knobs.
- **Visual Verification**: Before submission, components must be verified by switching through all Design Languages (Glass, Brutal, etc.) to ensure no breakage.

### 12.2 Golden Tests

- **Test Matrix**: Core components must include screenshot tests covering:
  - **Theme**: Light / Dark.
  - **Styles**: Glass / Brutal / Flat / Neumorphic (Full Matrix coverage).
  - **Text Scale**: Standard (1.0) / Accessibility (1.5).
- **Test Isolation Protocol**:
  - **Explicit Constraints**: All test scenarios **MUST** be wrapped in fixed-size containers (e.g., `SizedBox`). Relying on infinite constraints is strictly prohibited to prevent layout overflows and crashes.
  - **Background Visibility**: Scenarios **MUST** use `ColoredBox` injected with `theme.scaffoldBackgroundColor` to ensure Glass and Neumorphic effects are visible.
  - **Animation Freezing**: Tests involving infinite animations (Loading/Skeleton) **MUST** use `TickerMode(enabled: false)` or manual pump control to prevent timeouts.
- **Zero Overflow**: At 1.5x text scale, screenshots must not show overflow warnings.

### 12.3 Auxiliary Verification Applications

To ensure component robustness in extreme and dynamic environments, developers must synchronously maintain both **Widgetbook** and the **Theme Editor**. These applications serve as mandatory acceptance criteria for visual correctness.

1.  **Widgetbook (Isolation Verification)**

    - **Mandatory UseCases**: All new components must establish corresponding UseCases within Widgetbook.
    - **Boundary Testing**: Layout flexibility must be verified by simulating extreme content via **Knobs** (e.g., multi-line text wrapping, missing icons, minimal dimensions).
    - **Goal**: To ensure the structural integrity and correct interaction states (Hover, Press, Disabled) of a "single component" in an isolated environment.

2.  **Theme Editor (Integration Verification)**
    - **Implementation Synchronization**: Whenever a Theme Spec is added or modified (e.g., adding a new `ToggleStyle`), the parameter control panel in the Editor must be updated synchronously.
    - **Dynamic Stress Testing**: Acceptance must involve dynamic, drastic runtime adjustments of theme parameters via the Editor (e.g., drastically increasing global corner radius from 8px to 50px, or pushing color contrast to limits).
    - **Goal**: To verify strict adherence to **[3.1 IoC]** and **[3.2 DDS]** principles.
      - _Criteria_: If a component fails to update instantly or breaks visually when Editor parameters change, it indicates the presence of internal hard-coded logic and is deemed **Non-Compliant**.

---

## 13\. Governance

### 13.1 Constitution Version

2.0.0

### 13.2 Ratification Date

2025-11-28

### 13.3 Amendment Procedure

Amendments to this constitution require a consensus among core maintainers. Proposed changes must be thoroughly documented, reviewed, and approved before being incorporated. Minor clarifications and typo fixes may be applied by any maintainer.

### 13.4 Compliance Review

Adherence to these principles will be reviewed periodically during code reviews, architectural discussions, and sprint retrospectives. Non-compliance must be addressed and resolved promptly.

---

## Appendix A: Developer Implementation Guide (The Cookbook)

_This appendix provides concrete code examples to translate architectural principles into daily development habits. Deviating from the "Standard Pattern" requires strong justification._

### A.1 Containers & Styling

**Principle**: [2.1 The Primitive], [4.1 Token-First]

- **❌ Anti-Pattern (Old Habit)**:

  - Using `Container`, `DecoratedBox`, or `Material` for visual containers.
  - Hardcoding colors or border radii.

  <!-- end list -->

  ```dart
  // 🚫 BAD: Styles are locked. Cannot adapt to Glass/Brutal.
  Container(
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.black),
    ),
    child: ...
  )
  ```

- **✅ Standard Pattern**:

  - **Always** compose with `AppSurface`.
  - Rely on `variant` (semantic) or `style` (injected spec).

  <!-- end list -->

  ```dart
  // ✅ GOOD: Automatically applies Blur, Border, Shadow, and Colors from Theme.
  AppSurface(
    variant: SurfaceVariant.highlight,
    child: ...
  )
  // OR (for specific overrides from Spec)
  AppSurface(
    style: theme.toggleStyle.activeTrackStyle,
    child: ...
  )
  ```

### A.2 Logic & Differentiation

**Principle**: [1.2 Data-Driven Strategy], [3.2 Style Expansion]

- **❌ Anti-Pattern (Old Habit)**:

  - Checking `runtimeType` to render different content.

  <!-- end list -->

  ```dart
  // 🚫 BAD: Violates Open/Closed Principle. Breaks when adding 'Neumorphic'.
  if (theme is BrutalDesignTheme) {
    return Text("I");
  } else {
    return Icon(Icons.check);
  }
  ```

- **✅ Standard Pattern**:

  - Use the **Renderer Pattern**. Ask the Theme _what_ to render via Specs.

  <!-- end list -->

  ```dart
  // ✅ GOOD: The Theme configures the type; the Component just renders it.
  ToggleContentRenderer(
    type: theme.toggleStyle.activeType, // text, icon, or dot?
    text: theme.toggleStyle.activeText,
    icon: theme.toggleStyle.activeIcon,
  )
  ```

### A.3 Interaction & Physics

**Principle**: [3.1 Inversion of Control]

- **❌ Anti-Pattern (Old Habit)**:

  - Manually handling `GestureDetector` to implement press effects.

  <!-- end list -->

  ```dart
  // 🚫 BAD: Re-implementing physics. Inconsistent across themes.
  GestureDetector(
    onTapDown: (_) => setState(() => _scale = 0.9),
    child: Transform.scale(...)
  )
  ```

- **✅ Standard Pattern**:

  - Enable `interactive` on `AppSurface`.

  <!-- end list -->

  ```dart
  // ✅ GOOD: Inherits Theme-defined physics (Glass=Glow, Brutal=Offset).
  AppSurface(
    interactive: true,
    onTap: () { ... },
    child: ...
  )
  ```

### A.4 Layout & Metrics

**Principle**: [9.2 Centralized Config]

- **❌ Anti-Pattern (Old Habit)**:

  - Hardcoding pixel values for padding or spacing.

  <!-- end list -->

  ```dart
  // 🚫 BAD: Looks cramped in Brutalism, too loose in Dense themes.
  Padding(
    padding: EdgeInsets.all(16.0),
    child: ...
  )
  ```

- **✅ Standard Pattern**:

  - Scale values using `spacingFactor`.

  <!-- end list -->

  ```dart
  // ✅ GOOD: Scales automatically (e.g., 1.0x for Glass, 1.5x for Brutal).
  Padding(
    padding: EdgeInsets.all(16.0 * theme.spacingFactor),
    child: ...
  )
  ```

### A.5 Loading States

**Principle**: [5. Component Design]

- **❌ Anti-Pattern (Old Habit)**:

  - Using `CircularProgressIndicator` directly inside components.
  - Using static gray boxes.

  <!-- end list -->

  ```dart
  // 🚫 BAD: Native spinner style clashes with custom themes.
  if (isLoading) return CircularProgressIndicator();
  ```

- **✅ Standard Pattern**:

  - Use `AppSkeleton` which adapts animation (Pulse/Blink) to the theme.

  <!-- end list -->

  ```dart
  // ✅ GOOD: "Breathing" for Glass, "Blinking" for Brutal.
  if (isLoading) return AppSkeleton.circular(size: 24);
  ```

---

# Appendix B: Golden Test Standard Protocol

**Goal**: To ensure the **Stability**, **Consistency**, and **Readability** of visual regression tests across the entire UI library.

## B.1 Core Architecture

All Golden Test files must adhere to the following structure to ensure proper resource loading and test matrix generation.

```dart
void main() {
  // 1. Global Setup
  setUpAll(() async {
    // MUST load real fonts. Using Ahem (colored blocks) is prohibited.
    await loadAppFonts();
  });

  group('Component Golden Tests', () {
    // 2. Use the Matrix Factory
    // Hand-writing multiple goldenTest calls is prohibited.
    // You MUST use the matrix to generate all 8 styles (4 Themes x 2 Modes) at once.
    goldenTest(
      'Component - State Name',
      fileName: 'component_state_name',
      builder: () => buildThemeMatrix(
        name: 'State Name',
        width: 300.0, // Provide explicit width
        height: 100.0,
        child: ComponentUnderTest(...),
      ),
    );
  });
}
```

## B.2 Safe Mode Protocol

To prevent CI/CD failures, all test scenarios generated by `buildThemeMatrix` (and the underlying `buildSafeScenario`) must enforce the following protections:

### 1\. Explicit Constraints (Size Lock)

- **Rule**: Every test scenario **MUST** be wrapped in a fixed-size container (e.g., `SizedBox`).
- **Reason**: Prevents `RenderFlex overflow` errors and `BoxConstraints(biggest)` infinite expansion crashes.
- **Standard Sizes**:
  - Buttons/Inputs: `width: 300`, `height: 100`
  - Cards: `width: 300`, `height: auto`
  - Screens/Pages: `width: 375`, `height: 667`

### 2\. Background Visibility

- **Rule**: Every scenario **MUST** wrap the component in a `ColoredBox` injected with `theme.scaffoldBackgroundColor`.
- **Reason**:
  - **Glass Theme**: Requires a dark/colored background to show translucency and blur.
  - **Neumorphic Theme**: Requires specific grey tones to show shadow depth.
  - Transparent backgrounds make these themes invisible.

### 3\. Animation Freezing

- **Rule**: Scenarios are wrapped in `TickerMode(enabled: false)` by default.
- **Exception**: If testing an active animation sequence (e.g., Tooltip popping up), animation must be explicitly enabled, and time must be advanced manually via `pump()`.
- **Reason**: Prevents timeouts caused by infinite looping animations (e.g., `AppSkeleton` pulse, `AppLoader` spin) blocking `pumpAndSettle`.

## B.3 Interaction Strategy

For components requiring interaction to appear (e.g., Tooltips, Dialogs), prioritize **State Injection** over simulation.

- **✅ Recommended: State Injection**
  - Expose an `initiallyVisible` or `forceState` parameter in the component.
  - Usage: `AppTooltip(initiallyVisible: true, ...)`
  - **Benefit**: 100% stability, zero race conditions.
- **⚠️ Alternative: Simulated Interaction**
  - Use only when State Injection is impossible.
  - Must use the `pumpWidget` callback to manually trigger the event:
    ```dart
    pumpWidget: (tester, widget) async {
      await tester.pumpWidget(widget);
      await tester.longPress(find.byType(TargetWidget));
      await tester.pumpAndSettle();
    }
    ```

## B.4 Assets & Typography

- **Fonts**: Must use `test/test_utils/font_loader.dart` to register `NeueHaasGrot` and `LinksysIcons`.
- **Defensive Registration**: The loader must register both the `FamilyName` and `packages/ui_kit_library/FamilyName` to handle Flutter Test's path resolution behavior.
- **Icons**: Prefer using `Icon(Icons.xxx)` widgets, which automatically inherit the correct `contentColor` from `AppSurface`. Avoid hardcoded colors in SVGs.

---

## Appendix C: Code Review Checklist

Reviewers shall inspect code based on the following:

- [ ] **Architecture**: Is `AppSurface` used instead of `Container`?
- [ ] **IoC/DDS**: Are `runtimeType` checks avoided? Is divergent logic moved to Theme Specs?
- [ ] **Automation**: Is `@TailorMixin` used for the theme class?
- [ ] **Completeness**: Is a Widgetbook Story added covering all interaction states?
- [ ] **Semantics**: Are `SurfaceVariant` and `spacingFactor` used correctly?
- [ ] **Verification**: Has the component been visually verified across all Design Languages?
- [ ] **Testing**: Do Golden Tests use the "Safe Mode" pattern (Explicit Sizing + Background Color + Animation Freezing)?
