# Feature Specification: GenUI Client-Side Orchestration (Mock-First PoC)

**Feature Branch**: `008-genui-mockfirst-poc`
**Created**: 2025-12-03
**Status**: Draft
**Input**: User description: "GenUI Client-Side Orchestration (Mock-First PoC) - A proof-of-concept implementation that validates end-to-end GenUI logic from prompt assembly and JSON parsing to UI rendering using a mock server. The feature includes a unified ContentGenerator interface, mock adapter for hardcoded responses, robust JSON parser for handling malformed data, schema generator for Flutter widgets, and mock scenarios for Wi-Fi settings and info cards. Designed for seamless transition to real AWS Bedrock when ready."

## User Scenarios & Testing

### User Story 1 - Developer Validates JSON Parsing Logic (Priority: P1)

A developer needs to verify that the Flutter app can correctly parse JSON responses from the LLM into properly validated domain models, without waiting for AWS integration or dealing with network latency. **Note**: Phase 1 focuses on parsing logic validation; actual UI component rendering is deferred to Phase 2.

**Why this priority**: This is the foundation of the entire system. Without a working parser and renderer, the mock adapter cannot be validated. This unblocks all other development.

**Independent Test**: Can be fully tested by providing hardcoded mock JSON responses and verifying that they are correctly parsed into domain models (LLMResponse, ToolUseBlock, TextBlock) with proper validation. Delivers the core "parse and validate JSON → structured data" value proposition. (Actual UI rendering verified in Phase 2.)

**Acceptance Scenarios**:

1. **Given** the app receives a mock JSON response with a WifiSettingsCard tool_use block, **When** the parser processes it, **Then** the correct WifiSettingsCard component renders with the provided SSID, security, and enabled status.
2. **Given** the app receives a mock JSON response with plain text content, **When** the parser processes it, **Then** the text is displayed in an info card without errors.
3. **Given** the parser encounters malformed JSON (wrapped in markdown code blocks or invalid syntax), **When** it attempts to extract JSON, **Then** it gracefully handles the error and displays an error message.

---

### User Story 2 - Developer Triggers Mock Scenarios via Text Input (Priority: P1)

A developer needs to easily trigger different mock responses by typing simple text commands to test various UI states without modifying code.

**Why this priority**: This enables rapid iteration on UI components and allows testing of edge cases without complex setup. Essential for parallel development of parser and UI components.

**Independent Test**: Can be fully tested by typing "Setup Wi-Fi", observing the WifiSettingsCard render; typing "Hello", observing the info card; typing "Test Error", observing error handling. Each delivers testable value independently.

**Acceptance Scenarios**:

1. **Given** the developer types "Setup Wi-Fi", **When** the MockContentGenerator processes the input, **Then** it returns JSON for a WifiSettingsCard with predefined configuration.
2. **Given** the developer types "Hello" or any greeting, **When** the MockContentGenerator processes the input, **Then** it returns JSON with a plain text message.
3. **Given** the developer types "Test Error", **When** the MockContentGenerator processes the input, **Then** it returns malformed JSON to validate error handling paths.

---

### User Story 3 - Schema Generator Serializes Flutter Widgets to JSON Schema (Priority: P2)

A developer needs to define how Flutter UI components should be represented in JSON Schema format so that the LLM can generate valid schemas for future AWS integration.

**Why this priority**: This enables the transition to real LLM by establishing the contract between the client and the LLM. Not critical for Phase 1 validation but essential for Phase 2 configuration.

**Independent Test**: Can be tested by verifying that selected components (WifiSettingsCard, InfoCard) are serialized into valid JSON Schema that matches the format expected by the mock adapter.

**Acceptance Scenarios**:

1. **Given** a Flutter widget like WifiSettingsCard exists, **When** the schema generator processes it, **Then** it produces valid JSON Schema defining its properties (ssid, security, isEnabled).
2. **Given** multiple components are available, **When** the schema generator processes them, **Then** it generates a complete schema document for the LLM tool_use format.

---

### User Story 4 - Configuration Prepared for Future AWS Integration (Priority: P2)

A developer needs `ai_config.json` and system prompt structure in place to prepare for seamless transition to real AWS Bedrock without refactoring the mock system.

**Why this priority**: This enables Phase 2 and Phase 3 work to proceed without disrupting Phase 1 logic validation. Architectural preparation for the "seamless switch."

**Independent Test**: Can be tested by verifying that `ai_config.json` exists with the correct structure and can be loaded by the app without errors.

**Acceptance Scenarios**:

