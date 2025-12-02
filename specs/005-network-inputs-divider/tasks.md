---
description: "Task list for Interactive & Form Expansion (Network & Divider)"
---

# Tasks: Interactive & Form Expansion (Network & Divider)

**Input**: Design documents from `/specs/005-network-inputs-divider/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Tests are OPTIONAL, but included here as requested by the specification (Golden Tests, Unit Tests).

**Organization**: Tasks are grouped by user story to enable independent implementation and testing.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2)
- Include exact file paths in descriptions

## Path Conventions

The UI Kit project must adhere to the directory structure defined in the Project Constitution (v1.0.0, Section 2.3).
Tasks will use paths relative to the `src/` directory within the UI Kit package:

- `src/foundation/`
- `src/atoms/`
- `src/molecules/`
- `src/organisms/`
- `src/layout/`

## Constitutional Alignment

All tasks for feature implementation MUST align with the principles outlined in the Project Constitution (v1.0.0). Pay particular attention to:

- **Architectural Boundaries**: Especially Dependency Hygiene (Section 2.2) and Directory Structure (Section 2.3).
- **Theming & Styling**: Ensure components follow Token-First Design (Section 3.1) and use Theme Tailor (Section 3.3).
- **Component Design**: Enforce "Dumb Components" (Section 4.1) and "Composition over Inheritance" (Section 4.2).
- **Assets Management**: Adhere to Access Standards (Section 5.1) and Formatting Standards (Section 5.2).
- **Quality Assurance & Testing**: Mandatory Widgetbook (Section 12.1) and Golden Test (Section 12.2) requirements.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create directory `lib/src/molecules/inputs/network` for network fields (Constitution 2.3 Directory Structure)
- [x] T002 Create directory `lib/src/atoms/layout` for AppDivider (Constitution 2.3 Directory Structure)
- [x] T003 Create directory `test/molecules/inputs/network` for network field tests
- [x] T004 Create directory `test/atoms/layout` for AppDivider tests

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T005 Define `DividerStyle` theme extension in `lib/src/foundation/theme/design_system/specs/divider_style.dart` (Constitution 3.3 Theme Tailor)
- [x] T006 Define `NetworkInputStyle` theme extension in `lib/src/foundation/theme/design_system/specs/network_input_style.dart` (Constitution 3.3 Theme Tailor)
- [x] T007 [P] Add `DividerStyle` to `AppDesignTheme` in `lib/src/foundation/theme/design_system/app_design_theme.dart`
- [x] T008 [P] Add `NetworkInputStyle` to `AppDesignTheme` in `lib/src/foundation/theme/design_system/app_design_theme.dart`
- [x] T009 Configure Glass and Brutal theme implementations for `DividerStyle` in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart` and `brutal_design_theme.dart`
- [x] T010 Configure Glass and Brutal theme implementations for `NetworkInputStyle` in `lib/src/foundation/theme/design_system/styles/glass_design_theme.dart` and `brutal_design_theme.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Specialized Network Inputs (Priority: P1) 🎯 MVP

**Goal**: Developers need specialized text fields for common network addresses (IPv4, IPv6, MAC) that include built-in, strict validation and intelligent formatting.

**Independent Test**: 
1. In `AppIpv4TextField`, type "192" -> cursor jumps to next segment.
2. Type "256" -> error or prevented.
3. Paste "10.0.0.1" -> fills all segments.
4. Type "a1b2c3..." into MAC field -> formats to "A1:B2:C3...".

### Tests for User Story 1 (Requested in Plan/Spec) ⚠️

> **Important Note**: When executing Golden Tests, strictly adhere to the **Safe Mode Protocol** in Constitution Section 12.2 to ensure test stability and consistency.

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T011 [P] [US1] Implement Golden Tests for `AppIpv4TextField` in `test/molecules/inputs/network/app_ipv4_text_field_golden_test.dart` (Constitution 12.2 Golden Tests)
- [x] T012 [P] [US1] Implement Golden Tests for `AppMacAddressTextField` in `test/molecules/inputs/network/app_mac_address_text_field_golden_test.dart` (Constitution 12.2 Golden Tests)
- [x] T013 [P] [US1] Implement Golden Tests for `AppIpv6TextField` in `test/molecules/inputs/network/app_ipv6_text_field_golden_test.dart` (Constitution 12.2 Golden Tests)
- [x] T014 [P] [US1] Implement Unit Tests for `AppIpv4TextField` focus logic and validation in `test/molecules/inputs/network/app_ipv4_text_field_test.dart`
- [x] T015 [P] [US1] Implement Unit Tests for AppMacAddressTextField formatting logic, including SC-010 (defaults to colon-separated format), in `test/molecules/inputs/network/app_mac_address_text_field_test.dart`
- [x] T016 [P] [US1] Implement Unit Tests for AppIpv6TextField compaction logic, including SC-009 (correct compact form display), in `test/molecules/inputs/network/app_ipv6_text_field_test.dart`

### Implementation for User Story 1

- [x] T017 [P] [US1] Create `AppIpv4TextField` widget structure in `lib/src/molecules/inputs/network/app_ipv4_text_field.dart`
- [x] T018 [US1] Implement `AppIpv4TextField` internal state (4 controllers, focus nodes) and `FormField` wrapper
- [x] T019 [US1] Implement `AppIpv4TextField` auto-advance focus logic and Smart Paste (I4.4, I4.5)
- [x] T020 [US1] Implement `AppIpv4TextField` validation logic (0-255) and `onSaved` concatenation
- [x] T021 [P] [US1] Create `AppMacAddressTextField` widget structure in `lib/src/molecules/inputs/network/app_mac_address_text_field.dart`
- [x] T022 [US1] Implement `AppMacAddressTextField` InputFormatter for hex validation and auto-skipping separators (MA.2)
- [x] T023 [US1] Implement `AppMacAddressTextField` theme-aware formatting (MA.3)
- [x] T024 [P] [US1] Create `AppIpv6TextField` widget structure in `lib/src/molecules/inputs/network/app_ipv6_text_field.dart`
- [x] T025 [US1] Implement `AppIpv6TextField` validation and display compaction logic (I6.2, I6.3)
- [x] T026 [P] [US1] Implement Widgetbook UseCases for all network fields in `widgetbook/lib/stories/molecules/inputs/network_inputs_stories.dart` (Constitution 12.1 Widgetbook)

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Content Separation (AppDivider) (Priority: P4)

**Goal**: Developers need a simple, consistent component to visually group and separate content, following the current theme's line thickness and color palette.

**Independent Test**: Place `AppDivider` in Column/Row, verify theme styling (Glass glow vs Brutal solid) and orientation.

### Tests for User Story 2 (Requested in Plan/Spec) ⚠️

> **Important Note**: When executing Golden Tests, strictly adhere to the **Safe Mode Protocol** in Constitution Section 12.2 to ensure test stability and consistency.

- [x] T027 [P] [US2] Implement Golden Tests for `AppDivider` (Horizontal & Vertical) in `test/atoms/layout/app_divider_golden_test.dart` (Constitution 12.2 Golden Tests)

### Implementation for User Story 2

- [x] T028 [P] [US2] Create `AppDivider` widget structure in `lib/src/atoms/layout/app_divider.dart`
- [x] T029 [US2] Implement `AppDivider` custom painter for Glass (glow) and Brutal (solid/jagged) styles (D.2)
- [x] T030 [US2] Implement `AppDivider` sizing and orientation logic (D.1)
- [x] T031 [P] [US2] Implement Widgetbook UseCases for `AppDivider` in `widgetbook/lib/stories/atoms/layout/app_divider_stories.dart` (Constitution 12.1 Widgetbook)

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T032 [P] Run `flutter analyze` and fix any linting issues in new files
- [x] T033 Verify all new components appear correctly in Widgetbook
- [x] T034 Ensure all Golden Tests pass for both Glass and Brutal themes
- [x] T035 Review code against "Dumb Component" and "Composition" principles