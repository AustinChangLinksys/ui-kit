import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A demo component for configuring Wi-Fi settings.
///
/// This component is used to demonstrate the Component Registry's ability
/// to render complex UI Kit components from JSON props.
class WifiSettingsCard extends StatelessWidget {
  final String ssid;
  final String security;
  final bool isEnabled;

  const WifiSettingsCard({
    required this.ssid,
    required this.security,
    this.isEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.headlineSmall('Wi-Fi Settings'),
              AppSwitch(
                value: isEnabled,
                onChanged: (val) {}, // Read-only for demo
              ),
            ],
          ),
          AppGap.md(),
          AppTextFormField(
            label: 'Network Name (SSID)',
            initialValue: ssid,
            // readOnly: true, // Not supported in AppTextFormField yet
          ),
          AppGap.sm(),
          AppTextFormField(
            label: 'Security Type',
            initialValue: security,
            // readOnly: true,
          ),
        ],
      ),
    );
  }
}

/// A demo component for displaying information.
class InfoCard extends StatelessWidget {
  final String title;
  final String message;
  final String? iconName;

  const InfoCard({
    required this.title,
    required this.message,
    this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (iconName != null) ...[
                Icon(Icons.info_outline), // Placeholder for icon lookup
                AppGap.sm(),
              ],
              AppText.titleMedium(title),
            ],
          ),
          AppGap.sm(),
          AppText.bodyMedium(message),
        ],
      ),
    );
  }
}