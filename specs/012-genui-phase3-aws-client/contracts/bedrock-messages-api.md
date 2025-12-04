# API Contract: AWS Bedrock Messages API

**Feature**: 012-genui-phase3-aws-client
**Date**: 2025-12-04

## Overview

This document defines the API contract for communicating with AWS Bedrock Runtime using the Claude Messages API format.

## Endpoint

```
POST https://bedrock-runtime.{region}.amazonaws.com/model/{modelId}/invoke
```

**Authentication**: AWS Signature Version 4 (SigV4)
- Service: `bedrock-runtime`
- Region: From configuration (e.g., `us-east-1`)

## Request

### Headers

| Header | Value | Required |
|--------|-------|----------|
| `Content-Type` | `application/json` | Yes |
| `Accept` | `application/json` | Yes |
| `Authorization` | SigV4 signature | Yes (auto-generated) |
| `X-Amz-Date` | ISO 8601 timestamp | Yes (auto-generated) |
| `X-Amz-Content-Sha256` | SHA256 of body | Yes (auto-generated) |

### Body Schema

```typescript
interface BedrockMessagesRequest {
  // Required: Anthropic API version for Bedrock
  anthropic_version: "bedrock-2023-05-31";

  // Required: Maximum tokens to generate
  max_tokens: number; // 1-4096 recommended

  // Optional: System prompt
  system?: string;

  // Required: Conversation messages
  messages: Message[];

  // Optional: Tool definitions for function calling
  tools?: Tool[];

  // Optional: Model parameters
  temperature?: number; // 0.0-1.0, default 1.0
  top_p?: number; // 0.0-1.0
  top_k?: number; // 1-500
  stop_sequences?: string[];
}

interface Message {
  role: "user" | "assistant";
  content: string | ContentPart[];
}

interface ContentPart {
  type: "text" | "tool_use" | "tool_result";
  // For type: "text"
  text?: string;
  // For type: "tool_use" (assistant only)
  id?: string;
  name?: string;
  input?: Record<string, unknown>;
  // For type: "tool_result" (user only)
  tool_use_id?: string;
  content?: string; // JSON-encoded result
  is_error?: boolean;
}

interface Tool {
  name: string;
  description: string;
  input_schema: JSONSchema;
}

interface JSONSchema {
  type: "object";
  properties: Record<string, PropertySchema>;
  required?: string[];
}
```

### Example: Initial User Message

```json
{
  "anthropic_version": "bedrock-2023-05-31",
  "max_tokens": 2000,
  "system": "You are a helpful assistant for network configuration. Use the available tools to help users configure their devices.",
  "messages": [
    {
      "role": "user",
      "content": "Setup Guest Network"
    }
  ],
  "tools": [
    {
      "name": "WifiSettingsCard",
      "description": "Display an interactive Wi-Fi configuration card. Use this when the user wants to view or modify Wi-Fi settings.",
      "input_schema": {
        "type": "object",
        "properties": {
          "ssid": {
            "type": "string",
            "description": "Network name (SSID)"
          },
          "security": {
            "type": "string",
            "enum": ["Open", "WPA2", "WPA3"],
            "description": "Security protocol"
          },
          "isEnabled": {
            "type": "boolean",
            "description": "Whether the network is enabled"
          },
          "frequency": {
            "type": "string",
            "enum": ["2.4GHz", "5GHz", "6GHz"],
            "description": "Radio frequency band"
          }
        },
        "required": ["ssid", "security", "isEnabled"]
      }
    },
    {
      "name": "InfoCard",
      "description": "Display an informational message card.",
      "input_schema": {
        "type": "object",
        "properties": {
          "title": { "type": "string" },
          "message": { "type": "string" },
          "type": {
            "type": "string",
            "enum": ["info", "warning", "success", "error"]
          }
        },
        "required": ["title", "message"]
      }
    }
  ]
}
```

### Example: Tool Result Message

```json
{
  "anthropic_version": "bedrock-2023-05-31",
  "max_tokens": 2000,
  "messages": [
    {
      "role": "user",
      "content": "Setup Guest Network"
    },
    {
      "role": "assistant",
      "content": [
        {
          "type": "text",
          "text": "I'll help you set up a guest network."
        },
        {
          "type": "tool_use",
          "id": "toolu_wifi_123",
          "name": "WifiSettingsCard",
          "input": {
            "ssid": "GuestNetwork",
            "security": "WPA2",
            "isEnabled": true,
            "frequency": "2.4GHz"
          }
        }
      ]
    },
    {
      "role": "user",
      "content": [
        {
          "type": "tool_result",
          "tool_use_id": "toolu_wifi_123",
          "content": "{\"action\":\"save\",\"ssid\":\"MyGuests\",\"security\":\"WPA3\",\"isEnabled\":true,\"password\":\"guest123\"}"
        }
      ]
    }
  ],
  "tools": [/* same tools array */]
}
```

## Response

### Success Response (HTTP 200)

```typescript
interface BedrockMessagesResponse {
  id: string; // Message ID, e.g., "msg_01XFDUDYJgAACzvnptvVoYEL"
  type: "message";
  role: "assistant";
  model: string; // e.g., "claude-3-5-sonnet-20241022"
  content: ResponseContentPart[];
  stop_reason: "end_turn" | "tool_use" | "max_tokens" | "stop_sequence";
  stop_sequence?: string;
  usage: {
    input_tokens: number;
    output_tokens: number;
  };
}

interface ResponseContentPart {
  type: "text" | "tool_use";
  // For type: "text"
  text?: string;
  // For type: "tool_use"
  id?: string; // e.g., "toolu_01A09q90qw90lq917835lgs"
  name?: string; // Tool name
  input?: Record<string, unknown>; // Tool parameters
}
```

