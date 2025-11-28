# Feature Specification: UI Kit Unified Design System (v2.0)

**Feature Branch**: `002-unified-design-system`
**Created**: November 27, 2025
**Status**: Draft
**Input**: User description: "UI Kit Architecture Specification: Unified Design System (v2.0) Objective: Establish a scalable, multi-paradigm Design System architecture that allows runtime switching between distinct visual languages (e.g., Glassmorphism, Neo-Brutalism, Flat) while maintaining a unified semantic component library..."

## Clarifications

### Session 2025-11-27
- Q: Typography & Iconography → A: Integrate into AppDesignTheme (e.g., bodyStyleOverride).
- Q: Interaction States → A: AppSurface handles interaction via 'interactive' flag.
- Q: Motion & Physics → A: Add AnimationSpec to AppDesignTheme.
- Q: Metrics & Spacing → A: Add spacingFactor to AppDesignTheme.

### Session 2025-11-27 (Part 2)
- Q: Additional Design Languages → A: Add Flat and Neumorphic themes, both supporting Light/Dark modes.
- Q: Widgetbook Control Separation → A: Implement independent controls for "Design Language" (Knob) and "Theme Mode" (Addon) to allow orthogonal switching (e.g., Flat + Dark, Neumorphic + Light).

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Foundation: Theming & Primitives (Priority: P1)

As a developer, I want to use a unified `AppSurface` primitive that automatically adapts its appearance based on the active `AppDesignTheme`, so that I can build components without hardcoding visual styles like "Glass" or "Brutalism".

**Why this priority**: This is the architectural core. Without the abstract theme contract and the smart primitive renderer (`AppSurface`), no components can be migrated or created in the new system.

**Independent Test**: Create a test widget using `AppSurface`. Switch the theme between `GlassDesignTheme` and `BrutalDesignTheme` in a test environment. Verify that the `AppSurface` renders with blur/transparency for Glass, and solid color/thick border for Brutalism.

**Acceptance Scenarios**:

1. **Given** the `AppDesignTheme` contract is defined, **When** I implement `GlassDesignTheme` and `BrutalDesignTheme`, **Then** both must adhere to the interface (providing `SurfaceStyle` for base, elevated, and highlight variants).
2. **Given** an `AppSurface` widget in the tree, **When** the parent theme provides `GlassDesignTheme`, **Then** the surface renders with the configured blur strength, border color, and shadow.
3. **Given** an `AppSurface` widget in the tree, **When** the parent theme provides `BrutalDesignTheme`, **Then** the surface renders with 0 blur, a thick solid border, and a hard offset shadow.

---

### User Story 2 - Component Migration: Card & Dialog (Priority: P2)

As a developer, I want to use semantic components like `AppCard` and `AppDialog` that internally use `AppSurface`, so that my application UI automatically switches design languages when the global theme changes.

**Why this priority**: This proves the architecture works for actual components and migrates the existing "Liquid Glass" components to the new universal system.

**Independent Test**: Replace `LiquidGlassCard` with `AppCard` in a demo screen. Toggle the theme. The card should visually transform from a glass card to a brutalist card without changing the component code.

**Acceptance Scenarios**:

1. **Given** the `AppCard` component, **When** placed in a `BrutalDesignTheme` context, **Then** it renders as a Neo-Brutalist card (solid, thick border).
2. **Given** the `AppDialog` component, **When** placed in a `GlassDesignTheme` context, **Then** it renders as a Glassmorphism dialog (blurred background, semi-transparent).
3. **Given** the legacy `LiquidGlassCard` and `LiquidGlassDialog`, **When** the migration is complete, **Then** these are either deprecated or reimplemented as wrappers around `AppCard`/`AppDialog` with a forced Glass theme for backward compatibility.

---

### User Story 3 - Widgetbook Visualization (Priority: P3)

As a designer, I want to toggle between different "Design Languages" (Glass, Brutal) in Widgetbook, so that I can instantly verify how components look across different brand identities.

**Why this priority**: Visual verification is crucial for a design system. This enables designers and developers to "see" the multi-paradigm architecture in action.

**Independent Test**: Run Widgetbook. Locate the "Design Language" knob or theme addon. Switch between "Glass" and "Brutal". All displayed components in the story canvas must update their visual style immediately.

**Acceptance Scenarios**:

