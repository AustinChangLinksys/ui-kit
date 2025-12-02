import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/utils/app_validators.dart';

/// A specialized text field for MAC Address input.
///
/// Features:
/// - Auto-formatting (inserts separators like AA:BB:CC...).
/// - Restricts input to Hex characters.
/// - Visual style determined by [NetworkInputStyle].
class AppMacAddressTextField extends StatelessWidget {
  const AppMacAddressTextField({
    super.key,
    required this.label,
    required this.invalidFormatMessage, // IoC: Error message injection
    this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.enabled = true,
  });

  final String label;
  final String invalidFormatMessage;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    
    // 1. Get seperation from Theme Spec
    final separator = theme.networkInputStyle.macAddressSeparator; 

    return AppTextFormField(
      label: label,
      // Auto generate Hint: AA:BB:CC...
      hintText: List.generate(6, (i) => i == 0 ? 'AA' : (i == 1 ? 'BB' : '00')).join(separator),
      controller: controller,
      onSaved: onSaved,
      enabled: enabled,
      
      // 2. Input limit
      keyboardType: TextInputType.visiblePassword, // Avoid auto correction
      inputFormatters: [
        // Only allow Hex and separator
        FilteringTextInputFormatter.allow(RegExp('[a-fA-F0-9$separator]')),
        // Auto format (insert separator)
        _MacAddressInputFormatter(separator: separator),
        // Length limit (12 chars + 5 separators = 17)
        LengthLimitingTextInputFormatter(17),
      ],

      // 3. Validation
      validator: (value) {
        // A. Format validation
        final formatError = AppValidators.network.macAddress(
          message: invalidFormatMessage
        )(value);
        if (formatError != null) return formatError;

        // B. Business validation
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      
      // 4. Auto uppercase
      onChanged: (value) {
        onChanged?.call(value.toUpperCase());
      },
    );
  }
}

// --- Private Optimized Formatter ---

class _MacAddressInputFormatter extends TextInputFormatter {
  final String separator;

  _MacAddressInputFormatter({required this.separator});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    // 1. If in delete mode, do not format, avoid getting stuck
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // 2. Clean input: only allow Hex, and uppercase
    final cleanText = newValue.text.replaceAll(RegExp(r'[^a-fA-F0-9]'), '').toUpperCase();
    
    // 3. Rebuild string
    final buffer = StringBuffer();
    for (int i = 0; i < cleanText.length; i++) {
      buffer.write(cleanText[i]);
      // Add separator every 2 characters, but not at the end
      if ((i + 1) % 2 == 0 && i != cleanText.length - 1) {
        buffer.write(separator);
      }
    }

    final formattedText = buffer.toString();
    
    // 4. Simple cursor handling: always keep at end (for continuous MAC input)
    // Advanced approach is to calculate cursor relative position, but for fixed format like MAC, bottom placement usually works well and provides better UX
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}