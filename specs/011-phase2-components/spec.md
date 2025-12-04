# Feature Specification: Phase 2 UI Kit Components

**Feature Branch**: `011-phase2-components`
**Created**: 2025-12-04
**Status**: Draft
**Input**: UI Kit Architecture Specification: Phase 2 Components - Molecules & Organisms Expansion (AppBar, Menu, Dialog) with Multi-Style Support (Flat, Glass, Pixel)

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Standard AppBar Integration (Priority: P1)

As a developer using the UI Kit, I need to add a standard app bar to my application screens that automatically adapts its visual appearance based on the active design style (Flat, Glass, or Pixel) without any additional configuration.

**Why this priority**: The AppBar is the most fundamental navigation component present on virtually every screen. It establishes visual identity and provides essential navigation controls. Without this, no meaningful application layout can be built.

**Independent Test**: Can be fully tested by placing UnifiedAppBar in a Scaffold and switching between Flat/Glass/Pixel themes, verifying visual adaptation delivers correct styling for each mode.

**Acceptance Scenarios**:

1. **Given** a screen with UnifiedAppBar and Flat style active, **When** the app bar renders, **Then** it displays with solid background color, standard border radius, and soft shadow with optional hairline bottom divider.
2. **Given** a screen with UnifiedAppBar and Glass style active, **When** the app bar renders, **Then** it displays with translucent background, blur effect applied to content scrolling beneath, and visible light border.
3. **Given** a screen with UnifiedAppBar and Pixel style active, **When** the app bar renders, **Then** it displays with opaque solid background, sharp corners (0px radius), thick bottom divider, and hard-edge block shadow.
4. **Given** a UnifiedAppBar with title, leading widget, and actions, **When** rendered in any style, **Then** title is centered/aligned correctly, leading widget appears on the left, and actions appear on the right.

---

### User Story 2 - Collapsible Sliver AppBar (Priority: P1)

As a developer building scrollable content screens, I need a sliver app bar that collapses and expands smoothly during scrolling, with flexible space support that adapts overlay effects to the active design style.

**Why this priority**: Sliver AppBars are essential for modern mobile/tablet interfaces with hero images or expandable headers. This is a core navigation pattern alongside standard AppBar.

**Independent Test**: Can be fully tested by placing UnifiedSliverAppBar in a CustomScrollView with scrollable content and verifying pin/float/snap behaviors work smoothly across all three design styles.

**Acceptance Scenarios**:

1. **Given** a UnifiedSliverAppBar with pinned=true, **When** user scrolls down, **Then** the app bar collapses smoothly and remains visible at the top.
2. **Given** a UnifiedSliverAppBar with floating=true and snap=true, **When** user scrolls up slightly, **Then** the app bar snaps into full visibility without visual jitter.
3. **Given** a UnifiedSliverAppBar with flexibleSpace containing an image in Glass style, **When** the app bar is expanded, **Then** the image is overlaid with a blur mask/frosted glass layer.
4. **Given** a UnifiedSliverAppBar with flexibleSpace in Pixel style, **When** rendered, **Then** no blur effects are applied; styling remains sharp and opaque.

---

### User Story 3 - Popup Menu for Contextual Actions (Priority: P2)

As a developer, I need to display a popup menu with contextual actions that users can trigger from an icon button, with the menu container adapting its appearance to the active design style.

**Why this priority**: Popup menus are essential for contextual actions in app bars and list items but can be implemented after the primary navigation structure (AppBar) is in place.

**Independent Test**: Can be fully tested by placing UnifiedPopupMenu in a screen, tapping the trigger icon, and verifying menu items render correctly with proper touch targets and style-specific container appearance.

**Acceptance Scenarios**:

1. **Given** a UnifiedPopupMenu with items in Flat style, **When** user taps the trigger icon, **Then** a popover appears with standard radius and soft shadow containing the menu items.
2. **Given** a UnifiedPopupMenu with items in Glass style, **When** user taps the trigger icon, **Then** a popover appears with backdrop blur effect and glowing/light border.
3. **Given** a UnifiedPopupMenu with items in Pixel style, **When** user taps the trigger icon, **Then** a popover appears with sharp corners, thick borders, and solid block shadow (no blur).
4. **Given** a menu item marked as isDestructive=true, **When** the menu renders, **Then** that item's text and icon display in the error/destructive color.
5. **Given** any menu item, **When** rendered, **Then** the touch target is at minimum 48x48dp for accessibility compliance.

