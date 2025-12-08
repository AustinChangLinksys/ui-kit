# Technical Implementation Plan: Advanced Inputs

**Branch**: `020-advanced-inputs`
**Goal**: Implement `AppRangeInput`, `AppPinInput`, and `AppPasswordInput` with strict adherence to the multi-paradigm design system.
**Dependencies**: `AppTextField`, `AppIcon`, `AppColorScheme`, `AppMotion`, `AppFeedback`.
**Tools**: `theme_tailor`, `build_runner`, `flutter_test`, `widgetbook`.

## 1\. Technical Context

### Requirements Analysis

The feature requires three distinct input types that go beyond standard text entry. Key technical challenges include:

  * **AppPinInput**: Managing focus and clipboard paste for segmented inputs across platforms (Android/iOS/Web).
  * **AppPasswordInput**: Real-time validation rule evaluation without performance lag.
  * **Style Adaptation**: Drastic rendering differences between Pixel (Blocky/ASCII) and Glass (Glow/Blur).

### Technology Choices

  * **Pin Input Strategy**: Use a **"Ghost Input"** approach (a transparent, full-width `TextField` layered on top of the visual segments). This ensures native keyboard behavior, autofill support, and reliable pasting without complex focus management.
  * **Validation Logic**: Pure Dart functions injected via `AppPasswordRule`.
  * **Styling**: Three new `ThemeExtension` classes to encapsulate style-specific properties (shapes, separators, icons).

## 2\. Constitution Compliance Check

### Compliance Analysis

  * **[3.1 Inversion of Control]**: Components ask `PinInputStyle` for their look (e.g., `cellShape`), never checking `if (theme == Pixel)`.
  * **[3.2 Data-Driven Strategy]**: Password rules are passed as data lists, rendered via a loop.
  * **[4.1 Color System]**: Uses `AppColorScheme.signalStrong` for active states and `styleBackground` for containers.
  * **[5.1 Motion System]**: Pin input cursor blinking and state changes use `AppTheme.motion`. Pixel style forces `0ms`.
  * **[5.2 Feedback System]**: `AppFeedback.onSuccess()` triggers when Pin input is completed or Password rules pass.

### Gate Evaluation

  * **Gate Passed:** The architecture aligns with v3.0 standards.

## 3\. Phase 1: Design & Contracts

### 3.1 Theme Contracts (Extensions)

We need to define the "Vocabulary" for these new components.

**A. `RangeInputStyle`**

```dart
@TailorMixin()
class RangeInputStyle extends ThemeExtension<RangeInputStyle> with _$RangeInputStyleTailorMixin {
  final bool mergeContainers; // Flat (Unified Box) vs Glass (Separated)
  final Widget? customSeparator; // Pixel (ASCII Icon) vs Flat (Text)
  final Color activeBorderColor; // signalStrong vs primary
  final double spacing; // Gap between inputs
  // ...
}
```

**B. `PinInputStyle`**

```dart
@TailorMixin()
class PinInputStyle extends ThemeExtension<PinInputStyle> with _$PinInputStyleTailorMixin {
  final PinCellShape cellShape; // Box, Underline, Circle, Recess
  final bool fillOnInput;       // Pixel (Invert colors)
  final bool glowOnActive;      // Glass
  final TextStyle textStyle;    // Mono for Pixel
  final double cellSpacing;
  final double cellSize;
  // ...
}
```

**C. `PasswordInputStyle`** (Focuses on the Validator UI)

```dart
@TailorMixin()
class PasswordInputStyle extends ThemeExtension<PasswordInputStyle> with _$PasswordInputStyleTailorMixin {
  final IconData validIcon;     // Check / [x]
  final IconData pendingIcon;   // Circle / [ ]
  final TextStyle ruleTextStyle;
  final bool showRuleListBackground; // Glass (Pane)
  final Color validColor;       // signalStrong
  final Color pendingColor;
  // ...
}
```

### 3.2 API Contracts

**AppRangeInput**

