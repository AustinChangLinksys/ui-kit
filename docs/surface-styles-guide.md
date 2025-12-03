# Surface Styles Guide: Semantic Color System

## Overview

The UI Kit uses a **5-tier semantic surface hierarchy** to create clear visual distinctions and guide user attention through interface priority levels. Each surface style is implemented consistently across all 5 design themes (Glass, Brutal, Flat, Neumorphic, Pixel).

### Visual Hierarchy Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    HIGHLIGHT (Primary CTA)                  │
│              Maximum-priority actions & CTAs                │
│                    Design Theme Physics                      │
└─────────────────────────────────────────────────────────────┘
                           ▲
                           │
┌─────────────────────────────────────────────────────────────┐
│                  ELEVATED (Floating Context)                │
│            Modals, Dialogs, Tooltips, Floating UI          │
│                    Design Theme Physics                      │
└─────────────────────────────────────────────────────────────┘
                           ▲
                           │
┌─────────────────────────────────────────────────────────────┐
│                 TONAL/SECONDARY (Selection)                 │
│      Selected items, Active filters, Secondary actions      │
│                    Design Theme Physics                      │
└─────────────────────────────────────────────────────────────┘
                           ▲
                           │
┌─────────────────────────────────────────────────────────────┐
│                   BASE (Default Surface)                     │
│    Cards, Panels, Lists, Background containers              │
│                    Design Theme Physics                      │
└─────────────────────────────────────────────────────────────┘
```

---

## Surface Styles Reference

### 1. Base Surface

**Purpose**: Default background for low-priority content

- **Use for**: Card backgrounds, list items, neutral areas, panels, dialog content
- **Priority Level**: 1 (Lowest)
- **Variant Enum**: `SurfaceVariant.base`
- **Theme Property**: `theme.surfaceBase`

#### Implementation per Theme

**Glass Theme**
- Light: Frosted glass with minimal blur (alpha: 0.04, blur: 8.0)
- Dark: Darker frost with higher transparency (alpha: 0.08, blur: 8.0)
- Intent: Subtle background that recedes visually

**Brutal Theme**
- Solid grey (#EBEBEB light / #333333 dark)
- Border: 2px solid black
- Sharp corners (radius: 0.0)
- Intent: Stark contrast and geometric clarity

**Flat Theme**
- Light: Material 3 `surface` color
- Dark: Material 3 `surface` color
- No border or minimal 1px
- Intent: Clean, minimal Material aesthetic

**Neumorphic Theme**
- Light: Pale surface with no shadows
- Dark: Darker surface with subtle inset shadows
- Soft rounded corners (radius: 8.0)
- Intent: Tactile, embossed appearance

**Pixel Theme**
- Light: #F5F5F5 with 1px border
- Dark: #1A1A1A with 1px border
- 2px grid pattern texture overlay
- Sharp corners (radius: 0.0)
- Intent: Retro, pixelated aesthetic

#### Example Code

```dart
// Simple card with base surface
AppSurface(
  variant: SurfaceVariant.base,
  padding: const EdgeInsets.all(16),
  child: Column(
    children: [
      AppText('Card Title', variant: TextVariant.titleLarge),
      const SizedBox(height: 8),
      AppText('Card content goes here', variant: TextVariant.bodyMedium),
    ],
  ),
)

// List item with base surface
AppSurface(
  variant: SurfaceVariant.base,
  height: 56,
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Row(
    children: [
      AppIcon(Icons.settings),
      const SizedBox(width: 16),
      Expanded(child: AppText('Settings')),
      AppIcon(Icons.chevron_right),
    ],
  ),
)
```

#### Affected Components

- `AppCard` - Card containers
- `AppListItem` - List item backgrounds
- `AppPanel` - Panel backgrounds
- `AppSurface(variant: SurfaceVariant.base)` - Explicit base surfaces
- `AppNavigationBar` - Bar background (when fixed)

---

### 2. Tonal / Secondary Surface

**Purpose**: Medium-priority surfaces for selected/active states

- **Use for**: Selected filter tags, navigation item selection, secondary actions, active toggle states
- **Priority Level**: 2
- **Variant Enum**: `SurfaceVariant.tonal`
- **Theme Property**: `theme.surfaceSecondary`

#### Implementation per Theme

**Glass Theme**
- Light: Tinted frost with moderate blur (alpha: 0.12, blur: 15.0)
- Dark: Darker tinted frost (alpha: 0.25, blur: 15.0)
- Intent: Visible but still subtle, maintaining glass aesthetic

**Brutal Theme**
- Solid grey with 2px border
- Slightly darker than base (#D9D9D9 light / #4D4D4D dark)
- Sharp corners (radius: 0.0)
- Intent: Bold distinction while maintaining geometric style

**Flat Theme**
- Light: Material 3 `secondaryContainer` color
- Dark: Material 3 `secondaryContainer` color (darker shade)
- 1px border with secondary color
- Intent: Clear Material 3 hierarchy

**Neumorphic Theme**
- Light: Same as base but with subtle highlight shadow
- Dark: Raised appearance with shallow convex shadow
- Soft rounded corners (radius: 8.0)
- Intent: Pressed/active tactile state

**Pixel Theme**
- Light: #E8E8E8 with grid pattern
- Dark: #2E2E2E with grid pattern
- 1px border
- Sharp corners (radius: 0.0)
- Intent: Retro button-press appearance

#### Example Code

```dart
// Filter tags with selection state
class FilterTags extends StatefulWidget {
  @override
  State<FilterTags> createState() => _FilterTagsState();
}

