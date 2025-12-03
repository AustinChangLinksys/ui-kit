# Feature Specification: Semantic Color System Upgrade

**Feature Branch**: `007-semantic-colors`
**Created**: 2025-12-03
**Status**: Draft
**Input**: Introduce Secondary (Tonal) and Tertiary semantic layers to address Primary-heavy visual imbalance and establish richer visual hierarchy

## User Scenarios & Testing *(mandatory)*

<!--
  IMPORTANT: User stories should be PRIORITIZED as user journeys ordered by importance.
  Each user story/journey must be INDEPENDENTLY TESTABLE - meaning if you implement just ONE of them,
  you should still have a viable MVP (Minimum Viable Product) that delivers value.

  Assign priorities (P1, P2, P3, etc.) to each story, where P1 is the most critical.
  Think of each story as a standalone slice of functionality that can be:
  - Developed independently
  - Tested independently
  - Deployed independently
  - Demonstrated to users independently
-->

### User Story 1 - Visual Hierarchy with Secondary (Tonal) Surfaces (Priority: P1)

A designer or developer opens the Dashboard demo in any theme (Glass, Brutal, Flat, Neumorphic) and immediately notices a clear visual separation between critical primary actions (like "Add Device" buttons) and secondary states (like selected navigation tabs or applied filters). The dashboard demonstrates the full visual hierarchy: Base surfaces (low-importance), Tonal surfaces (medium-importance selected states), and Highlight surfaces (highest-priority CTAs). This reduces visual noise and makes the UI's information structure intuitively clear.

**Why this priority**: The core objective of this feature is solving the "Primary-heavy" visual imbalance. Without introducing Secondary (Tonal) surfaces and demonstrating them in the dashboard, the problem isn't solved. This directly enables users to design cleaner, more readable interfaces.

**Independent Test**: Can be fully tested by viewing the Dashboard demo and verifying that:
1. Primary actions (CTAs) stand out visually with Highlight surfaces
2. Selected/active states use distinctly different Tonal surfaces
3. The distinction is clear and unmistakable across at least two different themes

**Acceptance Scenarios**:

1. **Given** the Dashboard is loaded in Glass theme (Light mode), **When** a user views the navigation bar, **Then** the selected navigation item displays with a Tonal surface (tinted frost effect) clearly distinct from the unselected items.
2. **Given** the Dashboard is displayed with multiple interactive elements, **When** a user compares a "Publish" button (Highlight) to a "Save Draft" button (Tonal), **Then** the Highlight button is visually dominant and the Tonal button clearly indicates secondary priority.
3. **Given** the theme is switched to Brutal style, **When** a user views the same dashboard, **Then** the Tonal surface uses the theme's defined mechanical aesthetic (grey/halftone pattern) and maintains clear visual distinction from Base and Highlight surfaces.
4. **Given** the Dashboard is in Dark mode, **When** a user views Tonal surfaces, **Then** the Tonal surfaces are appropriately darkened and maintain visual distinction from the Light mode version.

---

### User Story 2 - Semantic Surface Extension in Theme Contract (Priority: P1)

A developer examines the `AppDesignTheme` class and finds that it now includes `surfaceSecondary` and `surfaceTertiary` properties alongside the existing `surfaceBase`, `surfaceElevated`, and `surfaceHighlight`. When they switch between the four design language implementations (Glass, Brutal, Flat, Neumorphic), each provides distinct visual definitions for these new surfaces that match the design language's aesthetic. The developer can immediately use these surfaces in their components without worrying about theme-consistency issues.

**Why this priority**: The foundation must support the new semantic layers. Without extending the theme contract, components cannot access the Secondary and Tertiary surfaces, making the feature incomplete. This is the architectural prerequisite for all component updates.

**Independent Test**: Can be fully tested by:
1. Verifying that each design language's theme implementation (glass_design_theme.dart, brutal_design_theme.dart, etc.) provides valid `surfaceSecondary` and `surfaceTertiary` definitions
2. Confirming that these surfaces can be accessed from `Theme.of(context).extension<AppDesignTheme>()`
3. Rendering a test component using each surface across all four themes and verifying they render without errors

**Acceptance Scenarios**:

1. **Given** a Flutter widget accesses the current theme extension, **When** it retrieves `theme.surfaceSecondary`, **Then** it receives a valid `SurfaceStyle` object with properly defined color, border, shadow, and blur properties.
2. **Given** the Glass theme is active, **When** a component renders with `surfaceSecondary`, **Then** the surface displays with tinted frost characteristics (higher opacity, slight color tint, distinct blur).
3. **Given** the Brutal theme is active, **When** a component renders with `surfaceSecondary`, **Then** the surface displays with mechanical characteristics (grey background or halftone pattern, thick borders).
4. **Given** all four themes are tested in both Light and Dark modes, **When** surfaces are rendered, **Then** each mode shows appropriately adjusted colors while maintaining visual intent.

