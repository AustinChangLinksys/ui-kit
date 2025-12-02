import 'dart:convert'; // For utf8.encode

/// Provides common and domain-specific form validators for the UI Kit.
///
/// Usage:
/// ```dart
/// validator: (value) {
///   return AppValidators.required()(value) ?? 
///          AppValidators.email()(value);
/// }
/// ```
class AppValidators {
  // Private constructor to prevent instantiation
  AppValidators._();

  // ===========================================================================
  // 1. General Validators
  // ===========================================================================

  /// Required field validator.
  /// Checks if the value is null or empty (after trimming whitespace).
  static String? Function(String?) required({String? message}) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message ?? 'This field is required';
      }
      return null;
    };
  }

  /// Length limit validator.
  /// [min] Minimum length, [max] Maximum length (0 means no limit).
  static String? Function(String?) length({
    int min = 0,
    int max = 0,
    String? message,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null; // Empty values are handled by 'required'

      // Use UTF-8 encoding length to ensure correct calculation for multi-byte characters (e.g., Chinese)
      final length = utf8.encode(value).length;
      
      if (length < min) {
        return message ?? 'Must be at least $min characters';
      }
      
      if (max > 0 && length > max) {
        return message ?? 'Must be at most $max characters';
      }
      
      return null;
    };
  }

  /// Email format validator.
  static String? Function(String?) email({String? message}) {
    // Regex from EmailRule
    final regExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&‘*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );
    
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (!regExp.hasMatch(value)) {
        return message ?? 'Invalid email address';
      }
      return null;
    };
  }

  /// Integer validator (IntegerRule).
  /// Optional check for [min] and [max] range (-1 means no check).
  static String? Function(String?) integer({
    int min = -1,
    int max = -1,
    String? message,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      
      final number = int.tryParse(value);
      if (number == null) {
        return message ?? 'Must be a valid integer';
      }
      
      if (min != -1 && number < min) {
        return message ?? 'Value must be >= $min';
      }
      
      if (max != -1 && number > max) {
        return message ?? 'Value must be <= $max';
      }
      
      return null;
    };
  }

  /// Numeric only validator (DigitalCheckRule).
  /// Checks if the string contains only digits.
  static String? Function(String?) numeric({String? message}) {
    final regExp = RegExp(r"^\d+$");
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (!regExp.hasMatch(value)) {
        return message ?? 'Must contain only digits';
      }
      return null;
    };
  }

  /// ASCII character validator (AsciiRule).
  static String? Function(String?) ascii({String? message}) {
    final regExp = RegExp(r'^[\x20-\x7E]+$');
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (!regExp.hasMatch(value)) {
        return message ?? 'Must contain only ASCII characters';
      }
      return null;
    };
  }

  /// No surrounding whitespace validator (NoSurroundWhitespaceRule).
  static String? Function(String?) noSurroundWhitespace({String? message}) {
    final regExp = RegExp(r'^\s+|\s+$');
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (regExp.hasMatch(value)) {
        return message ?? 'Cannot contain leading or trailing whitespace';
      }
      return null;
    };
  }

  /// No whitespace validator (WhiteSpaceRule).
  static String? Function(String?) noWhitespace({String? message}) {
    final regExp = RegExp(r'\s');
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (regExp.hasMatch(value)) {
        return message ?? 'Cannot contain whitespace';
      }
      return null;
    };
  }

  /// Special character check validator (SpecialCharCheckRule).
  /// Checks if the string contains characters other than alphanumeric and spaces.
  static String? Function(String?) noSpecialChars({String? message}) {
    final regExp = RegExp(r"[^a-zA-Z0-9 ]");
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (regExp.hasMatch(value)) {
        return message ?? 'Cannot contain special characters';
      }
      return null;
    };
  }

  // ===========================================================================
  // 2. Network Validators
  // Accessed via AppValidators.network.ipv4()
  // ===========================================================================
  
  static const _NetworkValidators network = _NetworkValidators();
}

class _NetworkValidators {
  const _NetworkValidators();

