# Feature Specification: GenUI Phase 2 - UI Rendering & Component Registry Integration

**Feature Branch**: `009-genui-ui-rendering`
**Created**: 2025-12-03
**Status**: Draft
**Input**: Phase 2 continuation - Transform GenUI logic (Phase 1) into dynamic Flutter UI rendering with component registry pattern

## User Scenarios & Testing

### User Story 1 - Developer Registers UI Components (Priority: P1)

A developer needs to declare which Flutter UI Kit components are available for GenUI to use during app initialization, without modifying GenUI core code.

**Why this priority**: This is foundational - without a registry, rendering has nowhere to look up components. Blocks all downstream rendering work.

**Independent Test**: Can be tested by registering 2-3 components, then verifying the registry returns them on lookup.

**Acceptance Scenarios**:

1. **Given** a developer initializes the app with a `ComponentRegistry`, **When** they register `WifiSettingsCard`, **Then** the registry stores and can return the component builder.
2. **Given** an unregistered component name, **When** the registry attempts lookup, **Then** it returns null or a "not found" indicator without crashing.
3. **Given** multiple developers adding components, **When** the registry is queried, **Then** all registered components are available and isolated.

---

### User Story 2 - Dynamic Widget Rendering from JSON (Priority: P1)

A developer inputs "Setup Wi-Fi" into GenUI. The system receives `LLMResponse` with `ToolUseBlock(name: "WifiSettingsCard", input: {ssid: "...", security: "..."})`and renders the actual Flutter `WifiSettingsCard` widget on screen.

**Why this priority**: This is the core MVP - transforming Phase 1's structured data into visual output.

**Independent Test**: Can be tested by mocking the Phase 1 orchestrator and verifying that a `ToolUseBlock` produces the correct Flutter widget.

**Acceptance Scenarios**:

1. **Given** Phase 1 returns a valid `ToolUseBlock` with component name and props, **When** `DynamicWidgetBuilder` processes it, **Then** the correct Flutter widget is instantiated with those props.
2. **Given** the builder encounters a component name not in the registry, **When** it attempts to build, **Then** it renders an "Unsupported Component" fallback card instead of crashing.
3. **Given** a mismatch between JSON props and widget parameter types, **When** type conversion fails, **Then** an error boundary catches it and displays an error state without affecting other components.

---

### User Story 3 - Mixed Content Layout (Priority: P2)

A developer triggers a response that contains both `TextBlock` and `ToolUseBlock` in the same `LLMResponse`. The UI should display them sequentially: first the text in a chat bubble, then the component card below it.

**Why this priority**: Enhances realism - real LLM responses often include text explanations + component actions. Medium priority because pure component rendering (US2) is more critical.

**Independent Test**: Can be tested by providing a mixed `LLMResponse` and verifying the layout contains both elements in correct order.

**Acceptance Scenarios**:

1. **Given** `LLMResponse.content = [TextBlock(text: "Hello"), ToolUseBlock(...)]`, **When** rendered, **Then** the text displays first, followed by the component below it.
2. **Given** multiple `ToolUseBlock` instances, **When** rendered, **Then** they appear stacked vertically.
3. **Given** empty or missing content blocks, **When** the UI is built, **Then** a fallback message appears without breaking the layout.

---

### User Story 4 - Loading & Error State Management (Priority: P2)

While Phase 1's orchestrator processes a request (mocked at 100ms), the UI should display a loading indicator ("Thinking..."). Once data arrives or an error occurs, the UI transitions to data or error state gracefully.

**Why this priority**: UX polish - without this, users see blank screen during processing.

**Independent Test**: Can be tested by simulating delayed Phase 1 response and verifying loading indicator appears/disappears appropriately.

**Acceptance Scenarios**:

1. **Given** Phase 1 is processing, **When** GenUiWrapper is mounted, **Then** a loading indicator is displayed.
2. **Given** Phase 1 returns data, **When** the state updates, **Then** the loading indicator smoothly transitions to rendered content.
3. **Given** Phase 1 throws an exception, **When** the error is caught, **Then** an error message displays with the exception detail.

