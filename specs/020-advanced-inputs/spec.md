# Feature Specification: Advanced Inputs

**Feature Branch**: `020-advanced-inputs`
**Status**: Draft

## 1. Problem Statement

Standard text fields are insufficient for complex data entry scenarios such as **Network Configuration** (Port Ranges), **Authentication** (OTP/PINs), and **Security** (Password creation with rules). Currently, these implementations are scattered, lack proper validation feedback, and do not adapt to the application's multi-paradigm design styles (e.g., Pixel vs. Glass).

## 2. User Scenarios

### 2.1 Range Input (Port/Value Range)
**As a** network admin, **I want** to input a start and end value for a port range, **So that** I can configure firewall rules efficiently without logic errors (Start > End).
*   **Scenario**: User types "80" in Start and "443" in End.
*   **Validation**: If User types "500" in Start and "20" in End, the component visually indicates an error state.

### 2.2 PIN Input (OTP/2FA)
**As a** user, **I want** to enter a 6-digit verification code, **So that** I can verify my identity quickly using auto-focus and paste functionality.
*   **Scenario**: User receives an SMS "123456", copies it, and pastes it into the field. All 6 digits fill automatically, and `onCompleted` triggers.

### 2.3 Password Input (Registration)
**As a** new user, **I want** to see real-time feedback on password complexity rules, **So that** I know exactly what criteria (length, symbol, number) I am missing while typing.
*   **Scenario**: User types "pass". The rule "At least 8 characters" remains unchecked (or red). User adds "word123!", and the rule turns green/checked.

## 3. Technical Requirements

### 3.1 AppRangeInput (Molecule)
A composite input allowing users to specify a start and end value.
*   **Structure**: Two `AppTextField`s connected by a visual separator.
*   **Validation Logic**: Supports an optional validator `bool Function(start, end)`. If false, triggers visual error on both fields.
*   **Style Strategy Matrix**:

| Feature | Flat (Default) | Glass (HUD) | Pixel (Retro) | Neumorphic |
| :--- | :--- | :--- | :--- | :--- |
| **Container** | **United Box**: Single border wrapping both inputs. | **Separated**: Two translucent boxes with a glowing line. | **Dual Blocks**: Two discrete heavy-border boxes. | **Dual Recess**: Two separate inner-shadow slots. |
| **Separator** | Text (`-` or `to`) | **Glowing Beam**: A neon line or arrow. | **ASCII**: Text (`~`) or Bitmap Icon. | **Engraved Line**: Carved visual. |
| **Error State** | Red Border | **Red Pulse**: Background glows red. | **Pattern**: Dithered background pattern. | **Red Glow**: Inner red shadow. |

### 3.2 AppPinInput (Molecule)
A segmented text input for OTP codes.
*   **Interaction**:
    *   **Ghost Input**: Use a hidden, full-width `TextField` overlay to handle focus, keyboard events, and clipboard pasting seamlessly.
    *   **Rendering**: Map the text value to a list of visual containers (Cells).
*   **Style Strategy Matrix**:

| Feature | Flat (Default) | Glass (Neon) | Pixel (Retro) | Neumorphic |
| :--- | :--- | :--- | :--- | :--- |
| **Cell Shape** | **Underline**: `_ _ _ _` | **Orb/Box**: Translucent shape with blur. | **Box**: Heavy black border `[ ]`. | **Recess**: Circular/Square hole. |
| **Active State** | Border Color Change | **Glow**: The active cell pulses. | **Blink**: A block cursor blinks (0ms). | **Convex**: Active cell pops up. |
| **Filled State** | Text Visible | **Illuminated**: Cell lights up (`signalStrong`). | **Solid Block**: Inverted colors (`activeFill`). | **Filled**: Standard text. |
| **Obscure** | `●` | **Blur Dot**: A fuzzy glowing dot. | `*` or `■` (Pixel block). | `●` (Inset). |