```dart
class AppRangeInput extends StatelessWidget {
  final TextEditingController? startController;
  final TextEditingController? endController;
  final String? startLabel;
  final String? endLabel;
  final String? errorText; 
  final String? Function(String start, String end)? validator;
  
  const AppRangeInput({ ... });
}
```

**AppPinInput**

```dart
class AppPinInput extends StatelessWidget {
  final int length; 
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool obscureText; 
  final bool autoFocus;
  final String? errorText;

  const AppPinInput({ ... });
}
```

**AppPasswordInput**

```dart
class AppPasswordInput extends StatefulWidget {
  final TextEditingController? controller;
  final List<AppPasswordRule>? rules;
  final bool initiallyObscured;
  // ...
}
```

## 4\. Implementation Steps

### Step 1: Foundation Layer

1.  **Create Extensions**: Implement `range_input_style.dart`, `pin_input_style.dart`, `password_input_style.dart`.
2.  **Update Factories**: Inject style values into `NeumorphicDesignTheme`, `PixelDesignTheme`, etc.
      * *Pixel*: `PinInputStyle(shape: Box, fillOnInput: true)`.
      * *Glass*: `PinInputStyle(shape: Circle, glowOnActive: true)`.
3.  **Generate**: Run `build_runner`.

### Step 2: AppPinInput (The Ghost Input)

1.  **Layout**: `Stack`
      * **Layer 1 (Bottom)**: `Row` of `_PinCell` widgets. Render based on `PinInputStyle`.
      * **Layer 2 (Top)**: `TextField` with `opacity: 0`, `enableInteractiveSelection: false`.
2.  **Logic**:
      * Listen to `TextField`. Update state.
      * Map characters to Cells.
      * If `length == max`, trigger `onCompleted` + `AppFeedback.onSuccess()`.
3.  **Pixel Special**: Ensure `AppTheme.motion.duration` is used (0ms) so the "filled block" appears instantly.

### Step 3: AppRangeInput

1.  **Layout**: `Row` [ `AppTextField` (Flexible) + `Separator` + `AppTextField` (Flexible) ].
2.  **Style Logic**:
      * If `style.mergeContainers` is true (Flat), wrap the Row in a single `AppSurface`.
      * If false (Glass/Pixel), each `AppTextField` has its own surface.
3.  **Validation**: Listen to both controllers. If validation fails, apply `error` state to **both** fields.

### Step 4: AppPasswordInput

1.  **Composition**: `Column` [ `AppTextField` + `Gap` + `_PasswordRulesList` ].
2.  **Toggle**: Suffix icon toggles `obscureText`. Icon source comes from `AppIconStyle` (Bitmap vs Vector).
3.  **Rules Renderer**:
      * Iterate `widget.rules`.
      * Check `rule.validate(text)`.
      * Render Icon + Text using `PasswordInputStyle`.
      * **Pixel Mode**: Use `[ ]` / `[x]` ASCII-style icons defined in the Theme.

## 5\. Verification Strategy

### Layer 1: Golden Matrix (`test/molecules/advanced_inputs_golden_test.dart`)

  * **Pin Input**:
      * **Empty**: Verify placeholders (Underline vs Box).
      * **Filled (Pixel)**: Verify solid inverted blocks.
      * **Filled (Glass)**: Verify glowing text.
  * **Range Input**:
      * **Neumorphic**: Verify dual recessed slots.
      * **Flat**: Verify single unified border.
  * **Password Input**:
      * **Validation Success**: Verify green text/icon using `signalStrong`.

### Layer 2: Interaction Testing (`test/molecules/pin_input_test.dart`)

  * **Paste**: Simulate pasting "123456". Verify `onCompleted` is called with "123456".
  * **Focus**: Tap on the widget -\> Verify hidden text field has focus.

### Layer 3: Widgetbook

  * **Stories**: `Pin Input`, `Range Input`, `Password Input`.
  * **Knobs**: `Error Text`, `Obscure Text`, `Theme Style`.