---

### User Story 4 - Modal Dialog for Confirmations (Priority: P2)

As a developer, I need to display modal dialogs for user confirmations, alerts, and decisions, with the dialog container and buttons adapting to the active design style.

**Why this priority**: Dialogs are critical for user confirmations and error handling but are secondary to navigation components. They complete the essential interaction patterns.

**Independent Test**: Can be fully tested by triggering UnifiedDialog display, verifying content renders correctly, buttons respond to taps, and the dialog dismisses appropriately across all design styles.

**Acceptance Scenarios**:

1. **Given** a UnifiedDialog in Flat style, **When** displayed, **Then** it shows as a standard modal with solid background, standard radius, and shadow.
2. **Given** a UnifiedDialog in Glass style, **When** displayed, **Then** it shows with translucent background, blur effect, and distinct visual layering against the barrier overlay.
3. **Given** a UnifiedDialog in Pixel style, **When** displayed, **Then** it shows with thick borders, sharp corners, and buttons following Pixel button styling (sharp/thick).
4. **Given** a UnifiedDialog with isDestructive=true, **When** displayed, **Then** the primary button reflects a danger state (error color styling).
5. **Given** a UnifiedDialog with content exceeding viewport height, **When** displayed, **Then** the content area is scrollable while the action button area remains fixed and accessible.

---

### User Story 5 - Theme Mode Consistency (Priority: P3)

As a developer, I need all Phase 2 components to maintain proper contrast and readability when switching between Light and Dark modes within each design style.

**Why this priority**: Accessibility is essential but builds upon the core component functionality being in place first.

**Independent Test**: Can be fully tested by rendering each component in Light and Dark mode for each design style and verifying text/icon contrast ratios meet accessibility standards.

**Acceptance Scenarios**:

1. **Given** any Phase 2 component in Flat style, **When** toggling between Light and Dark mode, **Then** contrast ratio remains WCAG AA compliant.
2. **Given** any Phase 2 component in Glass style, **When** toggling between Light and Dark mode, **Then** text and icons remain readable against translucent backgrounds.
3. **Given** any Phase 2 component in Pixel style, **When** toggling between Light and Dark mode, **Then** border colors and backgrounds adjust to maintain high contrast.

---

### Edge Cases

- What happens when AppBar title text is extremely long? System should truncate with ellipsis while preserving action button visibility.
- What happens when popup menu has many items exceeding screen height? Menu should be scrollable internally.
- How does system handle dialog with both content and customContent provided? System should assert that only one is provided (mutually exclusive).
- What happens when Glass style blur is rendered on low-performance devices? System should apply graceful degradation or simpler effects while maintaining usability.
- What happens when AppBar leading widget is null and no back navigation exists? Default back button should be hidden, not rendered as disabled.

## Requirements *(mandatory)*

### Functional Requirements

**AppBar Series**

- **FR-001**: UnifiedAppBar MUST implement PreferredSizeWidget and accept title (String), optional actions (List<Widget>), optional leading (Widget), and optional bottom (PreferredSizeWidget).
- **FR-002**: UnifiedAppBar MUST render leading widget on the left (defaulting to back button when navigation stack exists), title in the center/start, and actions on the right.
- **FR-003**: UnifiedAppBar MUST adapt container rendering (background, borders, shadows, dividers) based on the active design style without developer intervention.
- **FR-004**: UnifiedSliverAppBar MUST wrap SliverAppBar and support pinned, floating, snap, and flexibleSpace parameters with style-aware overlay rendering.
- **FR-005**: UnifiedSliverAppBar MUST apply blur overlay to flexibleSpace content when Glass style is active and the app bar is expanded.

**Popup Menu**

- **FR-006**: UnifiedPopupMenuItem MUST define value (generic T), label (String), optional icon (IconData), and isDestructive (bool) properties.
- **FR-007**: UnifiedPopupMenu MUST accept items list, onSelected callback, and optional trigger icon widget (defaulting to three-dot/more icon).
- **FR-008**: UnifiedPopupMenu popover container MUST adapt styling (radius, borders, shadows, blur) based on the active design style.
- **FR-009**: Menu items marked isDestructive MUST display with error/destructive color for both text and icon.
- **FR-010**: All menu item touch targets MUST be at minimum 48x48dp.

**Dialog**

