import 'package:flutter/material.dart';

/// Utility class for handling and displaying errors in the editor
class ErrorHandler {
  /// Shows an error snackbar with the given message
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Shows a success snackbar with the given message
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Shows an info snackbar with the given message
  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue.shade700,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Shows a confirmation dialog and returns the user's choice
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(cancelText),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(confirmText),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// Validates a double value against min/max bounds
  static bool isValidDouble(double value, double min, double max) {
    return value >= min && value <= max;
  }

  /// Validates hex color string format
  static bool isValidHexColor(String hex) {
    final cleaned = hex.replaceFirst(RegExp(r'^0x|^#'), '');
    if (cleaned.length != 6 && cleaned.length != 8) return false;
    try {
      int.parse(cleaned, radix: 16);
      return true;
    } catch (_) {
      return false;
    }
  }
}
