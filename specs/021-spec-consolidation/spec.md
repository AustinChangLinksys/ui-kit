# Feature Specification: Theme Spec Consolidation

**Feature Branch**: `021-spec-consolidation`
**Created**: 2025-12-08
**Status**: Draft
**Priority**: This Week
**Objective**: Refactor design_system/specs/ to reduce code duplication, unify implementation patterns, and enable local style overrides.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Library Maintainer Adds New Component Style Without Duplication (Priority: P1)

A library maintainer needs to add a new component (e.g., AppPopover) that requires animation and overlay styling. Instead of copying animationDuration, animationCurve, overlayColor, and blurStrength from existing specs, they should compose the new style from shared base specs.

**Why this priority**: This is the core problem - every new component currently requires duplicating 5-10 common properties across spec files, leading to inconsistency and maintenance burden. Solving this unlocks efficient component creation.

**Independent Test**: Can be fully tested by creating a new component style that composes SharedAnimationSpec and SharedOverlaySpec, verifying the style compiles and renders correctly with theme switching.

**Acceptance Scenarios**:

1. **Given** shared base specs (AnimationSpec, OverlaySpec) exist, **When** a maintainer creates a new PopoverStyle, **Then** they can compose it using `final AnimationSpec animation` and `final OverlaySpec overlay` fields without redefining duration/curve/overlayColor properties
2. **Given** a composed style using shared specs, **When** build_runner generates code, **Then** the generated .tailor.dart file includes proper copyWith and lerp methods for nested specs
3. **Given** a theme definition file, **When** defining PopoverStyle values, **Then** shared spec values can be reused via constructor: `PopoverStyle(animation: AnimationSpec.standard, overlay: theme.defaultOverlay)`

---

### User Story 2 - App Developer Overrides Animation Speed for a Specific Page (Priority: P1)

An app developer using the UI Kit needs faster animations on a dashboard page (150ms instead of 300ms) while keeping the default 300ms everywhere else, without forking the theme or creating a completely new theme variant.

**Why this priority**: Local override capability is critical for real-world adoption. Without it, developers must either accept global values or create theme forks, both of which reduce the library's utility.

**Independent Test**: Can be fully tested by wrapping a page with StyleOverride widget and verifying child components use the overridden animation duration.

**Acceptance Scenarios**:

1. **Given** a page wrapped with `StyleOverride(animationSpec: AnimationSpec.fast, child: ...)`, **When** an AppBottomSheet opens within that subtree, **Then** the sheet uses 150ms animation instead of the theme default 300ms
2. **Given** a component with an `animationOverride` parameter, **When** `AppCarousel(animationOverride: AnimationSpec(duration: Duration(milliseconds: 500)))` is used, **Then** that specific carousel uses 500ms while others use theme default
3. **Given** nested StyleOverride widgets, **When** inner override specifies only `animationSpec`, **Then** other specs (overlaySpec, etc.) inherit from outer override or theme default

---

### User Story 3 - Library Maintainer Merges Similar Style Specs (Priority: P2)

A library maintainer recognizes that BottomSheetStyle and SideSheetStyle share 80% of their properties (overlayColor, animationDuration, animationCurve, blurStrength). They want to merge these into a single SheetStyle with a `position` or `direction` discriminator.

**Why this priority**: Reduces total spec file count and ensures consistent behavior between related components. Lower priority than P1 because it's an optimization, not a blocker.

**Independent Test**: Can be fully tested by replacing BottomSheetStyle and SideSheetStyle with unified SheetStyle and verifying both AppBottomSheet and AppSideSheet render correctly across all themes.

**Acceptance Scenarios**:

1. **Given** a unified SheetStyle with `SheetDirection.bottom` and `SheetDirection.side` enum, **When** AppBottomSheet accesses theme.sheetStyle, **Then** it receives styling appropriate for bottom sheets
2. **Given** SheetStyle is defined once per theme, **When** a maintainer updates overlayColor, **Then** both bottom sheet and side sheet components reflect the change
3. **Given** existing component code using BottomSheetStyle, **When** migrating to SheetStyle, **Then** a clear deprecation path exists with compile-time guidance

---

### User Story 4 - Library Maintainer Unifies Implementation Pattern Across All Specs (Priority: P2)

Currently some specs use `@TailorMixin() + ThemeExtension` while others use `Equatable` manually. A maintainer wants all specs to follow the same pattern for consistency and to leverage code generation benefits.

**Why this priority**: Consistency reduces cognitive load and ensures all specs get automatic copyWith/lerp methods. Lower than P1 because existing code works, this is about improvement.

