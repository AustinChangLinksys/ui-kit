import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../../test_utils/theme_matrix_builder.dart';

void main() {
  group('AppStepper Golden Tests', () {
    final steps = [
      const StepperStep(
        id: 'step-1',
        label: 'Personal Info',
        description: 'Enter your details',
      ),
      const StepperStep(
        id: 'step-2',
        label: 'Address',
        description: 'Enter your address',
      ),
      const StepperStep(
        id: 'step-3',
        label: 'Payment',
        description: 'Enter payment details',
      ),
      const StepperStep(
        id: 'step-4',
        label: 'Review',
        description: 'Review and confirm',
      ),
      const StepperStep(
        id: 'step-5',
        label: 'Confirmation',
        description: 'Order confirmed',
      ),
    ];

    /// Scenario 1: First step (pending state)
    goldenTest(
      'renders horizontal stepper - Step 1 of 5 (pending state)',
      fileName: 'app_stepper_horizontal_step1',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: buildThemeMatrix(
          builder: (context, brightness) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppText(
                  'Step 1/5 - Pending',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppStepper(
                    steps: steps,
                    currentStep: 0,
                    completedSteps: const {},
                    variant: StepperVariant.horizontal,
                  ),
                ),
              ),
            ],
          ),
          width: 400,
          height: 300,
        ),
      ),
    );

    /// Scenario 2: Middle step (active state)
    goldenTest(
      'renders horizontal stepper - Step 3 of 5 (active state)',
      fileName: 'app_stepper_horizontal_step3',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: buildThemeMatrix(
          builder: (context, brightness) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppText(
                  'Step 3/5 - Active',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppStepper(
                    steps: steps,
                    currentStep: 2,
                    completedSteps: {0, 1},
                    variant: StepperVariant.horizontal,
                  ),
                ),
              ),
            ],
          ),
          width: 400,
          height: 300,
        ),
      ),
    );

    /// Scenario 3: Final step (completed state)
    goldenTest(
      'renders horizontal stepper - Step 5 of 5 (completed state)',
      fileName: 'app_stepper_horizontal_step5',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: buildThemeMatrix(
          builder: (context, brightness) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppText(
                  'Step 5/5 - All Complete',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppStepper(
                    steps: steps,
                    currentStep: 4,
                    completedSteps: {0, 1, 2, 3},
                    variant: StepperVariant.horizontal,
                  ),
                ),
              ),
            ],
          ),
          width: 400,
          height: 300,
        ),
      ),
    );

    /// Scenario 4: Vertical stepper variant
    goldenTest(
      'renders vertical stepper - Multi-step process',
      fileName: 'app_stepper_vertical_steps',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: buildThemeMatrix(
          builder: (context, brightness) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppText(
                    'Vertical - Step 2/5',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppStepper(
                    steps: steps,
                    currentStep: 1,
                    completedSteps: {0},
                    variant: StepperVariant.vertical,
                  ),
                ),
              ],
            ),
          ),
          width: 350,
          height: 500,
        ),
      ),
    );

    /// Scenario 5: Non-interactive stepper (read-only)
    goldenTest(
      'renders non-interactive stepper - Read-only mode',
      fileName: 'app_stepper_readonly',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: buildThemeMatrix(
          builder: (context, brightness) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppText(
                  'Read-Only - Step 2/5',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppStepper(
                    steps: steps,
                    currentStep: 1,
                    completedSteps: {0},
                    variant: StepperVariant.horizontal,
                    interactive: false,
                  ),
                ),
              ),
            ],
          ),
          width: 400,
          height: 300,
        ),
      ),
    );

    /// Scenario 6: Stepper with long descriptions
    goldenTest(
      'renders stepper with extended descriptions',
      fileName: 'app_stepper_long_descriptions',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: buildThemeMatrix(
          builder: (context, brightness) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppText(
                    'With Descriptions',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppStepper(
                    steps: const [
                      StepperStep(
                        id: 's1',
                        label: 'Step 1',
                        description: 'Provide personal information including name and email address',
                      ),
                      StepperStep(
                        id: 's2',
                        label: 'Step 2',
                        description: 'Enter complete shipping address with ZIP code',
                      ),
                      StepperStep(
                        id: 's3',
                        label: 'Step 3',
                        description: 'Review order details and proceed to checkout',
                      ),
                    ],
                    currentStep: 1,
                    completedSteps: {0},
                    variant: StepperVariant.vertical,
                  ),
                ),
              ],
            ),
          ),
          width: 380,
          height: 400,
        ),
      ),
    );

    /// Scenario 7: Stepper with custom styling via theme
    goldenTest(
      'renders stepper with theme styling applied',
      fileName: 'app_stepper_themed',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: buildThemeMatrix(
          builder: (context, brightness) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppText(
                  'Theme Applied',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppStepper(
                    steps: [
                      ...steps,
                    ],
                    currentStep: 2,
                    completedSteps: {0, 1},
                    variant: StepperVariant.horizontal,
                  ),
                ),
              ),
            ],
          ),
          width: 400,
          height: 300,
        ),
      ),
    );

    /// Scenario 8: Stepper with disabled step
    goldenTest(
      'renders stepper with disabled step option',
      fileName: 'app_stepper_with_disabled',
      builder: () => GoldenTestGroup(
        columns: 4,
        children: buildThemeMatrix(
          builder: (context, brightness) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppText(
                  'With Disabled Step',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppStepper(
                    steps: [
                      const StepperStep(
                        id: 's1',
                        label: 'Step 1',
                        enabled: true,
                      ),
                      const StepperStep(
                        id: 's2',
                        label: 'Step 2',
                        enabled: false,
                      ),
                      const StepperStep(
                        id: 's3',
                        label: 'Step 3',
                        enabled: true,
                      ),
                    ],
                    currentStep: 0,
                    completedSteps: const {},
                    variant: StepperVariant.horizontal,
                  ),
                ),
              ),
            ],
          ),
          width: 400,
          height: 250,
        ),
      ),
    );
  });
}