### 3.3 AppPasswordInput (Molecule)
A specialized input with visibility toggle and a rule validation list.
*   **Composition**: Wraps `AppTextField` and a custom `_PasswordRulesRenderer`.
*   **Rule Logic**: Accepts `List<AppPasswordRule>`. Evaluates rules on every keystroke.
*   **Style Strategy Matrix**:

| Feature | Flat (Default) | Glass (Neon) | Pixel (Retro) | Neumorphic |
| :--- | :--- | :--- | :--- | :--- |
| **Rule List** | Vertical List | **Glass Panel**: Rules sit on a faint blurred pane. | **Console Log**: Monospace text. `[ ]` vs `[x]`. | **Inset List**: Rules inside a recessed area. |
| **Valid Rule** | Green Icon + Text | **Green Glow**: Text glows (`signalStrong`). | **Solid Check**: `[x]` becomes `[■]`. | Green Text |
| **Pending Rule** | Grey Text | Faint Text | `[ ]` Empty Bracket | Grey Text |
| **Toggle Icon** | Standard Eye | **Glowing Eye**: Icon has a halo. | **Pixel Eye**: Bitmap/Aliased icon. | **Soft Button**: Convex toggle. |

### 3.4 Shared Systems Integration
#### **Semantic Color Mapping**
All components **MUST** use `AppColorScheme`:
*   **Active/Focus**: `primary` (Flat) or `signalStrong` (Glass/Pixel).
*   **Error/Invalid**: `error` or `signalWeak` (if used for "weak password").
*   **Background**: `styleBackground`.
*   **Text**: `onSurface`.

#### **Unified Motion System**
*   **Pixel Mode**: All state changes (Focus, Error Shake, Rule Check) must be **Instant (0ms)** or Stepped.
*   **Glass Mode**: Focus transitions and Rule validation success must use **Fluid Curves (500ms)**.

#### **Feedback System**
*   **Typing**: Standard keyboard feedback.
*   **Rule Success**: Trigger `AppFeedback.onSelection()` (Light) when a rule turns green.
*   **Form Valid**: Trigger `AppFeedback.onSuccess()` when all rules pass.
*   **Validation Error**: Trigger `AppFeedback.onError()` (Heavy) on submit if invalid.

## 4. Success Criteria

### 4.1 Visual Fidelity (Golden Matrix)
*   [ ] **AppPinInput (Pixel)**: Verify fields are square blocks with thick borders. Filled state shows inverted colors.
*   [ ] **AppPinInput (Glass)**: Verify fields are translucent orbs. Active field has a glow.
*   [ ] **AppRangeInput (Neumorphic)**: Verify the two input areas appear as separate recessed slots.
*   [ ] **AppPasswordInput (Pixel)**: Verify the validation list looks like a CLI log (`[ ] Rule`).

### 4.2 Interaction Verification
*   [ ] **Pin Paste**: Copy "123456" -> Tap input -> Paste. Verify all digits fill correctly and `onCompleted` fires.
*   [ ] **Range Logic**: Enter Start=100, End=50. Verify validation error state appears (Border color change / Icon).
*   [ ] **Password Feedback**: Type a character that satisfies a rule. Verify the specific rule updates visually (Color/Icon change).
*   [ ] **Haptics**: Verify haptic feedback triggers when a password rule becomes valid.

### 4.3 Accessibility
*   [ ] **AppPinInput**: Must expose semantic value as "One, Two, Three..." sequence or full number to screen readers.
*   [ ] **AppRangeInput**: Start and End fields must have distinct accessibility labels.

## 5. Assumptions & Dependencies

*   **Dependencies**: `AppTextField`, `AppIcon`, `AppColorScheme`, `AppMotion`, `AppFeedback`.
*   **Theme Extensions**: Need to create `RangeInputStyle`, `PinInputStyle`, `PasswordInputStyle` theme extensions.
