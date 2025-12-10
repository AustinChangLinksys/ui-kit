# Tasks: Unified Button System Architecture

**Feature**: 022-button-system-unified
**Date**: 2025-12-09
**Purpose**: Implementation tasks organized by user story priority for independent testing

## Implementation Phases (aligned with button_system_design_requirements.md)

This task structure follows the 4-phase approach defined in the design requirements:

### Requirements.md Phase Mapping:
- **Phase 0 (Infrastructure)** → Requirements Phase 1: Basic Architecture
- **Phase 1 (Components)** → Requirements Phase 2: Component Updates
- **Phase 2 (Themes)** → Requirements Phase 3: Theme Implementation
- **Phase 3 (Testing)** → Requirements Phase 4: Testing & Documentation

## User Story 1 (Priority P1): Simplified Button Creation with Named Constructors

### Phase 1A: Core Infrastructure Setup

**Dependencies**: None
**Parallel Execution**: All tasks can run in parallel

- [x] **T001**: Create ButtonStyleVariant enum in `lib/src/molecules/buttons/enums/button_style_variant.dart`
  - Define filled, outline, text variants
  - Add comprehensive dartdoc comments
  - Include usage examples in enum documentation
  - **Acceptance**: Enum compiles with all three variants defined

- [x] **T002**: Create AppButtonIconPosition enum in `lib/src/molecules/buttons/enums/app_button_icon_position.dart`
  - Define leading, trailing positions
  - Add comprehensive dartdoc comments
  - Include usage examples
  - **Acceptance**: Enum compiles with both positions defined

- [x] **T003**: Create ButtonSurfaceStates ThemeExtension in `lib/src/foundation/theme/design_system/specs/button_surface_states.dart`
  - Add @TailorMixin() annotation
  - Define enabled, disabled, hovered, pressed SurfaceStyle fields
  - Implement resolve() method with state priority logic
  - **Acceptance**: Class generates .tailor.dart file successfully

- [x] **T004**: Create ButtonSizeSpec ThemeExtension in `lib/src/foundation/theme/design_system/specs/button_size_spec.dart`
  - Add @TailorMixin() annotation
  - Define small/medium/large height and padding fields
  - Define iconSpacing field
  - Implement getHeight() and getPadding() methods
  - **Acceptance**: Class generates .tailor.dart file successfully

- [x] **T005**: Create ButtonTextStyles ThemeExtension in `lib/src/foundation/theme/design_system/specs/button_text_styles.dart`
  - Add @TailorMixin() annotation
  - Define small, medium, large TextStyle fields
  - Use appTextTheme tokens exclusively (Constitutional requirement)
  - **Acceptance**: Class generates .tailor.dart file successfully

### Phase 1B: Unified ButtonStyle Implementation

**Dependencies**: T003, T004, T005 must complete first
**Parallel Execution**: All tasks can run in parallel after dependencies

- [x] **T006**: Create unified ButtonStyle ThemeExtension in `lib/src/foundation/theme/design_system/specs/button_style.dart`
  - Add @TailorMixin() annotation
  - Define variant-specific surface and color fields (filled/outline/text)
  - Define shared textStyles, sizeSpec, interaction fields
  - Implement getSurface() and getContentColor() resolution methods
  - Implement getTextStyle() method for size-based typography
  - **Acceptance**: Class generates .tailor.dart file with all resolution methods

- [x] **T007**: Update AppDesignTheme in `lib/src/foundation/theme/app_design_theme.dart`
  - Add unified buttonStyle property
  - Mark old buttonStyle, iconButtonStyle, textButtonStyle as @deprecated
  - Update constructor to include new ButtonStyle
  - **Acceptance**: AppDesignTheme compiles and includes unified ButtonStyle

- [x] **T008**: Run code generation to create all .tailor.dart files
  - Execute: `dart run build_runner build --delete-conflicting-outputs`
  - Verify all new ThemeExtensions generate properly
  - **Acceptance**: All .tailor.dart files generate without errors

