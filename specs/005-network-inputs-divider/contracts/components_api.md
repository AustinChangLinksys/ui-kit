# Network & Divider Components API

This file defines the public API surface for the new components.

## AppIpv4TextField

```dart
class AppIpv4TextField extends FormField<String> {
  AppIpv4TextField({
    Key? key,
    this.controller, // Optional external controller for the FULL string
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? initialValue,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
  }) : super(
    key: key,
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    enabled: enabled,
    autovalidateMode: autovalidateMode,
    builder: (FormFieldState<String> state) {
       // Returns the composite widget (Row of 4 AppTextFields)
    }
  );

  final TextEditingController? controller;
}
```

## AppMacAddressTextField

```dart
class AppMacAddressTextField extends FormField<String> {
  AppMacAddressTextField({
    Key? key,
    this.controller,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? initialValue,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
  }) : super(...);

  final TextEditingController? controller;
}
```

## AppIpv6TextField

```dart
class AppIpv6TextField extends FormField<String> {
  AppIpv6TextField({
    Key? key,
    this.controller,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? initialValue,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
  }) : super(...);

  final TextEditingController? controller;
}
```

## AppDivider

```dart
class AppDivider extends StatelessWidget {
  const AppDivider({
    Key? key,
    this.axis = Axis.horizontal,
    this.height, // Only relevant if horizontal, defines total occupancy
    this.width,  // Only relevant if vertical
    this.indent, // Optional override
    this.endIndent, // Optional override
  }) : super(key: key);

  final Axis axis;
  final double? height;
  final double? width;
  final double? indent;
  final double? endIndent;
}
```
