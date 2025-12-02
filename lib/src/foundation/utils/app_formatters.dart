/// Provides data formatting utilities for the UI Kit.
///
/// Responsibility: Transforms raw user input into standardized formats
/// (e.g., lowercase, whitespace removal, IPv6 compression).
/// Unlike Validators (which only check), Formatters return a modified string.
class AppFormatters {
  // Private constructor to prevent instantiation
  AppFormatters._();

  // ===========================================================================
  // 1. Basic Formatters
  // ===========================================================================

  /// Removes leading and trailing whitespace.
  static String trim(String value) {
    return value.trim();
  }

  /// Converts string to lower case (useful for Email, Hex, etc.).
  static String toLowerCase(String value) {
    return value.toLowerCase();
  }

  /// Converts string to upper case (useful for MAC Addresses, etc.).
  static String toUpperCase(String value) {
    return value.toUpperCase();
  }

  /// Removes all whitespace characters from the string.
  static String removeAllWhitespace(String value) {
    return value.replaceAll(RegExp(r'\s+'), '');
  }

  // ===========================================================================
  // 2. Network Formatters
  // ===========================================================================

  /// Normalizes an IPv6 address (following RFC 5952 recommendations).
  ///
  /// Features:
  /// 1. Converts to lowercase.
  /// 2. Removes leading zeros (e.g., 0db8 -> db8).
  /// 3. Compresses the longest sequence of consecutive zeros to "::".
  /// 4. Returns the original string if the format is invalid (does not throw, to avoid interrupting UI flow).
  static String ipv6(String input) {
    if (input.isEmpty) return input;

    final cleanInput = input.trim().toLowerCase();

    try {
      // 1. Attempt to parse (Verify format)
      // Uses dart:core Uri parsing, which is cross-platform safe.
      final List<int> bytes = Uri.parseIPv6Address(cleanInput);

      // 2. Convert bytes back to standard 8 groups of 16-bit hex strings
      // Uri.parseIPv6Address returns 16 bytes (8-bit each)
      final List<String> hextets = [];
      for (var i = 0; i < 16; i += 2) {
        final int value = (bytes[i] << 8) | bytes[i + 1];
        hextets.add(value
            .toRadixString(16)); // Convert to hex and auto-remove leading zeros
      }

      // 3. Find the longest sequence of "0"s for "::" compression
      int bestStart = -1;
      int bestLen = 0;

      int currentStart = -1;
      for (var i = 0; i < hextets.length; i++) {
        if (hextets[i] == '0') {
          if (currentStart == -1) {
            currentStart = i;
          }
        } else {
          if (currentStart != -1) {
            final int currentLen = i - currentStart;
            if (currentLen > bestLen) {
              bestLen = currentLen;
              bestStart = currentStart;
            }
            currentStart = -1;
          }
        }
      }
      // Check the final sequence
      if (currentStart != -1) {
        final int currentLen = hextets.length - currentStart;
        if (currentLen > bestLen) {
          bestLen = currentLen;
          bestStart = currentStart;
        }
      }

      // 4. Compress only if the sequence of zeros is longer than 1 group (RFC recommendation)
      if (bestLen > 1) {
        final startPart = hextets.sublist(0, bestStart).join(':');
        final endPart = hextets.sublist(bestStart + bestLen).join(':');

        // Handle edge cases (starts or ends with ::)
        return '${startPart.isEmpty ? "" : startPart}::${endPart.isEmpty ? "" : endPart}';
      }

      // No compression needed, join with colons
      return hextets.join(':');
    } catch (e) {
      // Parse failed, return original input (let the Validator report the error)
      return input;
    }
  }

  /// Formats a MAC Address (Uppercased and ensures colon separation).
  /// Example: "001122334455" -> "00:11:22:33:44:55"
  /// Or: "00-11-22-33-44-55" -> "00:11:22:33:44:55"
  static String macAddress(String input) {
    if (input.isEmpty) return input;

    // Remove all non-hex characters
    final clean = input.replaceAll(RegExp(r'[^0-9a-fA-F]'), '').toUpperCase();

    // If length is not 12, it might be an incomplete MAC, return trimmed input
    if (clean.length != 12) return input.trim().toUpperCase();

    final buffer = StringBuffer();
    for (var i = 0; i < clean.length; i++) {
      buffer.write(clean[i]);
      if (i.isOdd && i != clean.length - 1) {
        buffer.write(':');
      }
    }
    return buffer.toString();
  }
}
