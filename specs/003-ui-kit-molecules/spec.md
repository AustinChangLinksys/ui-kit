# Feature Specification: Unified UI Kit Molecules

**Feature Branch**: `003-ui-kit-molecules`
**Created**: 2025-11-29
**Status**: Draft
**Input**: User description: "Implementation Roadmap: Unified UI Kit Components **Objective:** Implement the core `molecules` library for the Unified Design System (v2.0). **Architectural Core:** All components must utilize `AppSurface` for rendering and adhere to the **Data-Driven Strategy (DDS)** defined in the project constitution. --- ## 🛑 Global Development Rules (Constitution) 1. **Root Primitive:** Every component's root visual layer MUST be an `AppSurface`. Do not use `Container` or `DecoratedBox`. 2. **No Type Checks:** strictly FORBIDDEN to use `if (theme is BrutalTheme)`. Visual differences must be driven by `AppDesignTheme` properties or Specs. 3. **Interaction:** Use `AppSurface(interactive: true)` to automatically inherit Theme-defined physics (Scale, Glow, Offset). 4. **Verification:** Every component MUST have a corresponding **Widgetbook Story** with interactive Knobs. --- ## 🛠 Component Specifications ### 1. `AppButton` & `AppIconButton` * **Role:** Primary and secondary triggers. * **Props:** * `label` (String, AppButton only), `icon` (Widget). * `onTap` (VoidCallback?): Null implies **Disabled** state (opacity reduced). * `isLoading` (bool): If true, replace content with `AppSkeleton` or spinner; disable interaction. * `variant`: Defaults to `SurfaceVariant.highlight`. * **Visual Logic:** * **AppButton**: Horizontal padding based on `spacingFactor`. Shape follows theme default. * **AppIconButton**: Fixed aspect ratio (1:1). Shape is usually Circle (Glass) or Square (Brutal). ### 2. `AppTextField` (Input) * **Role:** Text entry. * **Props:** * `controller`, `hintText`, `onChanged`. * `errorText` (String?): If present, changes surface color/border to Error state. * **Visual Logic:** * Must wrap the native `TextField`. * **Glass**: Transparent background, only bottom border or subtle glow. * **Brutal**: Solid background, thick border. * *Note:* Use `AppSurface` as the container for the `TextField`. ### 3. `AppCheckbox` & `AppRadio` (Selection) * **Role:** Boolean or Single Option selection. * **Props:** `value` (bool), `onChanged`, `label` (optional). * **Implementation Strategy:** * Reuse the **`ToggleContentRenderer`** logic (which we defined for Switch). * **Checkbox**: Uses `activeIcon` (Check) or `activeText` (X). * **Radio**: Uses `activeType: dot` logic. * **Shape**: Checkbox adapts to Theme (Square vs Circle); Radio is always Circular. ### 4. `AppSlider` (Range) * **Role:** Value selection within a range. * **Props:** `value` (double), `onChanged`, `min`, `max`. * **Structure (Composite):** * **Track**: An `AppSurface` (Base variant). * **Fill**: An `AppSurface` (Highlight variant) representing progress. * **Thumb**: An `AppSurface` (Elevated variant) that slides via `LayoutBuilder`. ### 5. `AppBadge` / `AppTag` (Status) * **Role:** Static status indicators or interactive filters. * **Props:** `label`, `color` (optional override), `onDeleted` (optional). * **Visual Logic:** * Must use **Stadium/Capsule** shape (via `AppSurface` with high radius). * High density (small padding). * Typography: Usually smaller/bolder than body text. ### 6. `AppAvatar` (Identity) * **Role:** User profile image or initials. * **Props:** `imageUrl` (String?), `initials` (String), `size` (double). * **Visual Logic:** * **Shape**: Strictly `BoxShape.circle` (utilize the new `AppSurface(shape: BoxShape.circle)` feature). * **Fallback**: If image fails or is null, show initials on a colored surface. ### 7. `AppNavigationBar` (Layout) * **Role:** Bottom navigation container. * **Props:** `items` (List of NavigationItem), `currentIndex`, `onTap`. * **Visual Logic:** * **Glass**: Floating `AppSurface` with high blur, detached from bottom. * **Brutal**: Fixed rectangle attached to bottom, solid border. --- ## ✅ Definition of Done (DoD) For each component above, the following must be delivered: 1. **Source Code**: `lib/src/molecules/[category]/[component].dart` 2. **Widgetbook Story**: `widgetbook/lib/molecules/[category]/[component].story.dart` * Must demonstrate: Normal, Hover, Pressed, Disabled, and Theme Switching. 3. **Golden Test**: Basic screenshot test in Light/Dark mode."

