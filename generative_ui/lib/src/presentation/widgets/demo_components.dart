import 'package:flutter/material.dart';

/// A demo component for configuring Wi-Fi settings with action support.
///
/// This component demonstrates the closed-loop interaction pattern:
/// 1. AI renders this card with initial values
/// 2. User modifies settings and clicks Save/Cancel
/// 3. Action data is sent back to the AI via onAction callback
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

    return Card(
      elevation: 4,
      color: Colors.white,
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
                    Icon(Icons.wifi, color: Colors.blue, size: 28),
                    SizedBox(width: 10),
                    Text(
                      'Wi-Fi Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: _isEnabled,
                  onChanged: (val) => setState(() => _isEnabled = val),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Network Name (SSID)',
              value: _ssidController.text,
              onChanged: (val) => _ssidController.text = val,
              icon: Icons.router,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Security Type',
              value: _security,
              onChanged: (val) => _security = val,
              icon: Icons.security,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Password',
              value: _passwordController.text,
              onChanged: (val) => _passwordController.text = val,
              icon: Icons.lock,
              obscureText: true,
            ),
            if (hasActions) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.onCancel != null) ...[
                    OutlinedButton(
                      onPressed: widget.onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                  ],
                  if (widget.onSave != null)
                    ElevatedButton(
                      onPressed: _handleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: TextEditingController(text: value),
      onChanged: onChanged,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}

/// A demo component for displaying information.
///
/// This is a read-only component that displays info without user actions.
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
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A confirmation card for displaying success/error status after actions.
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
    final backgroundColor = isSuccess ? Colors.green[50] : Colors.red[50];
    final iconColor = isSuccess ? Colors.green : Colors.red;
    final icon = isSuccess ? Icons.check_circle : Icons.error;

    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            if (onDismiss != null) ...[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: onDismiss,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSuccess ? Colors.green : Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('OK'),
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
