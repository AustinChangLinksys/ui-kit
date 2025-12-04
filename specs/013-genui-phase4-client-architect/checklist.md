# Requirements Checklist: GenUI Phase 4 - Client Refactoring & Layout Architect

**Purpose**: Track implementation requirements derived from the feature specification
**Created**: 2025-12-04
**Feature**: [spec.md](./spec.md)

## Functional Requirements

- [ ] FR-001 Rename `generative_ui/example/` to `generative_ui/gen_ui_client/`
- [ ] FR-002 Convert demo components to use UI Kit atoms/molecules
- [ ] FR-003 Create ComponentRegistry with all UI Kit molecules
- [ ] FR-004 Ensure dynamic components inherit from AppDesignTheme
- [ ] FR-005 Support runtime theme switching (Glass, Brutal, Flat, Neumorphic, Pixel)
- [ ] FR-006 Support seed color customization via ColorScheme.fromSeed()
- [ ] FR-007 Create default "Layout Architect" system prompt
- [ ] FR-008 Enable system prompt override via configuration
- [ ] FR-009 Export pre-configured GenUiChatView with UI Kit theming
- [ ] FR-010 Wire onAction callbacks for all interactive components

## User Story Acceptance Criteria

### US1 - Theme-Aware Dynamic Components (P1)
- [ ] US1-AC1 WifiSettingsCard uses AppSurface with Glass theme
- [ ] US1-AC2 Theme switch updates existing AI-rendered components
- [ ] US1-AC3 Multiple components update simultaneously on theme change

### US2 - Complete UI Kit Component Registry (P1)
- [ ] US2-AC1 Registry resolves AppButton with theming
- [ ] US2-AC2 Complex forms render with consistent styling
- [ ] US2-AC3 Layout components maintain hierarchy and spacing

### US3 - Seed Color Theme Switching (P2)
- [ ] US3-AC1 Seed color change updates all colors
- [ ] US3-AC2 AI-rendered components update without re-render
- [ ] US3-AC3 Both dark/light modes update with seed color

### US4 - System Prompt Injection (P2)
- [ ] US4-AC1 AI responds in Layout Architect context
- [ ] US4-AC2 AI explains available components when unavailable requested
- [ ] US4-AC3 Default Layout Architect prompt used when none provided

### US5 - Project Restructuring (P3)
- [ ] US5-AC1 gen_ui_client launches successfully
- [ ] US5-AC2 Package path references updated correctly
- [ ] US5-AC3 Documentation reflects new project name

## Success Criteria

- [ ] SC-001 No hardcoded colors visible in AI-rendered components
- [ ] SC-002 Theme switch completes within 300ms without layout shifts
- [ ] SC-003 At least 10 UI Kit molecules available in registry
- [ ] SC-004 Seed color propagates without app restart
- [ ] SC-005 gen_ui_client functions identically to example
- [ ] SC-006 Documentation explains Layout Architect concept

## Notes

- Check items off as completed: `[x]`
- Items are numbered by category for traceability
- Link to relevant code changes in PR description
