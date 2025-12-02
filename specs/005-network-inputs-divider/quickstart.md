# 🚀 Quickstart: Network Inputs & Divider

**Feature**: `005-network-inputs-divider`

## 1. Setup

Ensure your `AppDesignTheme` is configured with the new extensions.

```dart
// In your theme definition
final theme = AppDesignTheme(
  // ... existing properties
  extensions: [
    DividerStyle(
      color: Colors.black,
      thickness: 1.0,
    ),
    NetworkInputStyle(
      macAddressSeparator: ':',
      ipv4SeparatorStyle: SeparatorStyle.dot,
    ),
  ],
);
```

## 2. Usage: IPv4 Field

```dart
AppIpv4TextField(
  onSaved: (value) => print("IPv4 Saved: $value"), // "192.168.1.1"
  validator: (value) {
    if (value == null || value.isEmpty) return "Required";
    return null;
  },
)
```

## 3. Usage: MAC Address Field

```dart
AppMacAddressTextField(
  initialValue: "AABBCCDDEEFF", // Can supply raw or formatted
  onSaved: (value) => print("MAC Saved: $value"), // "AA:BB:CC:DD:EE:FF"
)
```

## 4. Usage: Divider

```dart
Column(
  children: [
    Text("Section A"),
    AppDivider(), // Horizontal by default
    Text("Section B"),
    Container(
      height: 50,
      child: Row(
        children: [
          Text("Left"),
          AppDivider(axis: Axis.vertical), // Vertical divider
          Text("Right"),
        ],
      ),
    ),
  ],
)
```
