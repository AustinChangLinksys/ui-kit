import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Horizontal - First Step',
  type: AppStepper,
)
Widget buildHorizontalFirstStep(BuildContext context) {
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

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppStepper(
        steps: steps,
        currentStep: 0,
        completedSteps: const {},
        variant: StepperVariant.horizontal,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Horizontal - Active Step',
  type: AppStepper,
)
Widget buildHorizontalActiveStep(BuildContext context) {
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

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppStepper(
        steps: steps,
        currentStep: 2,
        completedSteps: const {0, 1},
        variant: StepperVariant.horizontal,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Horizontal - Completed',
  type: AppStepper,
)
Widget buildHorizontalCompleted(BuildContext context) {
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

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppStepper(
        steps: steps,
        currentStep: 4,
        completedSteps: const {0, 1, 2, 3},
        variant: StepperVariant.horizontal,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Vertical Layout',
  type: AppStepper,
)
Widget buildVerticalLayout(BuildContext context) {
  final stepCount = context.knobs.int.slider(
    label: 'Step Count',
    initialValue: 5,
    min: 2,
    max: 8,
  );

  final currentStep = context.knobs.int.slider(
    label: 'Current Step',
    initialValue: 1,
    min: 0,
    max: stepCount - 1,
  );

  final steps = List.generate(
    stepCount,
    (i) => StepperStep(
      id: 'step-${i + 1}',
      label: 'Step ${i + 1}',
      description: 'Step ${i + 1} description',
    ),
  );

  final completedSteps = <int>{
    for (int i = 0; i < currentStep; i++) i
  };

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: AppStepper(
          steps: steps,
          currentStep: currentStep,
          completedSteps: completedSteps,
          variant: StepperVariant.vertical,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive Steps',
  type: AppStepper,
)
Widget buildInteractiveSteps(BuildContext context) {
  final steps = [
    const StepperStep(
      id: 'step-1',
      label: 'Setup',
      description: 'Initial configuration',
    ),
    const StepperStep(
      id: 'step-2',
      label: 'Configuration',
      description: 'Customize settings',
    ),
    const StepperStep(
      id: 'step-3',
      label: 'Review',
      description: 'Verify changes',
    ),
  ];

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppStepper(
            steps: steps,
            currentStep: 1,
            completedSteps: const {0},
            variant: StepperVariant.horizontal,
            interactive: true,
            onStepTapped: (index) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Step ${index + 1} tapped')),
              );
            },
          ),
          const SizedBox(height: 16),
          const AppText(
            'Tap any step to navigate',
            variant: AppTextVariant.bodySmall,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Read-Only Mode',
  type: AppStepper,
)
Widget buildReadOnlyMode(BuildContext context) {
  final steps = [
    const StepperStep(
      id: 'step-1',
      label: 'Submitted',
      description: 'Application submitted',
    ),
    const StepperStep(
      id: 'step-2',
      label: 'Processing',
      description: 'Application being reviewed',
    ),
    const StepperStep(
      id: 'step-3',
      label: 'Approved',
      description: 'Application approved',
    ),
  ];

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppStepper(
        steps: steps,
        currentStep: 1,
        completedSteps: const {0},
        variant: StepperVariant.horizontal,
        interactive: false,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Disabled Steps',
  type: AppStepper,
)
Widget buildWithDisabledSteps(BuildContext context) {
  final steps = [
    const StepperStep(
      id: 'step-1',
      label: 'Verify Email',
      enabled: true,
    ),
    const StepperStep(
      id: 'step-2',
      label: 'Phone Verification',
      enabled: false,
      description: 'Verify email first',
    ),
    const StepperStep(
      id: 'step-3',
      label: 'Set Password',
      enabled: true,
    ),
  ];

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppStepper(
        steps: steps,
        currentStep: 0,
        completedSteps: const {},
        variant: StepperVariant.horizontal,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Custom Step Count',
  type: AppStepper,
)
Widget buildCustomStepCount(BuildContext context) {
  final stepCount = context.knobs.int.slider(
    label: 'Number of Steps',
    initialValue: 4,
    min: 2,
    max: 10,
  );

  final currentStep = context.knobs.int.slider(
    label: 'Current Step Index',
    initialValue: 1,
    min: 0,
    max: stepCount - 1,
  );

  final steps = List.generate(
    stepCount,
    (i) => StepperStep(
      id: 'step-${i + 1}',
      label: 'Step ${i + 1}',
    ),
  );

  final completedSteps = <int>{
    for (int i = 0; i < currentStep; i++) i
  };

  return DesignSystem.init(
    context,
    Padding(
      padding: const EdgeInsets.all(16),
      child: AppStepper(
        steps: steps,
        currentStep: currentStep,
        completedSteps: completedSteps,
        variant: StepperVariant.horizontal,
      ),
    ),
  );
}