- **FR-011**: UnifiedDialog MUST accept title (String), optional content (String), optional customContent (Widget), primaryButtonText, onPrimaryPressed, optional secondaryButtonText, optional onSecondaryPressed, and isDestructive flag.
- **FR-012**: UnifiedDialog MUST enforce mutual exclusivity between content and customContent parameters.
- **FR-013**: UnifiedDialog container MUST adapt styling based on the active design style including background, borders, and button styling.
- **FR-014**: When isDestructive is true, the primary button MUST reflect danger state styling.
- **FR-015**: UnifiedDialog MUST support scrollable content area when text exceeds viewport while keeping action buttons accessible.

**Cross-Component**

- **FR-016**: All Phase 2 components MUST NOT use BackdropFilter when Flat style is active to avoid resource wastage.
- **FR-017**: All Phase 2 components MUST maintain WCAG AA contrast ratios in both Light and Dark modes across all design styles.

### Key Entities

- **UnifiedAppBar**: Standard app bar component providing page-level navigation with title, leading widget, actions, and optional bottom widget. Adapts visual style to theme.
- **UnifiedSliverAppBar**: Collapsible app bar for use in scrollable contexts with flexible space support. Wraps SliverAppBar with style-aware rendering.
- **UnifiedPopupMenuItem<T>**: Data model representing a single menu item with value, label, optional icon, and destructive flag.
- **UnifiedPopupMenu<T>**: Interactive popup menu component triggered by an icon button, displaying a list of selectable items.
- **UnifiedDialog**: Modal dialog component for confirmations and user decisions with primary/secondary actions and style-adaptive container.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Developers can integrate any Phase 2 component into their application with a single widget and zero style-specific configuration; style adaptation is automatic.
- **SC-002**: All components render correctly across all 6 combinations (3 styles x 2 brightness modes) as verified by golden/visual regression tests.
- **SC-003**: Dialog content scrolling works without overflow errors when text exceeds 500 characters or 10 lines.
- **SC-004**: Sliver AppBar pin/float/snap transitions complete without visible jitter or frame drops during normal scrolling.
- **SC-005**: All interactive elements (menu items, buttons) meet 48x48dp minimum touch target requirement.
- **SC-006**: Text contrast ratios in all components meet WCAG AA standards (4.5:1 for normal text, 3:1 for large text) across all style/mode combinations.
- **SC-007**: Glass style blur effects are visible and distinguishable when rendered over varied background colors.
- **SC-008**: Pixel style components display with 0px corner radius and border widths matching the Pixel design token definitions.

## Assumptions

- The existing theme infrastructure (AppDesignTheme, theme_tailor) will be extended to support the new component styles.
- Design tokens for Pixel border widths and Glass blur intensity are either already defined or will be defined as part of this work.
- **Naming Convention**: To avoid conflicts with Flutter's native `AppBar` widget, AppBar components will use the `AppUnified` prefix: `AppUnifiedBar` and `AppUnifiedSliverBar`. Other components use the standard `App` prefix: `AppDialog`, `AppPopupMenu`, `AppPopupMenuItem`. All references to "UnifiedXxx" in this spec map to implementation names as follows:
  - UnifiedAppBar → `AppUnifiedBar`
  - UnifiedSliverAppBar → `AppUnifiedSliverBar`
  - UnifiedDialog → `AppDialog`
  - UnifiedPopupMenu → `AppPopupMenu`
  - UnifiedPopupMenuItem → `AppPopupMenuItem`
- BackdropFilter performance on low-end devices is handled by Flutter's built-in optimizations; no custom fallback required unless testing reveals issues.
- Default back button behavior integrates with Flutter's Navigator for automatic display when navigation stack > 1.

## Scope Boundaries

**In Scope**:
- AppUnifiedBar, AppUnifiedSliverBar, AppPopupMenu, AppDialog components
- Flat, Glass, and Pixel style adaptations for each component (primary focus)
- Light and Dark mode support for each style
- Golden tests for visual regression across all 8 style/mode combinations (4 themes × 2 modes) for full regression coverage, including graceful defaults for Neumorphic/Brutal themes

**Out of Scope**:
- Neumorphic and Brutal styles (existing styles not mentioned in spec)
- Animation customization beyond standard Flutter transitions
- Custom theme creation tools or runtime style switching UI
- Platform-specific adaptations (iOS/Android differences)
