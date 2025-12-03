# Phase 3 Preparation: AWS Bedrock & Interaction

## Objective
Integrate real AWS Bedrock data source and handle user interactions (e.g., form submissions, button clicks) within the rendered UI.

## Key Tasks

1.  **AWS Integration**:
    - Implement `AwsContentGenerator` using `aws_bedrock_runtime` package (or HTTP REST if package unavailable/limited).
    - Securely handle credentials (env vars, backend proxy).
    - Map Bedrock response format (Claude 3) to `LLMResponse` / `ContentBlock` domain entities.

2.  **Interaction Loop**:
    - Define `InteractionEvent` domain entity.
    - Update `OrchestrateUIFlowUseCase` to handle `tool_result` blocks (feeding tool outputs back to LLM).
    - Enhance `GenUiContainer` to capture component events (e.g., `onSaved`, `onAction`).

3.  **State Persistence**:
    - (Optional) Persist chat history / context for multi-turn conversations.

## Dependencies
- `http` or AWS SDK
- Backend proxy (recommended for production, direct for PoC)

## Pre-requisites
- AWS Account with Bedrock access (Claude 3 Sonnet/Haiku enabled).
- `generative_ui` Phase 2 complete.
