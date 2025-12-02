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
        AppMacAddressTextField(
            label: 'MAC Address', invalidFormatMessage: 'Invalid format'),
        const SizedBox(height: 24),
        AppIPv6TextField(
            label: 'IPv6 Address', invalidFormatMessage: 'Invalid format'),
      ],
    ),
  );
}
