# Quickstart Guide: Interaction & Navigation Components

**Duration**: 5-10 minutes
**Related**: [data-model.md](data-model.md) | [contracts/](contracts/)

This guide provides copy-paste examples for each of the 8 navigation and interaction components.

---

## 1. AppBottomSheet - Quick Start

**Use Case**: Display secondary options or additional content without navigation

```dart
// Basic usage
showModalBottomSheet(
  context: context,
  builder: (context) => AppBottomSheet(
    maxHeight: MediaQuery.of(context).size.height * 0.7,
    child: Column(
      children: [
        ListTile(
          title: Text('Option 1'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          title: Text('Option 2'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    ),
  ),
);
```

**Common Customizations**:

```dart
// Custom height
maxHeight: 400,

// Draggable dismissal
enableDrag: true,
isDismissible: true,

// Handle dismiss event
onDismiss: () => print('Dismissed'),
```

**Theme Customization**: The component automatically adapts to Glass, Brutal, Pixel, etc. themes via `AppDesignTheme`.

---

## 2. AppDrawer / AppSideSheet - Quick Start

**Use Case**: Navigation menu or side content panel

```dart
// Basic drawer
Scaffold(
  drawer: AppDrawer(
    width: 250,
    child: ListView(
      children: [
        DrawerHeader(child: Text('Menu')),
        ListTile(
          title: Text('Home'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          title: Text('Settings'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    ),
  ),
  body: YourContent(),
)

// Or use AppSideSheet for web-style sidebars
AppSideSheet(
  position: SheetPosition.left,
  isPersistent: true,
  width: 300,
  child: NavigationContent(),
)
```

**Key Properties**:

```dart
// Position
position: SheetPosition.left,  // or right

// Behavior
isPersistent: false,           // true = always visible
isDismissible: true,           // false = can't dismiss

// Styling automatically follows theme
```

---

## 3. AppTabs - Quick Start

**Use Case**: Switch between parallel content sections

```dart
// Basic tab implementation
AppTabs(
  tabs: [
    TabItem(
      label: 'All',
      content: ListView(children: [...]),
    ),
    TabItem(
      label: 'Favorites',
      content: ListView(children: [...]),
    ),
    TabItem(
      label: 'Recent',
      content: ListView(children: [...]),
    ),
  ],
  onTabChanged: (index) {
    print('Switched to tab $index');
  },
)
```

**Customization**:

```dart
// Different display styles
displayMode: TabDisplayMode.underline,  // or segmented, scrollable

// Start on different tab
initialIndex: 1,

// Styling
style: TabsStyle(...),  // Optional, uses theme default
```

---

## 4. AppStepper - Quick Start

**Use Case**: Show progress through a multi-step process

```dart
// Basic stepper
AppStepper(
  steps: [
    StepItem(title: 'Personal Info'),
    StepItem(title: 'Address'),
    StepItem(title: 'Payment'),
    StepItem(title: 'Review'),
  ],
  currentStep: 0,
  completedSteps: {},
  onStepTapped: (step) {
    setState(() {
      currentStep = step;
    });
  },
)
```

**Showing progress**:

```dart
// Mark steps as completed
AppStepper(
  currentStep: 2,
  completedSteps: {0, 1},  // Steps 1 and 2 are done
  steps: [
    StepItem(title: 'Step 1'),
    StepItem(title: 'Step 2'),
    StepItem(title: 'Step 3 (Current)', description: 'Fill in details'),
    StepItem(title: 'Step 4'),
  ],
)
```

**Linear vs Non-Linear**:

```dart
// Linear: must complete steps in order
type: StepperType.linear,

// Non-Linear: can jump to any step
type: StepperType.nonLinear,
```

---

## 5. AppBreadcrumb - Quick Start

**Use Case**: Show navigation hierarchy

