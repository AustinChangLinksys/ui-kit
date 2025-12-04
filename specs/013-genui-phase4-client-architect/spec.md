# Feature Specification: GenUI Phase 4 - Client Refactoring & Layout Architect

**Feature Branch**: `013-genui-phase4-client-architect`
**Created**: 2025-12-04
**Status**: Draft
**Input**: User description: "Upgrade `example/` to `gen_ui_client/` with Layout Architect role"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Theme-Aware Dynamic Components (Priority: P1)

When the AI renders a dynamic UI component (e.g., WifiSettingsCard), it automatically adopts the current app theme (Glassmorphism, Neo-Brutalism, Flat, Neumorphic, Pixel) rather than using hardcoded Material widgets.

**Why this priority**: This is the core value proposition of the Layout Architect. Without theme-awareness, the AI-generated UI feels disconnected from the rest of the application, breaking visual consistency.

**Independent Test**: Can be tested by switching themes at runtime and verifying all AI-rendered components update their appearance accordingly.

**Acceptance Scenarios**:

1. **Given** the app is set to Glassmorphism theme, **When** the AI renders a WifiSettingsCard, **Then** the card uses AppSurface with blur effects and glass-like appearance.
2. **Given** the user switches from Glass to Brutal theme, **When** viewing an existing AI-rendered component, **Then** the component updates to use bold borders and brutalist styling.
3. **Given** multiple dynamic components are rendered in a conversation, **When** the theme changes, **Then** all components update simultaneously to match the new theme.

---

### User Story 2 - Complete UI Kit Component Registry (Priority: P1)

The system provides a comprehensive registry of UI Kit components that the AI can utilize. This includes AppButton, AppTextField, AppCard, AppListTile, AppSwitch, AppCheckbox, and other molecules, not just demo-specific components.

**Why this priority**: A rich component library enables the AI to construct sophisticated layouts. Without this, the AI is limited to a few hardcoded demo widgets.

**Independent Test**: Can be tested by asking the AI to create various UI layouts and verifying it can use the full range of UI Kit components.

**Acceptance Scenarios**:

1. **Given** the component registry is initialized, **When** the AI requests an AppButton, **Then** the system resolves and renders an AppButton with appropriate theming.
2. **Given** a complex form request, **When** the AI responds with multiple form components (AppTextField, AppCheckbox, AppDropdown), **Then** all components render correctly with consistent styling.
3. **Given** a layout request, **When** the AI uses layout components (AppCard, AppListTile), **Then** the components maintain proper hierarchy and spacing.

---

### User Story 3 - Seed Color Theme Switching (Priority: P2)

Users can switch the application's seed color at runtime, and all components (including AI-rendered ones) automatically update their color palette.

**Why this priority**: Personalization enhances user experience, but builds upon the theme-awareness foundation. This enables brand customization and accessibility.

**Independent Test**: Can be tested by changing the seed color from the UI and verifying all colors update throughout the application.

**Acceptance Scenarios**:

1. **Given** the current seed color is blue, **When** the user selects a red seed color, **Then** all primary colors, accent colors, and component highlights update to red-based palette.
2. **Given** an AI-rendered component exists, **When** the seed color changes, **Then** the component's color scheme updates without re-rendering the entire conversation.
3. **Given** both dark and light modes are available, **When** the seed color changes, **Then** both mode palettes update to use the new seed color.

---

### User Story 4 - System Prompt Injection (Priority: P2)

Developers can inject custom system prompts that instruct the AI about its role as a "Layout Architect" and the available UI Kit components, without modifying the core library.

**Why this priority**: Customization allows different applications to have different AI personalities and capabilities. This enables domain-specific assistants.

**Independent Test**: Can be tested by configuring a custom system prompt and verifying the AI follows the injected instructions.

**Acceptance Scenarios**:

1. **Given** a system prompt describes the Layout Architect role, **When** the user asks for help, **Then** the AI responds in the context of being a layout designer.
2. **Given** a system prompt lists available components, **When** the user requests a component not in the list, **Then** the AI explains what is available instead.
3. **Given** no custom system prompt is provided, **When** the app initializes, **Then** a default Layout Architect prompt is used.