---

### Edge Cases

- What happens when the user input produces an empty `LLMResponse` (no content blocks)? Display a default message: "No content generated."
- How does the system handle a `ToolUseBlock` with missing required properties? Error boundary catches and displays a "Component Error" card with debugging info.
- What if the component builder function crashes (e.g., null dereference)? The error is caught and isolated to that specific widget; other content remains visible.
- How does the system scale with many components registered? Registry is O(1) lookup; no performance degradation expected up to 100+ components.

## Requirements

### Functional Requirements

- **FR-01**: System MUST render `TextBlock` content as a chat bubble styled according to UI Kit standards.
- **FR-02**: System MUST render `ToolUseBlock` by looking up the component name in the registry and instantiating the corresponding widget.
- **FR-03**: System MUST provide a `ComponentRegistry` interface allowing developers to register component builders during app initialization.
- **FR-04**: System MUST support automatic type conversion for primitive types (String, int, bool, double) and Enums when mapping JSON props to widget parameters.
- **FR-05**: System MUST display an "Unsupported Component" fallback card when a `ToolUseBlock` name is not found in the registry, without crashing the app.
- **FR-06**: System MUST implement error boundaries that catch rendering exceptions and confine them to the affected widget without crashing other components.
- **FR-07**: System MUST display a loading indicator ("Thinking...") while Phase 1 is processing a user request.
- **FR-08**: System MUST transition from loading to data/error state when Phase 1 completes or fails.
- **FR-09**: System MUST support mixed layouts with multiple `TextBlock` and `ToolUseBlock` instances rendered sequentially.
- **FR-10**: System MUST provide a `GenUiWrapper` widget as the entry point, accepting the orchestration use case and component registry.

### Key Entities

- **ComponentRegistry**: Interface defining `lookup(String componentName) -> WidgetBuilder?`.
- **WidgetBuilder**: Typedef `Function(BuildContext, Map<String, dynamic> props) -> Widget`.
- **GenUiWrapper**: Stateful widget wrapping the rendering logic, state management, and UI composition.
- **DynamicWidgetBuilder**: Utility that parses props and instantiates widgets via the registry.
- **UnsupportedComponentWidget**: Fallback widget for unregistered components.
- **ErrorBoundaryWidget**: Widget that catches exceptions and displays an error state.

## Success Criteria

### Measurable Outcomes

- **SC-001**: End-to-End Rendering - Input "Setup Wi-Fi" renders `WifiSettingsCard` with correct SSID, security type, and toggle, styled per UI Kit guidelines.
- **SC-002**: Mixed Layout - Input triggering mixed response displays text bubble followed by component card in correct sequence without layout breaks.
- **SC-003**: Fault Tolerance - Mock returning unknown component name "UnknownCard" displays "Unsupported Widget: UnknownCard" and app remains functional.
- **SC-004**: Visual Regression - Golden tests verify dynamically generated components are pixel-perfectly identical to hardcoded equivalents across all 8 theme combinations (4 themes × 2 brightness).
- **SC-005**: Component Registry Registration - Developers can register 5+ components and retrieve them without errors; registry lookup completes in <10ms.
- **SC-006**: Error Boundary Isolation - Component rendering error (e.g., null dereference) displays error indicator without affecting sibling widgets or loading state.
- **SC-007**: Loading State Transition - Loading indicator appears within 100ms of mount, disappears within 50ms of data arrival, smooth animation with no jank.
- **SC-008**: Type Conversion Support - JSON props with String, int, bool, double, and Enum types are correctly converted and passed to widget parameters without exceptions.

## Assumptions

- Phase 1 (orchestration logic) is complete and returns properly validated `LLMResponse` objects.
- UI Kit components (e.g., `WifiSettingsCard`, `InfoCard`) exist and follow consistent parameter conventions.
- Component builders are synchronous (no async operations) and do not modify app state.
- `AppSurface` pattern is mandatory for all rendered cards to maintain UI Kit consistency.
- Theme switching and styling are inherited from `AppDesignTheme` context; no custom theming in GenUI.
- The loading indicator animation is provided by UI Kit (e.g., `AppLoader` with "Thinking..." label).
- Unknown component fallback should display raw JSON data for debugging; intended for development/testing only.
- Error messages prioritize user-friendliness over technical detail (e.g., "Component Error" instead of stack trace).
- Interaction callbacks (buttons, form submissions) are deferred to Phase 3; Phase 2 focuses on rendering only.