```dart
// Basic breadcrumb
AppBreadcrumb(
  items: [
    BreadcrumbItem(
      label: 'Home',
      onTap: () => Navigator.pushNamed(context, '/'),
    ),
    BreadcrumbItem(
      label: 'Products',
      onTap: () => Navigator.pushNamed(context, '/products'),
    ),
    BreadcrumbItem(
      label: 'Electronics',
      onTap: () => Navigator.pushNamed(context, '/products/electronics'),
    ),
    BreadcrumbItem(
      label: 'Laptop',
      isCurrentLocation: true,  // Current page
    ),
  ],
)
```

**Handle overflow**:

```dart
// At small widths, show ellipsis or scroll
AppBreadcrumb(
  items: longBreadcrumbPath,
  overflowBehavior: BreadcrumbOverflowBehavior.ellipsis,  // or scroll, wrap
)
```

---

## 6. AppExpansionPanel - Quick Start

**Use Case**: Organize collapsible content sections (FAQ, settings, etc.)

```dart
// Basic expansion panel
AppExpansionPanel(
  panels: [
    ExpansionPanel(
      headerTitle: 'General Settings',
      content: Column(
        children: [
          CheckboxListTile(title: Text('Enable Notifications')),
          CheckboxListTile(title: Text('Dark Mode')),
        ],
      ),
    ),
    ExpansionPanel(
      headerTitle: 'Privacy',
      content: Column(
        children: [
          CheckboxListTile(title: Text('Share Profile')),
        ],
      ),
    ),
  ],
)
```

**Control what's open**:

```dart
// Start with first panel open
initialExpandedIndices: {0},

// Allow multiple panels open
allowMultipleOpen: true,

// Listen for changes
onPanelToggled: (index) {
  print('Panel $index toggled');
},
```

---

## 7. AppCarousel - Quick Start

**Use Case**: Display sequential items (images, onboarding slides, etc.)

```dart
// Basic carousel
AppCarousel(
  itemCount: 5,
  itemHeight: 300,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.blue,
      child: Center(child: Text('Item $index')),
    );
  },
)
```

**With navigation controls**:

```dart
// Show previous/next buttons
AppCarousel(
  itemCount: imageUrls.length,
  itemHeight: 400,
  itemBuilder: (context, index) => Image.network(imageUrls[index]),
  showNavigationButtons: true,
  onIndexChanged: (index) {
    print('Now showing item $index');
  },
)
```

**Auto-play**:

```dart
// Automatically advance items
enableAutoPlay: true,
autoPlayDuration: Duration(seconds: 3),
```

---

## 8. AppChipGroup - Quick Start

**Use Case**: Quick filtering or multi-select tags

```dart
// Single-select chips
AppChipGroup(
  chips: [
    ChipItem(label: 'All'),
    ChipItem(label: 'Published'),
    ChipItem(label: 'Draft'),
    ChipItem(label: 'Archived'),
  ],
  allowMultiSelect: false,
  onSelectionChanged: (selected) {
    setState(() {
      filterBy = selected.first;
    });
  },
)
```

**Multi-select**:

```dart
// Multiple chips can be selected
AppChipGroup(
  chips: [
    ChipItem(label: 'Flutter'),
    ChipItem(label: 'Dart'),
    ChipItem(label: 'iOS'),
    ChipItem(label: 'Android'),
  ],
  allowMultiSelect: true,
  initialSelectedIndices: {0, 1},  // Preselect Flutter and Dart
  onSelectionChanged: (selected) {
    print('Selected indices: $selected');
  },
)
```

**Handle overflow**:

```dart
// Wrap chips to multiple lines
layout: ChipGroupLayout.wrap,

// Or scroll horizontally
layout: ChipGroupLayout.scroll,
scrollDirection: Axis.horizontal,
```

---

## Using Components Together

### Example: Multi-Step Checkout Flow