---

### User Story 3 - AppButton with Tonal Variant (Priority: P1)

A developer adds a new button to their interface with the variant set to "Tonal" and immediately sees that it renders distinctly between Base (outline), Tonal (medium visibility), and Highlight (filled/maximum visibility) states. They use Tonal buttons for secondary actions like "Save Draft" or "Cancel," while reserving Highlight buttons for critical CTAs like "Publish" or "Delete." Testing across all four design themes shows that each theme renders the Tonal variant according to its visual language. The Tonal button's appearance is noticeably less shouting than Highlight but more prominent than Base.

**Why this priority**: `AppButton` is the most frequently used interactive component. Introducing Tonal variant support here demonstrates the feature's value immediately and unblocks other component updates. Teams can start using semantic color hierarchy in their buttons right away.

**Independent Test**: Can be fully tested by:
1. Creating buttons with Base, Tonal, and Highlight variants
2. Verifying visual distinction across all four themes
3. Confirming the button hierarchy makes information importance clear
4. Testing that the Tonal variant renders correctly in loading and disabled states

**Acceptance Scenarios**:

1. **Given** an AppButton with variant="tonal" is rendered, **When** viewed in Flat theme, **Then** it displays a light background fill with dark text (Material 3 Tonal Container style).
2. **Given** an AppButton with variant="tonal" is rendered in Glass theme, **When** compared to the same button with variant="highlight", **Then** the Tonal button shows semi-transparent tinted glass that is noticeably less dominant than the filled Highlight button.
3. **Given** a Tonal button is rendered in Brutal theme, **When** the user views it, **Then** it displays a solid grey background or patterned block, distinct from both outline and filled variants.
4. **Given** a Tonal button has isLoading=true, **When** the loader appears, **Then** it respects the theme's visual language and animates appropriately.

---

### User Story 4 - AppNavigationBar Selection with Tonal Indicator (Priority: P1)

A developer uses `AppNavigationBar` and sets one item as selected. Instead of just changing the icon/text color, the selected item now displays a prominent pill-shaped background indicator using the Secondary (Tonal) surface. This indicator is visually distinct from the unselected items but doesn't conflict with page-level primary actions (like FABs). The visual separation makes it immediately clear which navigation item is active, without introducing visual chaos that fights with the page's main CTA.

**Why this priority**: Navigation feedback is critical for usability. A clear selection state reduces user confusion about where they are in the app. Using Tonal surfaces for navigation selection prevents visual conflicts with primary actions on the page, solving a real UX problem.

**Independent Test**: Can be fully tested by:
1. Rendering a navigation bar with multiple items
2. Selecting different items and verifying the pill-shaped indicator appears and updates
3. Confirming the indicator uses the theme's Tonal surface
4. Verifying the indicator is visually distinct but doesn't dominate the page

**Acceptance Scenarios**:

1. **Given** an AppNavigationBar with 4 items (all unselected), **When** the user views it, **Then** all items display in Base styling with no background indicators.
2. **Given** an AppNavigationBar with selectedIndex=1, **When** the user views it, **Then** the selected item (index 1) displays a pill-shaped background using the Tonal surface style.
3. **Given** the selection changes from index 1 to index 3, **When** the change is applied, **Then** the Tonal indicator smoothly transitions to the new position and the previous selection returns to Base styling.
4. **Given** a page with a FAB using Highlight surface and a navigation bar with Tonal selection indicator, **When** the user views both, **Then** the FAB remains visually dominant and the navigation indicator is clearly secondary.
5. **Given** the navigation bar is displayed in Glass theme, **When** the Tonal indicator is rendered, **Then** it displays the theme's tinted frost effect for consistency.

---

### User Story 5 - AppTag with Selected State Using Tonal Surface (Priority: P2)

A developer renders a list of filter tags, each with an `isSelected` parameter. Unselected tags render in Base style, while selected tags automatically switch to Tonal style. This creates a clear visual distinction between "actionable tags" and "applied filters." Users can immediately see which filters are active without requiring additional UI affordances. In a filtering scenario with multiple selected tags, the visual hierarchy prevents the interface from becoming chaotic.

**Why this priority**: Tag selection states are important for form and filtering UIs. Automating the style switch based on selection state reduces developer effort and ensures consistent visual language. However, this is P2 because the feature can function without it—navigation bar selection (P1) is more critical to core usability.

**Independent Test**: Can be fully tested by:
1. Rendering tags with isSelected=true and isSelected=false
2. Verifying style switches automatically based on selection state
3. Confirming Tonal style is used for selected state
4. Testing across themes to ensure visual consistency

