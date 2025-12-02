# ⚙️ Technical Implementation Plan: UI Kit - Network Fields & Divider

## 1. 🏗️ Architectural Decisions & Component Structure

### A. Component Placement & Form Compatibility (Constitutional Boundary 2 & 4)

| Component Name | Category | UI Kit Dependencies | Form Compatibility |
| :--- | :--- | :--- | :--- |
| `AppDivider` | **Atom** | `AppDesignTheme` | N/A (Pure Visual) |
| `AppIpv6TextField` | **Molecule** | `AppTextField` | **Wraps `FormField<String>`** (Ensures `validator`, `onSaved` support). |
| `AppMacAddressTextField` | **Molecule** | `AppTextField` | **Wraps `FormField<String>`** (Ensures `validator`, `onSaved` support). |
| `AppIpv4TextField` | **Composite Molecule** | 4x `AppTextField` | **Wraps `FormField<String>`** (Handles complex composite validation and output). |

### B. Theming Strategy (Constitutional Boundary 3)

The existing `AppDesignTheme` will be extended to centralize style definitions, meeting requirements FR-007, FR-010, and Q5.

* **New Theme Extension Properties**:
    * `macAddressSeparator`: Defines the character (`:` or `-`) for `AppMacAddressTextField` (Q5).
    * `ipv4SeparatorStyle`: Defines the visual look (shape, contrast) of the dot/separator between IPv4 segments (FR-007).
    * `dividerStyle`: Extended to define theme-specific effects (Glow for Glass, High-Contrast geometry for Brutal) (FR-010).

## 2. 🧩 Implementation Plan: Network Fields

### A. `AppIpv4TextField` (Composite Form Field)

The component combines four `AppTextField` instances into a single `FormField` wrapper.

| ID | Task | Detail & Behavior Implementation |
| :--- | :--- | :--- |
| **I4.1** | **Base Structure** | `AppIpv4TextField` must be a **`FormField<String>`** wrapper, managing four internal `TextEditingController`s and `FocusNode`s. |
| **I4.2** | **Segment Layout** | Use a `Row` to hold four **`AppTextField`** instances, separated by a custom theme-aware separator widget. |
| **I4.3** | **Validation & Output** | The `FormField`'s `validator` checks internal segment validity (0-255) AND completeness. `onSaved` must concatenate the four values using dots (`.`) to form the full IP string. |
| **I4.4** | **Auto-Advance Focus (FR-003)** | Use `FocusNode` listeners on each segment. When a segment reaches 3 digits or a valid octet is confirmed, call `focusNode.nextFocus()`. |
| **I4.5** | **Smart Paste (Q1: Option A)** | Override paste logic. If pasted content is a valid IPv4 string, parse it (`.split('.')`) and populate all four internal controllers. Fallback to single-segment paste otherwise. |
| **I4.6** | **Theme Separator (FR-007)** | The separator widget must read `ipv4SeparatorStyle` from the theme to render the correct **Glass/Brutal** styling. |

### B. `AppMacAddressTextField` (Formatted Form Field)

The component is an `AppTextField` wrapped by `FormField` with custom formatting logic.

| ID | Task | Detail & Behavior Implementation |
| :--- | :--- | :--- |
| **MA.1** | **Base Structure** | `AppMacAddressTextField` must be a **`FormField<String>`** wrapper containing an `AppTextField`. |
| **MA.2** | **Input Formatter (FR-005, Q2)** | Create a `TextInputFormatter` to handle: 1. Hexadecimal characters. 2. **Auto-Skip** user-typed separators ($[:]$, $[-]$) without displaying them, advancing the cursor past the *auto-inserted* theme separator. |
| **MA.3** | **Theme Dependency (Q5: Option A)** | The formatter reads the default separator type (`macAddressSeparator`) from the theme extension for display output. |
| **MA.4** | **Validation** | Validator ensures 12 hex characters are present. |

### C. `AppIpv6TextField` (Compact Form Field)

The component is an `AppTextField` wrapped by `FormField` with custom display logic.

| ID | Task | Detail & Behavior Implementation |
| :--- | :--- | :--- |
| **I6.1** | **Base Structure** | `AppIpv6TextField` must be a **`FormField<String>`** wrapper containing an `AppTextField`. |
| **I6.2** | **Validation** | Validator accepts both full and compressed forms, enforcing IPv6 structure rules. |
| **I6.3** | **Display Compaction (Q4: Option A)** | Implement a dedicated service/utility function that converts the canonical internal value (8 segments) into the shortest valid compressed form (`::`) for presentation in the `AppTextField`. |

## 3. 📐 Implementation Plan: `AppDivider` (Atom)

| ID | Task | Detail & Behavior Implementation |
| :--- | :--- | :--- |
| **D.1** | **Base Structure (FR-009)** | Use a `SizedBox` or `Container` to manage size and orientation (`horizontal`/`vertical`). |
| **D.2** | **Theme Adaptivity (FR-010)** | Use a **`CustomPainter`** to draw the line: 1. **Glass**: Use shading/blur effects for a glow. 2. **Brutal**: Draw a high-contrast, possibly geometric line. The `CustomPainter` reads parameters from the `DividerStyle` extension. |
| **D.3** | **Simplicity (Q3: Option B)** | Strictly disallow any child widget or text label. |

