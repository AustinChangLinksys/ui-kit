---
description: Review code against UI Kit Constitution (Appendix C checklist) for compliance verification.
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding. If a file path is provided, review that specific file. If empty, ask the user which file or component to review.

## Goal

Perform a comprehensive code review against the UI Kit Constitution (`.specify/memory/constitution.md` Appendix C) to identify violations and provide actionable remediation.

## Operating Constraints

**READ-ONLY ANALYSIS**: Do not modify any files. Output a structured compliance report with specific line references and fix suggestions.

**Constitution Authority**: The constitution is the single source of truth. All findings must reference specific constitution sections.

**NO GUESSING POLICY**:
- **NEVER** assume or infer code behavior without reading the actual file
- **NEVER** report violations based on partial information or assumptions
- **ALWAYS** provide exact line numbers and code snippets as evidence
- If you cannot find the file or the code is unclear, **STOP and ask the user**

**AMBIGUITY RESOLUTION**:
When encountering any of these situations, **STOP immediately and ask the user**:
1. File path is missing, incomplete, or ambiguous
2. Multiple files match the pattern - ask which one to review
3. Code pattern could be interpreted multiple ways
4. Cannot determine if a pattern is intentional or a violation
5. Constitution rule is unclear for the specific case
6. Need additional context to make a judgment

**EVIDENCE-BASED REPORTING**:
Every finding MUST include:
- Exact file path
- Exact line number(s)
- Actual code snippet (copy-paste, not paraphrased)
- Specific Constitution section reference
- Clear explanation of why it's a violation

If you cannot provide ALL of the above for a finding, do NOT report it.

## Execution Steps

### 1. Load Context

1. **Validate Input First**:
   - If `$ARGUMENTS` is empty → **STOP** and ask: "Which file or component would you like me to review?"
   - If path looks incomplete (e.g., just a component name) → **STOP** and ask for full path
   - If path contains wildcards or patterns → **STOP** and ask which specific file(s) to review

2. **Verify File Exists**:
   - Attempt to read the specified file
   - If file not found → **STOP** and inform user, ask for correct path
   - If multiple matches → **STOP** and list them, ask user to choose

3. Read the Constitution from `.specify/memory/constitution.md`
4. Extract Appendix C checklist items
5. Load the target file(s) only after validation passes

### 2. Compliance Checks

For each file, perform the following checks:

#### A. Architecture (Section 6)

| Check | Constitution Ref | Pattern to Find | Violation Pattern |
|-------|------------------|-----------------|-------------------|
| AppSurface Usage | 6.1 | `AppSurface(` | `Container(` with `BoxDecoration` |
| Dumb Components | 6.2 | Callbacks only | Business state storage |
| Composition | 6.3 | Slots pattern | Deep inheritance |

#### B. Color System (Section 4.1-4.2)

| Check | Constitution Ref | Violation Pattern |
|-------|------------------|-------------------|
| No Hardcoded Colors | 4.1 | `Colors.red`, `Color(0x...)` in widgets |
| Semantic Colors | 4.1 | Direct `ColorScheme` access in custom components |
| Layer Separation | 4.2 | Mixing Structure/Decoration/Signal colors |

#### C. Theming (Section 4.5-4.8)

| Check | Constitution Ref | Pattern to Find |
|-------|------------------|-----------------|
| @TailorMixin | 4.5 | Style classes with `@TailorMixin()` |
| Shared Specs | 4.6 | `AnimationSpec`, `StateColorSpec`, `OverlaySpec` composition |
| StateColorSpec.resolve() | 4.6.4 | `.resolve(isActive:` pattern |
| AnimationSpec usage | 4.6 | `style.animation.duration` not hardcoded `Duration` |

#### D. Typography (Section 4.9)

| Check | Constitution Ref | Violation Pattern |
|-------|------------------|-------------------|
| appTextTheme usage | 4.9.1 | `TextStyle(fontSize:` in theme files |
| Token usage | 4.9.2 | Hardcoded font sizes/weights |

#### E. Motion (Section 5.1)

| Check | Constitution Ref | Violation Pattern |
|-------|------------------|-------------------|
| No hardcoded duration | 5.1 | `Duration(milliseconds: 300)` in widgets |
| Motion tokens | 5.1 | Missing `theme.motion` or `style.animation` |

#### F. Zero Internal Defaults (Section 3.3)

| Check | Constitution Ref | Violation Pattern |
|-------|------------------|-------------------|
| No fallback values | 3.3 | `?? defaultValue`, `static const defaultStyle` |
| Fail Fast | 3.3 | Missing `assert(theme != null)` |

#### G. Testing (Section 13, Appendix B)

| Check | Constitution Ref | Pattern to Find |
|-------|------------------|-----------------|
| Safe Mode | B.2 | `buildThemeMatrix`, `SizedBox` constraints |
| Font Loading | B.1 | `loadAppFonts()` in `setUpAll` |
| Animation Freeze | B.2.3 | `TickerMode(enabled: false)` |

### 3. Generate Report

Output a Markdown report:

```markdown
# UI Kit Constitution Compliance Report

**File**: `{file_path}`
**Date**: {date}
**Constitution Version**: 3.1.0

## Summary

| Category | Pass | Fail | N/A |
|----------|------|------|-----|
| Architecture | X | X | X |
| Color System | X | X | X |
| Theming | X | X | X |
| Typography | X | X | X |
| Motion | X | X | X |
| Zero Defaults | X | X | X |
| Testing | X | X | X |

## Findings

### CRITICAL (Must Fix)

| ID | Line | Check | Issue | Fix |
|----|------|-------|-------|-----|
| C1 | L42 | 4.1 | Hardcoded `Colors.red` | Use `scheme.error` |

**C1 Evidence:**
```dart
// Line 42 (actual code from file)
color: Colors.red,  // ← VIOLATION: Hardcoded color
```

### HIGH (Should Fix)

...

### MEDIUM (Recommended)

...

## Compliance Score

**X / Y checks passed (Z%)**

## Recommended Actions

1. ...
2. ...
```

### 4. Handle Uncertain Findings

If during analysis you encounter patterns that are ambiguous:
- Do NOT include them in the report
- Instead, list them in a separate **"Needs Clarification"** section
- Ask the user for guidance before categorizing as pass/fail

Example:
```markdown
## Needs Clarification

| Line | Pattern | Question |
|------|---------|----------|
| L55 | `Container(decoration: ...)` | Is this intentionally not using AppSurface? (e.g., for layout-only purpose) |
| L120 | `Duration(milliseconds: 200)` | Is this animation duration or timeout? |
```

### 5. Offer Assistance

After the report, ask:
- "Would you like me to fix the CRITICAL issues?"
- "Would you like a detailed explanation of any finding?"
- If there are items in "Needs Clarification": "Could you clarify the items above so I can complete the review?"

## Example Usage

```
/uikit.review lib/src/molecules/tabs/app_tabs.dart
/uikit.review lib/src/foundation/theme/design_system/specs/
```

## Context

$ARGUMENTS