## Out of Scope

- User interaction handling (buttons, form submissions, callbacks) - deferred to Phase 3.
- AWS Bedrock integration - remains in Phase 3.
- Streaming/incremental responses - deferred to future phases.
- Persistent conversation history or state storage - Phase 2 focuses on single-request rendering.
- Multi-language support or localization - deferred to Phase 3 or beyond.
- Animation library integrations beyond `AppLoader` - use UI Kit standards only.
- Caching or memoization of rendered components - render on-demand for MVP.

## Interface Contracts

### ComponentRegistry Interface

```dart
abstract class IComponentRegistry {
  /// Register a component builder by name
  void register(String componentName, WidgetBuilder builder);

  /// Lookup a component builder by name
  WidgetBuilder? lookup(String componentName);

  /// Get all registered component names (for debugging)
  List<String> getRegisteredComponents();
}
```

### WidgetBuilder Signature

```dart
typedef WidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props,
);
```

### GenUiWrapper Constructor Contract

```dart
GenUiWrapper({
  required OrchestrateUIFlowUseCase orchestrator,
  required IComponentRegistry registry,
  required VoidCallback onComplete,
})
```

## UX/UI Design

### Loading Experience

- Display `AppLoader` widget (from UI Kit) with "Thinking..." label when GenUiWrapper mounts and Phase 1 is processing.
- Use a "blinking dots" or pulse animation (Glass theme) or similar per active design system.
- Smooth fade transition (100-300ms) when data arrives; do not abruptly replace loading with content.

### Error Display

- Display an `AppCard` with red accent color (error variant) containing error message and optional debug info.
- Include a "Retry" button that re-triggers the orchestration flow.

### Component Rendering

- Each `ToolUseBlock` is wrapped in an `AppCard` for visual consistency.
- Text blocks are displayed in a chat bubble style (left-aligned, soft background).
- Multiple content blocks are stacked vertically with consistent spacing (`AppGap` between them).

### Accessibility

- All interactive elements have meaningful labels for screen readers.
- Loading state is announced to assistive tech ("Processing request").
- Error states include descriptive text, not just visual indicators.

## Testing Strategy

### Widget Testing

- Test `GenUiWrapper` state transitions: initial → loading → data → complete.
- Test `GenUiWrapper` error handling: invalid phase 1 response, null registry, missing components.
- Test `DynamicWidgetBuilder` type conversion: primitives, enums, edge cases (null values, wrong types).
- Test `ComponentRegistry` lookup performance and isolation.

### Integration Testing

- Mock Phase 1 orchestrator returning valid `LLMResponse`.
- Verify rendered widget tree contains expected widgets with correct props.
- Trigger Phase 1 errors and verify error boundary captures them.

### Golden Testing

- Capture screenshots of dynamically rendered components across all 8 theme combinations.
- Compare with hardcoded component screenshots; verify pixel-perfect match.
- Use `alchemist` with Safe Mode protocol (explicit constraints, background color injection, animation freezing).

## Acceptance Criteria - Phase 2 Completion

Phase 2 is **complete** when:

1. ✅ All 4 user stories (US1-US4) are implemented and tested independently.
2. ✅ All 10 functional requirements (FR-01 to FR-10) are satisfied.
3. ✅ All 8 success criteria (SC-001 to SC-008) are verified.
4. ✅ Golden tests pass across all 8 theme combinations with <2% pixel difference tolerance.
5. ✅ Zero regressions in existing UI Kit tests.
6. ✅ Architecture compliance: 6/6 Constitution gates pass (same as Phase 1).
7. ✅ Documentation updated: quickstart.md, data-model.md, Phase 2 tasks complete.
8. ✅ Ready for Phase 3 (AWS integration + interaction handling).
