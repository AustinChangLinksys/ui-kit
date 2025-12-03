# Quickstart: Using Semantic Color Surfaces

**Feature**: Semantic Color System Upgrade (`007-semantic-colors`)
**For**: Developers integrating Tonal/Secondary and Tertiary/Accent surfaces into components

---

## What's New?

The UI Kit now supports **three semantic surface levels** instead of two:

1. **Base** (low priority) - Default surface for backgrounds, low-emphasis content
2. **Tonal** (medium priority) - Selected states, secondary actions, applied filters
3. **Highlight** (high priority) - Primary CTAs, main actions, critical elements

Additionally, **Tertiary/Accent** surfaces are available for decorative or special-purpose use.

---

## Quick Start: Using Surfaces in Components

### 1. Creating a Button with Tonal Variant

**Primary CTA (Use Highlight)**:
```dart
AppButton(
  label: 'Publish Article',
  variant: SurfaceVariant.highlight,  // ← Maximum emphasis
  onPressed: () => publishArticle(),
)
```

**Secondary Action (Use Tonal)** ← NEW:
```dart
AppButton(
  label: 'Save Draft',
  variant: SurfaceVariant.tonal,      // ← Medium emphasis
  onPressed: () => saveDraft(),
)
```

**Low-Priority Action (Use Base)**:
```dart
AppButton(
  label: 'Cancel',
  variant: SurfaceVariant.base,       // ← Low emphasis
  onPressed: () => Navigator.pop(context),
)
```

**Visual Result**: Users immediately see action priority hierarchy

---

### 2. Selected State in Navigation Bar

Navigation bar automatically shows Tonal pill-shaped indicator for selected items:

```dart
AppNavigationBar(
  items: [
    NavigationItem(icon: Icon(Icons.home), label: 'Home'),
    NavigationItem(icon: Icon(Icons.settings), label: 'Settings'),
  ],
  currentIndex: 0,  // First item selected → displays Tonal indicator
  onIndexChanged: (index) => setState(() => selectedIndex = index),
)
```

**Visual Result**: Selected item has Tonal background pill; unselected items are transparent

---

### 3. Filter Tags with Selection State ← NEW

Tags now support selection state that automatically applies Tonal styling:

```dart
// Unselected tag (Base surface)
AppTag(label: 'WiFi', isSelected: false)

// Selected tag (Tonal surface)
AppTag(label: 'WiFi', isSelected: true)
```

**In a Filter List**:
```dart
Wrap(
  children: [
    for (var filter in availableFilters)
      AppTag(
        label: filter.name,
        isSelected: selectedFilters.contains(filter),
        onTap: () => toggleFilter(filter),
      ),
  ],
)
```

**Visual Result**: Applied filters are visually distinct with Tonal background; unselected filters are subtle Base styling

---

## Understanding the Visual Hierarchy

### Three-Tier Hierarchy Pattern

```
[Base Surface] (low priority)
     ↓
[Tonal Surface] (medium priority, NEW)
     ↓
[Highlight Surface] (high priority)
```

### When to Use Each

| Surface | Use Case | Example |
|---------|----------|---------|
| **Base** | Default, non-interactive areas | Card backgrounds, disabled buttons, list items |
| **Tonal** | Selected/active states, secondary actions | Selected tab, secondary button, applied filter |
| **Highlight** | Critical actions, primary CTAs | "Publish" button, "Save" button, main action |
| **Tertiary** | (Future) Decorative, special purpose | (Not yet widely used) |

---

## Theme-Aware: Works Across All Styles

The same component code renders correctly across all design languages:

```dart
AppButton(
  label: 'Save Draft',
  variant: SurfaceVariant.tonal,
  onPressed: () => saveDraft(),
)
```

**Glass Theme**: Renders with semi-transparent tinted glass (looks premium)
**Brutal Theme**: Renders with solid grey border (looks mechanical)
**Flat Theme**: Renders with pale color fill (looks clean)
**Neumorphic Theme**: Renders with shallow convex shadow (looks tactile)
**Pixel Theme**: Renders with pixelated grid effect (looks retro)

**Switch themes at runtime** — all surfaces update automatically with zero component code changes.

---

## Advanced: Custom Surface Styling

If you need a custom surface beyond the standard variants, you can override with explicit `SurfaceStyle`:

```dart
AppSurface(
  variant: SurfaceVariant.tonal,  // Default starting point
  style: theme.surfaceSecondary.copyWith(
    borderWidth: 4.0,  // Make border thicker
    contentColor: Colors.red,  // Custom text color
  ),
  child: AppText('Custom Surface'),
)
```

**Best Practice**: Use this sparingly. Most use cases should rely on standard variants for consistency.

---

## Testing: Verifying Surfaces

### Manual Testing (Widgetbook)