class _FilterTagsState extends State<FilterTags> {
  final selectedFilters = <String>{'Flutter'};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        AppTag(
          label: '#Flutter',
          isSelected: selectedFilters.contains('Flutter'),
          onTap: () => setState(() {
            selectedFilters.toggle('Flutter');
          }),
        ),
        AppTag(
          label: '#Design',
          isSelected: selectedFilters.contains('Design'),
          onTap: () => setState(() {
            selectedFilters.toggle('Design');
          }),
        ),
      ],
    );
  }
}

// Secondary action button
AppButton(
  label: 'Save Draft',
  variant: SurfaceVariant.tonal,
  onTap: () => saveDraft(),
)

// Navigation item selection (automatic via AppNavigationBar)
AppNavigationBar(
  currentIndex: selectedIndex,
  onTap: (index) => setState(() => selectedIndex = index),
  items: [
    AppNavigationItem(icon: Icons.home, label: 'Home'),
    AppNavigationItem(icon: Icons.search, label: 'Search'),
    AppNavigationItem(icon: Icons.favorite, label: 'Favorites'),
  ],
)
```

#### Affected Components

- `AppTag` - When `isSelected: true`
- `AppButton` - When `variant: SurfaceVariant.tonal`
- `AppNavigationBar` - Selected item pill indicator
- `AppSurface(variant: SurfaceVariant.tonal)` - Explicit tonal surfaces
- Filter or toggle components with active state

---

### 3. Accent / Tertiary Surface

**Purpose**: Decorative or special emphasis surfaces

- **Use for**: Badges, accent indicators, special status, decorative elements
- **Priority Level**: 2.5 (Special emphasis)
- **Variant Enum**: `SurfaceVariant.accent`
- **Theme Property**: `theme.surfaceTertiary`

#### Implementation per Theme

**Glass Theme**
- Warm/cool tint derived from tertiary palette
- Higher blur and alpha for accent effect
- Intent: Decorative and distinct from base/tonal

**Brutal Theme**
- Grey with accent-colored border (from tertiary palette)
- Maintains geometric style
- Intent: Accent through border color instead of fill

**Flat Theme**
- Material 3 tertiary palette colors
- Solid fill with complementary color
- Intent: Vibrant accent with Material 3 semantics

**Neumorphic Theme**
- Tertiary color with tactile shadow effect
- Raised or embossed appearance
- Intent: Decorative with tactile distinction

**Pixel Theme**
- Tertiary color with pixel-grid overlay
- Retro color palette applied
- Intent: Decorative with pixel aesthetic

#### Example Code

```dart
// Badge with accent surface
AppSurface(
  variant: SurfaceVariant.accent,
  shape: BoxShape.circle,
  width: 32,
  height: 32,
  child: Center(
    child: AppText('3', textAlign: TextAlign.center),
  ),
)

