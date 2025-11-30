# Data Model: Unified UI Kit Molecules

**Feature**: Unified UI Kit Molecules
**Description**: Constructor definitions for the new UI components.

## 1. AppButton & AppIconButton

### AppButton
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | **Required** | Text content of the button. |
| `onTap` | `VoidCallback?` | `null` | Action trigger. Null = Disabled. |
| `icon` | `Widget?` | `null` | Optional leading icon. |
| `isLoading` | `bool` | `false` | If true, shows spinner and blocks interaction. |
| `variant` | `SurfaceVariant` | `highlight` | visual style variant. |

### AppIconButton
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `icon` | `Widget` | **Required** | The icon widget (usually SvgPicture). |
| `onTap` | `VoidCallback?` | `null` | Action trigger. Null = Disabled. |
| `isLoading` | `bool` | `false` | If true, shows spinner. |
| `variant` | `SurfaceVariant` | `base` | Visual style variant. |
| `tooltip` | `String?` | `null` | Accessibility label / tooltip. |

## 2. AppTextField

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `controller` | `TextEditingController?` | `null` | Controls text being edited. |
| `hintText` | `String?` | `null` | Placeholder text. |
| `onChanged` | `ValueChanged<String>?`| `null` | Callback when text changes. |
| `errorText` | `String?` | `null` | If non-null, displays error state. |
| `obscureText`| `bool` | `false` | For passwords. |
| `keyboardType`| `TextInputType` | `text` | Input type (email, number, etc.). |

## 3. Selection (AppCheckbox, AppRadio, AppSlider)

### AppCheckbox / AppRadio
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `bool` | **Required** | Current state. |
| `onChanged` | `ValueChanged<bool?>?` | `null` | Callback. Null = Disabled. |
| `label` | `String?` | `null` | Optional text label next to toggle. |

### AppSlider
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `value` | `double` | **Required** | Current value. |
| `onChanged` | `ValueChanged<double>?` | `null` | Callback. Null = Disabled. |
| `min` | `double` | `0.0` | Minimum value. |
| `max` | `double` | `1.0` | Maximum value. |
| `divisions` | `int?` | `null` | Number of discrete steps. |

## 4. Status (AppBadge, AppTag, AppAvatar)

### AppBadge / AppTag
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `label` | `String` | **Required** | Text content. |
| `color` | `Color?` | `null` | Override background color. |
| `onDeleted` | `VoidCallback?` | `null` | If provided, shows delete icon (Tag only). |

### AppAvatar
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `imageUrl` | `String?` | `null` | URL for the profile image. |
| `initials` | `String` | **Required** | Fallback text (e.g., "AC"). |
| `size` | `double` | `40.0` | Diameter of the circle. |

## 5. AppNavigationBar

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `items` | `List<NavigationItem>` | **Required** | List of nav items (Icon + Label). Max 5. |
| `currentIndex`| `int` | `0` | Currently selected index. |
| `onTap` | `ValueChanged<int>` | **Required** | Selection callback. |

### Helper Entity: NavigationItem
| Field | Type | Description |
|-------|------|-------------|
| `icon` | `Widget` | Inactive icon. |
| `activeIcon` | `Widget?` | Active icon (optional). |
| `label` | `String` | Text label. |