---

### User Story 5 - Project Restructuring (Priority: P3)

The `example/` directory is renamed to `gen_ui_client/` and restructured as a standalone Flutter application that demonstrates the full capabilities of the generative UI system.

**Why this priority**: Project organization is important for maintainability but doesn't directly affect runtime functionality. This makes the codebase more professional and easier to navigate.

**Independent Test**: Can be tested by building and running the renamed project and verifying all existing functionality still works.

**Acceptance Scenarios**:

1. **Given** the project is restructured, **When** running `flutter run` in `gen_ui_client/`, **Then** the application launches successfully.
2. **Given** the project references generative_ui package, **When** the path reference is updated, **Then** all imports resolve correctly.
3. **Given** documentation exists, **When** the project is renamed, **Then** README and comments are updated to reflect the new name.

---

### Edge Cases

- What happens when a component requested by the AI is not in the registry?
- How does the system handle theme changes while a component is loading?
- What happens if seed color values are invalid (out of range)?
- How does the system behave when system prompt exceeds token limits?
- What happens if the AI tries to nest components in unsupported ways?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST rename `generative_ui/example/` to `generative_ui/gen_ui_client/`.
- **FR-002**: All demo components MUST use UI Kit atoms/molecules instead of hardcoded Material widgets.
- **FR-003**: System MUST provide a ComponentRegistry pre-populated with all UI Kit molecules (AppButton, AppTextField, AppCard, AppListTile, AppSwitch, AppCheckbox, AppDropdown, AppSlider, AppBadge, AppTag, AppAvatar).
- **FR-004**: Dynamic components MUST inherit their visual appearance from the current AppDesignTheme.
- **FR-005**: System MUST support runtime theme switching (Glass, Brutal, Flat, Neumorphic, Pixel) for all AI-rendered components.
- **FR-006**: System MUST support seed color customization via ColorScheme.fromSeed().
- **FR-007**: System MUST provide a default "Layout Architect" system prompt that describes the AI's role and available components.
- **FR-008**: Developers MUST be able to override the system prompt via configuration.
- **FR-009**: System MUST export a pre-configured GenUiChatView that works out-of-the-box with UI Kit theming.
- **FR-010**: All component registrations MUST include proper onAction callback wiring for interactive components.

### Key Entities

- **LayoutArchitectPrompt**: Default system prompt template that describes the AI's role as a layout designer and lists available components.
- **ThemeAwareComponent**: A component wrapper or pattern ensuring dynamic components access AppDesignTheme from context.
- **UiKitComponentRegistry**: Pre-built ComponentRegistry with all UI Kit molecules registered with proper factory functions.
- **SeedColorProvider**: State management for runtime seed color changes that propagates to all theme instances.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All AI-rendered components visually match the current theme with no hardcoded colors visible.
- **SC-002**: Theme switching updates all visible components within 300ms without layout shifts or flickering.
- **SC-003**: At least 10 UI Kit molecules are available in the component registry for AI use.
- **SC-004**: Seed color changes propagate to all components without requiring app restart or re-render of conversation.
- **SC-005**: The gen_ui_client application launches and functions identically to the previous example application.
- **SC-006**: Documentation clearly explains the Layout Architect concept and how to customize system prompts.

## Assumptions

- Phase 1-3 of GenUI are complete and functional.
- UI Kit library provides all necessary atoms and molecules with proper theming support.
- AppDesignTheme and theme switching mechanism from ui_kit_library are stable.
- The AI (Claude via AWS Bedrock) can understand component schemas and generate appropriate tool use.
- Runtime theme switching via Flutter's ThemeMode and custom theme extensions works reliably.

## Dependencies

- GenUI Phase 1-3 (completed)
- UI Kit Library with complete atoms and molecules
- AppDesignTheme system from ui_kit_library
- flutter_dotenv for configuration
- AWS Bedrock access

## Out of Scope

- Custom component creation UI (drag-and-drop builder)
- Persistent theme preferences across sessions
- Multi-language system prompt support
- Component animations/transitions during theme switches
- AI-driven component creation (generating new component code)
- Accessibility automation (the AI suggesting accessible alternatives)