### Phase 1C: AppButton Named Constructors

**Dependencies**: T006, T007, T008 must complete first
**Parallel Execution**: T009 and T010 can run in parallel

- [ ] **T009**: Add named constructors to AppButton class in `lib/src/molecules/buttons/app_button.dart`
  - Add primary(), primaryOutline() constructors
  - Add secondary(), secondaryOutline() constructors
  - Add tertiary(), text() constructors
  - Add danger(), dangerOutline() constructors
  - Add small(), large() size constructors
  - Use const constructors with initializer lists per research.md Decision 3
  - **Acceptance**: All 10 named constructors compile and map to correct variant/emphasis combinations

- [ ] **T010**: Update AppButton main constructor to support new parameters
  - Add ButtonStyleVariant variant parameter with default filled
  - Add AppButtonIconPosition iconPosition parameter with default leading
  - Maintain 100% backward compatibility with existing signatures
  - **Acceptance**: Existing AppButton usage compiles without changes

### Phase 1D: AppIconButton Named Constructors

**Dependencies**: T006, T007, T008 must complete first
**Parallel Execution**: T011 and T012 can run in parallel

- [ ] **T011**: Add named constructors to AppIconButton class in `lib/src/molecules/buttons/app_icon_button.dart`
  - Add primary(), secondary() constructors
  - Add outline(), ghost() style constructors
  - Add toggle() constructor with isActive parameter
  - Add danger() constructor
  - Add small(), large() size constructors
  - Use const constructors with initializer lists
  - **Acceptance**: All 8 named constructors compile and map to correct variant/emphasis combinations

- [ ] **T012**: Update AppIconButton main constructor to support new parameters
  - Add ButtonStyleVariant variant parameter with default filled
  - Add String? tooltip parameter for accessibility
  - Maintain 100% backward compatibility with existing signatures
  - **Acceptance**: Existing AppIconButton usage compiles without changes

### Phase 1E: Basic Theme Implementation

**Dependencies**: T006, T007, T008 must complete first
**Parallel Execution**: All theme tasks can run in parallel