```dart
class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Progress indicator
          AppStepper(
            steps: [
              StepItem(title: 'Cart'),
              StepItem(title: 'Shipping'),
              StepItem(title: 'Payment'),
              StepItem(title: 'Review'),
            ],
            currentStep: currentStep,
            completedSteps: _getCompletedSteps(),
          ),

          // Content based on step
          Expanded(
            child: _buildStepContent(),
          ),

          // Navigation buttons
          Row(
            children: [
              AppButton(
                onPressed: currentStep > 0 ? () => _previousStep() : null,
                label: 'Back',
              ),
              Spacer(),
              AppButton(
                onPressed: currentStep < 3 ? () => _nextStep() : null,
                label: currentStep == 3 ? 'Place Order' : 'Continue',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _cartStep();
      case 1:
        return _shippingStep();
      case 2:
        return _paymentStep();
      case 3:
        return _reviewStep();
      default:
        return SizedBox();
    }
  }

  // Step implementations...
}
```

---

## Testing Components

### Unit Test Example

```dart
testWidgets('AppTabs switches content', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: AppTabs(
          tabs: [
            TabItem(label: 'Tab 1', content: Text('Content 1')),
            TabItem(label: 'Tab 2', content: Text('Content 2')),
          ],
        ),
      ),
    ),
  );

  // Initially first tab is active
  expect(find.text('Content 1'), findsOneWidget);
  expect(find.text('Content 2'), findsNothing);

  // Tap second tab
  await tester.tap(find.text('Tab 2'));
  await tester.pumpAndSettle();

  // Now second content appears
  expect(find.text('Content 1'), findsNothing);
  expect(find.text('Content 2'), findsOneWidget);
});
```

### Golden Test Example

```dart
// Golden tests automatically generated for all 8 theme combinations
// Place in: test/molecules/tabs_golden_test.dart

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppTabs Golden Tests', () {
    goldenTest(
      'AppTabs - Default State',
      fileName: 'app_tabs_default',
      builder: () => buildThemeMatrix(
        name: 'Default State',
        width: 300.0,
        height: 200.0,
        child: AppTabs(
          tabs: [
            TabItem(label: 'All', content: SizedBox()),
            TabItem(label: 'Active', content: SizedBox()),
          ],
        ),
      ),
    );
  });
}
```

---

## Styling & Theming

All components automatically adapt to the active theme:

```dart
// Global theme switch - components update instantly
final theme = AppDesignTheme.glass(brightness: Brightness.dark);

// In MaterialApp
MaterialApp(
  theme: ThemeData(extensions: [theme]),
  home: YourApp(),
)
```

**No component code changes needed** - theme switching is automatic!

---

## Accessibility Notes

All components include:

```dart
// Screen reader support
// - Components announce their state (e.g., "Tab 2 of 3, selected")
// - All interactive elements have accessible labels

// Keyboard navigation
// - Arrow keys navigate tabs
// - Enter/Space activates selections
// - Tab key moves focus between components

// Touch targets
// - All interactive areas ≥ 48x48 dp
// - Proper touch feedback (ripple/highlight)
```

---

## Performance Tips

- **Large Lists**: Use `ListView.builder()` in carousel to avoid rendering all items
- **Animations**: Animations use GPU acceleration for smooth performance (60 FPS)
- **Theme Switching**: Instant theme changes with no component recompilation needed
- **Memory**: Components dispose resources properly (no leaks)

---

## Next Steps

1. **Review Data Model**: Check [data-model.md](data-model.md) for complete API reference
2. **Check Component Contracts**: See [contracts/](contracts/) for formal API signatures
3. **View Widgetbook**: Run Widgetbook to see all components in action (`cd widgetbook && flutter run`)
4. **Run Tests**: Execute golden tests to verify visual consistency (`flutter test --tags golden`)

---

## Common Issues

**Q: Tabs not switching content?**
A: Ensure `onTabChanged` callback calls `setState()` to rebuild the widget.

**Q: Carousel items not showing?**
A: Check that `itemBuilder` returns a widget with explicit width/height constraints.

**Q: Theme changes not applying?**
A: Verify theme is set in `MaterialApp.builder` or passed via `Theme.of(context)`.

**Q: Keyboard navigation not working?**
A: Components should have `autofocus: true` on initial mount.

---

**Questions?** See the full [data-model.md](data-model.md) and component contracts for detailed documentation.
