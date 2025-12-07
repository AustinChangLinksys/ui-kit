import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A specialized text field for numeric input with thousand separators.
///
/// Features:
/// - Auto-formatting with thousand separators (e.g., "1,000,000")
/// - Configurable separator character
/// - Optional decimal support
/// - IoC-based validation message injection
/// - No Layout Shift error handling (icon + tooltip)
class AppNumberTextField extends StatelessWidget {
  const AppNumberTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.enabled = true,
    this.thousandSeparator = ',',
    this.decimalSeparator = '.',
    this.allowDecimals = false,
    this.maxDecimalPlaces = 2,
    this.minValue,
    this.maxValue,
    this.invalidRangeMessage,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool enabled;

  /// Character used for thousand separation (default: ',')
  final String thousandSeparator;

  /// Character used for decimal point (default: '.')
  final String decimalSeparator;

  /// Whether to allow decimal input
  final bool allowDecimals;

  /// Maximum decimal places allowed (default: 2)
  final int maxDecimalPlaces;

  /// Optional minimum value constraint
  final num? minValue;

  /// Optional maximum value constraint
  final num? maxValue;

  /// Error message for range validation (IoC)
  final String? invalidRangeMessage;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      label: label,
      hintText: hintText ?? _generateHintText(),
      controller: controller,
      enabled: enabled,

      // Numeric keyboard
      keyboardType: TextInputType.numberWithOptions(
        decimal: allowDecimals,
        signed: minValue != null && minValue! < 0,
      ),

      // Input constraints
      inputFormatters: [
        // Allow digits, decimal separator, and minus sign
        FilteringTextInputFormatter.allow(
          RegExp(allowDecimals
              ? r'[0-9,.\-]'
              : r'[0-9,\-]'),
        ),
        // Auto-format with thousand separators
        _ThousandSeparatorFormatter(
          thousandSeparator: thousandSeparator,
          decimalSeparator: decimalSeparator,
          allowDecimals: allowDecimals,
          maxDecimalPlaces: maxDecimalPlaces,
        ),
      ],

      // Validation
      validator: (value) {
        // Range validation
        if (value != null && value.isNotEmpty) {
          final cleanValue = value.replaceAll(thousandSeparator, '');
          final numValue = num.tryParse(cleanValue);

          if (numValue != null) {
            if (minValue != null && numValue < minValue!) {
              return invalidRangeMessage ?? 'Value must be at least $minValue';
            }
            if (maxValue != null && numValue > maxValue!) {
              return invalidRangeMessage ?? 'Value must be at most $maxValue';
            }
          }
        }

        // Business validation
        return validator?.call(value);
      },

      // Pass through raw value (without separators) to onChange
      onChanged: (value) {
        final cleanValue = value.replaceAll(thousandSeparator, '');
        onChanged?.call(cleanValue);
      },

      // Pass through raw value on save
      onSaved: (value) {
        if (value == null) return;
        final cleanValue = value.replaceAll(thousandSeparator, '');
        onSaved?.call(cleanValue);
      },
    );
  }

  String _generateHintText() {
    if (allowDecimals) {
      return '1${thousandSeparator}000${decimalSeparator}00';
    }
    return '1${thousandSeparator}000${thousandSeparator}000';
  }
}

/// TextInputFormatter that adds thousand separators to numeric input.
class _ThousandSeparatorFormatter extends TextInputFormatter {
  final String thousandSeparator;
  final String decimalSeparator;
  final bool allowDecimals;
  final int maxDecimalPlaces;

  _ThousandSeparatorFormatter({
    required this.thousandSeparator,
    required this.decimalSeparator,
    required this.allowDecimals,
    required this.maxDecimalPlaces,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If deleting, allow normal behavior
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Clean input: remove existing separators
    String cleanText = newValue.text.replaceAll(thousandSeparator, '');

    // Handle negative sign
    final isNegative = cleanText.startsWith('-');
    if (isNegative) {
      cleanText = cleanText.substring(1);
    }

    // Split by decimal point
    String integerPart;
    String? decimalPart;

    if (allowDecimals && cleanText.contains(decimalSeparator)) {
      final parts = cleanText.split(decimalSeparator);
      integerPart = parts[0];
      decimalPart = parts.length > 1 ? parts[1] : '';

      // Limit decimal places
      if (decimalPart.length > maxDecimalPlaces) {
        decimalPart = decimalPart.substring(0, maxDecimalPlaces);
      }
    } else {
      integerPart = cleanText.replaceAll(decimalSeparator, '');
    }

    // Remove non-digit characters from integer part
    integerPart = integerPart.replaceAll(RegExp(r'[^0-9]'), '');

    // Format integer part with thousand separators
    final buffer = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      final reverseIndex = integerPart.length - 1 - i;
      buffer.write(integerPart[i]);

      // Add separator every 3 digits (from right), but not at the end
      if (reverseIndex > 0 && reverseIndex % 3 == 0) {
        buffer.write(thousandSeparator);
      }
    }

    // Reconstruct final text
    String formattedText = buffer.toString();
    if (isNegative && formattedText.isNotEmpty) {
      formattedText = '-$formattedText';
    }
    if (decimalPart != null) {
      formattedText = '$formattedText$decimalSeparator$decimalPart';
    }

    // Cursor position at end for continuous input
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
