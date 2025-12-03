# Component Showcase Guide

## Overview

The Component Showcase template (`component_showcase_template.dart`) displays all available UI Kit components organized by category. This guide lists all components currently displayed in the preview.

---

## Component Categories & List

### 1. Buttons & Navigation
Fundamental interactive components for user actions and navigation.

**Components:**
- **AppButton** - Primary and variant button styles
- **AppIconButton** - Icon-based button component with multiple variants

---

### 2. Form & Input Controls
Text input and selection components for data entry.

**Components:**
- **AppTextFormField** - Form-integrated text input with validation
- **AppTextField** - Simple text input field
- **AppDropdown** - Dropdown/select component with multiple options

**Note:** Network input fields (IPv4, MAC Address, IPv6) are available but require additional configuration in the showcase.

---

### 3. Selection Controls
Components for user selection and state toggling.

**Components:**
- **AppCheckbox** - Checkbox control (checked/unchecked states)
- **AppRadio** - Radio button control (single selection from group)
- **AppSwitch** - Toggle/switch component
- **AppSlider** - Slider control for numeric range selection

---

### 4. Status & Feedback
Components for displaying status, feedback, and user notifications.

**Components:**
- **AppBadge** - Badge indicator for notifications/counts
- **AppTag** - Tag component for categorization
- **AppAvatar** - Avatar display with initials fallback
- **AppLoader** - Loading spinner/progress indicator
- **AppTooltip** - Tooltip for contextual information
- **AppToast** - Toast notification messages

---

### 5. Display & Layout
Layout and content display components.

**Components:**
- **AppCard** - Card container for content grouping
- **AppListTile** - List item component with leading/trailing widgets
- **AppDivider** - Visual separator component
- **AppSkeleton** - Skeleton/placeholder loaders
  - Circular variant (for avatars)
  - Text variant (for content loading)

---

### 6. Icon Library
Icon display component.

**Components:**
- **AppIcon** - Icon display with two constructors:
  - `AppIcon.font()` - Material font icons
  - `AppIcon()` - SVG icons

---

### 7. Navigation Components
Navigation structure components.

**Components:**
- **AppNavigationBar** - Horizontal navigation bar with items
- **AppNavigationRail** - Vertical navigation rail with items
- **AppNavigationItem** - Navigation item with icon and label

---

## Additional Atomic Components (Referenced)

### Typography
- **AppText** - Text rendering with typography variants

### Layout
- **AppGap** - Spacing/gap utility component
- **AppSurface** - Surface container with theme variants

---

## Surface Variants Showcase

The showcase also displays all available surface variants:
- **Base** - Default surface
- **Elevated** - Elevated surface
- **Highlight** - Highlighted/emphasis surface
- **Tonal** - Tonal/secondary surface
- **Accent** - Accent/tertiary surface

---

## Color Palette Preview

Displays semantic colors from the current theme:
- Primary
- Secondary
- Tertiary
- Error

---

## Typography Preview

Displays typography hierarchy:
- Headline Small
- Title Medium
- Body Medium
- Body Small (Caption)

---

## Integration

The Component Showcase is integrated into the Theme Editor preview to demonstrate:
1. Real-time theme changes
2. Surface variant behavior with color overrides
3. All components rendered with current theme configuration

Access the showcase in the theme editor preview area to test design system changes across all UI components.

---

## Component Count

**Total Components Showcased:** 30+

**Category Breakdown:**
- Buttons & Navigation: 2
- Form & Input Controls: 3
- Selection Controls: 4
- Status & Feedback: 6
- Display & Layout: 5
- Icons: 1
- Navigation: 3
- Typography: 1
- Layout: 2
- Color/Surface Variants: 5

---

## Notes

- All components are rendered in their default state
- Interactive components have no-op handlers for demo purposes
- Components respect the current theme and surface configurations
- Theme changes are reflected in real-time across all components
