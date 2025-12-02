# 🔬 Research: Interactive & Form Expansion (Network & Divider)

**Feature**: `005-network-inputs-divider`
**Status**: Completed
**Date**: 2025-12-02

## 1. ❓ Unknowns & Clarifications

### 1.1 Partial IP Paste Behavior
* **Context**: Does `AppIpv4TextField` need to support pasting *partial* IPs (e.g., "192.168.")?
* **Decision**: **Best Effort Fill**.
* **Rationale**: Users often copy-paste subnets or partial addresses during configuration. Supporting this reduces friction. The logic will split the string by `.` and populate the segments sequentially from the first (leftmost) empty segment or overwrite from the start if focused on the first segment.
* **Alternatives**:
    * *Strict Full IP Only*: Rejects anything that isn't a complete 4-octet string. Rejected as too restrictive for developer tools.

### 1.2 IPv6 Auto-Compaction Toggle
* **Context**: Should `AppIpv6TextField` allow users to *disable* auto-compaction (force expand)?
* **Decision**: **No Toggle (Always Compact)**.
* **Rationale**: Consistent with clarification Q4 (Option A). Compaction is the standard representation. Adding a toggle adds UI complexity (button/gesture) not requested in the spec.
* **Alternatives**:
    * *Long-press to expand*: Could be a future enhancement if users request raw view.

### 1.3 Divider Indentation Handling
* **Context**: How does `AppDivider` handle "indentation" in the theme?
* **Decision**: **Theme-Defined Indent Factors**.
* **Rationale**: To adhere to "Token-First Design", the `DividerStyle` should define `indent` and `endIndent` as *factors* or *fixed values* (doubles). `AppDivider` can optionally accept overrides, but defaults must come from the theme.
* **Implementation**: `DividerStyle` will have `double? indent` and `double? endIndent`. If null, defaults to 0.

## 2. 📚 Best Practices & Patterns

### 2.1 IPv4 Segmented Input (Composite Field)
* **Focus Management**: Crucial to use `RawKeyboardListener` or specialized `FocusNode` listeners to detect "Backspace" on an empty segment to move focus *backward*. Standard `onChanged` doesn't catch backspace on empty fields.
* **Selection**: Select-all (Cmd+A) should ideally select the content of the *current segment* only, to simplify implementation complexity vs selecting all 4 segments.

### 2.2 MAC Address Formatting
* **Masking vs. Formatting**: "Formatting" (modifying text as you type) is preferred over "Masking" (fixed template `__ : __`) for variable-width fonts or when the separator might change.
* **Cursor Preservation**: When modifying the text (inserting a colon), the `TextSelection` index must be carefully adjusted to prevent the cursor from jumping to the end.

### 2.3 Divider Rendering
* **CustomPainter vs Container**: `CustomPainter` is superior for "Brutal" themes requiring jagged lines, dashed patterns, or non-standard drawing that `Container` borders cannot easily achieve. It also performs well.

## 3. 🔍 Technology & Libraries

* **`TextInputFormatter`**: Standard Flutter class. Essential for MAC/IPv6 validation and formatting.
* **`LogicalKeyboardKey`**: Required for detecting Backspace in `AppIpv4TextField` for reverse navigation.
* **`ThemeExtension<T>`**: Required mechanism for `DividerStyle` and `NetworkInputStyle`.
