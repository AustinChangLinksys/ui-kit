# Feature Specification: Interactive & Form Expansion (Phase 3 - Network & Divider Focus)

**Feature Branch**: `005-network-inputs-divider`
**Created**: 2025-12-02
**Status**: Draft
**Input**: User description: "Implementing Network Fields (IPv4 as Compound) & Divider with Theme Adaptivity."

## 1. 📢 Clarifications

### Scope Clarifications (Focused)

*   Q: Should these new UI components require specific observability (logging, metrics)?
    *   A: **No specific requirements**; rely on existing application-level observability.
*   Q: Are there specific accessibility requirements beyond constitutional adherence?
    *   A: No additional accessibility features required; follow general constitutional guidelines.
*   Q: **(CRITICAL)** How should the four segments of `AppIpv4TextField` behave on input completion?
    *   A: When a user finishes typing the maximum three digits in a segment (e.g., "192"), focus MUST **automatically shift** to the next segment's input field.
*   Q: What is the primary use case for `AppDivider`?
    *   A: To visually and semantically separate content sections. It must support both **horizontal** (default) and **vertical** orientation.

### Session 2025-12-02
*   Q: How should pasting a complete IPv4 address (e.g., "192.168.0.1") into the `AppIpv4TextField` be handled? → A: **Smart Parse & Distribute**: Detect if the clipboard content is a valid (or partial) dot-separated IP. If yes, automatically parse and distribute the octets into the four segments.
*   Q: How should the `AppMacAddressTextField` handle separator characters typed by the user (e.g., colons or dashes)? → A: **Auto-Skip**: Allow users to type valid separators (based on theme or standard), but treat them as navigation commands (move cursor past separator) rather than data.
*   Q: Should `AppDivider` support optional text or a widget in the center of the line (e.g., "---- OR ----")? → A: **Pure Line Only**: Keep `AppDivider` strictly as a visual line separator. Use standard Flutter composition (Row + Divider) for labelled dividers.
*   Q: For `AppIpv6TextField`, should it support a compact input mode that automatically shortens groups of zeros (e.g., "0:0:0:0:0:0:0:1" to "::1")? → A: **Auto-Compact Display**: Automatically detect and display the shortest possible representation using `::` for contiguous zero blocks.
*   Q: For `AppMacAddressTextField`, how should the output format (e.g., "AA:BB:CC:DD:EE:FF" or "AA-BB-CC-DD-EE:FF") be determined if not explicitly overridden? → A: **Fixed Standard**: Always use a single, globally accepted standard (e.g., colon-separated `AA:BB:CC:DD:EE:FF`).

## 2. 🛠️ User Scenarios & Testing *(mandatory)*

### User Story 1 - Specialized Network Inputs (Priority: P1)

Developers need specialized text fields for common network addresses (IPv4, IPv6, MAC) that include built-in, strict validation and intelligent formatting. **The IPv4 input must be broken into four visually distinct and navigable segments.**

**Why this priority**: Using segmented inputs for IPv4 improves data entry speed and reduces errors, as users do not need to manually enter the separating dots.

**Independent Test**:
1.  In `AppIpv4TextField`, type "192" in the first segment. Verify that the cursor **automatically jumps** to the second segment.
2.  Attempt to type "256" into any segment of `AppIpv4TextField`. Verify that the validator fails immediately and/or the component prevents the "6" entry.
3.  Type "a1b2c3d4e5f6" into `AppMacAddressTextField`. Verify that the component automatically formats it to "A1:B2:C3:D4:E5:F6" or similar theme-appropriate separator format.

**Acceptance Scenarios**:

1.  **Given** an `AppIpv4TextField` (Compound Component), **When** a user completes an octet (max 3 digits), **Then** the focus MUST automatically advance to the next segment's input field.
2.  **Given** the complete `AppIpv4TextField` (all four segments), **When** the form's validation is triggered, **Then** the component should return the concatenated IPv4 string (e.g., "192.168.1.10").
3.  **Given** an `AppIpv6TextField` and `AppMacAddressTextField`, **When** the user inputs an invalid address, **Then** the field should immediately show the error state.
4.  **Given** an `AppIpv4TextField` with the first segment focused, **When** the user pastes a valid IPv4 string "10.0.1.1", **Then** the component MUST distribute "10", "0", "1", "1" into the respective segments.
5.  **Given** an `AppMacAddressTextField`, **When** the user manually types a separator character (colon/dash) corresponding to the current mask position, **Then** the cursor MUST advance past the separator without duplicating it.
6.  **Given** an `AppIpv6TextField` with a long series of zeroes, **When** the address is displayed, **Then** it MUST automatically be shown in its shortest compact form (e.g., "::1" instead of "0:0:0:0:0:0:0:1").
7.  **Given** an `AppMacAddressTextField`, **When** the component is rendered without an explicit output format, **Then** it MUST default to the globally accepted colon-separated format (e.g., `AA:BB:CC:DD:EE:FF`).

---

### User Story 2 - Content Separation (`AppDivider`) (Priority: P4)

Developers need a simple, consistent component to visually group and separate content, following the current theme's line thickness and color palette.

**Why this priority**: Consistent visual breaks enhance readability. Using the theme's default divider ensures color and thickness consistency.

**Independent Test**: Place an `AppDivider` between two text elements. Verify the line thickness and color match the theme's defined `DividerStyle`.

**Acceptance Scenarios**:

1.  **Given** an `AppDivider`, **When** placed inside a `Column`, **Then** it should render as a full-width horizontal line with theme-defined thickness and color.
2.  **Given** an `AppDivider` is explicitly set to **vertical** orientation, **When** placed inside a `Row`, **Then** it should occupy the specified height and render a vertical line.

### Edge Cases