**Independent Test**: Can be fully tested by converting one Equatable-based spec (e.g., DialogStyle) to @TailorMixin pattern and verifying code generation works correctly.

**Acceptance Scenarios**:

1. **Given** DialogStyle currently extends Equatable, **When** converted to `@TailorMixin() class DialogStyle extends ThemeExtension<DialogStyle>`, **Then** build_runner generates DialogStyle.tailor.dart with copyWith and lerp
2. **Given** all specs use @TailorMixin, **When** a developer reads any spec file, **Then** they see the same structural pattern: imports, @TailorMixin annotation, ThemeExtension, fields with @override
3. **Given** SurfaceStyle is a foundational spec used by many components, **When** deciding its pattern, **Then** it remains Equatable-based (not ThemeExtension) since it's a value object composed into other specs, not a standalone theme extension

---

### User Story 5 - App Developer Resolves State-Based Colors Easily (Priority: P3)

An app developer building a custom component needs to determine the correct color for active/inactive/disabled states without manually checking multiple properties. They want a single method call to resolve the appropriate color.

**Why this priority**: Quality-of-life improvement for consumers. Core functionality works without this, but it makes the API more ergonomic.

**Independent Test**: Can be fully tested by calling `stateColors.resolve(isActive: true, isDisabled: false)` and verifying correct color is returned.

**Acceptance Scenarios**:

1. **Given** a StateColorSpec with active, inactive, and disabled colors, **When** calling `spec.resolve(isActive: true)`, **Then** returns the active color
2. **Given** a StateColorSpec where disabled color is not set, **When** calling `spec.resolve(isActive: false, isDisabled: true)`, **Then** returns inactive color as fallback
3. **Given** StateColorSpec is used in TabsStyle, **When** defining `textColors: StateColorSpec(active: blue, inactive: gray)`, **Then** AppTabs can resolve text color via `style.textColors.resolve(isSelected)`

---

### User Story 6 - Library Maintainer Completes Full Shared Spec Integration (Priority: P2)

A library maintainer recognizes that many existing styles still have redundant animation properties (animationDuration, animationCurve) that duplicate the shared AnimationSpec pattern. They want ALL component styles to consistently use shared specs for animation, overlay, and state colors.

**Why this priority**: Ensures complete consolidation. Leaving some styles with direct properties while others use shared specs creates inconsistency and confusion. This phase completes the "20% reduction" goal from SC-001.

**Independent Test**: Can be fully tested by verifying CarouselStyle, ExpansionPanelStyle, SlideActionStyle, etc. all compose AnimationSpec instead of having separate animationDuration/animationCurve properties.

**Acceptance Scenarios**:

1. **Given** CarouselStyle has animationDuration and animationCurve, **When** refactored, **Then** it uses `final AnimationSpec animation` field with backward-compatible getters
2. **Given** ExpandableFabStyle has overlayColor and enableBlur, **When** refactored, **Then** it uses `final OverlaySpec overlay` field
3. **Given** StateColorSpec only supports active/inactive, **When** components need hover/pressed states, **Then** StateColorSpec is extended with optional hover/pressed/disabled properties
4. **Given** TableStyle has hoverRowBackground and hoverRowContentColor, **When** hover-based colors are needed, **Then** StateColorSpec.resolve() supports isHovered parameter

---

### User Story 7 - Library Maintainer Completes Remaining Style Integration (Priority: P2/P3)

A library maintainer has completed initial shared spec integration but recognizes several styles still use legacy patterns. NavigationStyle lacks @TailorMixin and state colors, StepperStyle has standalone Duration field, and SkeletonStyle needs animation timing control.

**Why this priority**: P2 for NavigationStyle/StepperStyle (high-usage components), P3 for SkeletonStyle and optional migrations (lower impact).

**Independent Test**: Can be fully tested by verifying each style compiles with @TailorMixin and integrates shared specs without visual changes.

**Acceptance Scenarios**:

1. **Given** NavigationStyle has manual lerp method, **When** migrated, **Then** it uses @TailorMixin with AnimationSpec and StateColorSpec for item colors
2. **Given** StepperStyle has standalone `animationDuration: Duration`, **When** refactored, **Then** it uses `animation: AnimationSpec` with backward-compatible getter
3. **Given** SkeletonStyle is plain class, **When** migrated, **Then** it uses @TailorMixin with AnimationSpec for shimmer/pulse timing
4. **Given** AppNavigationBar uses hardcoded colors, **When** NavigationStyle integrates StateColorSpec, **Then** it uses `itemColors.resolve(isActive:)` for selected/unselected colors

---

### Edge Cases

