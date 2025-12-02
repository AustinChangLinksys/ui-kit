# 📐 Data Model & Schema

**Feature**: Interactive & Form Expansion (Phase 3 - Network & Divider Focus)
**Status**: Draft

## 1. 🧩 Entities

### `DividerStyle` (Theme Extension)
Defines the visual appearance of dividers across different themes.

| Field | Type | Description | Theme Mapping (Example) |
| :--- | :--- | :--- | :--- |
| `color` | `Color` | The color of the line. | Glass: `white.withOpacity(0.2)` <br> Brutal: `black` |
| `thickness` | `double` | The thickness of the line. | Glass: `1.0` <br> Brutal: `3.0` |
| `indent` | `double` | Start indentation. | Glass: `0.0` <br> Brutal: `0.0` |
| `endIndent` | `double` | End indentation. | Glass: `0.0` <br> Brutal: `0.0` |
| `glowStrength` | `double` | Intensity of the glow effect (for Glass). | Glass: `4.0` <br> Brutal: `0.0` |
| `pattern` | `DividerPattern` | Line pattern (Solid, Dashed, Jagged). | Glass: `Solid` <br> Brutal: `Solid` |

### `NetworkInputStyle` (Theme Extension)
Defines the styling for specialized network inputs.

| Field | Type | Description | Theme Mapping (Example) |
| :--- | :--- | :--- | :--- |
| `ipv4SeparatorStyle` | `SeparatorStyle` | Visual style of the dot separator. | Glass: `GlowingDot` <br> Brutal: `SquareBlock` |
| `macAddressSeparator` | `String` | Separator char for MAC addresses. | Glass: `:` <br> Brutal: `-` |

## 2. 🚦 Validation Rules

### IPv4 Validation (Per Segment)
* **Type**: Integer
* **Range**: 0 - 255
* **Regex**: `^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$`

### IPv6 Validation
* **Structure**: 8 groups of 4 hex digits, separated by `:`.
* **Compression**: `::` allowed once.
* **Regex**: Standard IPv6 regex (complex, will use standard library or robust regex).

### MAC Address Validation
* **Structure**: 6 groups of 2 hex digits.
* **Characters**: `[0-9A-Fa-f]`
* **Separators**: `:` or `-` (ignored during validation, enforced during formatting).

## 3. 💾 Component State (Transient)

### `AppIpv4TextField`
* **Internal State**:
    * `List<TextEditingController>`: 4 controllers, one for each octet.
    * `List<FocusNode>`: 4 focus nodes.
* **Output**: String (e.g., "192.168.1.1") via `onSaved`.

### `AppMacAddressTextField`
* **Internal State**:
    * `TextEditingController`: Single controller.
* **Output**: String (formatted per theme, e.g., "AA:BB:...") via `onSaved`.
