# Data Model & State

**Branch**: `019-legacy-migration`

## 1. Entities

### 1.1 SlideActionItem
Defines a single action within the `AppSlideAction` menu.

| Field | Type | Description |
| :--- | :--- | :--- |
| `label` | `String` | Text displayed for the action. |
| `icon` | `Widget` | Icon displayed (usually `AppIcon`). |
| `onTap` | `VoidCallback` | Action trigger. |
| `variant` | `SlideActionVariant` | Semantic style (Standard, Destructive, Neutral). |
| `foregroundColor` | `Color?` | Optional override (discouraged, prefer variant). |
| `backgroundColor` | `Color?` | Optional override (discouraged, prefer variant). |

### 1.2 ExpandableFabItem
Defines a satellite action for `AppExpandableFab`.

| Field | Type | Description |
| :--- | :--- | :--- |
| `tooltip` | `String?` | Text label shown on hover/long-press. |
| `icon` | `Widget` | Icon displayed. |
| `onTap` | `VoidCallback` | Action trigger. |
| `enable` | `bool` | Whether the action is interactive. |

## 2. Enums

### 2.1 SlideActionVariant
*   `standard`: Uses default `surfaceContainer` / `onSurface`.
*   `destructive`: Uses `error` / `onError`.
*   `neutral`: Uses `surface` / `onSurfaceVariant`.

### 2.2 FabAnimationType (Style)
*   `fanOut`: Radial expansion (Default/Flat).
*   `float`: Vertical/Bubbling rise (Glass).
*   `gridSnap`: Fixed grid positions (Pixel).
*   `spring`: Elastic bounce (Brutal).

### 2.3 GaugeRenderType (Style)
*   `gradient`: Continuous sweep (Flat, Glass).
*   `segmented`: Discrete blocks (Pixel).
*   `solid`: Single color stroke (Brutal).

### 2.4 GaugeCapType (Style)
*   `round`: Rounded ends (Flat).
*   `butt`: Sharp ends (Pixel, Brutal).
*   `comet`: Fading transparency (Glass).
*   `bead`: Circle at tip (Neumorphic).

## 3. Validation Rules

*   **AppGauge**: `value` must be normalized between `0.0` and `1.0`. Clamped if out of bounds.
*   **AppSlideAction**: `actions` list should typically contain 1-3 items for usability.
*   **AppExpandableFab**: `children` must not be empty.