- **Missing shared spec value**: When a theme does not define a required AnimationSpec, the system MUST throw a clear error at compile-time or runtime (complying with Constitution 3.3 Zero Internal Defaults)
- **Nested spec lerp**: When SheetStyle.lerp is called, the generated @TailorMixin code automatically chains OverlaySpec.lerp and AnimationSpec.lerp internally
- **Partial override**: When StyleOverride specifies only `duration`, `curve` inherits from the next layer (outer StyleOverride or Theme default)
- **Backward compatibility**: @Deprecated typedef redirects allow old code to compile with warnings while still functioning
- **withOverride all null**: Calling withOverride() with all null parameters MUST return a new instance with identical property values (semantically equal via == operator). Implementation should use `copyWith()` pattern, creating a new object rather than returning `this`

## Requirements *(mandatory)*

### Functional Requirements

#### Shared Base Specs

- **FR-001**: System MUST provide `AnimationSpec` as a shared spec with `duration` (Duration) and `curve` (Curve) properties
- **FR-002**: System MUST provide `StateColorSpec` as a shared spec with `active`, `inactive`, `disabled` (optional), and `error` (optional) Color properties
- **FR-003**: System MUST provide `OverlaySpec` as a shared spec with `scrimColor` (Color), `blurStrength` (double), and `animation` (AnimationSpec) properties
- **FR-004**: All shared specs MUST support a `withOverride()` method that returns a new instance with specified values overridden
- **FR-005**: Shared specs MUST provide static preset constants for common configurations (e.g., `AnimationSpec.fast`, `AnimationSpec.slow`, `AnimationSpec.standard`)

#### Style Composition

- **FR-006**: Component styles MUST be able to compose shared specs as fields (e.g., `SheetStyle { final AnimationSpec animation; }`)
- **FR-007**: Code generation via @TailorMixin MUST properly handle nested spec types with copyWith and lerp methods
- **FR-008**: Composed styles MUST support deep merging when using withOverride

#### Local Override Mechanism

- **FR-009**: System MUST provide `StyleOverride` InheritedWidget for subtree-level style overrides
- **FR-010**: StyleOverride MUST support optional overrides for each shared spec type (animationSpec, overlaySpec, stateColorSpec)
- **FR-011**: Components MUST resolve styles by checking StyleOverride first, then falling back to theme defaults
- **FR-012**: Components MUST support optional override parameters (e.g., `AppBottomSheet({ AnimationSpec? animationOverride })`)

#### Style Consolidation

- **FR-013**: System MUST merge BottomSheetStyle and SideSheetStyle into unified SheetStyle with direction discriminator
- **FR-014**: SheetStyle MUST support both bottom and side positioning via enum or type parameter
- **FR-015**: Deprecated styles (BottomSheetStyle, SideSheetStyle) SHOULD provide migration guidance via @Deprecated annotation

#### Pattern Unification

- **FR-016**: All ThemeExtension-based specs MUST use @TailorMixin annotation for code generation
- **FR-017**: Value object specs (SurfaceStyle, InteractionSpec) MAY remain Equatable-based when they are composed into ThemeExtension specs
- **FR-018**: All specs MUST follow consistent file naming: `{name}_style.dart` for styles, `{name}_spec.dart` for specs

#### Complete Shared Spec Integration (User Story 6)

- **FR-019**: StateColorSpec MUST support optional `hover` and `pressed` color states for interactive components
- **FR-020**: StateColorSpec.resolve() MUST support `isHovered` and `isPressed` parameters with priority: error > disabled > pressed > hover > active/inactive
- **FR-021**: CarouselStyle MUST compose AnimationSpec instead of separate animationDuration/animationCurve properties
- **FR-022**: ExpansionPanelStyle MUST compose AnimationSpec instead of separate animationDuration property
- **FR-023**: SlideActionStyle MUST compose AnimationSpec instead of separate animationDuration/animationCurve properties
- **FR-024**: GaugeStyle MUST compose AnimationSpec instead of separate animationDuration/animationCurve properties
- **FR-025**: LinkStyle (TopologySpec) MUST compose AnimationSpec instead of separate animationDuration property
- **FR-026**: TableStyle MUST compose AnimationSpec instead of separate modeTransitionDuration property
- **FR-027**: ExpandableFabStyle MUST compose OverlaySpec instead of separate overlayColor/enableBlur properties
- **FR-028**: All refactored styles MUST provide backward-compatible getters for deprecation period

#### Remaining Style Integration (User Story 7)