// Status indicator
AppSurface(
  variant: SurfaceVariant.accent,
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  child: AppText('New', style: TextStyle(fontSize: 12)),
)
```

#### Affected Components

- `AppBadge` - Badge backgrounds
- `AppIcon` - When marked with accent status
- `AppChip` - Special chips requiring distinction
- Custom components needing decorative surfaces

---

### 4. Elevated Surface

**Purpose**: High-priority floating context elements

- **Use for**: Modals, dialogs, tooltips, floating UI, popovers
- **Priority Level**: 3
- **Variant Enum**: `SurfaceVariant.elevated`
- **Theme Property**: `theme.surfaceElevated`

#### Implementation per Theme

**Glass Theme**
- Stronger blur and opacity for floating effect
- Typically lighter than base
- Intent: Distinct floating layer above content

**Brutal Theme**
- Thicker border (3-4px) for emphasis
- Elevated appearance through shadow
- Intent: Strong distinction for modals/dialogs

**Flat Theme**
- Material 3 `surfaceBright` or lighter color
- Elevated through color alone (no shadow)
- Intent: Clean Material elevation

**Neumorphic Theme**
- Pronounced outset shadow for floating effect
- Light color with strong shadow
- Intent: Physically raised appearance

**Pixel Theme**
- Grid overlay with elevated shadow
- Slightly lighter color
- Intent: Retro floating window appearance

#### Example Code

```dart
// Modal dialog
showDialog(
  context: context,
  builder: (context) => Dialog(
    child: AppSurface(
      variant: SurfaceVariant.elevated,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText('Dialog Title', variant: TextVariant.titleLarge),
          const SizedBox(height: 16),
          AppText('Dialog content'),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(label: 'Cancel', variant: SurfaceVariant.base),
              const SizedBox(width: 8),
              AppButton(label: 'Confirm', variant: SurfaceVariant.highlight),
            ],
          ),
        ],
      ),
    ),
  ),
)

// Tooltip background
Tooltip(
  message: 'Help text',
  decoration: BoxDecoration(
    // Use elevated style for tooltip
  ),
  child: AppIcon(Icons.help),
)
```

#### Affected Components

- `AppDialog` - Dialog backgrounds
- `AppModal` - Modal backgrounds
- `AppTooltip` - Tooltip backgrounds
- Popup menus and popovers
- Floating action button containers

---

### 5. Highlight Surface

**Purpose**: Maximum-priority actions and CTAs

- **Use for**: Primary buttons, main actions, critical CTAs, call-to-action elements
- **Priority Level**: 4 (Highest)
- **Variant Enum**: `SurfaceVariant.highlight`
- **Theme Property**: `theme.surfaceHighlight`

#### Implementation per Theme

**Glass Theme**
- Bright, saturated color through tint
- Maximum blur to draw attention
- Intent: Eye-catching action surface

**Brutal Theme**
- Bold color with thickest border (3px)
- Maximum contrast
- Intent: Command attention through boldness

**Flat Theme**
- Saturated Material 3 primary color
- Maximum visual weight
- Intent: Clear primary action

**Neumorphic Theme**
- Bright color with most pronounced shadow
- Maximum tactile raised effect
- Intent: Strong visual and tactile CTA

**Pixel Theme**
- Saturated retro color palette
- Grid overlay for consistency
- Intent: Vibrant, attention-grabbing action

#### Example Code

```dart
// Primary CTA button (default)
AppButton(label: 'Create New', onTap: () => createNew())

// Explicit highlight variant
AppButton(
  label: 'Delete Permanently',
  variant: SurfaceVariant.highlight,
  onTap: () => deleteItem(),
)

