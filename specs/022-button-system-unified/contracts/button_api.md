# Button API Contracts

**Feature**: 022-button-system-unified
**Date**: 2025-12-09
**Purpose**: Define API contracts for unified button system components

## AppButton API Contract

### Constructor Signatures

#### Main Constructor
```dart
const AppButton({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  ButtonStyleVariant variant = ButtonStyleVariant.filled,
  SurfaceVariant emphasis = SurfaceVariant.highlight,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
});
```

#### Named Constructors - Primary Actions
```dart
const AppButton.primary({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.highlight;

const AppButton.primaryOutline({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.outline,
     emphasis = SurfaceVariant.highlight;
```

#### Named Constructors - Secondary Actions
```dart
const AppButton.secondary({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.tonal;

const AppButton.secondaryOutline({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.outline,
     emphasis = SurfaceVariant.tonal;
```

#### Named Constructors - Tertiary Actions
```dart
const AppButton.tertiary({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.base;

const AppButton.text({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.text,
     emphasis = SurfaceVariant.base;
```

#### Named Constructors - Destructive Actions
```dart
const AppButton.danger({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.accent;

const AppButton.dangerOutline({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.outline,
     emphasis = SurfaceVariant.accent;
```

#### Named Constructors - Size Variants
```dart
const AppButton.small({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.highlight,
     size = AppButtonSize.small;

const AppButton.large({
  required String label,
  VoidCallback? onTap,
  Widget? icon,
  AppButtonIconPosition iconPosition = AppButtonIconPosition.leading,
  bool isLoading = false,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.highlight,
     size = AppButtonSize.large;
```

### Properties Contract

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `label` | `String` | Yes | - | Button text content |
| `onTap` | `VoidCallback?` | No | `null` | Tap handler, `null` disables button |
| `icon` | `Widget?` | No | `null` | Optional icon widget |
| `iconPosition` | `AppButtonIconPosition` | No | `leading` | Icon placement relative to text |
| `variant` | `ButtonStyleVariant` | No | `filled` | Visual style variant |
| `emphasis` | `SurfaceVariant` | No | `highlight` | Semantic emphasis level |
| `size` | `AppButtonSize` | No | `medium` | Button size specification |
| `isLoading` | `bool` | No | `false` | Shows loading indicator when `true` |

### Behavior Contract

#### State Management
- **Enabled State**: When `onTap` is not null and `isLoading` is false
- **Disabled State**: When `onTap` is null or `isLoading` is true
- **Loading State**: When `isLoading` is true, shows loading indicator instead of icon

#### Visual Rendering
- **Text**: Always rendered using resolved TextStyle from ButtonTextStyles
- **Icon**: Positioned according to `iconPosition`, hidden during loading
- **Loading**: Replaces icon with AppSkeleton.circular when active
- **Surface**: Rendered via AppSurface with resolved ButtonSurfaceStates

#### Interaction
- **Tap**: Triggers `onTap` callback when enabled
- **States**: Supports hover, press, and disabled visual feedback
- **Accessibility**: Provides semantic labels and touch targets ≥44px

---

## AppIconButton API Contract

### Constructor Signatures

#### Main Constructor
```dart
const AppIconButton({
  required Widget icon,
  VoidCallback? onTap,
  ButtonStyleVariant variant = ButtonStyleVariant.filled,
  SurfaceVariant emphasis = SurfaceVariant.base,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  String? tooltip,
  Key? key,
});
```

#### Named Constructors - Primary Actions
```dart
const AppIconButton.primary({
  required Widget icon,
  VoidCallback? onTap,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  String? tooltip,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.highlight;

const AppIconButton.secondary({
  required Widget icon,
  VoidCallback? onTap,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  String? tooltip,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.tonal;
```

#### Named Constructors - Style Variants
```dart
const AppIconButton.outline({
  required Widget icon,
  VoidCallback? onTap,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  String? tooltip,
  Key? key,
}) : variant = ButtonStyleVariant.outline,
     emphasis = SurfaceVariant.base;

const AppIconButton.ghost({
  required Widget icon,
  VoidCallback? onTap,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  String? tooltip,
  Key? key,
}) : variant = ButtonStyleVariant.text,
     emphasis = SurfaceVariant.base;
```

#### Named Constructors - Special States
```dart
const AppIconButton.toggle({
  required Widget icon,
  VoidCallback? onTap,
  bool isActive = false,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  String? tooltip,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = isActive ? SurfaceVariant.tonal : SurfaceVariant.base;

const AppIconButton.danger({
  required Widget icon,
  VoidCallback? onTap,
  AppButtonSize size = AppButtonSize.medium,
  bool isLoading = false,
  String? tooltip,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.accent;
```