### Example: Tool Use Response

```json
{
  "id": "msg_01XFDUDYJgAACzvnptvVoYEL",
  "type": "message",
  "role": "assistant",
  "model": "claude-3-5-sonnet-20241022",
  "content": [
    {
      "type": "text",
      "text": "I'll help you configure your Wi-Fi settings."
    },
    {
      "type": "tool_use",
      "id": "toolu_wifi_123",
      "name": "WifiSettingsCard",
      "input": {
        "ssid": "HomeNetwork",
        "security": "WPA2",
        "isEnabled": true,
        "frequency": "2.4GHz"
      }
    }
  ],
  "stop_reason": "tool_use",
  "usage": {
    "input_tokens": 150,
    "output_tokens": 89
  }
}
```

### Example: Confirmation Response (After Tool Result)

```json
{
  "id": "msg_02YGEVEZKhBBDawnoruWpXQ",
  "type": "message",
  "role": "assistant",
  "model": "claude-3-5-sonnet-20241022",
  "content": [
    {
      "type": "text",
      "text": "Your guest network has been configured successfully. The network 'MyGuests' is now active with WPA3 security. Guests can connect using the password you set."
    }
  ],
  "stop_reason": "end_turn",
  "usage": {
    "input_tokens": 280,
    "output_tokens": 45
  }
}
```

### Error Responses

| HTTP Code | Error Type | Description |
|-----------|------------|-------------|
| 400 | ValidationException | Invalid request format |
| 401 | UnrecognizedClientException | Invalid/expired credentials |
| 403 | AccessDeniedException | No permission to invoke model |
| 429 | ThrottlingException | Rate limit exceeded |
| 500 | InternalServerError | AWS service error |
| 503 | ServiceUnavailableException | Service temporarily unavailable |

**Error Response Format**:
```json
{
  "message": "Human-readable error description",
  "__type": "ValidationException"
}
```

## Dart Implementation Contract

### Request Builder

```dart
Map<String, dynamic> buildBedrockRequest({
  required List<ChatMessage> messages,
  required List<GenTool> tools,
  String? systemPrompt,
  int maxTokens = 2000,
  double? temperature,
}) {
  return {
    'anthropic_version': 'bedrock-2023-05-31',
    'max_tokens': maxTokens,
    if (systemPrompt != null) 'system': systemPrompt,
    'messages': messages.map((m) => m.toClaudeFormat()).toList(),
    'tools': tools.map((t) => t.toJson()).toList(),
    if (temperature != null) 'temperature': temperature,
  };
}
```

### Response Parser

```dart
LLMResponse parseBedrockResponse(String responseBody) {
  final json = jsonDecode(responseBody) as Map<String, dynamic>;
  return LLMResponse.fromMap(json);
}
```

### Error Handler

```dart
GenUiException handleBedrockError(int statusCode, String body) {
  final json = jsonDecode(body) as Map<String, dynamic>;
  final message = json['message'] as String? ?? 'Unknown error';
  final type = json['__type'] as String? ?? 'UnknownException';

  switch (statusCode) {
    case 401:
      return AuthenticationException(message);
    case 403:
      return AuthenticationException('Access denied: $message');
    case 429:
      return RateLimitException(message: message);
    case 400:
      return ValidationException(message);
    default:
      return GenUiException(message, isRetryable: statusCode >= 500);
  }
}
```

## Flow Diagrams

### Normal Conversation Flow

```
┌──────┐      ┌─────────────┐      ┌─────────┐      ┌───────────┐
│ User │      │ ChatController│    │  AWS    │      │  Bedrock  │
└──┬───┘      └──────┬──────┘      │ Adapter │      │  Runtime  │
   │                 │              └────┬────┘      └─────┬─────┘
   │ "Setup WiFi"    │                   │                 │
   │────────────────>│                   │                 │
   │                 │ generateWithHistory               │
   │                 │──────────────────>│                 │
   │                 │                   │ POST /invoke    │
   │                 │                   │────────────────>│
   │                 │                   │                 │
   │                 │                   │ tool_use        │
   │                 │                   │<────────────────│
   │                 │ LLMResponse       │                 │
   │                 │<──────────────────│                 │
   │ WifiSettingsCard│                   │                 │
   │<────────────────│                   │                 │
```

### Tool Result Flow

```
┌──────┐      ┌─────────────┐      ┌─────────┐      ┌───────────┐
│ User │      │ ChatController│    │  AWS    │      │  Bedrock  │
└──┬───┘      └──────┬──────┘      │ Adapter │      │  Runtime  │
   │                 │              └────┬────┘      └─────┬─────┘
   │ onAction(save)  │                   │                 │
   │────────────────>│                   │                 │
   │                 │ tool_result msg   │                 │
   │                 │──────────────────>│                 │
   │                 │                   │ POST /invoke    │
   │                 │                   │────────────────>│
   │                 │                   │                 │
   │                 │                   │ text response   │
   │                 │                   │<────────────────│
   │                 │ LLMResponse       │                 │
   │                 │<──────────────────│                 │
   │ "Settings saved"│                   │                 │
   │<────────────────│                   │                 │
```
