# Data Model & State

**Branch**: `020-advanced-inputs`

## 1. Entities

### 1.1 AppPasswordRule
Defines a validation rule for `AppPasswordInput`.

| Field | Type | Description |
| :--- | :--- | :--- |
| `label` | `String` | Text displayed to the user (e.g., "At least 8 chars"). |
| `validate` | `bool Function(String)` | Logic to check if the rule is met. |

## 2. Enums

### 2.1 PinCellShape (Style)
*   `underline`: Flat default.
*   `box`: Pixel/Brutal.
*   `circle`: Glass/Neumorphic.
*   `recess`: Neumorphic special.

## 3. Validation Rules

*   **AppRangeInput**: `start` and `end` are strings but logically numbers. Custom validator can enforce logic (e.g., start < end).
*   **AppPinInput**: Enforces length constraint. Only emits `onCompleted` when full length reached.