- [ ] **T013**: Update GlassDesignTheme with unified ButtonStyle
  - Create complete ButtonStyle instance in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart`
  - Implement all variant surfaces (filled/outline/text) with Glass theme characteristics
  - Implement StateColorSpec instances for all variants
  - **Acceptance**: Glass theme provides complete button styling without compilation errors

- [ ] **T014**: Update BrutalDesignTheme with unified ButtonStyle
  - Create complete ButtonStyle instance in `lib/src/foundation/theme/design_system/styles/brutal_design_theme.dart`
  - Implement all variant surfaces with Brutal theme characteristics (bold borders, solid colors)
  - **Acceptance**: Brutal theme provides complete button styling without compilation errors

- [ ] **T015**: Update FlatDesignTheme with unified ButtonStyle
  - Create complete ButtonStyle instance in `lib/src/foundation/theme/design_system/styles/flat_design_theme.dart`
  - Implement all variant surfaces with Flat theme characteristics (simple solid colors)
  - **Acceptance**: Flat theme provides complete button styling without compilation errors

- [ ] **T016**: Update NeumorphicDesignTheme with unified ButtonStyle
  - Create complete ButtonStyle instance in `lib/src/foundation/theme/design_system/styles/neumorphic_design_theme.dart`
  - Implement all variant surfaces with Neumorphic theme characteristics (soft shadows)
  - **Acceptance**: Neumorphic theme provides complete button styling without compilation errors

- [ ] **T017**: Update PixelDesignTheme with unified ButtonStyle
  - Create complete ButtonStyle instance in `lib/src/foundation/theme/design_system/styles/pixel_design_theme.dart`
  - Implement all variant surfaces with Pixel theme characteristics (hard edges, high contrast)
  - **Acceptance**: Pixel theme provides complete button styling without compilation errors

### Phase 1F: User Story 1 Validation

**Dependencies**: All Phase 1A-1E tasks must complete first
**Parallel Execution**: All validation tasks can run in parallel

- [ ] **T018**: Create basic smoke tests for named constructors
  - Test all AppButton named constructors instantiate without errors
  - Test all AppIconButton named constructors instantiate without errors
  - Verify no runtime exceptions during widget creation
  - **Acceptance**: All named constructors create widgets successfully

- [ ] **T019**: Validate single-line button creation (Success Criteria SC-001)
  - Test common patterns require single line of code
  - Verify `AppButton.primary(label: "Save", onTap: () {})` works
  - Verify `AppIconButton.primary(icon: Icons.add, onTap: () {})` works
  - **Acceptance**: Common button patterns require only single line of code

- [ ] **T020**: Create User Story 1 acceptance scenario tests
  - Test Scenario 1: Primary action button creation
  - Test Scenario 2: Secondary outline button creation
  - Test Scenario 3: Icon button creation
  - **Acceptance**: All three acceptance scenarios pass as defined in spec.md

### Phase 1F.1: Usage Frequency Optimization (based on button_system_design_requirements.md)

**Dependencies**: T009, T011, T018, T019, T020 must complete first
**Parallel Execution**: All optimization tasks can run in parallel

- [ ] **T020.1**: Optimize high-frequency constructor performance (AppButton.primary - 40% usage)
  - Implement const constructor optimization for AppButton.primary()
  - Benchmark single-line creation performance < 1ms
  - Verify compile-time constant evaluation works correctly
  - **Acceptance**: AppButton.primary() achieves optimal performance metrics defined in requirements.md

- [ ] **T020.2**: Optimize secondary high-frequency constructor (AppButton.secondaryOutline - 25% usage)
  - Optimize secondaryOutline rendering path for performance parity with primary
  - Ensure consistent const constructor benefits
  - **Acceptance**: secondaryOutline performance matches primary constructor performance

- [ ] **T020.3**: Optimize text button performance (AppButton.text - 15% usage)
  - Minimize rendering overhead for transparent background variant
  - Optimize text-only button layout calculations
  - **Acceptance**: text variant has minimal rendering overhead compared to filled variants

- [ ] **T020.4**: Validate usage frequency expectations
  - Create usage tracking mechanism by analyzing widgetbook story instantiations and test file constructor calls
  - Implement automated counter in test utilities to track named constructor usage patterns
  - Generate usage report comparing actual vs target frequencies (primary ≥40%, secondaryOutline ≥25%, text ≥15%)
  - Verify high-frequency constructors meet performance benchmarks (<1ms creation time)
  - Document performance benchmarks and usage statistics per requirements.md expectations
  - **Acceptance**: Usage frequency optimization meets all targets defined in design requirements with concrete measurement data

---

## User Story 2 (Priority P2): Unified Style System Integration

### Phase 2A: Style System Integration

**Dependencies**: All Phase 1 tasks must complete first
**Parallel Execution**: All tasks can run in parallel

- [ ] **T021**: Implement ButtonStyle resolution in AppButton build method
  - Access ButtonStyle from AppDesignTheme via Theme.of(context).extension<AppDesignTheme>()
  - Use ButtonStyle.getSurface() for AppSurface styling
  - Use ButtonStyle.getContentColor() for text/icon colors
  - Use ButtonStyle.getTextStyle() for typography
  - **Acceptance**: AppButton renders using unified ButtonStyle system

- [ ] **T022**: Implement ButtonStyle resolution in AppIconButton build method
  - Access ButtonStyle from AppDesignTheme
  - Use appropriate resolution methods for square icon button styling
  - Handle tooltip wrapper when tooltip parameter provided
  - **Acceptance**: AppIconButton renders using unified ButtonStyle system

- [ ] **T023**: Validate single ButtonStyle class exists (Success Criteria SC-002)
  - Remove old ButtonStyle, IconButtonStyle, TextButtonStyle classes
  - Ensure only one ButtonStyle class remains in codebase
  - Update all import statements to use unified ButtonStyle
  - **Acceptance**: Only one ButtonStyle class exists in entire codebase

- [ ] **T024**: Implement state-based style resolution
  - Ensure hover, pressed, disabled states resolve correctly
  - Verify StateColorSpec integration works for all variants
  - Test state priority order: disabled → pressed → hovered → enabled
  - **Acceptance**: All button states render with correct visual feedback

### Phase 2B: Theme Consistency Validation

**Dependencies**: T021, T022, T023, T024 must complete first
**Parallel Execution**: All validation tasks can run in parallel

- [ ] **T025**: Validate theme file consolidation (Success Criteria SC-007)
  - Verify each theme file contains single unified ButtonStyle definition
  - Confirm removal of separate button/iconButton/textButton style definitions
  - **Acceptance**: All theme files use single ButtonStyle definition

- [ ] **T026**: Create User Story 2 acceptance scenario tests
  - Test Scenario 1: Same ButtonStyle used by both AppButton and AppIconButton
  - Test Scenario 2: All three variants display with correct visual treatment
  - Test Scenario 3: StateColorSpec integration for state changes
  - **Acceptance**: All three acceptance scenarios pass as defined in spec.md

- [ ] **T027**: Validate backward compatibility (Success Criteria SC-003)
  - Compile all existing button code without modifications
  - Run existing test suites to ensure no regressions
  - **Acceptance**: All existing button code compiles and runs unchanged

---

## User Story 3 (Priority P3): Complete Style Variant Support

### Phase 3A: Advanced Variant Implementation

**Dependencies**: All Phase 2 tasks must complete first
**Parallel Execution**: All tasks can run in parallel

- [ ] **T028**: Implement complete variant/emphasis matrix support
  - Test all ButtonStyleVariant × SurfaceVariant combinations
  - Verify filled/outline/text variants work with highlight/tonal/base/elevated/accent emphasis
  - Ensure visual hierarchy: filled > outline > text
  - **Acceptance**: All 15 variant/emphasis combinations render correctly

- [ ] **T029**: Implement AppIconButton toggle state functionality
  - Ensure AppIconButton.toggle() properly handles isActive parameter
  - Verify emphasis changes based on toggle state (active = tonal, inactive = base)
  - Test visual feedback for toggle state changes
  - **Acceptance**: Toggle buttons show appropriate visual state feedback

- [ ] **T030**: Validate accent emphasis for destructive actions
  - Test AppButton.danger() and AppIconButton.danger() render with warning/error treatment
  - Verify accent emphasis provides appropriate visual weight
  - **Acceptance**: Destructive actions have distinct visual treatment

### Phase 3B: Complete Testing Suite

**Dependencies**: All Phase 3A tasks must complete first
**Parallel Execution**: T031 and T032 can run in parallel, T033 depends on both

- [ ] **T031**: Create comprehensive golden test matrix
  - Test all named constructors across all 5 themes
  - Test all button states (enabled, disabled, hover, pressed, loading)
  - Use buildThemeMatrix pattern for 4 themes × 2 brightness modes
  - **Acceptance**: Golden tests pass for all variant/theme/state combinations

- [ ] **T032**: Create User Story 3 acceptance scenario tests
  - Test Scenario 1: Manual variant/emphasis specification works correctly
  - Test Scenario 2: Visual hierarchy is clear when all variants used together
  - Test Scenario 3: Accent emphasis displays appropriate warning/error treatment
  - **Acceptance**: All three acceptance scenarios pass as defined in spec.md

- [ ] **T033**: Validate all Success Criteria are met
  - SC-001: Common button patterns require single line ✓ (T019)
  - SC-002: Only one ButtonStyle class exists ✓ (T023)
  - SC-003: Existing code compiles unchanged ✓ (T027)
  - SC-004: Visual regression tests show zero differences ✓ (T031)
  - SC-005: All 18 named constructors work across all themes ✓ (T031)
  - SC-006: All button states render correctly ✓ (T031)
  - SC-007: Single button style definition per theme ✓ (T025)
  - SC-008: Widgetbook demonstrates all combinations ✓ (T034)
  - **Acceptance**: All 8 success criteria are validated and passing

---

## Phase 4: Documentation and Polish

### Phase 4A: Developer Experience

**Dependencies**: All Phase 3 tasks must complete first
**Parallel Execution**: All tasks can run in parallel

- [ ] **T034**: Update Widgetbook stories with named constructor examples
  - Add examples for all AppButton named constructors
  - Add examples for all AppIconButton named constructors
  - Show both simplified and advanced usage patterns
  - Include interactive demos of all variant combinations
  - **Acceptance**: Widgetbook demonstrates all button combinations without visual inconsistencies

- [ ] **T035**: Update API documentation with comprehensive examples
  - Add dartdoc comments to all named constructors
  - Include usage examples for common patterns
  - Document migration paths from old to new patterns
  - **Acceptance**: All public APIs have comprehensive documentation

- [ ] **T036**: Create migration guide examples
  - Document before/after patterns for common button usage
  - Show equivalent old and new constructor usage
  - Provide performance comparison examples
  - **Acceptance**: Clear migration guidance exists for all patterns

### Phase 4B: Performance and Edge Cases

**Dependencies**: T034, T035, T036 must complete first
**Parallel Execution**: All tasks can run in parallel

- [ ] **T037**: Validate const constructor optimization
  - Verify named constructors use const initializer lists
  - Test compile-time constant evaluation performance
  - Benchmark theme switching performance
  - **Acceptance**: Named constructors provide compile-time optimization benefits

- [ ] **T038**: Test edge case scenarios
  - Test named constructor parameter conflicts (e.g., size override in .small())
  - Test theme switching with rendered buttons
  - Test undefined StateColorSpec states handling
  - Test icon sizing when button size changes in AppButton
  - **Acceptance**: All edge cases handle gracefully without crashes

- [ ] **T039**: Validate accessibility requirements
  - Test all button sizes meet minimum touch target (44px)
  - Verify tooltip accessibility for AppIconButton
  - Test semantic labels and screen reader compatibility
  - **Acceptance**: All accessibility requirements are met

---

## Task Summary (Updated with Usage Frequency Optimization)

**Total Tasks**: 43 (39 original + 4 optimization tasks)
**Phase 1 (P1 - Named Constructors)**: 24 tasks (includes 4 usage frequency optimization tasks)
**Phase 2 (P2 - Unified System)**: 7 tasks
**Phase 3 (P3 - Complete Variants)**: 8 tasks
**Phase 4 (Documentation)**: 4 tasks

### MVP Scope Recommendation
**Minimum Viable Product**: Complete Phase 1 and 2 (31 tasks total, includes usage frequency optimization)
- Provides all named constructors for simplified API
- Delivers unified ButtonStyle system
- Maintains 100% backward compatibility
- Covers User Stories 1 and 2 completely

### Parallel Execution Examples
```bash
# Phase 1A - All infrastructure can run in parallel
flutter test T001 & flutter test T002 & flutter test T003 & flutter test T004 & flutter test T005

# Phase 1E - All theme implementations in parallel
flutter test T013 & flutter test T014 & flutter test T015 & flutter test T016 & flutter test T017

# Phase 1F - All validations in parallel
flutter test T018 & flutter test T019 & flutter test T020
```

### Dependencies Visualization
```
Phase 1A (T001-T005) → Phase 1B (T006-T008) → Phase 1C,1D,1E (T009-T017) → Phase 1F (T018-T020)
                                                      ↓
Phase 2A (T021-T024) → Phase 2B (T025-T027)
                                                      ↓
Phase 3A (T028-T030) → Phase 3B (T031-T033)
                                                      ↓
Phase 4A (T034-T036) → Phase 4B (T037-T039)
```

This task breakdown provides independent user story testing, clear dependency management, and comprehensive validation of all Constitutional requirements while maintaining the existing system's reliability and performance.