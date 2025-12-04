import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppStepper', () {
    final steps = [
      const StepperStep(
        id: 'step-1',
        label: 'Personal Info',
        description: 'Enter your name and email',
      ),
      const StepperStep(
        id: 'step-2',
        label: 'Address',
        description: 'Enter your address details',
      ),
      const StepperStep(
        id: 'step-3',
        label: 'Confirmation',
        description: 'Review and confirm',
      ),
    ];

    testWidgets('renders without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(steps: steps),
            ),
          ),
        ),
      );

      expect(find.byType(AppStepper), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('displays all steps with labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(steps: steps),
            ),
          ),
        ),
      );

      // Check that all step labels are visible
      for (final step in steps) {
        expect(find.text(step.label), findsOneWidget);
      }
    });

    testWidgets('displays step descriptions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(steps: steps),
            ),
          ),
        ),
      );

      // Check that descriptions are visible
      expect(find.text('Enter your details'), findsOneWidget);
      expect(find.text('Enter your address'), findsOneWidget);
    });

    testWidgets('shows current step as active', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(
                steps: steps,
                currentStep: 1,
              ),
            ),
          ),
        ),
      );

      // Step 2 label should be visible and should be the current one
      expect(find.text('Address'), findsOneWidget);
    });

    testWidgets('marks completed steps', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(
                steps: steps,
                currentStep: 2,
                completedSteps: {0, 1},
              ),
            ),
          ),
        ),
      );

      // Completed steps should show checkmark icon
      expect(find.byIcon(Icons.check), findsWidgets);
    });

    testWidgets('calls onStepTapped when step is tapped', (WidgetTester tester) async {
      int? tappedStep;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(
                steps: steps,
                currentStep: 0,
                onStepTapped: (step) => tappedStep = step,
                interactive: true,
              ),
            ),
          ),
        ),
      );

      // Tap on the second step
      await tester.tap(find.text('Address'));
      await tester.pumpAndSettle();

      expect(tappedStep, 1);
    });

    testWidgets('does not call onStepTapped when interactive is false', (WidgetTester tester) async {
      int? tappedStep;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(
                steps: steps,
                currentStep: 0,
                onStepTapped: (step) => tappedStep = step,
                interactive: false,
              ),
            ),
          ),
        ),
      );

      // Try to tap on a step - should not trigger callback
      await tester.tap(find.text('Address'));
      await tester.pumpAndSettle();

      expect(tappedStep, isNull);
    });

    testWidgets('renders vertical stepper variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(
                steps: steps,
                variant: StepperVariant.vertical,
              ),
            ),
          ),
        ),
      );

      // Check that all steps are displayed vertically
      for (final step in steps) {
        expect(find.text(step.label), findsOneWidget);
      }
    });

    testWidgets('renders horizontal stepper variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(
                steps: steps,
                variant: StepperVariant.horizontal,
              ),
            ),
          ),
        ),
      );

      // Check that all steps are displayed horizontally
      for (final step in steps) {
        expect(find.text(step.label), findsOneWidget);
      }
    });

    testWidgets('disables steps when enabled is false', (WidgetTester tester) async {
      int? tappedStep;
      final disabledSteps = [
        const StepperStep(
          id: 'step-1',
          label: 'Step 1',
          enabled: true,
        ),
        const StepperStep(
          id: 'step-2',
          label: 'Step 2',
          enabled: false,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(
                steps: disabledSteps,
                onStepTapped: (step) => tappedStep = step,
              ),
            ),
          ),
        ),
      );

      // Try to tap disabled step
      await tester.tap(find.text('Step 2'));
      await tester.pumpAndSettle();

      // Should not trigger callback
      expect(tappedStep, isNull);
    });

    testWidgets('handles empty steps list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AppStepper(steps: const []),
            ),
          ),
        ),
      );

      // Should render without error and display SizedBox.shrink
      expect(find.byType(AppStepper), findsOneWidget);
    });

    testWidgets('supports rendering 2 steps', (WidgetTester tester) async {
      final twoSteps = [
        const StepperStep(id: 's1', label: 'S1'),
        const StepperStep(id: 's2', label: 'S2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AppStepper(
                  steps: twoSteps,
                  variant: StepperVariant.vertical,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AppStepper), findsOneWidget);
      expect(find.text('S1'), findsOneWidget);
      expect(find.text('S2'), findsOneWidget);
    });
  });
}