1. Open **Widgetbook**: `flutter run -d chrome` in `widgetbook/` directory
2. Navigate to **Dashboard Page**
3. Verify you see three distinct button styles:
   - "Add Device" (Highlight - most prominent)
   - "Save Draft" (Tonal - medium prominence)
   - "Cancel" (Base - least prominent)
4. Switch between themes (Glass, Brutal, Flat, Neumorphic, Pixel)
5. Verify each theme's visual definitions are correct
6. Switch to Dark mode and verify colors adapt

### Automated Testing (Golden Tests)

Golden tests validate all surfaces render correctly:

```bash
flutter test --update-goldens --tags golden
```

All 24 tests should pass (3 components × 4 themes × 2 brightness modes).

---

## Migration Guide: Updating Existing Components

If you have existing buttons or components using custom styling, consider adopting semantic variants:

### Before (Old Pattern):
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.blue.withValues(alpha: 0.2),  // Hard-coded styling
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('Secondary Action'),
)
```

### After (New Pattern):
```dart
AppButton(
  label: 'Secondary Action',
  variant: SurfaceVariant.tonal,  // Theme-aware, consistent
  onPressed: () {},
)
```

**Benefits**:
- ✅ Automatic theme switching
- ✅ Consistent across all designs
- ✅ Maintains visual hierarchy
- ✅ Simpler code
- ✅ Better accessibility (clear action priority)

---

## API Reference

### SurfaceVariant Enum

```dart
enum SurfaceVariant {
  base,       // Low emphasis
  elevated,   // Floating/modal context
  highlight,  // Primary action
  tonal,      // Medium emphasis / selected (NEW)
  accent,     // Decorative / special (NEW)
}
```

### AppSurface Parameters

```dart
AppSurface(
  variant: SurfaceVariant.tonal,      // Which surface style to use
  style: SurfaceStyle?,               // Optional override
  onTap: VoidCallback?,               // Interaction handler
  interactive: bool = false,          // Enable interaction physics even without onTap
  child: Widget?,                     // Content to render
  // ... dimension parameters (height, width, padding, etc.)
)
```

### Component Variants

```dart
AppButton(
  variant: SurfaceVariant.tonal,      // NEW parameter
  // ... other parameters
)

AppTag(
  isSelected: bool = false,           // NEW parameter → auto-switches to Tonal if true
  // ... other parameters
)

AppNavigationBar(
  // Automatically shows Tonal indicator for selected item
  currentIndex: int,
  // ... other parameters
)
```

---

## Troubleshooting

### Q: My Tonal button looks the same as Base
**A**: Check that your theme is properly initialized with `surfaceSecondary` defined. Verify with widgetbook: `flutter run -d chrome` in `widgetbook/` and check Dashboard page.

### Q: I want to use a custom Tonal color
**A**: Modify the theme factory for your design language:
- Edit `lib/src/foundation/theme/design_system/styles/[your_theme]_design_theme.dart`
- Update the `surfaceSecondary` property with your desired color
- Run `dart run build_runner build --delete-conflicting-outputs`

### Q: Can I mix surfaces in the same component?
**A**: Yes, but use sparingly. Each container can use a different `SurfaceVariant`, but maintain visual hierarchy:
```dart
Column(
  children: [
    AppSurface(variant: SurfaceVariant.highlight, child: mainContent),
    AppSurface(variant: SurfaceVariant.tonal, child: secondaryContent),
    AppSurface(variant: SurfaceVariant.base, child: tertiaryContent),
  ],
)
```

### Q: How do I test my component with different surfaces?
**A**: Use widgetbook stories with variant parameters:
```dart
@WidgetbookUseCase()
Widget testTonalButton(BuildContext context) => AppButton(
  label: 'Test Tonal',
  variant: SurfaceVariant.tonal,
);
```

---

## Design Principles

1. **Ask the theme, not the component**: Components never check `if (theme is GlassTheme)`. Instead, they ask the theme "What should surfaceSecondary look like?" and render accordingly.

2. **Consistent hierarchy everywhere**: Base → Tonal → Highlight ordering is maintained across all themes and components.

3. **Physics respects aesthetic**: Each theme's physics (Glass blur, Brutal borders, etc.) is preserved for Tonal surfaces.

4. **Opt-in, not breaking**: Existing components continue to work without changes. New functionality is opt-in via `variant` parameters.

---

## Next Steps

- **Learn More**: See [plan.md](./plan.md) for implementation details
- **Data Model**: Read [data-model.md](./data-model.md) for entity relationships
- **Research**: Check [research.md](./research.md) for design decisions and rationale

---

## Support

For questions or issues with semantic surfaces:
1. Check widgetbook Dashboard page for visual reference
2. Review existing component implementations (AppButton, AppNavigationBar, AppTag)
3. Consult [plan.md](./plan.md) section 1.4 for component integration patterns