// Custom highlighted surface
AppSurface(
  variant: SurfaceVariant.highlight,
  height: 56,
  child: Center(
    child: AppText(
      'Click to Start',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
)
```

#### Affected Components

- `AppButton` - Default variant
- Primary action buttons in dialogs/forms
- Main call-to-action elements
- Critical system actions requiring user attention

---

## Decision Tree: Which Surface to Use?

```
┌─ What is this element's purpose?
│
├─ Is it a PRIMARY action or CTA?
│  └─→ Use HIGHLIGHT (SurfaceVariant.highlight)
│      Examples: "Create", "Submit", "Delete Permanently"
│
├─ Is it a SECONDARY action or SELECTED STATE?
│  └─→ Use TONAL (SurfaceVariant.tonal)
│      Examples: "Save Draft", Selected nav item, Active filter tag
│
├─ Is it a DECORATIVE or SPECIAL element?
│  └─→ Use ACCENT (SurfaceVariant.accent)
│      Examples: Badges, Status indicators, Special emphasis
│
├─ Is it a FLOATING or ELEVATED context?
│  └─→ Use ELEVATED (SurfaceVariant.elevated)
│      Examples: Modals, Dialogs, Tooltips, Popovers
│
└─ Is it a DEFAULT or BACKGROUND element?
   └─→ Use BASE (SurfaceVariant.base)
       Examples: Cards, Lists, Panels, Neutral containers
```

---

## Migration Examples

### From Old Pattern to Semantic Colors

#### Before: Button Styling Without Clear Hierarchy

```dart
// Old: Color is hardcoded, hierarchy unclear
Container(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('Click Me'),
)
```

#### After: Clear Semantic Intent

```dart
// New: Semantic variant makes hierarchy explicit
AppButton(
  label: 'Click Me',
  variant: SurfaceVariant.highlight,  // Primary action
  onTap: () {},
)
```

---

#### Before: Selection State With Ad-hoc Styling

```dart
// Old: Selection state requires manual style switching
Container(
  decoration: BoxDecoration(
    color: isSelected ? Colors.purple : Colors.grey,
    borderRadius: BorderRadius.circular(4),
  ),
  child: Text(label),
)
```

#### After: Automatic Selection Styling

```dart
// New: Semantic surface switches automatically
AppTag(
  label: '#Flutter',
  isSelected: isSelected,  // Automatically uses tonal when true
  onTap: () => toggleSelection(),
)
```

---

#### Before: Navigation Without Visual Priority

```dart
// Old: No clear visual distinction for selected item
Row(
  children: items.map((item) => Container(
    color: currentIndex == item.index ? Colors.blue : Colors.transparent,
    child: Text(item.label),
  )).toList(),
)
```

#### After: Semantic Navigation Bar

```dart
// New: Pill-shaped tonal indicator for selected item
AppNavigationBar(
  currentIndex: currentIndex,
  onTap: (index) => setIndex(index),
  items: items,
)
```

---

## Theme-Specific Considerations

### Glass Theme
- **Strength**: Elegant, modern appearance with blur effects
- **Use when**: Building premium, contemporary interfaces
- **Consideration**: Blur effects add computational cost on lower-end devices
- **Content color**: Typically light/dark text contrasting with frosted background

### Brutal Theme
- **Strength**: Bold, geometric clarity
- **Use when**: Building stark, high-contrast interfaces
- **Consideration**: Strong borders may feel heavy in dense UIs
- **Content color**: High contrast - typically black on light, white on dark

### Flat Theme
- **Strength**: Familiar Material 3 paradigm
- **Use when**: Building standard Android-aligned interfaces
- **Consideration**: Relies on color alone for distinction
- **Content color**: Material 3 semantic colors (onPrimary, onSecondary, etc.)

### Neumorphic Theme
- **Strength**: Soft, tactile, embossed appearance
- **Use when**: Building warm, approachable interfaces
- **Consideration**: Shadows and highlights may reduce readability in some contexts
- **Content color**: Medium-contrast text for legibility over embossed surfaces

### Pixel Theme
- **Strength**: Retro, nostalgic, unique aesthetic
- **Use when**: Building playful, game-like interfaces
- **Consideration**: Grid overlay may clash with high-detail graphics
- **Content color**: Retro color palette - typically bold and saturated

---

## Code Quality Checklist

- [x] Surface variants chosen based on priority level
- [x] Consistency across all 5 themes
- [x] Components using semantic variants instead of hardcoded colors
- [x] Migration from color-based to semantic-based styling
- [x] Documentation of variant purpose and usage

---

## Performance Considerations

### Blur Effects (Glass Theme)
- Glassmorphic blur reduces frame rate on low-end devices
- Test on target devices, especially for animated surfaces
- Consider reducing blur strength on mobile devices

### Shadow Calculations (Neumorphic Theme)
- Multiple shadows increase rendering cost
- Avoid excessive nesting of shadowed surfaces
- Profile on target devices

### Grid Overlays (Pixel Theme)
- Pattern overlay adds texture processing
- Minimal performance impact on modern devices
- Consider disabling on very low-end targets

---

## Related Documentation

- **quickstart.md** - Quick reference for common usage patterns
- **plan.md** - Implementation architecture and design decisions
- **data-model.md** - Design system data model
- **research.md** - Theme research and aesthetic analysis

---

## Quick Reference Table

| Surface | Variant | Priority | Use Case | Theme Property |
|---------|---------|----------|----------|-----------------|
| Base | `.base` | 1 (Lowest) | Default backgrounds | `theme.surfaceBase` |
| Tonal | `.tonal` | 2 | Selection & secondary | `theme.surfaceSecondary` |
| Accent | `.accent` | 2.5 | Decorative & badges | `theme.surfaceTertiary` |
| Elevated | `.elevated` | 3 | Floating context | `theme.surfaceElevated` |
| Highlight | `.highlight` | 4 (Highest) | Primary actions | `theme.surfaceHighlight` |

---

## Questions & Support

For questions about surface styles usage or theme customization:
1. Check quickstart.md for common patterns
2. Review component examples in this guide
3. Examine widgetbook dashboard for live theme previews
4. Consult theme implementation files for design-language-specific details