## Clarifications

### Session 2025-11-29
- Q: How should `AppTextField` detect and visualize focus state on the wrapping `AppSurface`? → A: **Manual FocusNode Listener**: The wrapper creates/monitors a `FocusNode` and updates the `AppSurface` properties directly.
- Q: How should `AppNavigationBar` handle overflow if more than 5 items are provided? → A: **Strict Limit**: Throw an assertion error if `items.length > 5` to enforce UX best practices.
- Q: For `AppAvatar`, when `imageUrl` is present but the image is not square, how should it be scaled within the circular shape? → A: **center-crop**: The image should be scaled to cover the entire circle, cropping the edges evenly.
- Q: Should `AppSlider` support discrete steps, and if so, how? → A: **Discrete Steps**: Supports `divisions` property, snaps to intervals.
- Q: How should the vertical sizing of `AppButton` be determined? → A: **Fixed Height**: Button height is a predefined constant for visual consistency.
- Q: If no explicit `color` is provided for `AppBadge` or `AppTag`, what should be its default background color? → A: **Theme Surface Variant (Highlight)**: Consistent with `AppButton`'s default variant.

## User Scenarios & Testing

<!--
  User stories prioritized by foundational importance.
-->

### User Story 1 - Core Interactive Elements (Priority: P1)

As a developer or user, I need the fundamental interactive building blocks (buttons, inputs, toggles) to perform basic actions and data entry.

**Why this priority**: These are the atoms of interaction; without them, no functional UI can be built.

**Independent Test**: Create a "Forms" demo page in Widgetbook containing all these elements. Verify they respond to touch, show loading states, and reflect theme changes (Glass vs Brutal) without code changes.

**Acceptance Scenarios**:

1. **Given** an `AppButton` in `isLoading` state, **When** rendered, **Then** it displays an `AppSkeleton` or spinner and ignores taps.
2. **Given** an `AppTextField` with `errorText`, **When** rendered, **Then** the `AppSurface` container reflects the Error variant/color.
3. **Given** an `AppCheckbox`, **When** toggled, **Then** it switches visual state using `ToggleContentRenderer` logic (Check/X vs Empty).
4. **Given** an `AppSlider`, **When** dragged, **Then** the Thumb follows the pointer and Fill width updates proportionally.
5. **Given** any component, **When** disabled (`onTap: null`), **Then** opacity is reduced and interaction is blocked.

---

### User Story 2 - Navigation Structure (Priority: P1)

As a user, I need a navigation bar to move between different sections of the application.

**Why this priority**: Essential for the app's information architecture and layout structure.

**Independent Test**: A specialized Widgetbook story for `AppNavigationBar` showing it in different themes.

**Acceptance Scenarios**:

1. **Given** a `Glass` theme, **When** `AppNavigationBar` renders, **Then** it appears as a floating surface with blur, detached from the screen bottom.
2. **Given** a `Brutal` theme, **When** `AppNavigationBar` renders, **Then** it appears as a fixed rectangle attached to the bottom with a solid border.
3. **Given** a list of items, **When** an item is tapped, **Then** the `onTap` callback is fired with the correct index.

---

### User Story 3 - Informational Elements (Priority: P2)

As a user, I need visual indicators (badges, tags, avatars) to understand status and identity context quickly.

**Why this priority**: Enhances the user experience and information density but is secondary to core interaction.

**Independent Test**: A "Profile & Status" demo page in Widgetbook.

**Acceptance Scenarios**:

1. **Given** an `AppBadge`, **When** rendered, **Then** it has a Stadium/Capsule shape and high-density padding.
2. **Given** an `AppAvatar` with a null `imageUrl`, **When** rendered, **Then** it displays the provided `initials` on a colored surface.
3. **Given** an `AppAvatar`, **When** rendered, **Then** it is strictly circular regardless of theme defaults for other surfaces.

### Edge Cases

- **Text Overflow**: How do `AppButton`, `AppBadge`, and `AppTag` handle extremely long labels? (Should truncate with ellipsis).
- **Invalid Props**: How does `AppSlider` behave if `min` >= `max`? (Should assert or clamp).
- **Image Aspect Ratio**: How does `AppAvatar` handle non-square images? (Should center-crop to circle).
- **Navigation Overflow**: How does `AppNavigationBar` handle more items than can fit? (Should likely clip or scroll, though 5 is standard max).