- **FR-029**: NavigationStyle MUST migrate to @TailorMixin pattern with auto-generated lerp method
- **FR-030**: NavigationStyle MUST compose AnimationSpec for animation timing
- **FR-031**: NavigationStyle MUST compose StateColorSpec for item colors (selected/unselected)
- **FR-032**: StepperStyle MUST replace standalone `animationDuration: Duration` with `animation: AnimationSpec`
- **FR-033**: SkeletonStyle MUST migrate to @TailorMixin pattern
- **FR-034**: SkeletonStyle MUST compose AnimationSpec for shimmer/pulse timing
- **FR-035**: AppNavigationBar component MUST use `itemColors.resolve(isActive:)` for color resolution
- **FR-036**: AppNavigationRail component MUST use `itemColors.resolve(isActive:)` for color resolution

#### Optional Low-Priority Migrations (P3)

- **FR-037**: AppBarStyle MAY migrate from Equatable to @TailorMixin (optional)
- **FR-038**: AppMenuStyle MAY migrate from Equatable to @TailorMixin with optional AnimationSpec (optional)
- **FR-039**: DividerStyle MAY migrate from Equatable to @TailorMixin (optional)
- **FR-040**: InputStyle MAY migrate from Equatable to @TailorMixin (optional)
- **FR-041**: ToggleStyle MAY migrate to @TailorMixin pattern (optional)

### Key Entities

- **AnimationSpec**: Duration and curve for animations; composable into other specs
- **StateColorSpec**: Active/inactive/disabled/error color set with resolve() method
- **OverlaySpec**: Scrim color, blur strength, and animation for overlay components
- **SheetStyle**: Unified style for bottom sheets and side sheets with direction enum
- **StyleOverride**: InheritedWidget providing subtree-level spec overrides

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Total lines of code in specs/ directory reduced by at least 20% after consolidation
- **SC-002**: Creating a new component style requires defining 50% fewer properties by composing shared specs
- **SC-003**: All 20+ existing spec files follow a single consistent implementation pattern
- **SC-004**: Developers can override animation speed for a specific page/component in 3 lines of code or less
- **SC-005**: Zero breaking changes for existing component consumers during deprecation period; deprecated APIs may be removed after one minor version with clear migration guidance
- **SC-006**: All consolidated specs pass existing golden tests without visual changes
- **SC-007**: Time to add a new themed component reduced from 60+ minutes to under 30 minutes

### Qualitative Outcomes

- **SC-008**: Spec files are easier to read and understand due to consistent patterns
- **SC-009**: Library maintainers can confidently modify shared specs knowing all consumers will benefit
- **SC-010**: Documentation clearly explains when to use composition vs. direct properties

## Assumptions

- Existing component behavior must be preserved; this is a refactoring, not a redesign
- All current specs have been audited for common patterns (animation, colors, overlay)
- theme_tailor package supports nested @TailorMixin types (verified)
- Breaking changes to internal specs are acceptable; breaking changes to public widget APIs are not
- Deprecation period of at least one minor version before removing old style classes

## Out of Scope

- Adding new theme variants (Glass, Brutal, etc.) - this is about spec structure
- Modifying SurfaceStyle or InteractionSpec core structure (foundational, too risky)
- Creating new components - this is infrastructure for future components
- Performance optimization of theme resolution
- Runtime theme switching mechanism changes

## Dependencies & Related Features

- **Depends On**: theme_tailor package for code generation
- **Depends On**: Existing component implementations that will consume consolidated specs
- **Enables**: Faster component creation for future phases
- **Enables**: Per-page/per-component style customization
- **Related**: 015-interaction-navigation (components that will benefit from consolidated specs)

## Technical Decisions & Rationale

- **Composition over Inheritance**: Shared specs are composed as fields, not inherited, to maintain flexibility
- **InheritedWidget for Overrides**: Standard Flutter pattern for subtree configuration
- **Preserve Value Objects**: SurfaceStyle remains Equatable-based as it's composed into many places
- **Enum-based Discrimination**: SheetStyle uses enum for direction rather than separate classes to reduce type proliferation

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Breaking existing theme definitions | High - blocks all apps using library | Extensive testing, deprecation warnings, migration guide |
| code generation issues with nested specs | Medium - delays implementation | Spike test @TailorMixin with nested types first |
| StyleOverride performance overhead | Low - InheritedWidget is optimized | Profile with deeply nested trees before finalizing |
| Merge conflicts with ongoing component work | Medium - coordination needed | Communicate timeline, merge to main before component branches |

## Validation & Acceptance

This specification is ready for planning when:
- All user stories are understood and prioritized
- All functional requirements are testable
- Success criteria are measurable and verifiable
- No critical [NEEDS CLARIFICATION] items remain