1. **Given** Widgetbook is running, **When** I access the Theme/Knob controls, **Then** I see options for "Design Language" (e.g., Glass, Brutal).
2. **Given** a component story is visible, **When** I switch the language from Glass to Brutal, **Then** the component redraws with the Brutal style.

### Edge Cases

- What happens if `AppDesignTheme` is missing from the context? (Assumption: `AppSurface` should fallback to a safe default, likely a simple Material-like style or throw a clear error if enforced).
- How does `AppSurface` handle overrides? (If a user manually provides `color` or `border`, it should likely override the theme style, but this needs to be defined).

## Constitutional Alignment

*GATE: All specifications MUST adhere to the principles outlined in the Project Constitution (v1.0.0).*

- **2. Architectural Boundaries**: This feature respects the `foundation` (Theme), `atoms` (`AppSurface`), and `molecules` (`AppCard`) separation defined in section 2.3.
- **3. Theming & Styling**: Heavily relies on `ThemeExtension` (Section 3.2 Semantic Architecture) and `theme_tailor` (Section 3.3 Automation) to define the new `AppDesignTheme`.
- **4. Component Design**: `AppCard` and `AppDialog` will be "Dumb Components" (Section 4.1), delegating rendering logic to `AppSurface` and style logic to the Theme.
- **12. Quality Assurance & Testing**: Widgetbook integration (Section 12.1) is a core part of this feature (User Story 3).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST define an abstract `AppDesignTheme` ThemeExtension class containing definitions for `SurfaceStyle` (base, elevated, highlight).
- **FR-002**: The system MUST implement `GlassDesignTheme` matching the existing Glassmorphism style.
- **FR-003**: The system MUST implement `BrutalDesignTheme` matching Neo-Brutalism principles (no blur, thick borders, hard shadows).
- **FR-004**: The system MUST provide an `AppSurface` primitive atom that renders a container based on the current `AppDesignTheme`'s `SurfaceStyle`.
- **FR-005**: `AppSurface` MUST support rendering special effects defined in the style, such as `BackdropFilter` for blur (Glass) or hard offset shadows (Brutal).
- **FR-006**: The system MUST provide `AppCard` and `AppDialog` components that utilize `AppSurface` for rendering.
- **FR-007**: Widgetbook MUST allow toggling between `GlassDesignTheme` and `BrutalDesignTheme` at runtime.
- **FR-008**: `AppDesignTheme` MUST include `typography` override settings (e.g., font family preference per style).
- **FR-009**: `AppDesignTheme` MUST include `animation` settings (duration, curve) to define motion physics per style.
- **FR-010**: `AppDesignTheme` MUST include a `spacingFactor` to control global density scaling.
- **FR-011**: `AppSurface` MUST support an `interactive` boolean property that enables state-driven visual changes (hover/press) using the theme's motion settings.
- **FR-012**: The system MUST implement `NeumorphicDesignTheme`, supporting both Light (soft shadows, low contrast) and Dark modes.
- **FR-013**: The system MUST implement `FlatDesignTheme`, supporting both Light (clean, borderless) and Dark modes.
- **FR-014**: Widgetbook MUST support orthogonal switching of "Design Language" (via custom Knob) and "Theme Mode" (via standard Addon), allowing dynamic combination (e.g., Flat + Dark).

### Key Entities

- **AppDesignTheme**: The abstract contract for a visual design language. Includes `SurfaceStyle` sets, `AnimationSpec`, `spacingFactor`, and `TypographySpec`.
- **SurfaceStyle**: A data class defining visual properties (color, border, shadow, blur) for a specific surface type.
- **AppSurface**: The core renderer widget that translates `SurfaceStyle` into Flutter widgets (`Container`, `DecoratedBox`, `BackdropFilter`) and handles interactions if enabled.
- **AnimationSpec**: Defines `Duration` and `Curve` for implicit animations.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: `AppCard` rendered with `GlassDesignTheme` visually matches the legacy `LiquidGlassCard` (visual regression test).
- **SC-002**: `AppCard` rendered with `BrutalDesignTheme` exhibits 0 blur radius and visible borders/hard shadows as defined in the theme.
- **SC-003**: Switching themes in Widgetbook updates the UI in under 1 second without requiring a full app restart.
- **SC-004**: New components (e.g., a future `AppBadge`) can be implemented using `AppSurface` with `< 20` lines of layout code (excluding constructor boilerplate).
- **SC-005**: All 4 design themes (Glass, Brutal, Flat, Neumorphic) render legibly in both Light and Dark modes.