import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../../test_utils/font_loader.dart';
import '../../test_utils/golden_test_matrix_factory.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

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

    goldenTest(
      'AppStepper - Horizontal (Step 1/5)',
      fileName: 'stepper_horizontal_step1',
      builder: () => buildThemeMatrix(
        name: 'Step 1/5 - Pending',
        width: 400.0,
        height: 200.0,
        child: AppStepper(
          steps: steps,
          currentStep: 0,
          completedSteps: const {},
          variant: StepperVariant.horizontal,
        ),
      ),
    );

    goldenTest(
      'AppStepper - Horizontal (Step 3/5)',
      fileName: 'stepper_horizontal_step3',
      builder: () => buildThemeMatrix(
        name: 'Step 3/5 - Active',
        width: 400.0,
        height: 200.0,
        child: AppStepper(
          steps: steps,
          currentStep: 2,
          completedSteps: const {0, 1},
          variant: StepperVariant.horizontal,
        ),
      ),
    );

    goldenTest(
      'AppStepper - Horizontal (Step 5/5)',
      fileName: 'stepper_horizontal_step5',
      builder: () => buildThemeMatrix(
        name: 'Step 5/5 - Completed',
        width: 400.0,
        height: 200.0,
        child: AppStepper(
          steps: steps,
          currentStep: 4,
          completedSteps: const {0, 1, 2, 3},
          variant: StepperVariant.horizontal,
        ),
      ),
    );

    goldenTest(
      'AppStepper - Vertical (Multi-step)',
      fileName: 'stepper_vertical_multistep',
      builder: () => buildThemeMatrix(
        name: 'Vertical - Step 2/5',
        width: 350.0,
        height: 400.0,
        child: AppStepper(
          steps: steps,
          currentStep: 1,
          completedSteps: const {0},
          variant: StepperVariant.vertical,
        ),
      ),
    );

    goldenTest(
      'AppStepper - Read-only Mode',
      fileName: 'stepper_readonly',
      builder: () => buildThemeMatrix(
        name: 'Read-Only - Step 2/5',
        width: 400.0,
        height: 200.0,
        child: AppStepper(
          steps: steps,
          currentStep: 1,
          completedSteps: const {0},
          variant: StepperVariant.horizontal,
          interactive: false,
        ),
      ),
    );

    goldenTest(
      'AppStepper - With Descriptions',
      fileName: 'stepper_with_descriptions',
      builder: () => buildThemeMatrix(
        name: 'With Descriptions',
        width: 380.0,
        height: 300.0,
        child: AppStepper(
          steps: const [
            StepperStep(
              id: 's1',
              label: 'Step 1',
              description: 'Provide personal information including name and email',
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
          completedSteps: const {0},
          variant: StepperVariant.vertical,
        ),
      ),
    );

    goldenTest(
      'AppStepper - With Disabled Step',
      fileName: 'stepper_with_disabled',
      builder: () => buildThemeMatrix(
        name: 'With Disabled Step',
        width: 400.0,
        height: 150.0,
        child: AppStepper(
          steps: const [
            StepperStep(
              id: 's1',
              label: 'Step 1',
              enabled: true,
            ),
            StepperStep(
              id: 's2',
              label: 'Step 2',
              enabled: false,
            ),
            StepperStep(
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
    );

    goldenTest(
      'AppStepper - Theme Styling',
      fileName: 'stepper_themed',
      builder: () => buildThemeMatrix(
        name: 'Theme Styling Applied',
        width: 400.0,
        height: 200.0,
        child: AppStepper(
          steps: steps,
          currentStep: 2,
          completedSteps: const {0, 1},
          variant: StepperVariant.horizontal,
        ),
      ),
    );
  });
}