**Acceptance Scenarios**:

1. **Given** an AppTag with isSelected=false, **When** the tag is rendered, **Then** it displays in Base style (default, non-highlighted).
2. **Given** an AppTag with isSelected=true, **When** the tag is rendered, **Then** it automatically displays in Tonal style without requiring explicit variant parameter.
3. **Given** a list of tags with mixed selection states (some selected, some not), **When** the user views the list, **Then** selected tags are clearly visually distinct from unselected ones.
4. **Given** an AppTag's isSelected value changes from false to true, **When** the change is applied, **Then** the style transitions smoothly to Tonal.
5. **Given** multiple tags are selected, **When** the user views them in Brutal theme, **Then** the Tonal surfaces (mechanical aesthetic) are applied and the overall visual hierarchy remains clear without visual chaos.

---

### User Story 6 - Multi-Theme Support for Semantic Surfaces (Priority: P1)

A designer switches between Glass, Brutal, Flat, and Neumorphic themes in the widgetbook and verifies that all components using Secondary (Tonal) and Tertiary surfaces render correctly according to each theme's visual language. In Glass theme, Tonal surfaces display with tinted frost. In Brutal theme, they display with halftone or grey solid patterns. In Flat theme, they display with pale brand color fills. In Neumorphic theme, they display with shallow convex depth. The physics (blur, border, shadow) of each design language are respected.

**Why this priority**: The entire system is built on supporting multiple design languages. If the new semantic surfaces only work in one theme, the feature is fundamentally incomplete. Testing and verifying across all four themes is essential.

**Independent Test**: Can be fully tested by:
1. Rendering the same component (e.g., AppButton with Tonal variant, AppTag with selected state, AppNavigationBar) in all four themes
2. Verifying each theme's visual definitions are applied correctly
3. Confirming physics (shadows, blur, borders) respect each theme's aesthetic
4. Testing both Light and Dark modes for each theme

**Acceptance Scenarios**:

1. **Given** a component using Tonal surface is rendered in Glass theme, **When** the user views it, **Then** it displays with glass-specific properties: tinted frost, higher opacity, distinct blur.
2. **Given** the same component is rendered in Brutal theme, **When** the user views it, **Then** it displays with mechanical properties: grey/halftone fill, thick borders, no blur.
3. **Given** the component is rendered in Flat theme, **When** the user views it, **Then** it displays with flat-specific properties: pale brand color fill, sharp edges, minimal depth.
4. **Given** the component is rendered in Neumorphic theme, **When** the user views it, **Then** it displays with tactile properties: shallow convex depth, subtle shadows, distinct from base surface.
5. **Given** all four themes are rendered in both Light and Dark modes, **When** the user switches between modes, **Then** colors adapt appropriately while visual intent remains consistent.

---

### User Story 7 - Golden Test Matrix Coverage (Priority: P1)

The testing team runs the golden tests for all components using Tonal surfaces (AppButton, AppNavigationBar, AppTag) across the 8-style matrix (4 themes × 2 brightness modes). All tests pass, confirming visual consistency. Future developers can modify theme parameters and immediately see which components are affected by running the golden tests.

**Why this priority**: Regression safety is critical. Without comprehensive golden test coverage, future changes risk breaking the visual system unknowingly. The 8-style matrix is the standard for this codebase, so all new features must pass it.

**Independent Test**: Can be fully tested by running `flutter test --update-goldens --tags golden` and verifying all new tests pass in all 8 styles.

**Acceptance Scenarios**:

1. **Given** golden test files exist for AppButton (Tonal variant), AppNavigationBar, and AppTag (selected state), **When** tests are run, **Then** all 24 golden images (3 components × 8 styles) are generated without errors.
2. **Given** a developer modifies a theme parameter (e.g., color, border), **When** golden tests are run, **Then** affected components show visual changes in the golden diff, making the impact immediately visible.
3. **Given** the app is built in production mode, **When** all golden tests are executed, **Then** they complete within reasonable time (under 5 minutes total for all 24 images).

---

### Edge Cases

