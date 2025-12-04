import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A demo component for configuring Wi-Fi settings with action support.
///
/// This component demonstrates the closed-loop interaction pattern:
/// 1. AI renders this card with initial values
/// 2. User modifies settings and clicks Save/Cancel
/// 3. Action data is sent back to the AI via onAction callback
///
/// Uses UI Kit components for theme-aware rendering.
class WifiSettingsCard extends StatefulWidget {
  final String ssid;
  final String security;
  final bool isEnabled;

  /// Callback when user saves settings.
  /// Receives a Map with: ssid, security, isEnabled, password
  final void Function(Map<String, dynamic>)? onSave;

  /// Callback when user cancels.
  final VoidCallback? onCancel;

  const WifiSettingsCard({
    required this.ssid,
    required this.security,
    this.isEnabled = false,
    this.onSave,
    this.onCancel,
    super.key,
  });

  @override
  State<WifiSettingsCard> createState() => _WifiSettingsCardState();
}

class _WifiSettingsCardState extends State<WifiSettingsCard> {
  late TextEditingController _ssidController;
  late TextEditingController _passwordController;
  late String _security;
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _ssidController = TextEditingController(text: widget.ssid);
    _passwordController = TextEditingController();
    _security = widget.security;
    _isEnabled = widget.isEnabled;
  }

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSave() {
    widget.onSave?.call({
      'ssid': _ssidController.text,
      'security': _security,
      'isEnabled': _isEnabled,
      'password': _passwordController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasActions = widget.onSave != null || widget.onCancel != null;

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.wifi, size: 28),
                    SizedBox(width: 10),
                    AppText(
                      'Wi-Fi Settings',
                      variant: AppTextVariant.titleLarge,
                    ),
                  ],
                ),
                AppSwitch(
                  value: _isEnabled,
                  onChanged: (val) => setState(() => _isEnabled = val),
                ),
              ],
            ),
            AppGap.lg(),
            AppTextField(
              controller: _ssidController,
              hintText: 'Network Name (SSID)',
            ),
            AppGap.md(),
            AppTextField(
              controller: TextEditingController(text: _security),
              hintText: 'Security Type',
              onChanged: (val) => _security = val,
            ),
            AppGap.md(),
            AppTextField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            if (hasActions) ...[
              AppGap.lg(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.onCancel != null) ...[
                    AppButton(
                      label: 'Cancel',
                      variant: SurfaceVariant.base,
                      onTap: widget.onCancel,
                    ),
                    const SizedBox(width: 12),
                  ],
                  if (widget.onSave != null)
                    AppButton(
                      label: 'Save',
                      variant: SurfaceVariant.highlight,
                      onTap: _handleSave,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A demo component for displaying information.
///
/// This is a read-only component that displays info without user actions.
/// Uses UI Kit components for theme-aware rendering.
class InfoCard extends StatelessWidget {
  final String title;
  final String message;
  final String? iconName;

  const InfoCard({
    required this.title,
    required this.message,
    this.iconName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const AppSurface(
                  variant: SurfaceVariant.base,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.info_outline,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: AppText(
                    title,
                    variant: AppTextVariant.titleMedium,
                  ),
                ),
              ],
            ),
            AppGap.md(),
            AppText(
              message,
              variant: AppTextVariant.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// A confirmation card for displaying success/error status after actions.
/// Uses UI Kit components for theme-aware rendering.
class ConfirmationCard extends StatelessWidget {
  final String title;
  final String message;
  final bool isSuccess;

  /// Optional callback for dismiss/acknowledge action.
  final VoidCallback? onDismiss;

  const ConfirmationCard({
    required this.title,
    required this.message,
    this.isSuccess = true,
    this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = isSuccess ? Colors.green : colorScheme.error;
    final icon = isSuccess ? Icons.check_circle : Icons.error;

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                AppSurface(
                  variant: SurfaceVariant.base,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(icon, color: iconColor, size: 28),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: AppText(
                    title,
                    variant: AppTextVariant.titleMedium,
                  ),
                ),
              ],
            ),
            AppGap.md(),
            AppText(
              message,
              variant: AppTextVariant.bodyMedium,
            ),
            if (onDismiss != null) ...[
              AppGap.lg(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'OK',
                    variant: SurfaceVariant.highlight,
                    onTap: onDismiss,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
