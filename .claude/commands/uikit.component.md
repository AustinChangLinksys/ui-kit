---
description: Generate a new UI Kit component following Constitution patterns and Atomic Design principles.
---

## User Input

```text
$ARGUMENTS
```

You **MUST** parse the user input for:
- **Component name** (e.g., `AppTimePicker`, `AppRating`)
- **Atomic level** (atom, molecule, organism) - infer from complexity if not specified

If missing required info, ask the user.

## Goal

Generate a complete, Constitution-compliant component scaffold including:
1. Widget implementation
2. Style specification (if needed)
3. Golden test file
4. Widgetbook use case

## Operating Constraints

**Constitution Compliance**: All generated code MUST follow `.specify/memory/constitution.md` principles.

**Atomic Design**: Place files in correct directories based on component complexity.

**NO GUESSING POLICY**:
- **NEVER** assume component requirements without explicit user input
- **NEVER** generate code with placeholder values or assumed properties
- **ALWAYS** ask the user if any required information is missing or unclear

**AMBIGUITY RESOLUTION**:
When encountering any of these situations, **STOP immediately and ask the user**:
1. Component name is missing or unclear
2. Atomic level (atom/molecule/organism) cannot be confidently determined
3. Required properties are not specified
4. Component purpose or behavior is ambiguous
5. Similar component already exists - ask if updating or creating new
6. Style spec requirements are unclear

## Directory Structure

```
lib/src/
├── atoms/{component}/          # Primitives (AppGap, AppIcon)
├── molecules/{component}/      # Composed (AppButton, AppTabs)
└── organisms/{component}/      # Complex (AppDataTable, AppDialog)

test/
├── atoms/{component}/
├── molecules/{component}/
└── organisms/{component}/

widgetbook/lib/stories/
├── atoms/
├── molecules/
└── organisms/
```

## Execution Steps

### 1. Determine Component Structure

Based on component name and description:

| Level | Characteristics | Style Needed | Example |
|-------|-----------------|--------------|---------|
| Atom | Single purpose, no children | Rarely | AppGap, AppDivider |
| Molecule | Composed of atoms, has slots | Usually | AppButton, AppTabs |
| Organism | Complex, multiple molecules | Always | AppDialog, AppDataTable |

### 2. Generate Widget File

Create `lib/src/{level}/{component_snake}/app_{component_snake}.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// {Component description}
///
/// Constitution compliance:
/// - Uses AppSurface (6.1)
/// - Dumb component pattern (6.2)
/// - Theme-driven styling (3.1 IoC)
class App{ComponentName} extends StatelessWidget {
  const App{ComponentName}({
    super.key,
    // Required parameters
    // Optional parameters with named syntax
  });

  // Properties

  @override
  Widget build(BuildContext context) {
    // Constitution 3.3: Zero Internal Defaults - Fail Fast
    final theme = Theme.of(context).extension<AppDesignTheme>();
    assert(
      theme != null,
      'App{ComponentName} requires DesignSystem initialization. '
      'Call DesignSystem.init() in MaterialApp.builder.',
    );

    final style = theme!.{componentStyle};

    // Constitution 6.1: Use AppSurface
    return AppSurface(
      style: theme.surfaceBase,
      child: // Component content
    );
  }
}
```

### 3. Generate Style Spec (if needed)

Create `lib/src/foundation/theme/design_system/specs/{component_snake}_style.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'shared/shared_specs.dart';

part '{component_snake}_style.tailor.dart';

/// Style specification for {ComponentName} components.
///
/// Composes shared specs per Constitution 4.6:
/// - [AnimationSpec] for transitions
/// - [StateColorSpec] for state-based colors (if applicable)
@TailorMixin()
class {ComponentName}Style extends ThemeExtension<{ComponentName}Style>
    with _${ComponentName}StyleTailorMixin {
  const {ComponentName}Style({
    required this.animation,
    // Add component-specific properties
  });

  /// Animation timing for transitions
  @override
  final AnimationSpec animation;

  // Component-specific properties
}
```

### 4. Generate Golden Test

Create `test/{level}/{component_snake}/app_{component_snake}_golden_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:alchemist/alchemist.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/theme_matrix_builder.dart';
import '../../test_utils/load_fonts.dart';

void main() {
  // Constitution B.1: Load real fonts
  setUpAll(() async {
    await loadAppFonts();
  });

  group('App{ComponentName} Golden Tests', () {
    // Constitution B.2: Safe Mode Protocol
    goldenTest(
      'App{ComponentName} - Default State',
      fileName: 'app_{component_snake}_default',
      builder: () => buildThemeMatrix(
        name: 'Default',
        width: 300.0,  // B.2.1: Explicit constraints
        height: 100.0,
        child: const App{ComponentName}(
          // Default props
        ),
      ),
    );

    goldenTest(
      'App{ComponentName} - Interactive State',
      fileName: 'app_{component_snake}_interactive',
      builder: () => buildThemeMatrix(
        name: 'Interactive',
        width: 300.0,
        height: 100.0,
        child: const App{ComponentName}(
          // Interactive props
        ),
      ),
    );
  });
}
```

