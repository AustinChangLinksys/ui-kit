import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Internet Settings',
  type: InternetSettingsPage,
  path: 'Examples',
)
Widget buildInternetSettingsStory(BuildContext context) {
  return InternetSettingsPage(
    ipv4Address: context.knobs.string(
      label: 'IPv4 Address',
      initialValue: '192.168.1.1',
    ),
    macAddress: context.knobs.string(
      label: 'MAC Address',
      initialValue: 'AABBCCDDEEFF',
    ),
    ipv6Address: context.knobs.string(
      label: 'IPv6 Address',
      initialValue: '2001:db8::1',
    ),
    isIPv4Enabled: context.knobs.boolean(
      label: 'Enable IPv4',
      initialValue: true,
    ),
    isMACEnabled: context.knobs.boolean(
      label: 'Enable MAC',
      initialValue: true,
    ),
    isIPv6Enabled: context.knobs.boolean(
      label: 'Enable IPv6',
      initialValue: true,
    ),
  );
}

class InternetSettingsPage extends StatefulWidget {
  final String ipv4Address;
  final String macAddress;
  final String ipv6Address;
  final bool isIPv4Enabled;
  final bool isMACEnabled;
  final bool isIPv6Enabled;

  const InternetSettingsPage({
    super.key,
    required this.ipv4Address,
    required this.macAddress,
    required this.ipv6Address,
    required this.isIPv4Enabled,
    required this.isMACEnabled,
    required this.isIPv6Enabled,
  });

  @override
  State<InternetSettingsPage> createState() => _InternetSettingsPageState();
}

class _InternetSettingsPageState extends State<InternetSettingsPage> {
  late TextEditingController _ipv4Controller;
  late TextEditingController _macController;
  late TextEditingController _ipv6Controller;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _ipv4Controller = TextEditingController(text: widget.ipv4Address);
    _macController = TextEditingController(text: widget.macAddress);
    _ipv6Controller = TextEditingController(text: widget.ipv6Address);
  }

  @override
  void didUpdateWidget(covariant InternetSettingsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.ipv4Address != oldWidget.ipv4Address) {
      _ipv4Controller.text = widget.ipv4Address;
    }
    if (widget.macAddress != oldWidget.macAddress) {
      _macController.text = widget.macAddress;
    }
    if (widget.ipv6Address != oldWidget.ipv6Address) {
      _ipv6Controller.text = widget.ipv6Address;
    }
  }

  @override
  void dispose() {
    _ipv4Controller.dispose();
    _macController.dispose();
    _ipv6Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent, // Allow Widgetbook background
      body: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacingFactor * 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.headline('Internet Settings'),
              AppGap.lg(),

              AppText.titleMedium('IPv4 Configuration'),
              AppGap.md(),
              AppIpv4TextField(
                controller: _ipv4Controller,
                enabled: widget.isIPv4Enabled,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  // Simple pattern for demonstration
                  if (!RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$')
                      .hasMatch(value)) {
                    return 'Invalid IPv4 format';
                  }
                  return null;
                },
              ),
              AppGap.lg(),

              AppDivider(), // Horizontal divider

              AppGap.lg(),
              AppText.titleMedium('MAC Address Filter'),
              AppGap.md(),
              AppMacAddressTextField(
                label: 'MAC Address',
                invalidFormatMessage:
                    'Invalid MAC format (e.g., AA:BB:CC:DD:EE:FF)',
                controller: _macController,
                enabled: widget.isMACEnabled,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (!RegExp(r'^[0-9A-Fa-f]{2}(:[0-9A-Fa-f]{2}){5}$')
                      .hasMatch(value)) {
                    return 'Invalid MAC format (e.g., AA:BB:CC:DD:EE:FF)';
                  }
                  return null;
                },
              ),
              AppGap.lg(),

              AppDivider(), // Another horizontal divider

              AppGap.lg(),
              AppText.titleMedium('IPv6 Configuration'),
              AppGap.md(),
              AppIPv6TextField(
                controller: _ipv6Controller,
                enabled: widget.isIPv6Enabled,
                label: 'IPv6 Address',

                // 這是給內部 "格式驗證器" 用的錯誤訊息 (當輸入不是合法 IPv6 時顯示)
                invalidFormatMessage: 'Invalid IPv6 format',

                // ✨ 修正 1: 改用 additionalValidator 疊加額外規則
                additionalValidator:
                    AppValidators.required(message: 'Required'),
              ),
              AppGap.lg(),

              Center(
                child: AppButton(
                  label: 'Save Settings',
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings Saved!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Validation Failed!')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