- What happens when a developer tries to use `surfaceSecondary` or `surfaceTertiary` in a theme that hasn't been updated to define them? (System should gracefully fallback to Base or raise a clear error)
- How does the system handle transitions between surfaces when theme is changed at runtime? (Surfaces should update immediately without flickering)
- What happens when a component uses Tonal surface in a theme where the Tonal definition is very similar to Base? (Visual distinction should be enforced—designers must ensure each surface level is visually distinct)
- How do disabled states interact with Tonal surfaces? (Disabled state styling should take precedence, graying out or desaturating the Tonal surface)

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The `AppDesignTheme` class MUST be extended to include `surfaceSecondary` and `surfaceTertiary` properties of type `SurfaceStyle`
- **FR-002**: All five design language implementations (Glass, Brutal, Flat, Neumorphic, Pixel) MUST provide distinct visual definitions for `surfaceSecondary` and `surfaceTertiary` that respect their aesthetic
- **FR-003**: `AppButton` MUST support a new `variant="tonal"` option that renders using `surfaceSecondary`
- **FR-004**: `AppNavigationBar` MUST display a pill-shaped background indicator for the selected item using `surfaceSecondary` instead of just changing text/icon color
- **FR-005**: `AppTag` MUST support an `isSelected` parameter that automatically switches between Base and Tonal surfaces
- **FR-006**: All components using Tonal surfaces MUST render correctly across all four design themes
- **FR-007**: The system MUST maintain physics-based consistency: Tonal surfaces MUST inherit the blur, border, and shadow properties of their respective design language
- **FR-008**: All components using new semantic surfaces MUST have comprehensive golden tests covering the 8-style matrix (4 themes × 2 brightness modes)
- **FR-009**: The Dashboard demo component MUST be updated to showcase the visual hierarchy: Base (low-priority), Tonal (medium-priority/selected), and Highlight (high-priority) surfaces
- **FR-010**: Disabled states in components using Tonal surfaces MUST remain visually distinguishable from enabled states

### Key Entities

- **SurfaceStyle**: Represents a visual surface definition including color, border (width, color, radius), shadow (blur, spread, offset, color), and blur properties. Used for Base, Elevated, Highlight, Secondary, and Tertiary surface levels.
- **AppDesignTheme**: The core theme extension that defines all surfaces and component specifications. Now includes surfaceSecondary and surfaceTertiary alongside existing surfaces.
- **Design Language**: One of five implementations (Glass, Brutal, Flat, Neumorphic, Pixel) that provides distinct visual definitions for all surfaces while maintaining consistent physics principles.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Dashboard demo displays a clear, unmistakable visual separation between Primary (Highlight) actions, Secondary (Tonal) states, and Base surfaces—developers should immediately recognize the three-tier hierarchy without explanation
- **SC-002**: `AppButton` supports Tonal variant and renders correctly across all four themes; visual distinction between Base, Tonal, and Highlight variants is clear in both Light and Dark modes
- **SC-003**: `AppNavigationBar` selected item displays with a pill-shaped Tonal background indicator; navigation selection state is immediately obvious to end-users without ambiguity
- **SC-004**: `AppTag` with `isSelected=true` automatically switches to Tonal surface; selected tags are visually distinct from unselected tags without requiring additional component parameters
- **SC-005**: All 24 golden tests (3 components × 4 themes × 2 modes, or extended to all components using Tonal surfaces) pass without regressions
- **SC-006**: Tonal surfaces respect design language physics: Glass theme shows tinted frost with blur, Brutal shows mechanical patterns, Flat shows pale color fills, Neumorphic shows shallow convex depth
- **SC-007**: Code generation and theme tailor integration work seamlessly—new surfaces automatically appear in generated theme extension code with proper copyWith and lerp methods
- **SC-008**: Developers can apply Tonal surfaces to new components within 10 minutes (accessing from theme, understanding visual intent, implementing in widget)
- **SC-009**: Visual noise in the dashboard demo is reduced compared to baseline: critical actions stand out, secondary states are clearly marked, and the overall information hierarchy is readable at a glance

## Assumptions

- The existing `SurfaceStyle` data model is sufficient to represent Secondary and Tertiary surfaces; no new properties are needed
- Tonal surfaces should be derived from the theme's secondary color palette (Material 3 convention) or mechanically defined in Brutal/Neumorphic themes
- The Dashboard demo is the primary showcase; other components can be updated incrementally after the foundation is in place
- "Tonal" and "Tertiary" surface terminology aligns with Material Design 3 conventions for consistency with Flutter/Material ecosystem
- Disabled states take visual precedence over semantic surfaces (a disabled Tonal button should appear grayed out, not in full Tonal color)

## Constraints

- All changes MUST maintain backward compatibility with existing themes and components
- The change MUST not increase bundle size significantly (generated code should be minimal)
- All new code MUST follow the existing architectural patterns (Atomic Design, theme tailor integration, physics-based rendering)
- Updates to golden tests MUST preserve the 8-style matrix validation (4 themes × 2 modes)
- The feature MUST not introduce new external dependencies

## Out of Scope

- Changes to Material 3 color theming in the Flutter framework itself
- Support for color interpolation algorithms beyond existing lerp mechanisms
- Animation/transition effects when switching between surfaces (handled by component-level animation specs)
- Custom color palette generation or AI-based color suggestions
- Documentation site updates or design guideline documents (covered under separate documentation initiative)
