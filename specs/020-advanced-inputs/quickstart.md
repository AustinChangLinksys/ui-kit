# Quickstart: Advanced Inputs

## 1. AppRangeInput
Composite input for start/end values (e.g., Port Range).

```dart
AppRangeInput(
  startLabel: 'Start Port',
  endLabel: 'End Port',
  validator: (start, end) {
    if (int.parse(start) >= int.parse(end)) return 'Start must be less than End';
    return null;
  },
)
```

## 2. AppPinInput
OTP/PIN entry with ghost input for seamless keyboard support.

```dart
AppPinInput(
  length: 6,
  onCompleted: (pin) {
    print('Verified: $pin');
    AppFeedback.onSuccess();
  },
)
```

## 3. AppPasswordInput
Password field with real-time rule validation.

```dart
AppPasswordInput(
  label: 'New Password',
  rules: [
    AppPasswordRule(label: '8+ chars', validate: (v) => v.length >= 8),
    AppPasswordRule(label: '1 Number', validate: (v) => v.contains(RegExp(r'[0-9]'))),
  ],
)
```
