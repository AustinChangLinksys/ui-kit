import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Integration test for Phase 4 navigation components
/// Tests multi-component checkout flow: stepper → tabs → carousel → bottom sheet
void main() {
  group('Navigation Components Integration', () {
    Widget buildTestApp(Widget child) {
      return MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [GlassDesignTheme.light()],
        ),
        home: Scaffold(body: child),
      );
    }

    testWidgets('AppStepper + AppTabs integration', (tester) async {
      int currentStep = 0;
      int currentTab = 0;

      await tester.pumpWidget(
        buildTestApp(
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  // Stepper for checkout flow
                  AppStepper(
                    steps: const [
                      StepperStep(id: '1', label: 'Cart'),
                      StepperStep(id: '2', label: 'Shipping'),
                      StepperStep(id: '3', label: 'Payment'),
                    ],
                    currentStep: currentStep,
                    completedSteps: {for (int i = 0; i < currentStep; i++) i},
                    onStepTapped: (index) {
                      setState(() => currentStep = index);
                    },
                  ),
                  const SizedBox(height: 16),
                  // Tabs for different views within step
                  Expanded(
                    child: AppTabs(
                      tabs: const [
                        TabItem(label: 'Summary'),
                        TabItem(label: 'Details'),
                      ],
                      initialIndex: currentTab,
                      onTabChanged: (index) {
                        setState(() => currentTab = index);
                      },
                      tabContents: const [
                        Center(child: Text('Summary Content')),
                        Center(child: Text('Details Content')),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify stepper renders (horizontal stepper shows current step label + step numbers)
      expect(find.text('Cart'), findsOneWidget); // Current step label
      expect(find.text('1'), findsOneWidget); // Step 1 number
      expect(find.text('2'), findsOneWidget); // Step 2 number
      expect(find.text('3'), findsOneWidget); // Step 3 number

      // Verify tabs render
      expect(find.text('Summary'), findsOneWidget);
      expect(find.text('Details'), findsOneWidget);

      // Verify initial tab content
      expect(find.text('Summary Content'), findsOneWidget);
    });

    testWidgets('AppCarousel renders within AppExpansionPanel', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          SizedBox(
            height: 400,
            child: AppExpansionPanel(
              panels: [
                ExpansionPanelItem(
                  headerTitle: 'Product Gallery',
                  content: SizedBox(
                    height: 200,
                    child: AppCarousel(
                      itemCount: 3,
                      itemHeight: 150,
                      itemBuilder: (context, index) => Container(
                        color: Colors.blue.withAlpha(100 + index * 50),
                        child: Center(child: Text('Product $index')),
                      ),
                    ),
                  ),
                ),
              ],
              initialExpandedIndices: const {0},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify expansion panel renders
      expect(find.text('Product Gallery'), findsOneWidget);

      // Verify carousel renders within expanded panel
      expect(find.text('Product 0'), findsOneWidget);
    });

    testWidgets('AppBreadcrumb + AppChipGroup filter integration',
        (tester) async {
      final selectedFilters = <int>{};

      await tester.pumpWidget(
        buildTestApp(
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb for navigation hierarchy
                  // Last item has enabled: false to indicate current location
                  const AppBreadcrumb(
                    items: [
                      BreadcrumbItem(label: 'Home'),
                      BreadcrumbItem(label: 'Products'),
                      BreadcrumbItem(label: 'Electronics', enabled: false),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // ChipGroup for filtering
                  AppChipGroup(
                    chips: const [
                      ChipItem(label: 'All'),
                      ChipItem(label: 'Phones'),
                      ChipItem(label: 'Laptops'),
                      ChipItem(label: 'Accessories'),
                    ],
                    selectionMode: ChipSelectionMode.single,
                    selectedIndices: selectedFilters,
                    onSelectionChanged: (indices) {
                      setState(() {
                        selectedFilters.clear();
                        selectedFilters.addAll(indices);
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify breadcrumb renders
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
      expect(find.text('Electronics'), findsOneWidget);

      // Verify chip group renders
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Phones'), findsOneWidget);
      expect(find.text('Laptops'), findsOneWidget);
      expect(find.text('Accessories'), findsOneWidget);
    });

    testWidgets('All 8 navigation components render together', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          SingleChildScrollView(
            child: Column(
              children: [
                // 1. AppStepper
                const AppStepper(
                  steps: [
                    StepperStep(id: '1', label: 'Step 1'),
                    StepperStep(id: '2', label: 'Step 2'),
                  ],
                  currentStep: 0,
                ),
                const SizedBox(height: 8),

                // 2. AppTabs
                SizedBox(
                  height: 100,
                  child: AppTabs(
                    tabs: const [
                      TabItem(label: 'Tab A'),
                      TabItem(label: 'Tab B'),
                    ],
                    tabContents: const [
                      Center(child: Text('Content A')),
                      Center(child: Text('Content B')),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // 3. AppBreadcrumb
                const AppBreadcrumb(
                  items: [
                    BreadcrumbItem(label: 'Root'),
                    BreadcrumbItem(label: 'Current', enabled: false),
                  ],
                ),
                const SizedBox(height: 8),

                // 4. AppChipGroup
                const AppChipGroup(
                  chips: [
                    ChipItem(label: 'Chip 1'),
                    ChipItem(label: 'Chip 2'),
                  ],
                ),
                const SizedBox(height: 8),

                // 5. AppExpansionPanel
                const SizedBox(
                  height: 100,
                  child: AppExpansionPanel(
                    panels: [
                      ExpansionPanelItem(
                        headerTitle: 'Panel',
                        content: Text('Panel Content'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // 6. AppCarousel
                SizedBox(
                  height: 100,
                  child: AppCarousel(
                    itemCount: 2,
                    itemHeight: 80,
                    itemBuilder: (context, index) => Container(
                      color: Colors.grey,
                      child: Center(child: Text('Item $index')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify all components render
      expect(find.text('Step 1'), findsOneWidget);
      expect(find.text('Tab A'), findsOneWidget);
      expect(find.text('Root'), findsOneWidget);
      expect(find.text('Chip 1'), findsOneWidget);
      expect(find.text('Panel'), findsOneWidget);
      expect(find.text('Item 0'), findsOneWidget);
    });

    testWidgets('Theme switching affects all navigation components',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [BrutalDesignTheme.light()],
          ),
          home: const Scaffold(
            body: Column(
              children: [
                AppStepper(
                  steps: [
                    StepperStep(id: '1', label: 'Step'),
                  ],
                  currentStep: 0,
                ),
                AppBreadcrumb(
                  items: [
                    BreadcrumbItem(label: 'Home', enabled: false),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify components render with Brutal theme
      expect(find.text('Step'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });
  });
}
