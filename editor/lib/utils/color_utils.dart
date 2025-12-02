import 'package:flutter/material.dart';

/// Converts a Flutter Color to hex string format
String colorToHex(Color color) {
  return '0x${color.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0')}';
}

/// Converts a hex string to a Flutter Color
Color hexToColor(String hexString) {
  // Remove 0x prefix if present
  String hex = hexString.replaceFirst(RegExp(r'^0x'), '');

  // Handle both 6-digit and 8-digit hex
  if (hex.length == 6) {
    hex = 'FF$hex'; // Add full opacity
  }

  try {
    return Color(int.parse(hex, radix: 16));
  } catch (e) {
    // Default to black on error
    return Colors.black;
  }
}

/// Validates if a string is a valid hex color
bool isValidHex(String hex) {
  final cleaned = hex.replaceFirst(RegExp(r'^0x'), '');
  if (cleaned.length != 6 && cleaned.length != 8) return false;
  try {
    int.parse(cleaned, radix: 16);
    return true;
  } catch (_) {
    return false;
  }
}
