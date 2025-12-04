# Component Props Reference

**Date**: 2025-12-04

This document defines the expected props for each registered UI Kit component.

## Atoms

### AppSurface
```json
{
  "type": "AppSurface",
  "props": {
    "variant": "base|elevated|highlight",
    "interactive": false,
    "borderRadius": 8.0,
    "padding": 16.0
  },
  "children": [...]
}
```

### AppText
```json
{
  "type": "AppText",
  "props": {
    "text": "Hello World",
    "variant": "headline|title|body|label|caption|tiny",
    "textAlign": "left|center|right"
  }
}
```

### AppIcon
```json
{
  "type": "AppIcon",
  "props": {
    "icon": "home|settings|wifi|...",
    "size": 24.0
  }
}
```

### AppGap
```json
{
  "type": "AppGap",
  "props": {
    "size": 16.0,
    "horizontal": false
  }
}
```

### AppDivider
```json
{
  "type": "AppDivider",
  "props": {
    "thickness": 1.0
  }
}
```

### AppSkeleton
```json
{
  "type": "AppSkeleton",
  "props": {
    "width": 100.0,
    "height": 20.0,
    "borderRadius": 4.0
  }
}
```

## Molecules - Buttons

### AppButton
```json
{
  "type": "AppButton",
  "props": {
    "label": "Click Me",
    "variant": "base|elevated|highlight",
    "isEnabled": true,
    "icon": "add"
  }
}
```

### AppIconButton
```json
{
  "type": "AppIconButton",
  "props": {
    "icon": "settings",
    "variant": "base|elevated|highlight",
    "isEnabled": true
  }
}
```

## Molecules - Inputs

### AppTextField
```json
{
  "type": "AppTextField",
  "props": {
    "label": "Email",
    "hint": "Enter your email",
    "isEnabled": true,
    "obscureText": false,
    "maxLines": 1
  }
}
```

### AppDropdown
```json
{
  "type": "AppDropdown",
  "props": {
    "label": "Select Option",
    "items": ["Option A", "Option B", "Option C"],
    "selectedIndex": 0
  }
}
```

### AppIPv4TextField
```json
{
  "type": "AppIPv4TextField",
  "props": {
    "label": "IP Address",
    "initialValue": "192.168.1.1"
  }
}
```

## Molecules - Selection

### AppCheckbox
```json
{
  "type": "AppCheckbox",
  "props": {
    "label": "Remember me",
    "value": false,
    "isEnabled": true
  }
}
```

### AppRadio
```json
{
  "type": "AppRadio",
  "props": {
    "label": "Option A",
    "groupValue": "A",
    "value": "A",
    "isEnabled": true
  }
}
```

### AppSlider
```json
{
  "type": "AppSlider",
  "props": {
    "value": 0.5,
    "min": 0.0,
    "max": 1.0,
    "divisions": 10,
    "label": "Volume"
  }
}
```

### AppSwitch
```json
{
  "type": "AppSwitch",
  "props": {
    "value": false,
    "label": "Enable notifications",
    "isEnabled": true
  }
}
```

## Molecules - Status

### AppBadge
```json
{
  "type": "AppBadge",
  "props": {
    "label": "New",
    "variant": "primary|success|warning|error"
  }
}
```

### AppTag
```json
{
  "type": "AppTag",
  "props": {
    "label": "Flutter",
    "isSelected": false,
    "isDismissible": true
  }
}
```

### AppAvatar
```json
{
  "type": "AppAvatar",
  "props": {
    "initials": "JD",
    "imageUrl": null,
    "size": 40.0
  }
}
```

## Molecules - Layout

### AppCard
```json
{
  "type": "AppCard",
  "props": {
    "variant": "base|elevated|highlight",
    "padding": 16.0
  },
  "children": [...]
}
```

### AppListTile
```json
{
  "type": "AppListTile",
  "props": {
    "title": "List Item",
    "subtitle": "Description",
    "leadingIcon": "person",
    "trailingIcon": "chevron_right"
  }
}
```

## Molecules - Feedback

### AppLoader
```json
{
  "type": "AppLoader",
  "props": {
    "size": 32.0
  }
}
```

### AppToast
```json
{
  "type": "AppToast",
  "props": {
    "message": "Operation successful",
    "variant": "info|success|warning|error"
  }
}
```

## Flutter Layout Containers

### Column
```json
{
  "type": "Column",
  "props": {
    "mainAxisAlignment": "start|center|end|spaceBetween|spaceAround|spaceEvenly",
    "crossAxisAlignment": "start|center|end|stretch",
    "mainAxisSize": "min|max"
  },
  "children": [...]
}
```

### Row
```json
{
  "type": "Row",
  "props": {
    "mainAxisAlignment": "start|center|end|spaceBetween|spaceAround|spaceEvenly",
    "crossAxisAlignment": "start|center|end|stretch",
    "mainAxisSize": "min|max"
  },
  "children": [...]
}
```

### Padding
```json
{
  "type": "Padding",
  "props": {
    "all": 16.0,
    "horizontal": null,
    "vertical": null,
    "left": null,
    "right": null,
    "top": null,
    "bottom": null
  },
  "children": [...]
}
```

### SizedBox
```json
{
  "type": "SizedBox",
  "props": {
    "width": 100.0,
    "height": 50.0
  },
  "children": [...]
}
```

## Action Callback Schema

Interactive components trigger onAction with this payload:

```json
{
  "action": "tap|change|submit|dismiss",
  "componentType": "AppButton",
  "data": {
    "value": "...",
    "...additional props"
  }
}
```
