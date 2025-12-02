import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/utils/app_formatters.dart';
import 'package:ui_kit_library/src/foundation/utils/app_validators.dart';
import 'package:ui_kit_library/src/molecules/forms/app_text_form_field.dart';

/// A specialized text field for IPv6 input.
///
/// Features:
/// - Pre-configured input formatters (Hex + Colon only).
/// - Built-in format validation.
/// - Optional auto-compaction on save.
class AppIPv6TextField extends StatelessWidget {
  const AppIPv6TextField({
    super.key,
    required this.label,
    required this.invalidFormatMessage, // Force caller to provide localized error
    this.hintText = '2001:0db8:85a3:0000:0000:8a2e:0370:7334',
    this.controller,
    this.onChanged,
    this.onSaved,
    this.additionalValidator,
    this.enabled = true,
    this.autoCompact = true,
  });

  final String label;
  final String invalidFormatMessage;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  /// Additional business logic validation (e.g., check against Router IP)
  final FormFieldValidator<String>? additionalValidator;

  final bool enabled;

  /// Whether to automatically compact the IPv6 string (e.g. 0000 -> 0, ::) on save.
  final bool autoCompact;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      label: label,
      hintText: hintText,
      controller: controller,
      enabled: enabled,

      // 1. Input Constraints: Only allow characters valid in IPv6
      keyboardType:
          TextInputType.visiblePassword, // Prevents auto-correct/suggestions
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F:]')),
      ],

      // 2. Composite Validation
      validator: (value) {
        // A. Structural Validation (UI Kit Responsibility)
        final formatError =
            AppValidators.network.ipv6(message: invalidFormatMessage)(value);

        if (formatError != null) return formatError;

        // B. Business Validation (App Responsibility)
        if (additionalValidator != null) {
          return additionalValidator!(value);
        }

        return null;
      },

      // 3. Handling Changes
      onChanged: (value) {
        // Optional: Auto lowercase as user types
        onChanged?.call(value.toLowerCase());
      },

      // 4. Handling Save (Auto Compaction)
      onSaved: (value) {
        if (value == null) return;

        final finalValue = autoCompact ? AppFormatters.ipv6(value) : value;

        onSaved?.call(finalValue);
      },
    );
  }
}