### 5. Generate Widgetbook UseCase

Create `widgetbook/lib/stories/{level}/{component_snake}_use_case.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

@UseCase(name: 'Default', type: App{ComponentName})
Widget build{ComponentName}UseCase(BuildContext context) {
  return App{ComponentName}(
    // Use context.knobs for interactive properties
  );
}
```

### 6. Update Exports

Add to `lib/ui_kit.dart`:
```dart
export 'src/{level}/{component_snake}/app_{component_snake}.dart';
```

If style was created, also add:
```dart
export 'src/foundation/theme/design_system/specs/{component_snake}_style.dart';
```

### 7. Quality Assurance

**IMPORTANT**: Perform automated quality checks on generated component:

#### 7.1 Static Analysis
```bash
flutter analyze lib/src/{level}/{component_snake}/app_{component_snake}.dart
```
- **If errors found**: Fix immediately (unused variables, imports, etc.)
- **If warnings found**: Address lint issues
- **Re-run analysis** until clean

#### 7.2 Golden Test Generation
```bash
flutter test test/{level}/{component_snake}/app_{component_snake}_golden_test.dart --update-goldens --tags golden
```
- **Generate golden images** for the new component
- **Verify test passes** with new images
- **Check visual output** matches expectations

#### 7.3 AppDesignTheme Integration (if style spec created)

**IMPORTANT**: If a style spec was generated, automatically integrate it into the theme system:

##### 7.3.1 Add Style Property to AppDesignTheme
Add the new style property to `lib/src/foundation/theme/design_system/app_design_theme.dart`:

```dart
// In AppDesignTheme class
@override
final {ComponentName}Style {componentName}Style;

// In constructor
const AppDesignTheme({
  // existing parameters...
  required this.{componentName}Style,
  // ...
});
```

##### 7.3.2 Configure Style in All 5 Theme Files
For each theme file (`glass_design_theme.dart`, `flat_design_theme.dart`, `brutal_design_theme.dart`, `neumorphic_design_theme.dart`, `pixel_design_theme.dart`):

```dart
// Add to each theme's constructor call
{componentName}Style: {ComponentName}Style(
  // theme-specific configuration
  animation: AnimationSpec.standard, // or theme-specific timing
  // other properties...
),
```

##### 7.3.3 Export Style Spec
Add export to `lib/ui_kit.dart`:
```dart
export 'src/foundation/theme/design_system/specs/{component_snake}_style.dart';
```

#### 7.4 Build Validation (if style spec created)
```bash
dart run build_runner build --delete-conflicting-outputs
```
- **Generate .tailor.dart files** for any new style specs
- **Verify no build errors**
- **Confirm theme integration** compiles successfully

### 8. Provide Summary Report

Output a detailed summary:

```markdown
## ✅ Component Generated: App{ComponentName}

### 📁 Files Created
- ✅ `lib/src/{level}/{component_snake}/app_{component_snake}.dart`
- ✅ `lib/src/foundation/theme/design_system/specs/{component_snake}_style.dart` (if needed)
- ✅ `test/{level}/{component_snake}/app_{component_snake}_golden_test.dart`
- ✅ `widgetbook/lib/stories/{level}/{component_snake}_use_case.dart`
- ✅ Updated `lib/ui_kit.dart` exports

### 🔍 Quality Checks Completed
- ✅ **Static Analysis**: No lint errors
- ✅ **Golden Tests**: Images generated and passing
- ✅ **Theme Integration**: Style added to AppDesignTheme (if style spec was created)
- ✅ **Theme Configuration**: Style configured in all 5 theme files (if style spec was created)
- ✅ **Build Validation**: No compilation errors

### 🎯 Next Steps
1. **Review component**: Test interactive features in Widgetbook
2. **Constitution Review**: Run `/uikit.review {component_path}` for compliance verification (optional)

### 📋 Component Ready for Use! 🎉
```

## Example Usage

```
/uikit.component AppTimePicker molecule
/uikit.component AppRating - A star rating component
/uikit.component AppTreeView organism
```

## Context

$ARGUMENTS
