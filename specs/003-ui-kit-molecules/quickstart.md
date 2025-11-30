# Quickstart: UI Kit Molecules

## Installation

Ensure `ui_kit` is added to your `pubspec.yaml`:

```yaml
dependencies:
  ui_kit:
    path: ../ui_kit
```

## Usage Examples

### Buttons

```dart
AppButton(
  label: 'Submit',
  icon: AppIcons.check,
  onTap: () => print('Clicked!'),
  isLoading: _isSubmitting,
)

AppIconButton(
  icon: AppIcons.settings,
  onTap: () => openSettings(),
)
```

### Text Input

```dart
AppTextField(
  controller: _controller,
  hintText: 'Enter your email',
  errorText: _isValid ? null : 'Invalid email',
)
```

### Status Indicators

```dart
// Avatar with fallback
AppAvatar(
  imageUrl: user.photoUrl,
  initials: user.initials, // 'JD'
)

// Status Badge
AppBadge(label: 'Pending')
```

### Navigation

```dart
AppNavigationBar(
  currentIndex: _tabIndex,
  onTap: (index) => setState(() => _tabIndex = index),
  items: [
    NavigationItem(icon: Icon(Icons.home), label: 'Home'),
    NavigationItem(icon: Icon(Icons.person), label: 'Profile'),
  ],
)
```
