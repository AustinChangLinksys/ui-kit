# Quickstart: Interactive & Form Expansion

This guide demonstrates how to use the new Form, Feedback, and List components.

## 1. Forms & Validation

Use `AppTextFormField` inside a standard Flutter `Form` widget. It automatically handles error states.

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      AppTextFormField(
        label: 'Email',
        hintText: 'name@example.com',
        validator: (value) {
          if (value == null || !value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      AppButton(
        text: 'Submit',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Form is valid, error borders appear if invalid
            print('Processing...');
          }
        },
      ),
    ],
  ),
)
```

## 2. Dropdowns

`AppDropdown` mimics the look of text fields.

```dart
// Simple String Dropdown
AppDropdown<String>(
  label: 'Role',
  items: ['Admin', 'User', 'Guest'],
  value: _selectedRole,
  onChanged: (val) => setState(() => _selectedRole = val),
);

// Complex Object Dropdown
AppDropdown<User>(
  label: 'Assignee',
  items: userList,
  itemAsString: (u) => u.fullName, // Display name
  itemValue: (u) => u.id,          // Unique ID for equality check
  onChanged: (user) => print(user?.id),
);
```

## 3. Feedback (Loaders & Toasts)

### Loaders

```dart
// Circular (Default) - glows in Glass theme
AppLoader(); 

// Linear Progress (Determinate)
AppLoader(
  variant: LoaderVariant.linear,
  value: 0.7, // 70%
);
```

### Toasts

Toasts are typically triggered via a helper (implementation detail) or rendered in an overlay.

```dart
// Showing a toast (Conceptual usage)
AppToast.show(
  context,
  type: ToastType.success,
  title: 'Profile Saved',
  description: 'Your changes have been updated successfully.',
);
```

## 4. List Tiles

Standard list items for menus or settings.

```dart
AppListTile(
  leading: AppIcon(MyAssets.icons.settings),
  title: AppText('General Settings'),
  subtitle: AppText('Language, Theme, etc.'),
  trailing: AppIcon(MyAssets.icons.chevronRight),
  onTap: () => Navigator.push(...),
);
```