*   **Input Formatting**: Ensure network fields accept both lowercase and uppercase hex characters for MAC/IPv6 input, but display them consistently (e.g., always uppercase).
*   **Vertical Divider**: Ensure the vertical divider correctly aligns when its parent widget has limited vertical space.

## 3. 🛡️ Constitutional Alignment

*(GATE: All specifications MUST adhere to the principles outlined in the Project Constitution (v1.0.0).)*

*   **2. Architectural Boundaries**:
    *   `AppIpv4TextField` is a **composite molecule** consisting of four embedded input widgets.
    *   `AppIpv6TextField` and `AppMacAddressTextField` are single **molecules** wrapping `AppTextField`.
    *   `AppDivider` is an **atom**.
*   **3. Theming & Styling**:
    *   `DividerStyle` (defining thickness, color, and optional indentation) MUST be added to `AppDesignTheme` via `ThemeExtension`.
*   **4. Component Design**:
    *   `AppIpv4TextField` requires internal logic for focus management (auto-advance) and segment-level validation (0-255).
    *   `AppIpv6TextField` and `AppMacAddressTextField` embed validation and formatting logic (InputFormatter/Masking) directly.
*   **8. Accessibility**:
    *   Network fields must clearly convey their specialized input requirements to screen readers.
    *   `AppIpv4TextField` segments must be correctly announced (e.g., "Octet 1 of 4").

## 4. ✅ Requirements *(mandatory)*

### Functional Requirements

#### Specialized Form Inputs (`AppIpv4TextField` - Compound Component)

*   **FR-001**: System MUST provide `AppIpv4TextField` as a **composite component** composed of four independent input segments, visually separated by a theme-consistent dot or separator.
*   **FR-002**: Each segment in `AppIpv4TextField` MUST enforce **octet validation** (input values must be 0-255).
*   **FR-003**: `AppIpv4TextField` MUST implement **auto-advance focus logic**: when a segment receives a third digit (unless the number starts with 0), focus must shift to the next segment.
*   **FR-004**: System MUST provide `AppIpv6TextField` with **strict built-in IPv6 address validation** and support for **compressed notation** (`::`).
*   **FR-005**: System MUST provide `AppMacAddressTextField` with **strict built-in MAC address validation** and **auto-formatting/masking** using theme-consistent separators.
*   **FR-006**: All specialized fields MUST visually mimic the states (Focus, Error, Disabled) of the base `AppTextField` exactly.
*   **FR-007 (Theme Adaptivity)**: `AppIpv4TextField`'s **separators** MUST visually adapt to the current theme:
    *   **Glass Theme**: Should use subtle, glowing, or glass-textured dots/separators.
    *   **Brutal Theme**: Should use bold, high-contrast, possibly solid rectangular or slanted geometric separators.
*   **FR-011 (Smart Paste)**: `AppIpv4TextField` MUST detect valid IPv4 strings on paste and automatically distribute octets across the four segments.
*   **FR-012 (Type-Through)**: `AppMacAddressTextField` MUST allow users to type standard separator characters to skip over the visual mask separators seamlessly.
*   **FR-014 (IPv6 Auto-Compact Display)**: `AppIpv6TextField` MUST automatically detect and display the shortest possible representation using `::` for contiguous zero blocks.
*   **FR-015 (MAC Address Output Format)**: `AppMacAddressTextField` MUST use a fixed, globally accepted colon-separated format (e.g., `AA:BB:CC:DD:EE:FF`) for output when no explicit format is provided.

#### Divider (`AppDivider`)

*   **FR-008**: System MUST provide `AppDivider` that respects the `DividerStyle` from `AppDesignTheme`.
*   **FR-009**: `AppDivider` MUST support both **horizontal** (default) and **vertical** orientations.
*   **FR-010 (Theme Adaptivity)**: `AppDivider`'s line style MUST differentiate based on the theme:
    *   **Glass Theme**: The line may have a slight glow or gradient effect, simulating a glass edge.
    *   **Brutal Theme**: The line MUST be solid, high-contrast, single-color, potentially featuring jagged or misaligned edges for a brutalist aesthetic.
*   **FR-013 (Pure Line)**: `AppDivider` MUST strictly render as a visual line separator without supporting embedded text or child widgets.

### Key Entities

*   **DividerStyle**: Theme extension defining the default thickness, color, and optional indentation for dividers.

## 5. 🚀 Success Criteria *(mandatory)*

### Measurable Outcomes

*   **SC-001**: All **4** new components pass Golden Tests across all defined theme/mode combinations.
*   **SC-002**: **(CRITICAL)** `AppIpv4TextField` successfully executes **focus auto-advance** logic in 100% of test cases when a segment is filled.
*   **SC-003**: `AppIpv4TextField`, `AppIpv6TextField`, and `AppMacAddressTextField` reject invalid/incomplete input and trigger the error state in **100%** of defined negative test cases.
*   **SC-004**: `AppMacAddressTextField` successfully formats raw input into the defined theme-style format in **100%** of test cases.
*   **SC-005**: **(Theme Adaptivity)** `AppIpv4TextField`'s separators MUST render two distinctly visual styles when switching between **Glass** and **Brutal** themes.
*   **SC-006**: **(Theme Adaptivity)** `AppDivider` MUST render two distinctly visual line styles when switching between **Glass** and **Brutal** themes.
*   **SC-007**: `AppDivider` thickness and color match the current `DividerStyle` definition in pixel comparison tests.
*   **SC-008**: `AppDivider` correctly renders a vertical line when the orientation is set to `vertical`.
*   **SC-009**: `AppIpv6TextField` correctly displays IPv6 addresses in their compact form for 100% of applicable test cases.
*   **SC-010**: `AppMacAddressTextField` defaults to `AA:BB:CC:DD:EE:FF` format in 100% of test cases when no output format is specified.