# Data Model: Unified Design System

## 1. AppDesignTheme (Abstract ThemeExtension)

The root object injected into `ThemeData.extensions`.

| Property | Type | Description |
| :--- | :--- | :--- |
| `surfaceBase` | `SurfaceStyle` | Default surface (cards, panels). |
| `surfaceElevated` | `SurfaceStyle` | Floating surface (dialogs, sheets). |
| `surfaceHighlight` | `SurfaceStyle` | Active/accent surface (badges, toasts). |
| `typography` | `TypographySpec` | Font overrides and text styles. |
| `animation` | `AnimationSpec` | Global motion physics. |
| `spacingFactor` | `double` | Density multiplier (default 1.0). |

## 2. SurfaceStyle

Defines the visual appearance of a container.

| Property | Type | Description |
| :--- | :--- | :--- |
| `backgroundColor` | `Color` | Fill color. |
| `borderColor` | `Color` | Border stroke color. |
| `borderWidth` | `double` | Border thickness. |
| `borderRadius` | `double` | Corner radius. |
| `shadows` | `List<BoxShadow>` | Elevation effects. |
| `blurStrength` | `double` | Sigma for `BackdropFilter` (0 for non-glass). |
| `contentColor` | `Color` | Default text/icon color on this surface. |

## 3. AnimationSpec

Defines motion physics.

| Property | Type | Description |
| :--- | :--- | :--- |
| `duration` | `Duration` | Transition length. |
| `curve` | `Curve` | Easing curve. |

## 4. TypographySpec

Defines font choices.

| Property | Type | Description |
| :--- | :--- | :--- |
| `bodyFontFamily` | `String?` | Override for body text (e.g., 'Roboto Mono'). |
| `displayFontFamily` | `String?` | Override for headlines. |
