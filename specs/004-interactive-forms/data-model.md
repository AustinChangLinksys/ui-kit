# Data Model: Interactive & Form Expansion

**Feature**: Interactive & Form Expansion
**Date**: 2025-12-01

## 1. Theme Extensions (Foundation)

These entities extend the `AppDesignTheme` to support the new components.

### 1.1 `LoaderStyle`
*Defines the visual properties of the AppLoader component.*

| Field | Type | Description |
|---|---|---|
| `color` | `Color?` | Primary color of the loader. If null, defaults to theme primary. |
| `strokeWidth` | `double` | Thickness of the circular ring or linear bar. |
| `size` | `double` | Default diameter for circular loader. |
| `period` | `Duration` | Duration of one complete animation cycle. |

### 1.2 `ToastStyle`
*Defines the visual properties of the AppToast component.*

| Field | Type | Description |
|---|---|---|
| `padding` | `EdgeInsets` | Internal padding for the toast content. |
| `margin` | `EdgeInsets` | Margin for positioning the toast (e.g., from screen edge). |
| `borderRadius` | `BorderRadius` | Corner radius of the toast container. |
| `backgroundColor` | `Color?` | Background color override. Usually derived from SurfaceVariant. |
| `textStyle` | `TextStyle` | Typography for the toast message. |
| `displayDuration` | `Duration` | Default duration the toast remains visible. |

---

## 2. Component Props (Molecules)

These are the public API contracts for the new widgets.

### 2.1 `AppTextFormField`
*A form field wrapper for AppTextField.*

| Prop | Type | Required | Description |
|---|---|---|---|
| `name` | `String` | No | Semantic name for testing/forms. |
| `initialValue` | `String?` | No | Initial text content. |
| `validator` | `String? Function(String?)?` | No | Validation logic. Returns error string or null. |
| `onSaved` | `void Function(String?)?` | No | Callback when form is saved. |
| `onChanged` | `void Function(String)?` | No | Callback when text changes. |
| `enabled` | `bool` | No (Default true) | Interactive state. |
| `...` | `AppTextField Props` | - | Proxies all visual props (label, hint, icon, etc.) to `AppTextField`. |

### 2.2 `AppDropdown<T>`
*A generic dropdown selection component.*

| Prop | Type | Required | Description |
|---|---|---|---|
| `items` | `List<T>` | **Yes** | List of data items to select from. |
| `value` | `T?` | No | Currently selected item. |
| `onChanged` | `void Function(T?)?` | **Yes** | Callback when selection changes. |
| `itemBuilder` | `Widget Function(BuildContext, T)` | No | Custom renderer for dropdown items. |
| `itemAsString` | `String Function(T)?` | No | Function to convert item to display string. Defaults to `toString()`. |
| `itemValue` | `dynamic Function(T)?` | No | Function to extract unique ID/Value for comparison. |
| `label` | `String?` | No | Floating label text. |
| `hint` | `String?` | No | Placeholder text when empty. |

### 2.3 `AppLoader`
*A visual indicator for loading states.*

| Prop | Type | Required | Description |
|---|---|---|---|
| `variant` | `LoaderVariant` | No (Default circular) | `circular` or `linear`. |
| `value` | `double?` | No | If non-null, renders determinate progress (0.0 - 1.0). If null, indeterminate. |
| `label` | `String?` | No | Optional semantic label or text displayed next to loader. |

### 2.4 `AppToast`
*A transient notification message.*

| Prop | Type | Required | Description |
|---|---|---|---|
| `type` | `ToastType` | **Yes** | Semantic type: `success`, `error`, `info`, `warning`. |
| `title` | `String` | **Yes** | Main message text. |
| `description` | `String?` | No | Secondary detail text. |
| `onDismiss` | `VoidCallback?` | No | Callback when toast is dismissed (manually or auto). |

### 2.5 `AppListTile`
*A standard list row component.*

| Prop | Type | Required | Description |
|---|---|---|---|
| `title` | `Widget` | **Yes** | Primary content (usually Text). |
| `subtitle` | `Widget?` | No | Secondary content below title. |
| `leading` | `Widget?` | No | Widget at the start (Icon/Avatar). |
| `trailing` | `Widget?` | No | Widget at the end (Arrow/Switch). |
| `onTap` | `VoidCallback?` | No | Interaction callback. Enables hover/press effects if non-null. |
| `selected` | `bool` | No (Default false) | Selected visual state. |