## Constitutional Alignment

*GATE: All specifications MUST adhere to the principles outlined in the Project Constitution (v1.0.0).*

- **2. Architectural Boundaries**: Components will be placed in `lib/src/molecules/` and will not depend on `organisms` or business logic.
- **3. Theming & Styling**: Strictly follows `AppDesignTheme`. No `is BrutalTheme` checks allowed; stylistic choices will be derived from theme properties.
- **4. Component Design**: Components are stateless (mostly) and composed using `AppSurface`.
- **12. Quality Assurance & Testing**: Widgetbook stories and Golden tests are explicitly required for every component.

## Requirements

### Functional Requirements

**General & Architecture**
- **FR-001**: All components MUST use `AppSurface` as their root visual element (replacing `Container`/`DecoratedBox`).
- **FR-002**: Components MUST NOT use runtime type checking of the theme (e.g., `if (theme is BrutalTheme)`) to determine rendering logic.
- **FR-003**: Interactive components MUST set `AppSurface(interactive: true)` to inherit theme-defined physics.

**Inputs & Triggers**
- **FR-004**: `AppButton` MUST support a text label and an optional icon widget.
- **FR-004a**: `AppButton` MUST have a fixed vertical height, defined by the active theme, to ensure consistent visual sizing.
- **FR-005**: `AppIconButton` MUST maintain a fixed 1:1 aspect ratio.
- **FR-006**: `AppButton` and `AppIconButton` MUST render an `AppSkeleton` or spinner when `isLoading` is true, and disable interaction.
- **FR-007**: `AppTextField` MUST wrap the native Flutter `TextField` widget within an `AppSurface` and use a `FocusNode` listener to update the surface's visual state (border/glow) when focused.
- **FR-008**: `AppTextField` MUST visually indicate an error state (via surface variant/color) when `errorText` is provided.
- **FR-009**: `AppCheckbox` and `AppRadio` MUST utilize `ToggleContentRenderer` logic for rendering their active states.
- **FR-010**: `AppSlider` MUST be composed of three `AppSurface` layers: Track (Base), Fill (Highlight), and Thumb (Elevated).
- **FR-010a**: `AppSlider` MUST support a `divisions` property to enable discrete step selection, snapping the value to intervals.

**Status, Identity & Navigation**
- **FR-011**: `AppBadge` and `AppTag` MUST be rendered with a Stadium/Capsule shape.
- **FR-011a**: When `color` is not explicitly provided, `AppBadge` and `AppTag` MUST default to the `Theme Surface Variant (Highlight)` color.
- **FR-012**: `AppAvatar` MUST always be rendered with a `BoxShape.circle` shape.
- **FR-012a**: When `AppAvatar` receives a non-square image via `imageUrl`, it MUST be `center-crop`ped to fit the circular shape.
- **FR-013**: `AppAvatar` MUST display provided initials as fallback content if `imageUrl` is missing or fails to load.
- **FR-014**: `AppNavigationBar` MUST render a list of navigation items and handle selection taps.
- **FR-015**: `AppNavigationBar` MUST adapt its layout (Floating/Detached vs Fixed/Attached) based on the active theme's definitions.
- **FR-019**: `AppNavigationBar` MUST enforce a maximum of 5 items via an assertion, rejecting configurations that exceed this limit.

**Deliverables**
- **FR-016**: Every component MUST have a corresponding Widgetbook story located in `widgetbook/lib/molecules/[category]/`.
- **FR-017**: Widgetbook stories MUST demonstrate Normal, Hover, Pressed, Disabled, and Loading (where applicable) states.
- **FR-018**: Every component MUST have a Golden Test verifying its appearance in both Light and Dark modes.

## Success Criteria

### Measurable Outcomes

- **SC-001**: Development team has access to all 10 specified components (`AppButton` through `AppNavigationBar`) in the shared library.
- **SC-002**: Documentation (Widgetbook) allows interactive simulation of all defined component states (Hover, Pressed, Disabled, Loading).
- **SC-003**: Visual regression tests (Goldens) pass for all components in both Light and Dark themes.
- **SC-004**: Architectural compliance report confirms 100% adherence to `AppSurface` primitive (0 legacy containers).
- **SC-005**: Code review confirms 0 instances of explicit theme type checking (`is BrutalTheme`) in component logic.