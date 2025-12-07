import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit_library/ui_kit.dart';

@UseCase(name: 'Network Inputs', type: AppIpv4TextField)
Widget buildNetworkInputsUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodyLarge('IPv4 Address'),
        const SizedBox(height: 8),
        AppIpv4TextField(
          label: 'IPv4 Address',
        ),
        const SizedBox(height: 24),
        const AppMacAddressTextField(
            label: 'MAC Address', invalidFormatMessage: 'Invalid format'),
        const SizedBox(height: 24),
        const AppIPv6TextField(
            label: 'IPv6 Address', invalidFormatMessage: 'Invalid format'),
      ],
    ),
  );
}

/// Demonstrates Number TextField with thousand separators
@UseCase(name: 'Number Input', type: AppNumberTextField)
Widget buildNumberInputUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.headlineSmall('Number Input with Separators'),
        const SizedBox(height: 16),

        // Basic number input
        const AppNumberTextField(
          label: 'Price',
          hintText: '1,000,000',
        ),
        const SizedBox(height: 24),

        // Number with decimal
        const AppNumberTextField(
          label: 'Tax Rate',
          allowDecimals: true,
          maxDecimalPlaces: 2,
          hintText: '10.5',
        ),
        const SizedBox(height: 24),

        // Number with range validation
        const AppNumberTextField(
          label: 'Quantity (1-100)',
          minValue: 1,
          maxValue: 100,
          invalidRangeMessage: 'Must be between 1 and 100',
        ),
      ],
    ),
  );
}

/// Demonstrates error state display (No Layout Shift Policy)
/// Error is shown via icon + tooltip, not text below input
@UseCase(name: 'Error States', type: AppTextField)
Widget buildErrorStatesUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.headlineSmall('Error Handling - No Layout Shift'),
        const SizedBox(height: 8),
        AppText.bodySmall(
          'Error is shown via icon + tooltip. Hover/tap the icon or focus the field to see error message.',
        ),
        const SizedBox(height: 24),

        // Text field with error (icon + tooltip)
        const AppTextField(
          hintText: 'Required field',
          errorText: 'This field is required',
        ),
        const SizedBox(height: 24),

        // Underline variant with error
        const AppTextField(
          variant: AppInputVariant.underline,
          hintText: 'Email address',
          errorText: 'Invalid email format',
        ),
        const SizedBox(height: 24),

        // Field without error for comparison
        const AppTextField(
          hintText: 'No error - same height',
        ),
        const SizedBox(height: 16),
        AppText.caption(
          'Notice: All inputs maintain the same height regardless of error state.',
        ),
      ],
    ),
  );
}