## 4. 🧪 Testing Strategy (Mandatory)

### A. Form Integration Testing (Critical)

* **Form Validation Test**: Create a `Form` containing all three network fields. Call `Form.validate()` with incomplete/invalid data and assert that the error messages are displayed.
* **Form Saving Test**: Fill all fields correctly. Call `Form.save()` and assert that the output `onSaved` callbacks receive the correct, consolidated string format (e.g., `192.168.1.1` for IPv4, compacted string for IPv6).

### B. Golden Testing (SC-001, SC-005, SC-006, SC-007)

* **Theme Matrix**: All 4 components must be tested against **Glass** and **Brutal** themes to validate visual adaptation requirements (FR-007, FR-010).
* **Snapshots**: Capture snapshots of `AppDivider` in both horizontal and vertical orientations.

### C. Unit & Widget Testing (SC-002, SC-003, SC-004)

* **IPv4 (Behavior)**: Verify `auto-advance` (SC-002). Simulate **Smart Paste** (Q1) of a valid full IP and verify all four controllers update.
* **MAC Address (Formatting)**: Simulate typing `"a1:b2c3-d4e5f6"` and assert that **Auto-Skip** (Q2) functions correctly and the final displayed output matches the **Theme-Defined Separator** (SC-004).
* **IPv6 (Formatting)**: Assert that a full-zero address (e.g., all zeros) is displayed using **Auto-Compact** (`::`).

## 5. 🔍 Constitution Checks

> This section validates the plan against the core principles of the [Project Constitution (v1.0.0)](../.specify/memory/constitution.md).

### 5.1 Boundary Compliance

* **[2.1 Physical Isolation]**: All new components are strictly within `lib/src/` (atoms/molecules) of the `ui_kit` package. No business logic dependencies. **(PASS)**
* **[2.2 Dependency Hygiene]**: Relies only on `flutter`, `theme_tailor`. No `bloc`, `provider` or HTTP clients. **(PASS)**
* **[2.3 Directory Structure]**:
  * `AppDivider` → `src/atoms/layout/` or `src/atoms/display/`
  * Network Fields → `src/molecules/inputs/`
  * **(PASS)**

### 5.2 Core Principles Compliance

* **[3.1 Inversion of Control]**: Components like `AppDivider` and `AppIpv4TextField` (separators) ask the Theme (`DividerStyle`, `ipv4SeparatorStyle`) "how to look". They do not check `if (theme is Brutal)`. **(PASS)**
* **[3.2 Data-Driven Strategy]**: Visual differences (Glass vs Brutal) are driven by properties in the Theme Extension (e.g., `glowStrength`, `linePattern`), not logic branches in the widget. **(PASS)**

### 5.3 Component Design Compliance

* **[5.1 The Primitive]**: `AppIpv4TextField` segments and `AppMacAddressTextField` use `AppTextField`, which internally uses `AppSurface`. `AppDivider` will likely just be a painter, but if it needs a container, it should respect surface rules or be a pure visual element. **(PASS)**
* **[5.3 Composition]**: `AppIpv4TextField` composes 4x `AppTextField`. `AppMacAddressTextField` composes `AppTextField`. **(PASS)**

### 5.4 Asset & Animation Compliance

* **[7. Assets]**: No new assets are explicitly required, but if custom icons are needed for separators, `flutter_gen` must be used. **(PASS)**
* **[8. Animation]**: Focus transitions are standard focus node operations. No complex animations planned. **(PASS)**

### 5.5 Quality Assurance Compliance

* **[12.1 Widgetbook]**: Plan includes Golden Tests. UseCases must also be added for Widgetbook. **(PASS)**
* **[12.2 Golden Tests]**: Plan explicitly mandates Matrix Testing for Glass/Brutal. **(PASS)**

## 6. 📝 Technical Context

### Unknowns & Clarifications

* **NEEDS CLARIFICATION**: Does `AppIpv4TextField` need to support pasting *partial* IPs (e.g., "192.168.")?
  * *Assumption for Plan*: Smart Paste will attempt to fill as many segments as possible from left to right.
* **NEEDS CLARIFICATION**: Should `AppIpv6TextField` allow users to *disable* auto-compaction (force expand)?
  * *Clarification from Q4*: Auto-compact is the default behavior. No toggle requested.
* **NEEDS CLARIFICATION**: How does `AppDivider` handle "indentation" in the theme?
  * *Assumption*: `DividerStyle` will have `indent` and `endIndent` properties (double) relative to the parent width.

### Dependencies

* `flutter` (SDK)
* `theme_tailor` (Dev)
* `widgetbook` (Dev)
* `golden_toolkit` (Dev)

### Integrations

* **InputFormatters**: Custom logic for MAC and IPv6.
* **Form System**: Standard Flutter `Form` integration.