#### Named Constructors - Size Variants
```dart
const AppIconButton.small({
  required Widget icon,
  VoidCallback? onTap,
  bool isLoading = false,
  String? tooltip,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.base,
     size = AppButtonSize.small;

const AppIconButton.large({
  required Widget icon,
  VoidCallback? onTap,
  bool isLoading = false,
  String? tooltip,
  Key? key,
}) : variant = ButtonStyleVariant.filled,
     emphasis = SurfaceVariant.highlight,
     size = AppButtonSize.large;
```

### Properties Contract

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `icon` | `Widget` | Yes | - | Icon widget (typically Icon or AppIcon) |
| `onTap` | `VoidCallback?` | No | `null` | Tap handler, `null` disables button |
| `variant` | `ButtonStyleVariant` | No | `filled` | Visual style variant |
| `emphasis` | `SurfaceVariant` | No | `base` | Semantic emphasis level |
| `size` | `AppButtonSize` | No | `medium` | Button size specification |
| `isLoading` | `bool` | No | `false` | Shows loading indicator when `true` |
| `tooltip` | `String?` | No | `null` | Accessibility tooltip text |

### Behavior Contract

#### State Management
- **Enabled State**: When `onTap` is not null and `isLoading` is false
- **Disabled State**: When `onTap` is null or `isLoading` is true
- **Loading State**: When `isLoading` is true, shows AppSkeleton.circular instead of icon
- **Toggle State**: Special constructor parameter `isActive` affects emphasis selection

#### Visual Rendering
- **Icon**: Centered within square button bounds
- **Loading**: Replaces icon with circular loading indicator
- **Surface**: Square aspect ratio (width = height from ButtonSizeSpec)
- **Tooltip**: Wraps button when tooltip string provided

#### Interaction
- **Tap**: Triggers `onTap` callback when enabled
- **States**: Supports hover, press, and disabled visual feedback
- **Accessibility**: Tooltip provides semantic description for screen readers

---

## ButtonStyle Theme Extension Contract

### Interface Definition
```dart
@TailorMixin()
class ButtonStyle extends ThemeExtension<ButtonStyle> {
  const ButtonStyle({
    required this.filledSurfaces,
    required this.filledContentColors,
    required this.outlineSurfaces,
    required this.outlineContentColors,
    required this.textSurfaces,
    required this.textContentColors,
    required this.textStyles,
    required this.sizeSpec,
    required this.interaction,
  });

  // Filled variant styles
  final ButtonSurfaceStates filledSurfaces;
  final StateColorSpec filledContentColors;

  // Outline variant styles
  final ButtonSurfaceStates outlineSurfaces;
  final StateColorSpec outlineContentColors;

  // Text variant styles
  final ButtonSurfaceStates textSurfaces;
  final StateColorSpec textContentColors;

  // Shared properties
  final ButtonTextStyles textStyles;
  final ButtonSizeSpec sizeSpec;
  final InteractionSpec interaction;

  // Resolution methods
  SurfaceStyle getSurface(ButtonStyleVariant variant, {
    required bool isEnabled,
    bool isHovered = false,
    bool isPressed = false,
  });

  Color getContentColor(ButtonStyleVariant variant, {
    required bool isEnabled,
    bool isHovered = false,
    bool isPressed = false,
  });

  TextStyle getTextStyle(AppButtonSize size);
}
```

### Registration Contract

ButtonStyle must be registered in AppDesignTheme as:
```dart
final ButtonStyle buttonStyle;
```

This replaces the previous separate style properties:
- `buttonStyle` (old separate class)
- `iconButtonStyle` (removed)
- `textButtonStyle` (removed)

### Implementation Requirements

Each theme (Glass, Brutal, Flat, Neumorphic, Pixel) must provide:

1. **Complete ButtonStyle instance** with all variants implemented
2. **StateColorSpec instances** for each variant's content colors
3. **ButtonSurfaceStates instances** for each variant's surface styles
4. **Consistent ButtonSizeSpec** aligned with theme's sizing philosophy
5. **ButtonTextStyles** using Constitutional typography tokens
6. **InteractionSpec** matching theme's interaction patterns

## Validation Rules

### Constructor Validation
- All required parameters must be provided
- Named constructors must use const initializer lists
- Default values must align with Constitutional requirements

### Runtime Validation
- ButtonStyle must exist in theme (fail-fast if missing)
- All style resolution must return non-null values
- State resolution must follow defined priority order

### Integration Validation
- AppSurface must accept resolved SurfaceStyle instances
- StateColorSpec must resolve valid Colors for all states
- ButtonSizeSpec dimensions must meet accessibility minimums

### Backward Compatibility
- Existing AppButton/AppIconButton code must compile unchanged
- Visual output must be identical for equivalent configurations
- Theme switching must work without component recreation

This API contract ensures type safety, Constitutional compliance, and seamless integration while providing both simplified named constructors and full customization capabilities.