1. **Given** the app initializes, **When** it attempts to load `ai_config.json`, **Then** it successfully loads the configuration without errors.
2. **Given** the mock adapter exists, **When** the unified `ContentGenerator` interface is used, **Then** both mock and future AWS implementations can be swapped by changing a single line in configuration or code.

---

### Edge Cases

- What happens when the user enters text that doesn't match any mock scenario keywords? System should return a default "no matching scenario" response gracefully.
- How does the parser handle JSON with extra whitespace or nested code blocks (e.g., markdown code blocks)? Parser must extract and clean before deserializing.
- What happens when the LLM response format changes in future versions? The unified interface should abstract format details to minimize downstream impact.
- How does the system handle rapid sequential requests? Mock adapter should respond consistently without race conditions or state pollution.

## Requirements

### Functional Requirements

- **FR-001**: System MUST provide a unified `ContentGenerator` interface that abstracts backend implementation (mock vs. real).
- **FR-002**: System MUST implement `MockContentGenerator` that inherits from `ContentGenerator` and returns hardcoded JSON responses based on text input keywords.
- **FR-003**: System MUST implement a universal JSON parser that extracts valid JSON from raw strings, handling markdown code blocks and nested whitespace.
- **FR-004**: System MUST implement a schema generator that serializes Flutter widgets into JSON Schema format compatible with LLM tool_use format.
- **FR-005**: System MUST render UI components dynamically based on parsed JSON tool_use blocks from the mock adapter.
- **FR-006**: System MUST provide at least 3 mock scenarios: Wi-Fi settings configuration, plain text info card, and malformed JSON error handling.
- **FR-007**: System MUST initialize and load configuration from `ai_config.json` at app startup.
- **FR-008**: System MUST cleanly separate mock logic from parsing/rendering logic to enable future AWS adapter implementation.
- **FR-009**: Users MUST be able to trigger mock scenarios by typing text commands in the app interface.
- **FR-010**: System MUST handle and display errors gracefully when encountering invalid JSON or unknown scenarios.

### Key Entities

- **ContentGenerator Interface**: Abstract contract defining `generate(String userInput) -> String jsonResponse`. Implementations include MockContentGenerator and future AwsPassThroughGenerator.
- **MockContentGenerator**: Concrete implementation that returns predefined JSON based on keyword matching in user input.
- **JSON Parser**: Utility that extracts valid JSON from strings, handling code blocks and malformed input.
- **Schema Generator**: Utility that dynamically serializes Flutter widgets into JSON Schema format.
- **MockResponse**: Data model representing Claude-compatible responses with `id`, `model`, and `content` fields.
- **Tool Use Block**: JSON structure with `type: "tool_use"`, `name: "ComponentName"`, and `input: {properties}`.

## Success Criteria

### Measurable Outcomes

- **SC-001**: All 3 core mock scenarios (Wi-Fi, info, error) trigger correctly and render expected UI without errors.
- **SC-002**: JSON parser correctly extracts and deserializes valid JSON from at least 5 different malformed input formats (code blocks, extra whitespace, nesting).
- **SC-003**: Schema generator produces valid JSON Schema for at least 2-3 UI components that validates against the mock response format.
- **SC-004**: App initializes without errors and loads `ai_config.json` successfully.
- **SC-005**: Parser and renderer operate independently - parser can be tested separately from UI component rendering.
- **SC-006**: All existing UI Kit tests continue to pass after adding GenUI orchestration code.
- **SC-007**: Developers can add new mock scenarios by adding <10 lines of code to keyword matching logic.
- **SC-008**: MockContentGenerator returns responses in <100ms consistently (local performance, not I/O bound).

## Assumptions

- The mock adapter is the only backend implementation during Phase 1; AWS integration is explicitly deferred to Phase 3.
- Component responses follow Claude's tool_use format as the source of truth for JSON structure.
- The app already has UI Kit components available (WifiSettingsCard, InfoCard, etc.) or these will be created as part of this work.
- Error handling prioritizes user-friendly messages over technical debugging details.
- Performance targets assume local device execution without network latency.
- Reasonable defaults apply: JSON parsing uses standard Dart libraries; schema generation uses JSON Schema Draft 7 standards; configuration uses YAML or JSON as per project conventions.

## Out of Scope

- AWS Bedrock integration and authentication (deferred to Phase 3).
- Real LLM system prompt refinement and tuning (deferred to Phase 2).
- Advanced features like streaming responses, caching, or request queuing.
- Persistent storage of interaction history or mock scenarios.
- Multi-language support or localization.