  /// IPv4 format validator (IpAddressRule).
  /// By default, it excludes reserved IPs (IpAddressNoReservedRule), can be enabled via [allowReserved].
  String? Function(String?) ipv4({
    String? message,
    bool allowReserved = false,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null;

      try {
        final uri = Uri.parseIPv4Address(value);
        
        // If reserved IPs are not allowed, perform additional checks
        if (!allowReserved) {
           // Check 0.0.0.0/8
           if (uri[0] == 0) return message ?? 'Invalid IP: Reserved range (0.0.0.0/8)';
           // Check 127.0.0.0/8 (Loopback)
           if (uri[0] == 127) return message ?? 'Invalid IP: Loopback address';
           // Check 224.0.0.0/4 (Multicast)
           if (uri[0] >= 224 && uri[0] <= 239) return message ?? 'Invalid IP: Multicast address';
           // Check 255.255.255.255 (Broadcast)
           if (uri[0] == 255 && uri[1] == 255 && uri[2] == 255 && uri[3] == 255) {
             return message ?? 'Invalid IP: Broadcast address';
           }
        }
        
        return null;
      } catch (e) {
        return message ?? 'Invalid IPv4 address';
      }
    };
  }

  /// IPv6 format validator (IPv6Rule).
  String? Function(String?) ipv6({String? message}) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (value == '::') return message ?? 'Invalid IPv6 address'; // Unspecified
      
      try {
        Uri.parseIPv6Address(value);
        return null;
      } catch (e) {
        return message ?? 'Invalid IPv6 address';
      }
    };
  }

  /// MAC Address format validator (MACAddressRule).
  String? Function(String?) macAddress({String? message}) {
    final regExp = RegExp(r"^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$");
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (!regExp.hasMatch(value)) {
        return message ?? 'Invalid MAC address';
      }
      return null;
    };
  }

  /// Subnet Mask validator (SubnetMaskRule).
  /// Validates if it is a valid mask format (e.g., 255.255.255.0).
  String? Function(String?) subnetMask({String? message}) {
    return (value) {
      if (value == null || value.isEmpty) return null;

      try {
        // Parse IPv4
        final octets = Uri.parseIPv4Address(value);
        // Convert to 32-bit integer
        int mask = (octets[0] << 24) | (octets[1] << 16) | (octets[2] << 8) | octets[3];
        
        // Validation rule: Binary must be contiguous 1s followed by contiguous 0s
        // E.g., 11111111 11111111 11111111 00000000 (Valid)
        // E.g., 11111111 00000000 11111111 00000000 (Invalid)
        
        // Trick: If x is a valid mask, then (~x + 1) & ~x should be 0
        // Or simply check: inverted + 1 should be a power of 2
        
        if (mask == 0) return null; // 0.0.0.0 is sometimes considered valid, depending on requirements
        
        // Check if it's contiguous 1s
        // Invert the mask, e.g., 11110000 -> 00001111
        int inverse = ~mask & 0xFFFFFFFF;
        // If it's contiguous 1s, inverse + 1 should have only one bit set to 1 (i.e., power of 2)
        if ((inverse + 1) & inverse != 0) {
           return message ?? 'Invalid Subnet Mask (bits not contiguous)';
        }
        
        return null;
      } catch (e) {
        return message ?? 'Invalid Subnet Mask format';
      }
    };
  }

  /// Wi-Fi SSID validator (WiFiSsidRule).
  /// Length 1-32, cannot start with space.
  String? Function(String?) wifiSsid({String? message}) {
    final regExp = RegExp(r"^(?!\s).{0,31}\S$");
    return (value) {
      if (value == null || value.isEmpty) return null;
      
      // Additional length check (Regex is sometimes hard to precisely control byte length)
      if (utf8.encode(value).length > 32) {
         return message ?? 'SSID too long (max 32 bytes)';
      }
      
      if (!regExp.hasMatch(value)) {
        return message ?? 'Invalid SSID format';
      }
      return null;
    };
  }

  /// Wi-Fi Password validator (WiFiPasswordRule).
  /// 8-64 characters, ASCII range.
  String? Function(String?) wifiPassword({
    String? message,
    bool ignoreLength = false,
  }) {
    final regExp = RegExp(ignoreLength
        ? r"^(?! )[\x20-\x7e]+(?<! )$"
        : r"^(?! )[\x20-\x7e]{8,64}(?<! )$");
        
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (!regExp.hasMatch(value)) {
        return message ?? 'Invalid Wi-Fi password';
      }
      return null;
    };
  }
  
  /// Wi-Fi PSK (Hex) validator (WiFiPSKRule).
  /// If 64 characters long, it must be Hex, otherwise treated as a standard password.
  String? Function(String?) wifiPsk({String? message}) {
    final hexRegExp = RegExp(r'^[0-9a-fA-F]+$');
    return (value) {
      if (value == null || value.isEmpty) return null;
      
      if (value.length == 64) {
        if (!hexRegExp.hasMatch(value)) {
           return message ?? '64-char key must be Hexadecimal';
        }
      }
      return null;
    };
  }
}